package com.chippendales.stickers;

import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;
import android.util.TypedValue;

import com.chippendales.BuildConfig;
import com.chippendales.KeyboardService;
import com.chippendales.packs.PackData;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;


public class Stickers {
    private static final String TAG = "Stickers";
    private static final String PACK_DATA_LIST = "PACK_DATA_LIST";
    private static final String SAVE_VERSION = "SAVE_VERSION";
    public StickerpacksResponse stickerpacksResponse;
    public final List<PackData> packDataList = new ArrayList<>();
    public List<PackData> packDataListDefault = new ArrayList<>();

    private SharedPreferences sharedPreferences;
    private long lastDownload = 0;
    private Context lContext;

    public Stickers(Context context) {
        lContext = context;
        sharedPreferences = context.getSharedPreferences("Chippmoji", Context.MODE_PRIVATE);
        checkVersion(false);
        setDefaultStickerPack();
    }

    public static Boolean isGif(String pathName) {
        if ("image/gif".equals(getMimeTypeOfFile(pathName))) {
            return true;
        }
        return false;
    }

    public static String getMimeTypeOfFile(String pathName) {
        BitmapFactory.Options opt = new BitmapFactory.Options();
        opt.inJustDecodeBounds = true;
        BitmapFactory.decodeFile(pathName, opt);
        return opt.outMimeType;
    }

    public static BitmapFactory.Options getBitmapOptions(String path) {
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeFile(path,options);
        options.inJustDecodeBounds = false;
        return options;
    }

    public void loadStickers(final CallbackStickersLoaded callback) {
        callback.pack();
    }


    // Resize bitmap for icon key
    private File createIconKey(File imageFile, String localeFileName) {
        final File outputFile = new File(KeyboardService.imagesDir, localeFileName);
        if (outputFile.exists()) {
            return outputFile;
        }
        try {
            OutputStream dataWriter = new FileOutputStream(outputFile);
            Bitmap bm = BitmapFactory.decodeFile(imageFile.getPath());
            if (bm == null) {
                imageFile.delete();
                return null;
            }
            try {
                float px = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, 50, lContext.getResources().getDisplayMetrics());
                int optimaDp = Math.round(px);
                //int height = Math.round(bm.getHeight() / (bm.getWidth() / optimaWidth));

                int width = 0;
                int height = 0;
                if(bm.getWidth() > bm.getHeight()){
                    double kf = (double) bm.getWidth() / (double) optimaDp;
                    width = optimaDp;
                    height = (int) Math.round((double) bm.getHeight() / kf);
                } else if (bm.getHeight() > bm.getWidth()){
                    double kf = ((double) bm.getHeight() / (double) optimaDp);
                    height=optimaDp;
                    width = (int) Math.round((double) bm.getWidth() / kf);
                } else {
                    width=optimaDp;
                    height=optimaDp;
                }

                Log.v("TAG",localeFileName+"-------------------------------------------------------");
                Log.v("TAG","w: "+bm.getWidth()+" h: "+bm.getHeight());
                Log.v("TAG","w: "+width+" h1: "+height);

                Bitmap ico = Bitmap.createScaledBitmap(bm, width, height, true);
                ico.compress(Bitmap.CompressFormat.WEBP, 100, dataWriter);
                Log.i(TAG, "create icon " + outputFile.getName() + ": " + outputFile.length() + " bytes; Width: " + width + "px Height: " + height);
                return outputFile;
            } finally {
                if (dataWriter != null) {
                    dataWriter.flush();
                    dataWriter.close();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    private File downloadFile(String url, String localeFileName) {
        final File outputFile = new File(KeyboardService.imagesDir, localeFileName);
        if (outputFile.exists()) {
            return outputFile;
        }
        try {
            InputStream resourceReader = (InputStream) new URL(url).getContent();
            final byte[] buffer = new byte[4096];
            OutputStream dataWriter = new FileOutputStream(outputFile);
            try {
                while (true) {
                    final int numRead = resourceReader.read(buffer);
                    if (numRead <= 0) {
                        break;
                    }
                    dataWriter.write(buffer, 0, numRead);
                }
                if (outputFile.length() > 0) {
                    Log.i(TAG, "load file: " + outputFile.getName() + ": " + outputFile.length() + " bytes");
                    return outputFile;
                } else {
                    outputFile.delete();
                    return null;
                }
            } finally {
                if (dataWriter != null) {
                    dataWriter.flush();
                    dataWriter.close();
                }
                if (resourceReader != null) {
                    resourceReader.close();
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    private void defAppPack(){
        try {
            String packList[] = lContext.getAssets().list("pack_app");
            for(String img: packList){
                Log.i("###>>>",img);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    private void setDefaultStickerPack() {
        checkVersion(true);
        String packList[]=new String[0];
        final String PACK_LIB="pack/";
        final String[] emojiList= new String[] {"lips", "speechbubbles", "dancers"};
        for(String emojiName : emojiList) {
            String curAssets = "";
            try {
                curAssets = PACK_LIB + emojiName;
                packList = lContext.getAssets().list(curAssets);
            } catch (IOException e) {
                e.printStackTrace();
            }
            if (packList != null && packList.length > 0) {
                long packId = 1;
                PackData packData = new PackData();
                packData.objectId = packId;
                packData.name = "Chippmoji";
                List<StickerData> stickerData = new ArrayList<StickerData>();
                long i = 0;
                for (String img : packList) {
                    InputStream sIs = null;
                    try {
                        sIs = lContext.getAssets().open(curAssets + "/" + img);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    if (sIs != null) {
                        StickerData sd = new StickerData();
                        i = i + 1;
                        File file = copyImgFile(sIs, "s" + img);
                        sd.objectId = i;
                        sd.imageId = i;
                        sd.packId = packId;
                        sd.packName = packData.name;
                        sd.file = file;
                        sd.mime = getMimeTypeOfFile(file.getPath());//"image/gif"
                        sd.iconKey = file;
//                        if (isGif(file.getPath())) {
//                            sd.iconKey = file;
//                        } else {
//                            sd.iconKey = createIconKey(file, "si" + img);
//                        }
                        sd.url = null;
                        stickerData.add(sd);
                    }
                }
                packData.stickers = stickerData;
                packDataListDefault.add(packData);
                Log.e("Testing", stickerData.toString());
            }
        }
    }

    private File copyImgFile(InputStream resourceReader, String localeFileName) {
        try {
            final File tempFile = new File(KeyboardService.imagesDir, localeFileName);
            final byte[] buffer = new byte[4096];
            OutputStream dataWriter = null;
            try {
                dataWriter = new FileOutputStream(tempFile);
                while (true) {
                    final int numRead = resourceReader.read(buffer);
                    if (numRead <= 0) {
                        break;
                    }
                    dataWriter.write(buffer, 0, numRead);
                }

                return tempFile;

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
        }
        return null;
    }

    private void checkVersion(Boolean del) {
        //BuildConfig.VERSION_CODE;
        int saveVersion = sharedPreferences.getInt(SAVE_VERSION, 0);
        Log.i(TAG, "Check version: old: "+saveVersion+" current: "+BuildConfig.VERSION_CODE);
        if ((saveVersion != BuildConfig.VERSION_CODE) || del) {
            sharedPreferences.edit().clear().commit();
            clearCash(KeyboardService.imagesDir);
            clearCash(KeyboardService.tempDir);
        }
    }

    public void clearCash(File dir) {
        Log.d(TAG, "--- Clear cash ---");
        File[] files = dir.listFiles();
        if (files != null) {
            for (File file : files) {
                if (!file.isDirectory()) {
                    Log.v(TAG, "--- " + file.getName() + " delete");
                    file.delete();
                }
            }
        }
    }

    public interface CallbackStickersLoaded {
        void pack();
    }

}
