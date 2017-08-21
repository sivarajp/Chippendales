package com.chippendales.stickers;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.bumptech.glide.Glide;
import com.chippendales.KeyboardService;
import com.chippendales.R;

import java.util.ArrayList;
import java.util.List;


public class StickerAdapter extends RecyclerView.Adapter<StickerHolder> {
    private final String TAG = "StickerAdapter";
    private List<StickerData> stickerDataList = new ArrayList<StickerData>();
    private KeyboardService keyboardService;

    public StickerAdapter(KeyboardService kis, List<StickerData> sdl) {
        this.keyboardService = kis;
        this.stickerDataList = sdl;
    }

    @Override
    public StickerHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.recycler_item, parent, false);
        if (keyboardService.selectedTab == 2) {
            view = LayoutInflater.from(parent.getContext()).inflate(R.layout.dancer_recycler_item, parent, false);
        }
        return new StickerHolder(view);
    }

    @Override
    public void onBindViewHolder(final StickerHolder holder, final int position) {
        final StickerData sticker = stickerDataList.get(position);

        try {
            Bitmap ico = BitmapFactory.decodeFile(sticker.iconKey.getPath());
            if (sticker.mime.equals("image/gif")) {
                Log.e("Gif file name", sticker.iconKey.getPath());
                Glide.with(keyboardService.getBaseContext()).load(sticker.iconKey.getPath()).into(holder.imageView);
            } else {
                holder.imageView.setImageBitmap(ico);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        holder.imageView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                keyboardService.inputContent(sticker, position);
            }
        });
    }

    @Override
    public int getItemCount() {
        return stickerDataList.size();
    }
}
