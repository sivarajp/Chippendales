package com.chippendales.packs;


import com.chippendales.stickers.StickerData;

import java.io.File;
import java.util.List;

/**
 * Created by mist on 21.12.16.
 */

public class PackData {
    public long objectId;
    public File iconOn;
    public File iconOff;
    public String name;
    public List<StickerData> stickers;
}