package com.example.waiter;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.content.res.Configuration;

import androidx.recyclerview.widget.GridLayoutManager;

import androidx.core.internal.view.SupportMenu;
import androidx.core.view.InputDeviceCompat;
import androidx.core.view.ViewCompat;
import androidx.recyclerview.widget.RecyclerView;

import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
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
import com.example.waiter.model.db.bills.BillsList;
import com.example.waiter.model.db.foods.Foods;
import com.example.waiter.model.db.new_order.NewOrders;
import com.example.waiter.model.db.update_order.UpdateOrder;
import com.example.waiter.util.ClickListener;
import com.example.waiter.util.ErrorString;
import com.example.waiter.util.RecyclerTouchListener;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class SchetActivity extends Activity implements ZakazAdapter.OnItemClickListener, ZakazAdapter.OnCommentClickListener {

    private BludsArr bluds = new BludsArr();
    private ArrayList<Bluds> bludsList = new ArrayList<Bluds>();
    private ListView bludsListView;
    private ProgressBar progressBarB;
    private RecyclerView recyclerView;
    private Button btnKod = null;
    private Button btnSend = null;
    private EditText edtKod = null;
    private int isClosed = 0;
    private String userName = "";
    private TextView itogoInfo = null;
    private ServerConnection mServer = null;
    private int schetId = 0;
    private int orderId = 0;
    private TextView schetInfo = null;
    private int stolNum = 1;
    private int stolSumm = 0;
    private int userId = 0;
    private int userType = 1;
    private TextView wayterInfo = null;
    private ListView zakazListView;
    private ProgressBar progressBarZ;
    private ZakazAdapter zakazAdapter;
    private ZakazArr zakazs = new ZakazArr();
    private CategoryAdapter categoryAdapter;
    private RecyclerView otdlist;
    private List<CategoryData>categoryDataList=new ArrayList<>();
    private boolean isSearchOpened = false;
    private int otdel = 0;
    private String openedTime = "";
//    private Boolean isManager = false;
    private Boolean isManager = true;
    private int lastZakaz = 0;
    int spanCount=4;
    private Boolean sendBtn = true;
    @Override
    public void onCommentClick(Zakaz zakaz, int position) {
        ///  schyot is closed
        if (SchetActivity.this.isClosed != 1) {

            if (zakazs.getZakazs().get(position).getZakazPrinted() == 0){
                /// create an alert builder
                AlertDialog.Builder builder = new AlertDialog.Builder(this);
                builder.setTitle("Добавить комментарий на заказ!");
                /// set the custom layout
                final View customLayout = getLayoutInflater().inflate(R.layout.dialog_layout, null);
                builder.setView(customLayout);
                /// add a button
                builder.setPositiveButton("OK", (dialog, which) -> {
                    // send data from the AlertDialog to the Activity
                    EditText editText = customLayout.findViewById(R.id.editText);
                    // sendDialogDataToActivity(editText.getText().toString());
                    String comment = editText.getText().toString();
                    Toast.makeText(this, comment, Toast.LENGTH_SHORT).show();
                    zakazs.editCommentZakaz(comment,position);
                    reDrawZakazs();
                });
                // show the alert dialog
                AlertDialog dialog = builder.create();
                dialog.show();

            }

        }

    }
    @Override
    public void onItemClickListener(int position) {

        if (SchetActivity.this.isClosed != 1  ) {
            //  SchetActivity.this.zakazs.DecBludoFromZakaz(position)
            lastZakaz = position;

            if (SchetActivity.this.zakazs.getZakazs().get(position).getZakazPrinted() == 1){
                if (isManager){
                    if (SchetActivity.this.zakazs.getZakazs().get(position).getmZakazType() == 1){
                        KolvoDialog dialog = new KolvoDialog(SchetActivity.this);
                        dialog.show();

                        dialog.setItemClickListener(new KolvoDialog.OnItemClickListener() {
                            @Override
                            public void onItemClick(View view, String obj) {

                                if (!obj.equals("")){
                                    double kolvo = Double.parseDouble(obj);
                                    if (!SchetActivity.this.zakazs.DecBludoFromZakazTyped(position, kolvo)){
                                        Toast.makeText(SchetActivity.this,"Error smaller than kolvo",Toast.LENGTH_SHORT).show();
                                    }
                                    dialog.dismiss();
                                    hideKeyboard(view);
                                    SchetActivity.this.reDrawZakazs();
                                } else {
                                    dialog.dismiss();
                                    hideKeyboard(view);
                                    Toast.makeText(SchetActivity.this,"Error Empty",Toast.LENGTH_SHORT).show();
                                }
                            }
                        });
                    } else {
                        if (SchetActivity.this.zakazs.DecBludoFromZakaz(position)){
                            //hideKeyboard(view);
                            SchetActivity.this.reDrawZakazs();
                        }
                    }
                } else {
                    Toast.makeText(SchetActivity.this,"Вы не имеете права отменять заказы!",Toast.LENGTH_SHORT).show();
                }
            } else {
                if (SchetActivity.this.zakazs.getZakazs().get(position).getmZakazType() == 1){
                    KolvoDialog dialog = new KolvoDialog(SchetActivity.this);
                    dialog.show();

                    dialog.setItemClickListener(new KolvoDialog.OnItemClickListener() {
                        @Override
                        public void onItemClick(View view, String obj) {

                            if (!obj.equals("")){
                                double kolvo = Double.parseDouble(obj);
                                if (!SchetActivity.this.zakazs.DecBludoFromZakazTyped(position, kolvo)){
                                    Toast.makeText(SchetActivity.this,"Error smaller than kolvo",Toast.LENGTH_SHORT).show();
                                }
                                dialog.dismiss();
                                hideKeyboard(view);
                                SchetActivity.this.reDrawZakazs();
                            } else {
                                dialog.dismiss();
                                hideKeyboard(view);
                                Toast.makeText(SchetActivity.this,"Error Empty",Toast.LENGTH_SHORT).show();
                            }
                        }
                    });
                } else {
                    if (SchetActivity.this.zakazs.DecBludoFromZakaz(position)){
                        //hideKeyboard(view);
                        SchetActivity.this.reDrawZakazs();
                    }

                }

            }

        }

    }
    /* renamed from: uz.software.raa.kafemanager.SchetActivity$1 */
    class C02211 implements OnItemClickListener {
        C02211() {
        }

        public void onItemClick(AdapterView<?> adapterView, View view, int position, long id) {
            if (SchetActivity.this.isClosed != 1) {
                lastZakaz = zakazs.getZakazsSize()-1;

                if (bludsList.get(position).getmBludType() == 1){
                    KolvoDialog dialog = new KolvoDialog(SchetActivity.this);
                    dialog.show();
                    dialog.setItemClickListener(new KolvoDialog.OnItemClickListener() {
                        @Override
                        public void onItemClick(View view, String obj) {

                            if (!obj.equals("")){
                                double kolvo = Double.parseDouble(obj);
                                SchetActivity.this.zakazs.AddBludoToZakazTyped(
                                        (bludsList.get(position)).getBludId(),
                                        (bludsList.get(position)).getBludNaim(),
                                        "empty",
                                        (bludsList.get(position)).getBludPrice(),
                                        (bludsList.get(position)).getmBludType(),
                                        kolvo);
                                dialog.dismiss();
                                hideKeyboard(view);
                                SchetActivity.this.reDrawZakazs();
                            } else {
                                dialog.dismiss();
                                hideKeyboard(view);
                                Toast.makeText(SchetActivity.this,ErrorString.Error_Emprty,Toast.LENGTH_SHORT).show();
                            }
                        }
                    });
                } else {
                    double kolvo = 0.0;
                    SchetActivity.this.zakazs.AddBludoToZakaz(
                            (bludsList.get(position)).getBludId(),
                            (bludsList.get(position)).getBludNaim(),
                            "empty",
                            (bludsList.get(position)).getBludPrice(),
                            (bludsList.get(position)).getmBludType(),
                            kolvo);
                    hideKeyboard(view);
                    SchetActivity.this.reDrawZakazs();
                }
            }
        }
    }

    /* renamed from: uz.software.raa.kafemanager.SchetActivity$2 */
    class C02222 implements OnItemClickListener {
        C02222() {
        }

        public void onItemClick(AdapterView<?> adapterView, View view, int position, long id) {
            if (SchetActivity.this.isClosed != 1  ) {
                //  SchetActivity.this.zakazs.DecBludoFromZakaz(position)
                lastZakaz = position;

                if (SchetActivity.this.zakazs.getZakazs().get(position).getZakazPrinted() == 1){
                    if (isManager){
                        if (SchetActivity.this.zakazs.getZakazs().get(position).getmZakazType() == 1){
                            KolvoDialog dialog = new KolvoDialog(SchetActivity.this);
                            dialog.show();

                            dialog.setItemClickListener(new KolvoDialog.OnItemClickListener() {
                                @Override
                                public void onItemClick(View view, String obj) {

                                    if (!obj.equals("")){
                                        double kolvo = Double.parseDouble(obj);
                                        if (!SchetActivity.this.zakazs.DecBludoFromZakazTyped(position, kolvo)){
                                            Toast.makeText(SchetActivity.this,ErrorString.Error_Kolvo_Small,Toast.LENGTH_SHORT).show();
                                        }
                                        dialog.dismiss();
                                        hideKeyboard(view);
                                        SchetActivity.this.reDrawZakazs();
                                    } else {
                                        dialog.dismiss();
                                        hideKeyboard(view);
                                        Toast.makeText(SchetActivity.this,ErrorString.Error_Emprty,Toast.LENGTH_SHORT).show();
                                    }
                                }
                            });
                        } else {
                            if (SchetActivity.this.zakazs.DecBludoFromZakaz(position)){
                                hideKeyboard(view);
                                SchetActivity.this.reDrawZakazs();
                            }
                        }
                    } else {
                        Toast.makeText(SchetActivity.this,ErrorString.Error_Access,Toast.LENGTH_SHORT).show();
                    }
                } else {
                    if (SchetActivity.this.zakazs.getZakazs().get(position).getmZakazType() == 1){
                        KolvoDialog dialog = new KolvoDialog(SchetActivity.this);
                        dialog.show();

                        dialog.setItemClickListener(new KolvoDialog.OnItemClickListener() {
                            @Override
                            public void onItemClick(View view, String obj) {

                                if (!obj.equals("")){
                                    double kolvo = Double.parseDouble(obj);
                                    if (!SchetActivity.this.zakazs.DecBludoFromZakazTyped(position, kolvo)){
                                        Toast.makeText(SchetActivity.this,ErrorString.Error_Kolvo_Small,Toast.LENGTH_SHORT).show();
                                    }
                                    dialog.dismiss();
                                    hideKeyboard(view);
                                    SchetActivity.this.reDrawZakazs();
                                } else {
                                    dialog.dismiss();
                                    hideKeyboard(view);
                                    Toast.makeText(SchetActivity.this,ErrorString.Error_Emprty,Toast.LENGTH_SHORT).show();
                                }
                            }
                        });
                    } else {
                        if (SchetActivity.this.zakazs.DecBludoFromZakaz(position)){
                            hideKeyboard(view);
                            SchetActivity.this.reDrawZakazs();
                        }
                    }
                }

                /*if (isManager){
                    if (SchetActivity.this.zakazs.getZakazs().get(position).getmZakazType() == 1){
                        KolvoDialog dialog = new KolvoDialog(SchetActivity.this);
                        dialog.show();

                        dialog.setItemClickListener(new KolvoDialog.OnItemClickListener() {
                            @Override
                            public void onItemClick(View view, String obj) {

                                if (!obj.equals("")){
                                    double kolvo = Double.parseDouble(obj);
                                    if (!SchetActivity.this.zakazs.DecBludoFromZakazTyped(position, kolvo)){
                                        Toast.makeText(SchetActivity.this,"Error smaller than kolvo",Toast.LENGTH_SHORT).show();
                                    }
                                    dialog.dismiss();
                                    hideKeyboard(view);
                                    SchetActivity.this.reDrawZakazs();
                                } else {
                                    dialog.dismiss();
                                    hideKeyboard(view);
                                    Toast.makeText(SchetActivity.this,"Error Empty",Toast.LENGTH_SHORT).show();
                                }
                            }
                        });
                    } else {
                        if (SchetActivity.this.zakazs.DecBludoFromZakaz(position)){
                            hideKeyboard(view);
                            SchetActivity.this.reDrawZakazs();
                        }
                    }
                } else {
                    Toast.makeText(SchetActivity.this,"Вы не имеете права отменять заказы!",Toast.LENGTH_SHORT).show();
                }*/

            }
        }
    }

    class MySimpleAdapter extends SimpleAdapter {
        public MySimpleAdapter(Context context, List<? extends Map<String, ?>> data, int resource, String[] from, int[] to) {
            super(context, data, resource, from, to);
        }

        public void setViewText(TextView v, String text) {
            super.setViewText(v, text);
            if (v.getId() == R.id.tvzNN) {
                if (((Zakaz) SchetActivity.this.zakazs.getZakazs().get(Integer.parseInt(text) - 1)).getZakazPrinted() == 1) {
                    v.setTextColor(SupportMenu.CATEGORY_MASK);
                    v.setBackgroundColor(InputDeviceCompat.SOURCE_ANY);
                    return;
                }
                v.setTextColor(ViewCompat.MEASURED_STATE_MASK);
                v.setBackgroundColor(-1);
            }
        }
    }

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_schet);

        this.userId = getIntent().getIntExtra(MainActivity.EXTRA_USER_ID, 1);
        this.userType = getIntent().getIntExtra(MainActivity.EXTRA_USER_TYPE, 1);
        System.out.println("is manager " + userType);

        isManager = userType == 1;

        this.schetId = getIntent().getIntExtra(SummActivity.EXTRA_SCHET_ID, 0);
        this.orderId = getIntent().getIntExtra("orderId", 0);
        this.stolNum = getIntent().getIntExtra(SummActivity.EXTRA_STOL_NUM, 1);
        this.isClosed = getIntent().getIntExtra(SummActivity.EXTRA_IS_CLOSED, 0);
        this.userName = getIntent().getStringExtra("uz.software.raa.user_name");
        this.btnSend = (Button) findViewById(R.id.btnSend);
        this.btnSend.setEnabled(false);
        this.btnKod = (Button) findViewById(R.id.btnKod);
        this.edtKod = (EditText) findViewById(R.id.kodEdt);
        this.edtKod.setSelectAllOnFocus(true);
        this.schetInfo = (TextView) findViewById(R.id.schetInfoView);
        this.wayterInfo = (TextView) findViewById(R.id.tvWayter);
        this.itogoInfo = (TextView) findViewById(R.id.tvItogo);
        this.bludsListView = (ListView) findViewById(R.id.bludsListView);
        progressBarB = findViewById(R.id.progress_circularB);
        bludsListView.setVisibility(View.GONE);
        progressBarB.setVisibility(View.VISIBLE);
        this.recyclerView = (RecyclerView) findViewById(R.id.otdlist);
        reDrawBluds(1);
        this.bludsListView.setOnItemClickListener(new C02211());

        zakazListView = findViewById(R.id.schetListView);
        progressBarZ = findViewById(R.id.progress_circularZ);


//        if ((getResources().getConfiguration().screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK) == Configuration.SCREENLAYOUT_SIZE_LARGE) {
//            spanCount = 6;
//        } else if ((getResources().getConfiguration().screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK) == Configuration.SCREENLAYOUT_SIZE_NORMAL) {
//            spanCount = 4;
//        } else if ((getResources().getConfiguration().screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK) == Configuration.SCREENLAYOUT_SIZE_SMALL) {
//            spanCount = 3;
//        } else {
//            spanCount = 1;
//        }

        categoryDataList.add(new CategoryData(1, getString(R.string.otdel_1)));
        categoryDataList.add(new CategoryData(2, getString(R.string.otdel_2)));
        categoryDataList.add(new CategoryData(3, getString(R.string.otdel_3)));
        categoryDataList.add(new CategoryData(4, getString(R.string.otdel_4)));
        categoryDataList.add(new CategoryData(5, getString(R.string.otdel_5)));
        categoryDataList.add(new CategoryData(6, getString(R.string.otdel_6)));
        categoryDataList.add(new CategoryData(7, getString(R.string.otdel_7)));
        categoryDataList.add(new CategoryData(8, getString(R.string.otdel_8)));

        this.categoryAdapter = new CategoryAdapter(this, categoryDataList);
        GridLayoutManager gridLayoutManager = new GridLayoutManager(getApplicationContext(), spanCount);
        this.recyclerView.setLayoutManager(gridLayoutManager);
        this.recyclerView.setHasFixedSize(true);
        this.recyclerView.setAdapter(this.categoryAdapter);
        this.recyclerView.addOnItemTouchListener(new RecyclerTouchListener(this, this.recyclerView, new ClickListener() {
            @Override
            public void onClick(View view, int position) {
                CategoryData categoryData = categoryDataList.get(position);
                reDrawBluds(categoryData.getId());
            }

            @Override
            public void onLongClick(View view, int position) {
            }
        }));

        edtKod.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View view, boolean b) {
                schetInfo.setVisibility(View.GONE);
                btnKod.setText("Закрыть");
                isSearchOpened = true;
            }
        });

        edtKod.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                bludsList.clear();
                int bludsCnt = bluds.getBludsCnt();
                ArrayList<Map<String, Object>> bludsData = new ArrayList(bludsCnt);
                for (int j = 0; j  < bludsCnt;j ++) {
                    Map<String, Object> m = new HashMap();
                    System.out.println(bluds.getBluds().get(j ).getmBludType());
                    System.out.println(bluds.getBluds().get(j ).getBludNaim());
                    m.put("bludIDAttr", Integer.valueOf(((Bluds) bluds.getBluds().get(j )).getBludId()));
                    m.put("bludNaimAttr", ((Bluds) bluds.getBluds().get(j)).getBludNaim());
                    m.put("bludPriceAttr", formatMoney(Integer.valueOf(((Bluds) bluds.getBluds().get(j)).getBludPrice())));
                    if (bluds.getBluds().get(j).getBludNaim().toLowerCase().contains(charSequence)){
                        bludsData.add(m);
                        bludsList.add(bluds.getBluds().get(j));
                    }
                }
                bludsListView.setOnItemClickListener(new C02211());
                bludsListView.setAdapter(new SimpleAdapter(SchetActivity.this, bludsData, R.layout.bluditem, new String[]{"bludIDAttr", "bludNaimAttr", "bludPriceAttr"}, new int[]{R.id.tvIdBlud, R.id.tvBludNaim, R.id.tvBludPrice}));

            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        });

        getServZakaz();
    }

    public void onClickKodBtn(View view) {
        if (this.isClosed != 1) {
            String sKod = this.edtKod.getText().toString();
            if (sKod != "") {
                edtKod.setText("");
                edtKod.clearFocus();
                schetInfo.setVisibility(View.VISIBLE);
                btnKod.setText("Искать");
                hideKeyboard(view);
                obrabKod(sKod);
            }
        }
    }

    public void obrabKod(String paramString) {
        if (isSearchOpened){
            edtKod.setText("");
            edtKod.clearFocus();
            schetInfo.setVisibility(View.VISIBLE);
            btnKod.setText("Искать");
            isSearchOpened = false;
            bludsList.clear();
            bludsList.addAll(bluds.getBluds());
            int bludsCnt = this.bluds.getBludsCnt();
            ArrayList<Map<String, Object>> bludsData = new ArrayList(bludsCnt);
            for (int i = 0; i < bludsCnt; i++) {
                Map<String, Object> m = new HashMap();
                m.put("bludIDAttr", Integer.valueOf(((Bluds) bludsList.get(i)).getBludId()));
                m.put("bludNaimAttr", ((Bluds) bludsList.get(i)).getBludNaim());
                m.put("bludPriceAttr", formatMoney(Integer.valueOf(((Bluds) bludsList.get(i)).getBludPrice())));
                bludsData.add(m);
            }
            this.bludsListView.setAdapter(new SimpleAdapter(this, bludsData, R.layout.bluditem, new String[]{"bludIDAttr", "bludNaimAttr", "bludPriceAttr"}, new int[]{R.id.tvIdBlud, R.id.tvBludNaim, R.id.tvBludPrice}));

            //reDrawBluds(otdel);
        } else {
            /*String req = "4;" + this.userId + ";" + paramString + ";";
            this.mServer = new ServerConnection();
            try
            {
                this.mServer.execute(new String[] { req });
                while (this.mServer.status == 0) {}
                paramString = this.mServer.recv;
                int i = this.mServer.status;
                this.mServer.closeConnection();
                if ((i <= 0) || (paramString == ""))
                {
                    ServerErrors.ProcessErr(this, i);
                    this.edtKod.setText("");
                    return;
                }
                String[] d  = paramString.split(";");
                if (d.length < 5)
                {
                    ServerErrors.ProcessErr(this, -7);
                    this.edtKod.setText("");
                    return;
                }
                i = Integer.parseInt(d[2]);
                String str = d[3];
                int j = Integer.parseInt(d[4]);
                this.zakazs.AddBludoToZakaz(i, str,"empty", j, Integer.parseInt(d[5]),0.0D);
            }
            catch (Exception ex)
            {

                Log.e("myApp", ex.getMessage());
                this.mServer.closeConnection();

            }
            finally
            {
                this.mServer.closeConnection();
            }*/
            reDrawZakazs();
            this.btnKod.requestFocus();
            this.edtKod.selectAll();
        }
    }

    public String getUsing() {

        final String[] answ = {""};

        Call<String> call = RetrofitClient.getInstance().getMyApi().getCheckUsing();
        call.enqueue(new Callback<String>() {
            @Override
            public void onResponse(Call<String> call, Response<String> response) {

                System.out.println(response.body());

                if (response.body() == null){
                    Toast.makeText(getApplicationContext(), ErrorString.Error_List_Users, Toast.LENGTH_LONG).show();
                    return;
                }

                if (response.body().equals("1")){
                    answ[0] = "1";
                } else {
                    Toast.makeText(getApplicationContext(), response.body(), Toast.LENGTH_LONG).show();
                    answ[0] = response.body();
                }

            }

            @Override
            public void onFailure(Call<String> call, Throwable t) {
                Toast.makeText(getApplicationContext(), ErrorString.Error_List_Users, Toast.LENGTH_LONG).show();
            }

        });
        return answ[0];
    }

    public void onClickBtnSend(View view) {

        /*if (sendBtn){
            this.btnSend.setEnabled(false);
            sendBtn = false;
            progressBarZ.setVisibility(View.VISIBLE);
            organizeOrder();
        }*/

        /*String str = getUsing();

        if (!str.equals("1")){
            //Toast.makeText(this,str,Toast.LENGTH_SHORT).show();
            return;
        }*/


        if (schetId == 0){
            newOrder();
        } else {
            updateOrder();
        }

    }

    //////////////////////////////////         New zakaz or update zakaz
    public void newOrder() {
        this.btnSend.setEnabled(false);

        System.out.println("<<<<<<<<<< ////////////////////// >>>>>>>>>>");

        ArrayList<NewOrders.Order> newList = new ArrayList<>();

        Iterator localObject3 = this.zakazs.getZakazs().iterator();
        while ((localObject3).hasNext())
        {
            Zakaz localZakaz = (Zakaz)(localObject3).next();
            if (localZakaz.getZakazPrinted() == 0) {
                String kolvo = "";
                if (localZakaz.getmZakazType() == 0){
                    kolvo = String.valueOf((int) localZakaz.getZakazKolvo());
                } else {
                    kolvo = String.valueOf(localZakaz.getZakazKolvo());
                }

                NewOrders.Order nOrder = new NewOrders.Order(
                        localZakaz.getmZakazComment(),
                        kolvo,
                        String.valueOf(localZakaz.getBludId()));

                newList.add(nOrder);

            }
        }

        NewOrders newOrders = new NewOrders(String.valueOf(stolNum),String.valueOf(userId),userName,"0","0","",newList);

        Call<NewOrders> call = RetrofitClient.getInstance().getMyApi().createNewOrder(newOrders);
        call.enqueue(new Callback<NewOrders>() {
            @Override
            public void onResponse(Call<NewOrders> call, Response<NewOrders> response) {

                btnSend.setEnabled(true);

                System.out.println(response.body());
                if (schetId == 0) {
                    schetId = Integer.valueOf(response.body().getSchyotid());
                }
                System.out.println(response.body().getUserid());
                openedTime =response.body().getOpenedT();
                orderId = Integer.valueOf(response.body().getOrderid());

                getServZakaz();

            }

            @Override
            public void onFailure(Call<NewOrders> call, Throwable t) {
                Toast.makeText(getApplicationContext(), "An error has occured", Toast.LENGTH_LONG).show();
            }

        });

    }

    public void updateOrder() {
        this.btnSend.setEnabled(false);

        System.out.println("<<<<<<<<<< ////////////////////// >>>>>>>>>>");

        ArrayList<UpdateOrder.Order> newList = new ArrayList<>();

        Iterator localObject3 = this.zakazs.getZakazs().iterator();
        while ((localObject3).hasNext())
        {
            Zakaz localZakaz = (Zakaz)(localObject3).next();
            if (localZakaz.getZakazPrinted() == 0) {
                String kolvo = "";
                if (localZakaz.getmZakazType() == 0){
                    kolvo = String.valueOf((int) localZakaz.getZakazKolvo());
                } else {
                    kolvo = String.valueOf(localZakaz.getZakazKolvo());
                }
                UpdateOrder.Order nOrder = new UpdateOrder.Order(
                        localZakaz.getmZakazComment(),
                        kolvo,
                        String.valueOf(localZakaz.getBludId()));
                System.out.println(localZakaz.getBludId());

                newList.add(nOrder);

            }
        }

        UpdateOrder newOrders = new UpdateOrder(String.valueOf(schetId),String.valueOf(orderId),
                String.valueOf(stolNum),
                String.valueOf(userId),
                userName,
                "",
                newList);

        Call<UpdateOrder> call = RetrofitClient.getInstance().getMyApi().updateOrder(newOrders);
        call.enqueue(new Callback<UpdateOrder>() {
            @Override
            public void onResponse(Call<UpdateOrder> call, Response<UpdateOrder> response) {

                btnSend.setEnabled(true);

                System.out.println(response.body());
                if (schetId == 0) {
                    schetId = Integer.valueOf(response.body().getSchyotid());
                }
                System.out.println(response.body().getUserid());
                openedTime = response.body().getOpenedT();

                getServZakaz();

            }

            @Override
            public void onFailure(Call<UpdateOrder> call, Throwable t) {
                Toast.makeText(getApplicationContext(), "An error has occured", Toast.LENGTH_LONG).show();
            }

        });


    }

    public void organizeOrder() {

        String localObject1 = "3;" + this.userId + ";" + this.orderId + ";" + this.stolNum + ";";
        Iterator localObject3 = this.zakazs.getZakazs().iterator();
        while ((localObject3).hasNext())
        {
            Zakaz localZakaz = (Zakaz)(localObject3).next();
            if (localZakaz.getZakazPrinted() == 0) {
                localObject1 = (String)localObject1 + localZakaz.getBludId() + ";" + localZakaz.getmZakazComment() + ";" + localZakaz.getZakazKolvo() + ";";
            }
        }
        this.mServer = new ServerConnection();
        try
        {
            this.mServer.execute(new String[] { localObject1 });
            while (this.mServer.status == 0) {}
            localObject1 = this.mServer.recv;
            int i = this.mServer.status;
            this.mServer.closeConnection();
            if ((i <= 0) || (localObject1 == ""))
            {
                ServerErrors.ProcessErr(this, i);
                this.btnSend.setEnabled(true);
                return;
            }
            String[] d = ((String)localObject1).split(";");
            if (d.length < 3)
            {
                ServerErrors.ProcessErr(this, -7);
                this.btnSend.setEnabled(true);
                return;
            }
            if (this.schetId == 0) {
                this.schetId = Integer.parseInt(d[2]);
            }
            System.out.println(d[2]);
            openedTime = d[2];

        }
        catch (Exception localException)
        {
            progressBarZ.setVisibility(View.GONE);
            Log.e("myApp", localException.getMessage());
            this.mServer.closeConnection();

        }
        finally
        {
            this.mServer.closeConnection();
        }
        Iterator localObject = this.zakazs.getZakazs().iterator();
        while (localObject.hasNext())
        {
            Zakaz localzakaz = (Zakaz)((Iterator)localObject).next();
            if (((Zakaz)localzakaz).getZakazPrinted() == 0) {
                ((Zakaz)localzakaz).setZakazPrinted(1);
            }
        }
        progressBarZ.setVisibility(View.GONE);
        reDrawZakazs();
    }

    public void reDrawBluds(int idOtdel) {
        edtKod.setText("");
        edtKod.clearFocus();
        schetInfo.setVisibility(View.VISIBLE);
        btnKod.setText("Искать");
        isSearchOpened = false;
        hideKeyboard(edtKod);
        bludsList.clear();
        getServBluds(idOtdel);
    }

    public void reDrawZakazs() {
        zakazAdapter = null;

        sendBtn = true;
        ArrayList<Zakaz> zakazList = zakazs.getZakazs();
        int summZakaz = 0;
        int notPrintedKolvo = 0;
        int zakazsCnt = this.zakazs.getZakazsSize();

        ArrayList<Map<String, Object>> zakazsData = new ArrayList(zakazsCnt);
        for (int i = 0; i < zakazsCnt; i++) {
            Map<String, Object> m = new HashMap();
            m.put("zakazNNAttr", Integer.valueOf(i + 1));
            m.put("zakazNaimAttr", ((Zakaz) this.zakazs.getZakazs().get(i)).getZakazNaim());
            if (this.zakazs.getZakazs().get(i).getmZakazType() == 1){
                m.put("zakazKolvoAttr", Double.valueOf(((Zakaz) this.zakazs.getZakazs().get(i)).getZakazKolvo()));
            } else {
                Double d = Double.valueOf(((Zakaz) this.zakazs.getZakazs().get(i)).getZakazKolvo());
                int k = d.intValue();
                m.put("zakazKolvoAttr", k);
            }
            if (((Zakaz) this.zakazs.getZakazs().get(i)).getZakazPrinted() == 0) {
                notPrintedKolvo++;
            }
            double summ = ((Zakaz) this.zakazs.getZakazs().get(i)).getZakazSumm();
            summZakaz += summ;
            Double d = Double.valueOf(((Zakaz) this.zakazs.getZakazs().get(i)).getZakazSumm());
            int k = d.intValue();
            m.put("zakazSummAttr", formatMoney(k));
            zakazsData.add(m);
        }
        String sSchetInfo = this.orderId == 0 ? "Новый счет" : "Счет № " + this.orderId;
        int iTmp = this.stolNum;
        if (this.stolNum == 0) {
            sSchetInfo = sSchetInfo + "  С собой ";
            this.wayterInfo.setText("    За услуги = 0");
        }
        if (this.stolNum >= 1 && this.stolNum <= 100)
            sSchetInfo = sSchetInfo + "  Стол № " + this.stolNum;
        if (this.stolNum >= 101 && this.stolNum <= 200)
            sSchetInfo = sSchetInfo + "  Кабина № " + (iTmp - 100);
        if (this.stolNum >= 201 && this.stolNum <= 300) {
            sSchetInfo = sSchetInfo + "  Зал № " + (iTmp - 200);
        }
        if (this.isClosed == 1) {
            sSchetInfo = sSchetInfo + " ЗАКРЫТ!";
        }

        this.schetInfo.setText(sSchetInfo);
        String sWayterInfo = "";
        int wayterSumm = 0;

        Date dateObj = new Date();
        Calendar calendar = Calendar.getInstance();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd.MM.yyyy hh:mm:ss");
        if (!openedTime.equals("")){
            try {
                dateObj = simpleDateFormat.parse(openedTime);
                calendar.setTime(dateObj);
                System.out.println(dateObj);
                System.out.println(calendar.get(Calendar.HOUR_OF_DAY));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        if (this.stolNum > 0) {
            if (calendar.get(Calendar.HOUR_OF_DAY) <= 5
                    || calendar.get(Calendar.HOUR_OF_DAY) >= 22
                    || calendar.get(Calendar.MINUTE) >= 59
                    || calendar.get(Calendar.SECOND) >= 59) {
                wayterSumm = (int) (((double) summZakaz) * 0.15d);
                this.wayterInfo.setText(sWayterInfo + "    За обслуживание 15% = " + formatMoney(wayterSumm));
            } else {
                wayterSumm = (int) (((double) summZakaz) * 0.1d);
                this.wayterInfo.setText(sWayterInfo + "    За обслуживание 10%= " + formatMoney(wayterSumm));
            }
        }
        if (this.stolNum >= 101 && this.stolNum <= 200) {
            sWayterInfo = "За кабину = " + formatMoney(this.stolSumm);
        }

        this.itogoInfo.setText("Итого: " + (formatMoney((this.stolSumm + summZakaz) + wayterSumm)));

        zakazAdapter = new ZakazAdapter(this,zakazList, this::onCommentClick, this::onItemClickListener);

        zakazListView.setAdapter(zakazAdapter);
        zakazListView.setSelection(lastZakaz);

        if (notPrintedKolvo == 0) {
            this.btnSend.setEnabled(false);
        } else {
            this.btnSend.setEnabled(true);
        }
    }

    public String getServBludsSearch(String search) {
        String str = "0";
        int paramInt;
        this.mServer = new ServerConnection();
        try
        {
            this.mServer.execute(new String[] { "4;" + this.userId + ";" + search + ";" });
            while (this.mServer.status == 0) {}
            String localObject2 = this.mServer.recv;
            paramInt = this.mServer.status;
            this.mServer.closeConnection();
            if ((paramInt <= 0) || (localObject2 == ""))
            {
                ServerErrors.ProcessErr(this, paramInt);
                return "0";
            }
            String[] d = localObject2.split(";");
            if (d.length < 3)
            {
                ServerErrors.ProcessErr(this, -7);
                return "0";
            }
            str = d[2];
        }
        catch (Exception localException)
        {

            Log.e("myApp", localException.getMessage());
            this.mServer.closeConnection();

        }
        finally
        {
            this.mServer.closeConnection();
        }
        return str;
    }

    public void getServBluds(int paramInt) {

        System.out.println("<<<<<<<<<< ,,,,,,,,,,,,,,,,,, >>>>>>>>>>");

        Call<ArrayList<Foods>> call = RetrofitClient.getInstance().getMyApi().getFoods(paramInt);
        call.enqueue(new Callback<ArrayList<Foods>>() {
            @Override
            public void onResponse(Call<ArrayList<Foods>> call, Response<ArrayList<Foods>> response) {

                ArrayList<Foods> n;

                if (response.body() == null){
                    Toast.makeText(getApplicationContext(), ErrorString.Error_List_Bluds, Toast.LENGTH_LONG).show();
                    n = new ArrayList<Foods>();
                    //return;
                } else {
                    n = response.body();
                }

                bludsListView.setVisibility(View.VISIBLE);
                progressBarB.setVisibility(View.GONE);

                bluds.setUpBluds(n);
                bludsList.addAll(bluds.getBluds());
                int bludsCnt = bluds.getBludsCnt();
                ArrayList<Map<String, Object>> bludsData = new ArrayList(bludsCnt);
                for (int i = 0; i < bludsCnt; i++) {
                    Map<String, Object> m = new HashMap();
                    m.put("bludIDAttr", Integer.valueOf(((Bluds) bludsList.get(i)).getBludId()));
                    m.put("bludNaimAttr", ((Bluds) bludsList.get(i)).getBludNaim());
                    m.put("bludPriceAttr", formatMoney(Integer.valueOf(((Bluds) bludsList.get(i)).getBludPrice())));
                    bludsData.add(m);
                }
                bludsListView.setAdapter(new SimpleAdapter(SchetActivity.this,
                        bludsData,
                        R.layout.bluditem,
                        new String[]{"bludIDAttr", "bludNaimAttr", "bludPriceAttr"},
                        new int[]{R.id.tvIdBlud, R.id.tvBludNaim, R.id.tvBludPrice}));

            }

            @Override
            public void onFailure(Call<ArrayList<Foods>> call, Throwable t) {
                Toast.makeText(getApplicationContext(), ErrorString.Error_List_Bluds, Toast.LENGTH_LONG).show();
            }

        });

    }

    public void getServZakaz() {

        Call<ArrayList<BillsList>> call = RetrofitClient.getInstance().getMyApi().getBills(schetId,orderId,stolNum);
        call.enqueue(new Callback<ArrayList<BillsList>>() {
            @Override
            public void onResponse(Call<ArrayList<BillsList>> call, Response<ArrayList<BillsList>> response) {

                if (response.body() == null){
                    //Toast.makeText(getApplicationContext(), ErrorString.Error_List_Zakazs, Toast.LENGTH_LONG).show();
                    System.out.println(ErrorString.Error_List_Zakazs);
                    return;
                }

                ArrayList<BillsList> n = response.body();

                System.out.println(n.size());

                zakazs.setUpZakaz(n.get(0).getBillsList());
                stolSumm = Integer.valueOf(n.get(0).getSUMM());

                reDrawZakazs();

                zakazListView.setOnItemClickListener(new C02222());

                if ( n.get(0).getBillsList().size() > 0){
                    openedTime = n.get(0).getBillsList().get(0).getSDATE().substring(11,16);
                }

            }

            @Override
            public void onFailure(Call<ArrayList<BillsList>> call, Throwable t) {
                System.out.println(t.toString());
                //Toast.makeText(getApplicationContext(), ErrorString.Error_List_Zakazs, Toast.LENGTH_LONG).show();
            }

        });

    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        /*Intent intent=new Intent(this,SummActivity.class);
        intent.putExtra("uz.software.raa.user_id",this.userId);
        intent.putExtra(MainActivity.EXTRA_USER_NAME,getIntent().getStringExtra(MainActivity.EXTRA_USER_NAME));
        startActivity(intent);
        finish();*/
        finish();
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

    public static String formatKolvo(double paramDouble) {
        DecimalFormat localDecimalFormat = new DecimalFormat("#,###.###");
        DecimalFormatSymbols localDecimalFormatSymbols = new DecimalFormatSymbols();
        localDecimalFormatSymbols.setDecimalSeparator('.');
        //localDecimalFormatSymbols.setGroupingSeparator(',');
        localDecimalFormat.setDecimalFormatSymbols(localDecimalFormatSymbols);
        localDecimalFormat.setDecimalSeparatorAlwaysShown(false);
        return localDecimalFormat.format(paramDouble);
    }

    public void hideKeyboard(View view) {
        try {
            InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
            imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
            this.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
        } catch(Exception ignored) {
            Toast.makeText(this,"Error to Close Keyboard!", Toast.LENGTH_SHORT).show();
        }
    }
}
