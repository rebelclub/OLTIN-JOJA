package com.example.waiter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.List;

public class CategoryAdapter extends RecyclerView.Adapter<CategoryAdapter.ViewHolder> {

    private List<CategoryData> categoryDataList;
    private Context context;
    private onClickItemListener itemListener=new onClickItemListener() {
        @Override
        public void onClick(CategoryData data) {

        }
    };

    public CategoryAdapter(Context context, List<CategoryData> categoryDataList) {
        this.categoryDataList = categoryDataList;
        this.context = context;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view= LayoutInflater.from(parent.getContext()).inflate(R.layout.schet_item,parent,false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        CategoryData categoryData=categoryDataList.get(position);
        if (holder instanceof ViewHolder){
            holder.textButton.setText(categoryData.getCatname());

        }
    }

    @Override
    public int getItemCount() {
        return (categoryDataList!=null)?categoryDataList.size():0;
    }

    class ViewHolder extends RecyclerView.ViewHolder{

        Button textButton;

        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            textButton=(Button) itemView.findViewById(R.id.btnOtd);
        }
    }


    interface onClickItemListener{
        public void onClick(CategoryData data);
    }
}
