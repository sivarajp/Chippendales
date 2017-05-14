package com.chippendales.stickers;

import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;

import com.chippendales.R;


public class StickerHolder  extends RecyclerView.ViewHolder {
    public ImageView imageView;

    public StickerHolder(View itemView) {
        super(itemView);
        imageView = (ImageView) itemView.findViewById(R.id.imageItem);
    }
}
