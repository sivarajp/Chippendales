package com.chippendales.stickers;

import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.BitmapFactory;
import android.util.Log;

import com.chippendales.BuildConfig;
import com.chippendales.KeyboardService;
import com.chippendales.packs.PackData;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;


public class Stickers {
    private static final String TAG = "Stickers";
    private static final String SAVE_VERSION = "SAVE_VERSION";
    public List<PackData> packDataListDefault = new ArrayList<>();
    private SharedPreferences sharedPreferences;
    private Context lContext;

    public Stickers(Context context) {
        lContext = context;
        sharedPreferences = context.getSharedPreferences("Chippmoji", Context.MODE_PRIVATE);
        checkVersion(false);
        setDefaultStickerPack();
        sharedPreferences.edit().putInt(SAVE_VERSION, BuildConfig.VERSION_CODE).apply();
    }

    public static String getMimeTypeOfFile(String pathName) {
        Log.e("BitmappathName",pathName);
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

    private void setDefaultStickerPack() {

        String packList[]=new String[0];
        final String PACK_LIB="pack/";
        final String[] emojiList= new String[] { "dancers", "lips", "speechbubbles",};
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
                        final BitmapFactory.Options bitmapOptions = getBitmapOptions(file.getPath());
                        sd.mime = bitmapOptions.outMimeType;
                        sd.iconKey = file;
                        sd.url = null;
                        sd.imageName = img.replaceFirst("[.][^.]+$", "");
                        sd.height = bitmapOptions.outHeight;
                        sd.width = bitmapOptions.outWidth;
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
