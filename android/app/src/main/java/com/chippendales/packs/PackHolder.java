package com.chippendales.packs;

import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;

import com.chippendales.R;


public class PackHolder extends RecyclerView.ViewHolder {
    //public final View progressBar;
    public final ImageView imageView;
    //public final TextView textView;

    public PackHolder(View itemView) {
        super(itemView);
        imageView = (ImageView) itemView.findViewById(R.id.rv_item_image);
//        textView = (TextView) itemView.findViewById(R.id.rv_item_text);
//        progressBar = itemView.findViewById(R.id.progressBar);
    }
}