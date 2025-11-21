package com.example.waiter;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.Toast;

import com.example.waiter.model.api.RetrofitClient;
import com.example.waiter.model.db.login.Login;
import com.example.waiter.util.ErrorString;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;


public class MainActivity extends Activity {

    public static final String EXTRA_USER_ID = "uz.software.raa.user_id";
    public static final String EXTRA_USER_NAME = "uz.software.raa.user_name";
    public static final String EXTRA_USER_TYPE = "uz.software.raa.user_type";
    private EditText ed = null;
    private ServerConnection mServer = null;
    private int userId = 0;
    private String userName = "";
    private Integer userType = 1;
    private static long backPressed = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        this.ed = (EditText) findViewById(R.id.passwEditText);

    }

    public void onClickEnterButton(View view) {
        if (this.ed.getText().toString() != "") {

            Call<Login> call = RetrofitClient.getInstance().getMyApi().getUserData(this.ed.getText().toString());  ///
            call.enqueue(new Callback<Login>() {
                @Override
                public void onResponse(Call<Login> call, Response<Login> response) {



                    if (response.body() == null){
                        Toast.makeText(getApplicationContext(), ErrorString.Error_Password, Toast.LENGTH_LONG).show();
                        return;
                    }

                    Login myheroList = response.body();
                    System.out.println(myheroList);
                    Login.User[] oneHeroes = new Login.User[myheroList.getUser().size()];

                    for (int i = 0; i < myheroList.getUser().size(); i++) {
                        oneHeroes[i] = myheroList.getUser().get(i);
                        System.out.println(oneHeroes[i].getUSERID());
                        System.out.println(oneHeroes[i].getUSERNAIM());
                        System.out.println(oneHeroes[i].getISACTIVE());
                    }

                    if (oneHeroes[0].getISACTIVE() == 1){
                        userId = oneHeroes[0].getUSERID();
                        userName = oneHeroes[0].getUSERNAIM();
                        if (oneHeroes[0].getWORKERID() == 1){
                            userType = 1;
                        } else {
                            userType = 0;
                        }
                        System.out.println("is manager " + userType);
                        next();
                    }

                }

                @Override
                public void onFailure(Call<Login> call, Throwable t) {
                    Toast.makeText(getApplicationContext(), ErrorString.Error_Users, Toast.LENGTH_LONG).show();
                }

            });

        }
    }

    private void next(){
        Intent i2 = new Intent(this, SummActivity.class);
        i2.putExtra(EXTRA_USER_ID, this.userId);
        i2.putExtra(EXTRA_USER_NAME, this.userName);
        i2.putExtra(EXTRA_USER_TYPE, this.userType);
        startActivity(i2);
        finish();
    }

    @Override
    public void onBackPressed() {
        if (backPressed + 2500 > System.currentTimeMillis()) {
            finish();
        } else {
            Toast.makeText(getApplicationContext(), "Нажмите еще раз чтобы выйти",Toast.LENGTH_LONG).show();
        }
        backPressed = System.currentTimeMillis();
    }

}
