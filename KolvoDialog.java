package com.example.waiter;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;

import androidx.annotation.NonNull;

public class KolvoDialog extends Dialog implements View.OnClickListener {

    private EditText kolvoEdt;
    private Button okBtn;
    private OnItemClickListener itemClickListener;
    private Context context;

    public void setItemClickListener(OnItemClickListener itemClickListener) {
        this.itemClickListener = itemClickListener;
    }

    public KolvoDialog(@NonNull Context context) {
        super(context);
        this.context = context;

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.custom_dialog);
        okBtn = (Button) findViewById(R.id.dialogLoginBtn);
        okBtn.setOnClickListener(this);
        kolvoEdt = (EditText) findViewById(R.id.dialogNameEt);
        kolvoEdt.requestFocus();
        InputMethodManager imm = (InputMethodManager) context.getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.toggleSoftInput(InputMethodManager.SHOW_FORCED,0);

    }


    @Override
    public void onClick(View v) {

        if (v.getId()== R.id.dialogLoginBtn){
            String kolvo=(kolvoEdt.getText().toString());
            itemClickListener.onItemClick(v,kolvo);
        }


    }


    public interface OnItemClickListener {
        void onItemClick(View view, String obj);
    }
}
