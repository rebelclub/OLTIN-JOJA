package com.example.waiter;

import android.icu.text.SimpleDateFormat;

import com.example.waiter.model.db.orders.Orders;

import java.time.Instant;
import java.util.Date;

public class Order {
    private int allOrderID = 0;
    private int mOrderId = 0;
    private String mOtkrit = "12:00";
    private int mStol = 1;
    private int mSumma = 12500;
    private String mZakrit = "23:00";

    private String userId = "";

    public Order(String data) {
        String[] d = data.split(",");
        if (d.length == 5) {
            this.mOrderId = Integer.parseInt(d[0]);
            this.mStol = Integer.parseInt(d[1]);
            this.mOtkrit = d[2];
            this.mZakrit = d[3];
            this.mSumma = Integer.parseInt(d[4]);
        }
    }

    public Order(Orders orders) {

        this.allOrderID = orders.getALLORDERID();
        this.mOrderId = orders.getORDERID();
        this.userId = orders.getUSERID();
        this.mStol = orders.getSTOL();
        System.out.println(orders.getOPENED());
        System.out.println(orders.getCLOSED());

        String opened = orders.getOPENED().toString().substring(11,16);
        String closed = orders.getCLOSED().toString().substring(11,16);

        System.out.println(opened);
        System.out.println(closed);

        this.mOtkrit = opened;

        if (orders.getCLOSED().toString().startsWith("18")){
            this.mZakrit = "24:00";
        } else {
            this.mZakrit = closed;
        }

        this.mSumma = orders.getRESERV();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getAllOrderID() {
        return allOrderID;
    }

    public void setAllOrderID(int allOrderID) {
        this.allOrderID = allOrderID;
    }

    public int getOrderId() {
        return this.mOrderId;
    }

    public void setOrderId(int mOrderId) {
        this.mOrderId = mOrderId;
    }

    public int getStol() {
        return this.mStol;
    }

    public void setStol(int mStol) {
        this.mStol = mStol;
    }

    public String getOtkrit() {
        return this.mOtkrit;
    }

    public void setOtkrit(String mOtkrit) {
        this.mOtkrit = mOtkrit;
    }

    public String getZakrit() {
        return this.mZakrit;
    }

    public void setZakrit(String mZakrit) {
        this.mZakrit = mZakrit;
    }

    public int getSumma() {
        return this.mSumma;
    }

    public void setSumma(int mSumma) {
        this.mSumma = mSumma;
    }
}
