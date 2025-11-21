package com.example.waiter;

public class Bluds {
    private int mBludId;
    private String mBludNaim;
    private int mBludPrice;
    private int mBludType;

    public Bluds(String data) {
        String[] d = data.split(",");
        if (d.length == 4) {
            this.mBludId = Integer.parseInt(d[0]);
            this.mBludNaim = d[1];
            this.mBludPrice = Integer.parseInt(d[2]);
            this.mBludType = Integer.parseInt(d[3]);
            return;
        }
        this.mBludId = 0;
        this.mBludNaim = "Error";
        this.mBludPrice = 0;
        this.mBludType = 0;
    }

    public Bluds(int mBludId, String mBludNaim, int mBludPrice, int mBludType) {
        this.mBludId = mBludId;
        this.mBludNaim = mBludNaim;
        this.mBludPrice = mBludPrice;
        this.mBludType = mBludType;
    }

    public int getBludId() {
        return this.mBludId;
    }

    public void setBludId(int mBludId) {
        this.mBludId = mBludId;
    }

    public String getBludNaim() {
        return this.mBludNaim;
    }

    public void setBludNaim(String mBludNaim) {
        this.mBludNaim = mBludNaim;
    }

    public int getBludPrice() {
        return this.mBludPrice;
    }

    public void setBludPrice(int mBludPrice) {
        this.mBludPrice = mBludPrice;
    }

    public int getmBludType() {
        return mBludType;
    }

    public void setmBludType(int mType) {
        this.mBludType = mType;
    }
}
