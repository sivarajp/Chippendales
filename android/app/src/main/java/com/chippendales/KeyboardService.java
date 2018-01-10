package com.chippendales;

import android.app.Activity;
import android.app.AppOpsManager;
import android.content.ClipDescription;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.inputmethodservice.InputMethodService;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v13.view.inputmethod.EditorInfoCompat;
import android.support.v13.view.inputmethod.InputConnectionCompat;
import android.support.v13.view.inputmethod.InputContentInfoCompat;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v4.content.FileProvider;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.ExtractedTextRequest;
import android.view.inputmethod.InputBinding;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.InputMethodInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.HorizontalScrollView;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ViewFlipper;

import com.chippendales.packs.PackAdapter;
import com.chippendales.packs.PackData;
import com.chippendales.stickers.MarginDecoration;
import com.chippendales.stickers.StickerAdapter;
import com.chippendales.stickers.StickerData;
import com.chippendales.stickers.Stickers;
import com.google.firebase.analytics.FirebaseAnalytics;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.facebook.react.bridge.UiThreadUtil.runOnUiThread;


public class KeyboardService extends InputMethodService {

    private static final String TAG = "KeyboardService";
    private final static String SERVICE_NAME = "com.chippendales.KeyboardService";
    private static final String MIME_TYPE_GIF = "image/gif";
    public static File imagesDir;
    public static File tempDir;
    private static String authority; //"com.chippendales.chippmoji";
    private static String DEEPLINK_TEXT = "Check out the Chippmoji Keyboard! ";
    public Stickers stickers;
    LinearLayout mainBoard;
    LinearLayout speechBoard;
    private StickerAdapter stickerAdapter;
    private List<PackData> packDataList = new ArrayList<>();
    private PackAdapter packAdapter;
    private TextView packNameLabel;
    private boolean contentSupportedGif;
    private RecyclerView packView, stickerView;
    private String deeplink = "https://www.chippmoji.com/";
    private long startTime = 0;
    private EditorInfo editorInfo;
    private ViewFlipper keyboardViewFlipper;
    private Button lips, speech, dance;
    private HorizontalScrollView scrollView;
    public int selectedTab = 0;
    Map<String, String> UrlMap = new HashMap<String, String>()
    {{
        put("116_Tourticket" , "http://www.chippendales.com/touring-show");
        put("106_Treat" , "https://boutique.chippendales.com");
        put("101_Vegas" , "http://www.chippendales.com/tickets");
    }};

    private FirebaseAnalytics mFirebaseAnalytics;

    public static boolean rokomojiEnabled(Activity activity) {
//        requestPermissionIfNeeded(Manifest.permission.READ_EXTERNAL_STORAGE, activity);
        InputMethodManager imm = (InputMethodManager) activity.getSystemService(Context.INPUT_METHOD_SERVICE);
        List<InputMethodInfo> imList = imm.getEnabledInputMethodList();
        for (InputMethodInfo imi : imList) {
            if (activity.getPackageName().equalsIgnoreCase(imi.getPackageName()) && SERVICE_NAME.equalsIgnoreCase(imi.getServiceName())) {
                return true;
            }
        }
        return false;
    }

    private static boolean requestPermissionIfNeeded(String permission, Activity activity) {
        if (ContextCompat.checkSelfPermission(activity, permission) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(activity, new String[]{permission}, 1);
            return true;
        }
        return false;
    }

    private void showStickers(final int index) {

        packDataList = stickers.packDataListDefault;
        final List<PackData> curDataList = new ArrayList<>(packDataList);
        if (curDataList.size() > 0) {
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    packAdapter = new PackAdapter(returnThis(), curDataList);
                    if (packView != null) {
                        packView.setAdapter(packAdapter);
                    }
                    switchBoard(index);
                }
            });

        }
    }

    private KeyboardService returnThis() {
        return this;
    }

    private void getStickers(final int index) {
        stickers.loadStickers(new Stickers.CallbackStickersLoaded() {
            @Override
            public void pack() {
                showStickers(index);
            }
        });
    }

    public void switchBoard(int tab) {

        if (packDataList.get(tab) == null)
            return;

        if (packNameLabel != null) {
            packNameLabel.setText(packDataList.get(tab).name);
        }

        stickerAdapter = new StickerAdapter(this, packDataList.get(tab).stickers);
        if (stickerView != null) {
            stickerView.setAdapter(stickerAdapter);
        }
    }

    @Override
    public View onCreateInputView() {

        if (mFirebaseAnalytics == null) {
            mFirebaseAnalytics = FirebaseAnalytics.getInstance(this);
        }
        mainBoard = (LinearLayout) getLayoutInflater().inflate(R.layout.main_board_layout, null);
        keyboardViewFlipper = (ViewFlipper) mainBoard.findViewById(R.id.keyboard_viewFlipper);
        speechBoard = (LinearLayout) getLayoutInflater().inflate(R.layout.speech_board, null, false);
        scrollView = (HorizontalScrollView) speechBoard.findViewById(R.id.speech_board_scroll);
        stickerView = (RecyclerView) getLayoutInflater().inflate(R.layout.recycler_view, null);
        stickerView.addItemDecoration(new MarginDecoration(returnThis()));
        stickerView.setHasFixedSize(false);
        stickerView.setLayoutManager(new GridLayoutManager(returnThis(), 1, LinearLayoutManager.HORIZONTAL, false));
        scrollView.addView(stickerView);
        packView = (RecyclerView) getLayoutInflater().inflate(R.layout.recycler_view, null);

        ImageButton switchKeyBoard = (ImageButton) mainBoard.findViewById(R.id.radio0);
        switchKeyBoard.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                InputMethodManager inputMethodManager = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
                inputMethodManager.showInputMethodPicker();
            }
        });

        createEmojiDisplayLayout(0, 1);

        dance = (Button) mainBoard.findViewById(R.id.radio1);
        dance.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                createEmojiDisplayLayout(0, 1);
            }
        });

        lips = (Button) mainBoard.findViewById(R.id.radio2);
        lips.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                createEmojiDisplayLayout(1, 2);
            }

        });
        speech = (Button) mainBoard.findViewById(R.id.radio3);
        speech.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                createEmojiDisplayLayout(2, 2);
            }

        });



        final ImageButton shareLink = (ImageButton) mainBoard.findViewById(R.id.radio4);
        shareLink.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                final InputConnection inputConnection = getCurrentInputConnection();
                inputConnection.commitText(DEEPLINK_TEXT + " " + deeplink, 0);
            }
        });

        final ImageButton delete = (ImageButton) mainBoard.findViewById(R.id.radio5);
        delete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                InputConnection inputConnection = getCurrentInputConnection();
                CharSequence currentText = inputConnection.getExtractedText(new ExtractedTextRequest(), 0).text;
                CharSequence beforCursorText = inputConnection.getTextBeforeCursor(currentText.length(), 0);
                CharSequence afterCursorText = inputConnection.getTextAfterCursor(currentText.length(), 0);
                inputConnection.deleteSurroundingText(beforCursorText.length(), afterCursorText.length());
            }
        });

        return mainBoard;
    }

    private void createEmojiDisplayLayout(int selectedTab, int GridColumns) {
        this.selectedTab = selectedTab;
        scrollView.scrollTo(0,0);
        keyboardViewFlipper.removeView(speechBoard);
        showStickers(selectedTab);
        keyboardViewFlipper.addView(speechBoard, selectedTab);
        final GridLayoutManager gridLayoutManager = new GridLayoutManager(returnThis(), GridColumns, LinearLayoutManager.HORIZONTAL, false);
        stickerView.setLayoutManager(gridLayoutManager);
        keyboardViewFlipper.setDisplayedChild(selectedTab);
    }


    public void inputContent(@NonNull StickerData stickerData, int position) {
        final int flag;
        final Uri contentUri = FileProvider.getUriForFile(this, authority, stickerData.file);
        if (Build.VERSION.SDK_INT >= 25) {
            flag = InputConnectionCompat.INPUT_CONTENT_GRANT_READ_URI_PERMISSION;
        } else {
            flag = 0;
            final EditorInfo editorInfo = getCurrentInputEditorInfo();
            try {
                grantUriPermission(editorInfo.packageName, contentUri, Intent.FLAG_GRANT_READ_URI_PERMISSION);
            } catch (Exception e) {
                Log.e(TAG, "grantUriPermission failed packageName=" + editorInfo.packageName + " contentUri=" + contentUri, e);
            }
        }

        if (contentSupportedGif && MIME_TYPE_GIF.equals(stickerData.mime)) {
            String description = "Images";
            InputContentInfoCompat icic;
            if (stickerData.url == null) {
                icic = new InputContentInfoCompat(contentUri, new ClipDescription(description, new String[]{stickerData.mime, MIME_TYPE_GIF}), null);
            } else {
                icic = new InputContentInfoCompat(contentUri, new ClipDescription(description, new String[]{stickerData.mime, MIME_TYPE_GIF}), Uri.parse(stickerData.url));
            }
            final InputContentInfoCompat inputContentInfoCompat = icic;
            InputConnectionCompat.commitContent(getCurrentInputConnection(), getCurrentInputEditorInfo(), inputContentInfoCompat, flag, null);

        } else {
            if (!stickerToShare(stickerData)) {
                Toast.makeText(this, "Application does not support stickers", Toast.LENGTH_SHORT).show();
            }
        }
    }

    private ActivityInfo getAppForShare(StickerData stickerData) {
        Intent intent = new Intent();
        intent.setAction(Intent.ACTION_SEND);
        intent.setType(stickerData.mime);
        PackageManager pm = getPackageManager();
        List<ResolveInfo> activities = pm.queryIntentActivities(intent, 0);
        for (ResolveInfo act : activities) {
            ActivityInfo ai = act.activityInfo;
            if (editorInfo.packageName.equalsIgnoreCase(ai.applicationInfo.packageName)) {
                return ai;
            }
        }
        return null;
    }


    public void onStartInputView(EditorInfo info, boolean restarting) {
        contentSupportedGif = isCommitContentSupported(info, MIME_TYPE_GIF);
        startTime = System.currentTimeMillis();
        editorInfo = info;
        getStickers(selectedTab);

    }

    public void onFinishInputView(boolean finishingInput) {
        if (startTime > 0) {
            long timeSpent = (System.currentTimeMillis() - startTime) / 1000;
        }
    }

    private boolean isCommitContentSupported(@Nullable EditorInfo editorInfo, @NonNull String mimeType) {
        if (editorInfo == null) {
            return false;
        }

        final InputConnection ic = getCurrentInputConnection();
        if (ic == null) {
            return false;
        }

        if (!validatePackageName(editorInfo)) {
            return false;
        }

        final String[] supportedMimeTypes = EditorInfoCompat.getContentMimeTypes(editorInfo);
        for (String supportedMimeType : supportedMimeTypes) {
            if (ClipDescription.compareMimeTypes(mimeType, supportedMimeType)) {
                return true;
            }
        }
        return false;
    }

    private boolean validatePackageName(@Nullable EditorInfo editorInfo) {
        if (editorInfo == null) {
            return false;
        }
        final String packageName = editorInfo.packageName;
        if (packageName == null) {
            return false;
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            return true;
        }

        final InputBinding inputBinding = getCurrentInputBinding();
        if (inputBinding == null) {
            Log.e(TAG, "inputBinding should not be null here. You are likely to be hitting b.android.com/225029");
            return false;
        }
        final int packageUid = inputBinding.getUid();

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            final AppOpsManager appOpsManager = (AppOpsManager) getSystemService(Context.APP_OPS_SERVICE);
            try {
                appOpsManager.checkPackage(packageUid, packageName);
            } catch (Exception e) {
                return false;
            }
            return true;
        }

        final PackageManager packageManager = getPackageManager();
        final String possiblePackageNames[] = packageManager.getPackagesForUid(packageUid);
        for (final String possiblePackageName : possiblePackageNames) {
            if (packageName.equals(possiblePackageName)) {
                return true;
            }
        }
        return false;
    }

    public void onCreate() {
        super.onCreate();
        if (mFirebaseAnalytics == null) {
            mFirebaseAnalytics = FirebaseAnalytics.getInstance(this);
        }
        imagesDir = new File(getFilesDir(), "images");
        imagesDir.mkdirs();
        tempDir = new File(getFilesDir(), "/images/stickers");
        tempDir.mkdirs();
        authority = "com.chippendales.chippmoji";
        stickers = new Stickers(this);
    }

    private Boolean stickerToShare(@NonNull StickerData stickerData) {
        if (editorInfo == null) {
            return false;
        }
        Boolean shared = false;
        ActivityInfo ai = getAppForShare(stickerData);
        if (ai == null) {
            return false;
        } else {
            try {
                String imgType = stickerData.mime;
                String flType = imgType.substring(6);
                File tempFile = new File(tempDir.getPath(), "sticker_" + stickerData.objectId + "." + flType);
                final byte[] buffer = new byte[4096];
                InputStream resourceReader = null;
                OutputStream dataWriter = null;
                try {
                    resourceReader = new FileInputStream(stickerData.file);
                    dataWriter = new FileOutputStream(tempFile);
                    if ("com.whatsapp".equals(ai.packageName)) {
                        tempFile = new File(tempDir.getPath(), "sticker_" + stickerData.objectId + ".jpg");
                        dataWriter = new FileOutputStream(tempFile);
                        Bitmap bitmap = Bitmap.createBitmap(stickerData.width, stickerData.height, Bitmap.Config.ARGB_8888);
                        bitmap.eraseColor(Color.WHITE);
                        Canvas canvas = new Canvas(bitmap);
                        canvas.drawBitmap(BitmapFactory.decodeFile(stickerData.file.getAbsolutePath()), 0, 0, null);
                        bitmap.compress(Bitmap.CompressFormat.JPEG, 90, dataWriter);
                        imgType = "image/jpeg";
                    } else {
                        while (true) {
                            final int numRead = resourceReader.read(buffer);
                            if (numRead <= 0) {
                                break;
                            }
                            dataWriter.write(buffer, 0, numRead);
                        }
                    }

                    //-------------- share
                    Intent intent = new Intent(Intent.ACTION_SEND)
                            //.addCategory(Intent.CATEGORY_LAUNCHER)
                            .setClassName(ai.applicationInfo.packageName, ai.name)
                            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            .addFlags(Intent.FLAG_FROM_BACKGROUND)
                            //.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                            .setComponent(new ComponentName(ai.applicationInfo.packageName, ai.name));
                    intent.setType(imgType);
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                        intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                        dataWriter.flush();
                        dataWriter.close();
                    }

                    if (UrlMap.containsKey(stickerData.imageName)) {
                        intent.putExtra(Intent.EXTRA_TEXT, UrlMap.get(stickerData.imageName));
                    }
                    intent.putExtra(Intent.EXTRA_STREAM, FileProvider.getUriForFile(this, authority, tempFile));
                    getApplicationContext().startActivity(intent);
                    shared = true;
                    Bundle params = new Bundle();
                    params.putString("name", stickerData.imageName);
                    mFirebaseAnalytics.logEvent("EmojiShare", params);
                } finally {
                    if (dataWriter != null) {
                        dataWriter.flush();
                        dataWriter.close();
                    }
                    if (resourceReader != null) {
                        resourceReader.close();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                shared = false;
            }
            return shared;
        }
    }

}
