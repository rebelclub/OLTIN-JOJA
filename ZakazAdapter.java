package com.example.waiter;

import android.content.Context;
import android.os.Build;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.core.internal.view.SupportMenu;
import androidx.core.view.InputDeviceCompat;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.List;

public class ZakazAdapter extends ArrayAdapter<Zakaz> {

    interface OnCommentClickListener{
        void onCommentClick(Zakaz zakaz, int position);
    }

    interface OnItemClickListener{
        void onItemClickListener(int position);
    }

    private final OnCommentClickListener onCommentClickListener;
    private final OnItemClickListener onItemClickListener;

    private final Context context;
    private final LayoutInflater inflater;
    private final ArrayList<Zakaz> zakazs;

    ZakazAdapter(Context context, ArrayList<Zakaz> zakazs, OnCommentClickListener onClickListener, OnItemClickListener onItemClickListener ) {
        super(context,0,zakazs);
        this.context = context;
        this.onCommentClickListener = onClickListener;
        this.onItemClickListener = onItemClickListener;
        this.zakazs = zakazs;
        this.inflater = LayoutInflater.from(context);
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {

        View currentItemView = convertView;

        if (currentItemView == null) {
            currentItemView = LayoutInflater.from(getContext()).inflate(R.layout.zakazitem_new, parent, false);
        }

        Zakaz zakaz = getItem(position);

        Integer printed = zakaz.getZakazPrinted();
        String name = zakaz.getZakazNaim();
        String nn = String.valueOf(zakaz.getZakazNN());
        String count = String.valueOf(zakaz.getZakazKolvo());
        Double summ = (zakaz.getZakazSumm());
        String comment = zakaz.getmZakazComment();

        ImageView tvzEditComment_new;
        TextView tvzNN_new, tvzNaim_new, tvzKolvo_new, tvzSumm_new, tvzComment_new;
        tvzNN_new = currentItemView.findViewById(R.id.tvzNN_new);
        tvzNaim_new = currentItemView.findViewById(R.id.tvzNaim_new);
        tvzKolvo_new = currentItemView.findViewById(R.id.tvzKolvo_new);
        tvzSumm_new = currentItemView.findViewById(R.id.tvzSumm_new);
        tvzComment_new = currentItemView.findViewById(R.id.tvzComment_new);
        tvzEditComment_new = currentItemView.findViewById(R.id.tvzEditComment_new);

        assert zakaz != null;
        //numbersImage.setImageResource(currentNumberPosition.getNumbersImageId());

        if (printed == 0){
            tvzNN_new.setText(nn);
            tvzNN_new.setTextColor(context.getColor(R.color.black));
            tvzNN_new.setBackgroundColor(context.getColor(R.color.white));
        }
        if (printed == 1){
            tvzNN_new.setText(nn);
            tvzNN_new.setTextColor(SupportMenu.CATEGORY_MASK);
            tvzNN_new.setBackgroundColor(InputDeviceCompat.SOURCE_ANY);
        }

        if (comment.equals("empty")){
            tvzComment_new.setVisibility(View.GONE);
        } else if (comment.equals("")){
            tvzComment_new.setVisibility(View.GONE);
        } else {
            tvzComment_new.setVisibility(View.VISIBLE);
            tvzComment_new.setText(comment);
        }


        tvzNaim_new.setText(name);
        tvzKolvo_new.setText(count);
        tvzSumm_new.setText(SchetActivity.formatMoney(summ));

        currentItemView.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v)
            {
                onItemClickListener.onItemClickListener(position);
            }
        });

        tvzEditComment_new.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                onCommentClickListener.onCommentClick(zakaz, position);

            }
        });

        return currentItemView;
    }

    /*@Override
    public void onBindViewHolder(ZakazAdapter.ViewHolder holder, int position) {
        int pos = position;
        Zakaz zakaz = zakazs.get(pos);

        Integer printed = zakaz.getZakazPrinted();
        String name = zakaz.getZakazNaim();
        String nn = String.valueOf(zakaz.getZakazNN());
        String count = String.valueOf(zakaz.getZakazKolvo());
        String summ = String.valueOf(zakaz.getZakazSumm());
        String comment = zakaz.getmZakazComment();

        System.out.println(zakaz.getZakazNaim());
        System.out.println(zakaz.getZakazPrinted());
        System.out.println(zakaz.getmZakazComment());

        if (printed == 0){
            holder.tvzNN_new.setText(nn);
        }
        if (printed == 1){
            holder.tvzNN_new.setText(nn);
            holder.tvzNN_new.setTextColor(SupportMenu.CATEGORY_MASK);
            holder.tvzNN_new.setBackgroundColor(InputDeviceCompat.SOURCE_ANY);
        }

        if (comment.equals("empty")){
            holder.tvzComment_new.setVisibility(View.GONE);
        } else if (comment.equals("")){
            holder.tvzComment_new.setVisibility(View.GONE);
        } else {
            holder.tvzComment_new.setText(comment);
        }


        holder.tvzNaim_new.setText(name);
        holder.tvzKolvo_new.setText(count);
        holder.tvzSumm_new.setText(summ);


        holder.itemView.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v)
            {
                onItemClickListener.onItemClickListener(pos);
            }
        });

        holder.tvzEditComment_new.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                onCommentClickListener.onCommentClick(zakaz, pos);

            }
        });
    }

    @Override
    public int getItemCount() {
        return zakazs.size();
    }

    public static class ViewHolder extends RecyclerView.ViewHolder {
        ImageView tvzEditComment_new;
        TextView tvzNN_new, tvzNaim_new, tvzKolvo_new, tvzSumm_new, tvzComment_new;
        ViewHolder(View view){
            super(view);
            tvzNN_new = view.findViewById(R.id.tvzNN_new);
            tvzNaim_new = view.findViewById(R.id.tvzNaim_new);
            tvzKolvo_new = view.findViewById(R.id.tvzKolvo_new);
            tvzSumm_new = view.findViewById(R.id.tvzSumm_new);
            tvzComment_new = view.findViewById(R.id.tvzComment_new);
            tvzEditComment_new = view.findViewById(R.id.tvzEditComment_new);
        }
    }*/
}
