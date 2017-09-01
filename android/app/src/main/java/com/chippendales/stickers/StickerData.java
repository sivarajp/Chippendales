package com.chippendales.stickers;

import java.io.File;

/**
 * Created by mist on 13.12.16.
 */

public class StickerData {
    public long objectId;
    public File file;
    public File iconKey;
    public long imageId;
    public String mime; // image/gif
    public String url;
    public long packId;
    public String packName;
    public String imageName;
    public int height;
    public int width;

    @Override
    public String toString() {
        return "StickerData{" +
                "objectId=" + objectId +
                ", file=" + file +
                ", iconKey=" + iconKey +
                ", imageId=" + imageId +
                ", mime='" + mime + '\'' +
                ", url='" + url + '\'' +
                ", packId=" + packId +
                ", packName='" + packName + '\'' +
                ", imageName='" + imageName + '\'' +
                ", width='" + width + '\'' +
                ", height='" + height + '\'' +
                '}';
    }
}
