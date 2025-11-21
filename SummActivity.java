package com.example.waiter;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import androidx.core.internal.view.SupportMenu;
import androidx.core.view.ViewCompat;

import android.text.InputType;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.SimpleAdapter;
import android.widget.TextView;
import android.widget.Toast;

import com.example.waiter.model.api.RetrofitClient;
import com.example.waiter.model.db.login.Login;
import com.example.waiter.model.db.orders.Orders;
import com.example.waiter.model.db.users.Users;
import com.example.waiter.util.ErrorString;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class SummActivity extends Activity {
    public static final String EXTRA_IS_CLOSED = "uz.software.raa.is_closed";
    public static final String EXTRA_SCHET_ID = "uz.software.raa.schet_id";
    public static final String EXTRA_STOL_NUM = "uz.software.raa.stol_num";
    public static final String EXTRA_USER_ID1 = "uz.software.raa.user_id";
    final String AT_ORDER_ID = "orderIDAttr";
    final String AT_ORDER_OTKRIT = "orderOtkritAttr";
    final String AT_ORDER_STOL = "orderStolAttr";
    final String AT_ORDER_SUMM = "orderSummAttr";
    final String AT_ORDER_ZAKRIT = "orderZakritAttr";
    private Button btn = null;
    private TextView inf = null;
    private ServerConnection mServer = null;
    private OrdersArr orders;

    private String orderId = "";
    ArrayList<Orders> orderList = new ArrayList<>();
    private ArrayList<Users> userList = new ArrayList<>();
    /*private int ordersCnt = 0;*/
    private ListView ordersListView;

    private ProgressBar progressBar;
    private EditText stolEdt = null;
    private TextView ttl = null;
    private int userId = 0;
    private int userType = 0;
//    public static int userId = 0;
    private String userName = "";
    private Boolean isUsing = true;

    /* renamed from: uz.software.raa.kafemanager.SummActivity$1 */
    class C02231 implements OnItemClickListener {
        C02231() {
        }

        public void onItemClick(AdapterView<?> adapterView, View view, int position, long id) {

            int schetId = ((Order) SummActivity.this.orders.getOrders().get(position)).getAllOrderID();
            int stolNum = ((Order) SummActivity.this.orders.getOrders().get(position)).getStol();
            int isClosed = 1;
            if (((Order) SummActivity.this.orders.getOrders().get(position)).getZakrit().compareTo("24:00") == 0) {
                isClosed = 0;
            }
            Intent i = new Intent(SummActivity.this, SchetActivity.class);
            i.putExtra(MainActivity.EXTRA_USER_ID, SummActivity.this.userId);
            i.putExtra(MainActivity.EXTRA_USER_TYPE, SummActivity.this.userType);
            i.putExtra(MainActivity.EXTRA_USER_NAME, SummActivity.this.userName);
            i.putExtra(SummActivity.EXTRA_SCHET_ID, schetId);
            i.putExtra("orderId", SummActivity.this.orders.getOrders().get(position).getOrderId());
            i.putExtra(SummActivity.EXTRA_STOL_NUM, stolNum);
            i.putExtra(SummActivity.EXTRA_IS_CLOSED, isClosed);
            SummActivity.this.startActivity(i);
            //SummActivity.this.finish();
        }
    }

    class MySimpleAdapter extends SimpleAdapter {
        public MySimpleAdapter(Context context, List<? extends Map<String, ?>> data, int resource, String[] from, int[] to) {
            super(context, data, resource, from, to);
        }

        public void setViewText(TextView v, String text) {
            super.setViewText(v, text);
            if (v.getId() != R.id.tvZakrit) {
                return;
            }
            if (text.compareTo("24:00") == 0) {
                v.setTextColor(SupportMenu.CATEGORY_MASK);
                v.setBackgroundColor(-16711936);
                return;
            }
            v.setTextColor(ViewCompat.MEASURED_STATE_MASK);
            v.setBackgroundColor(-1);
        }
    }

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.summary);

        this.userId = getIntent().getIntExtra(MainActivity.EXTRA_USER_ID, 1);
        this.userType = getIntent().getIntExtra(MainActivity.EXTRA_USER_TYPE, 1);
        this.userName = getIntent().getStringExtra(MainActivity.EXTRA_USER_NAME);
        System.out.println("is manager " + userType);
        this.btn = (Button) findViewById(R.id.newOrderButton);
        this.btn.setEnabled(false);
        this.stolEdt = (EditText) findViewById(R.id.editStolNum);
        this.inf = (TextView) findViewById(R.id.infoTextView);
        this.orders = new OrdersArr();
        this.ordersListView = (ListView) findViewById(R.id.ordersListView);
        ordersListView.setVisibility(View.GONE);
        progressBar = findViewById(R.id.progress_circularS);
        progressBar.setVisibility(View.VISIBLE);

        ordersListView.setOnItemClickListener(new C02231());
        btn.setEnabled(true);
        hideKeyboard();

        ttl = (TextView) findViewById(R.id.titleTextView);

        if (userId == 0) {
            ttl.setText("Менеджер:  " + userName);
        }
        if (userId!= 0) {
            ttl.setText("Официант:  " + userName);
        }

        getServAnswer();

    }

    public void reDrawOrders() {
        ArrayList<Map<String, Object>> data = new ArrayList(orders.getOrders().size());

        for (int i = 0; i < orders.getOrders().size(); i++) {
            Map<String, Object> m = new HashMap();
            m.put("orderIDAttr", Integer.valueOf(( orders.getOrders().get(i)).getOrderId()));
            m.put("orderStolAttr", Integer.valueOf(( orders.getOrders().get(i)).getStol()));
            m.put("orderOtkritAttr", (orders.getOrders().get(i)).getOtkrit());
            m.put("orderZakritAttr", (orders.getOrders().get(i)).getZakrit());
            m.put("orderSummAttr", formatMoney((orders.getOrders().get(i)).getSumma()));
            data.add(m);
        }
        MySimpleAdapter sAdapter = new MySimpleAdapter(this, data, R.layout.orderitem,
                new String[]{"orderIDAttr", "orderStolAttr", "orderOtkritAttr", "orderZakritAttr", "orderSummAttr"},
                new int[]{R.id.tvOrderNum, R.id.tvStol, R.id.tvOtkrit, R.id.tvZakrit, R.id.tvSumma});

        this.ordersListView.setAdapter(sAdapter);
        this.ordersListView.setAdapter(sAdapter);

        if (this.userId == 0) {
            this.inf.setText("Всего заказов: " + formatMoney(orders.getOrders().size()) + "    На сумму: " + formatMoney(this.orders.getOrdersSumm()));
//            this.ttl.setText("Менеджер " + this.userName);
        }
        if (this.userId !=0) {
            this.inf.setText("Всего заказов: " + orders.getOrders().size());
//            this.ttl.setText("Официант:  " + this.userName);
        }
        this.stolEdt.setText("");

    }

    public void getServAnswer() {

        Call<ArrayList<Orders>> call = RetrofitClient.getInstance().getMyApi().getUserOrders(String.valueOf(userId),String.valueOf(userName));
        call.enqueue(new Callback<ArrayList<Orders>>() {
            @Override
            public void onResponse(Call<ArrayList<Orders>> call, Response<ArrayList<Orders>> response) {

                orderList.clear();
                orderList.addAll(response.body());

                orders.setUpOrders(orderList);
                System.out.println(orderList.size());
                //ordersCnt = orders.getOrdersCnt();
                ordersListView.setVisibility(View.VISIBLE);
                progressBar.setVisibility(View.GONE);


                reDrawOrders();
            }

            @Override
            public void onFailure(Call<ArrayList<Orders>> call, Throwable t) {
                Toast.makeText(getApplicationContext(), ErrorString.Error_Orders, Toast.LENGTH_LONG).show();
            }

        });



    }

    private boolean getUsing() {

        Call<String> call = RetrofitClient.getInstance().getMyApi().getCheckUsing();
        call.enqueue(new Callback<String>() {
            @Override
            public void onResponse(Call<String> call, Response<String> response) {

                if (response.body() == null){
                    Toast.makeText(getApplicationContext(), ErrorString.Error_List_Users, Toast.LENGTH_LONG).show();
                    return;
                }

                if (response.body().equals("1")){
                    isUsing = true;
                } else {
                    Toast.makeText(getApplicationContext(), response.body(), Toast.LENGTH_LONG).show();
                    isUsing = false;
                }

            }

            @Override
            public void onFailure(Call<String> call, Throwable t) {
                Toast.makeText(getApplicationContext(), ErrorString.Error_List_Users, Toast.LENGTH_LONG).show();
            }

        });
        return isUsing;
    }

    public void onClickNewOrderButton(View paramView) {

        /*getUsing();

        if (!isUsing){
            //Toast.makeText(this,str,Toast.LENGTH_SHORT).show();
            return;
        }*/

        System.out.println("--------------------");

        if (this.stolEdt.getText().toString().equals("")){
            Toast.makeText(this,"Номер стола пустой!",Toast.LENGTH_SHORT).show();
            return;
        }
        progressBar.setVisibility(View.VISIBLE);
        final String[] answ = {"-1"};

        int j = Integer.parseInt(this.stolEdt.getText().toString());
        int i;
        if (j >= 0) {
            i = j;
//            if (j <= 150) {}
            if (j >= 450) {
            }
        } else {
            i = 1;
        }

        Call<String> call = RetrofitClient.getInstance().getMyApi().getTableCheck(String.valueOf(i));
        call.enqueue(new Callback<String>() {
            @Override
            public void onResponse(Call<String> call, Response<String> response) {

                if (response.body() == null) {
                    Toast.makeText(getApplicationContext(), ErrorString.Error_Open_Table, Toast.LENGTH_LONG).show();
                    return;
                }

                answ[0] = response.body().toString();
                System.out.println(response.body() + "-----------------");

                System.out.println(answ[0]);
                if (answ[0].equals("-1")) {
                    Toast.makeText(SummActivity.this, i + " - занята!", Toast.LENGTH_SHORT).show();
                    return;
                }
                progressBar.setVisibility(View.GONE);
                Intent i2 = new Intent(SummActivity.this, SchetActivity.class);
                i2.putExtra("uz.software.raa.user_id", userId);
                i2.putExtra("uz.software.raa.schet_id", 0);
                i2.putExtra("uz.software.raa.stol_num", i);
                i2.putExtra("uz.software.raa.is_closed", 0);
                i2.putExtra("uz.software.raa.user_name", userName);
                i2.putExtra(MainActivity.EXTRA_USER_TYPE, SummActivity.this.userType);
                startActivity(i2);
                //finish();
            }

            @Override
            public void onFailure(Call<String> call, Throwable t) {
                Toast.makeText(getApplicationContext(), ErrorString.Error_Open_Table, Toast.LENGTH_LONG).show();
            }
        });


    }

    private int tableCheck(){

        final String[] listItems = new String[]{"С собой", "Зал №-1", "Зал №-2", "Тапчан", "Кароват", "Кабина", "Стол"};
        final int table[] = {0,1};

        AlertDialog.Builder boite;
        boite = new AlertDialog.Builder(SummActivity.this);
        boite.setTitle(" Новый заказ ");

        final EditText input = new EditText(SummActivity.this);
        input.setInputType(InputType.TYPE_CLASS_NUMBER);
        boite.setView(input);

        boite.setSingleChoiceItems(listItems, -1, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int whichButton) {

                table[0] = whichButton;

            }
        });

        boite.setCancelable(false);

        boite.setPositiveButton("Открыть заказ", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {

                if (table[0] == 0) {
                    table[0] = 0;
                }
                if (table[0] == 1)
                    table[0] = Integer.valueOf(input.getText().toString());

                if (table[0] == 2)
                    table[0] = 50 + Integer.valueOf(input.getText().toString());

                if (table[0] == 3) {
                    table[0] = 100 + Integer.valueOf(input.getText().toString());
                }
                if (table[0] == 4) {
                    table[0] = 150 + Integer.valueOf(input.getText().toString());
                }
                if (table[0] == 5) {
                    table[0] = 200 + Integer.valueOf(input.getText().toString());
                }
                if (table[0] == 6) {
                    table[0] = 250 + Integer.valueOf(input.getText().toString());
                }

            }
        });
        boite.setNegativeButton("Отмена", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {

            }
        });
        boite.create();
        boite.show();

        return table[0];
    }

    public void onClickBtnRefresh(View view) {
        getServAnswer();
        //this.ordersCnt = this.orders.getOrdersCnt();
        reDrawOrders();
    }

    public static String formatMoney(double paramDouble) {
        DecimalFormat localDecimalFormat = new DecimalFormat("#,###.##");
        DecimalFormatSymbols localDecimalFormatSymbols = new DecimalFormatSymbols();
        localDecimalFormatSymbols.setDecimalSeparator('.');
        localDecimalFormatSymbols.setGroupingSeparator(' ');
        localDecimalFormat.setDecimalFormatSymbols(localDecimalFormatSymbols);
        localDecimalFormat.setDecimalSeparatorAlwaysShown(false);
        return localDecimalFormat.format(paramDouble);
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        Intent intent=new Intent(this,MainActivity.class);
        intent.putExtra("uz.software.raa.user_id",this.userId);
        intent.putExtra(MainActivity.EXTRA_USER_NAME,getIntent().getStringExtra(MainActivity.EXTRA_USER_NAME));
        startActivity(intent);
        reDrawOrders();
        finish();
    }

    protected void hideKeyboard() {

//        stolEdt.setInputType(InputType.TYPE_NULL);
//
//        stolEdt.requestFocus();
//        InputMethodManager mgr = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
//        mgr.showSoftInput(stolEdt, InputMethodManager.SHOW_FORCED);
    }

    @Override
    protected void onResume() {
        super.onResume();

        getServAnswer();
    }

    @Override
    protected void onStart() {
        super.onStart();

        //getUsers();
    }
}
