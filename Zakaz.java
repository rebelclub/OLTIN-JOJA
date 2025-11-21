package com.example.waiter;

import java.util.Formatter;

public class Zakaz {
    private int mBludId = 0;
    private int mBludPrice = 1;
    private double mZakazKolvo = 1.0;
    private int mZakazNN = 0;
    private String mZakazNaim = "";
    private String mZakazComment = "";
    private int mZakazPrinted = 0;
    private int mZakazType=0;

    public Zakaz(int nn, String data) {
        String[] d = data.split(",");
        if (d.length == 6) {
            this.mZakazNN = nn;
            this.mBludId = Integer.parseInt(d[0]);
            this.mZakazNaim = d[1];
            this.mZakazComment = d[2];
            this.mZakazKolvo = Double.parseDouble(d[3]);
            this.mBludPrice = Integer.parseInt(d[4]);
            this.mZakazPrinted = 1;
            this.mZakazType=Integer.parseInt(d[5]);
        }
    }

    public Zakaz(int nn, int idBlud, String naim, String comment, int price,int mType, double kolvo) {
        this.mZakazNN = nn;
        this.mBludId = idBlud;
        this.mZakazNaim = naim;
        this.mZakazComment = comment;
        this.mZakazKolvo = kolvo;
        this.mBludPrice = price;
        this.mZakazPrinted = 0;
        this.mZakazType=mType;
    }

    public Zakaz(int nn, int idBlud, String naim, String comment,  int printed, int price,int mType, double kolvo) {
        this.mZakazNN = nn;
        this.mBludId = idBlud;
        this.mZakazNaim = naim;
        this.mZakazComment = comment;
        this.mZakazKolvo = kolvo;
        this.mBludPrice = price;
        this.mZakazPrinted = printed;
        this.mZakazType=mType;
    }

    public int getZakazNN() {
        return this.mZakazNN;
    }

    public void setZakazNN(int zakazNN) {
        this.mZakazNN = zakazNN;
    }

    public int getBludId() {
        return this.mBludId;
    }

    public void setBludId(int BludId) {
        this.mBludId = BludId;
    }

    public String getZakazNaim() {
        return this.mZakazNaim;
    }

    public void setZakazNaim(String zakazNaim) {
        this.mZakazNaim = zakazNaim;
    }

    public String getmZakazComment() {
        return mZakazComment;
    }

    public void setmZakazComment(String mZakazComment) {
        this.mZakazComment = mZakazComment;
    }

    public double getZakazKolvo() {
        return this.mZakazKolvo;
    }

    public void setZakazKolvo(double mZakazKolvo) {
        this.mZakazKolvo = mZakazKolvo;
    }

    public double IncKolvo() {
        this.mZakazKolvo++;
        return this.mZakazKolvo;
    }

    public double IncKolvoTyped(double kolvo) {
        this.mZakazKolvo += kolvo;
        return this.mZakazKolvo;
    }

    public double DecKolvo() {
            this.mZakazKolvo--;
            return this.mZakazKolvo;
    }

    public double DecKolvoTyped(double kolvo) {
        double k = this.mZakazKolvo;
        System.out.println(k);
        if (k < 0){
            k += kolvo;
            this.mZakazKolvo = Double.parseDouble(SchetActivity.formatKolvo(k));
            System.out.println(this.mZakazKolvo);
            return this.mZakazKolvo;
        } else if (k >= kolvo){
            k -= kolvo;
            this.mZakazKolvo = Double.parseDouble(SchetActivity.formatKolvo(k));
            System.out.println(this.mZakazKolvo);
            return this.mZakazKolvo;
        } else {
            return -111;
        }
    }

    public double DecKolvoTypedPrinted(double kolvo) {
        double k = this.mZakazKolvo;
        System.out.println(k);
        if (k < 0){
            k += kolvo;
            this.mZakazKolvo = Double.parseDouble(SchetActivity.formatKolvo(k));
            System.out.println(this.mZakazKolvo);
            return this.mZakazKolvo;
        } else {
            return -111;
        }
    }

    public int getBludPrice() {
        return this.mBludPrice;
    }

    public void setBludPrice(int mBludPrice) {
        this.mBludPrice = mBludPrice;
    }

    public int getZakazPrinted() {
        return this.mZakazPrinted;
    }

    public void setZakazPrinted(int zakazPrinted) {
        this.mZakazPrinted = zakazPrinted;
    }

    public double getZakazSumm() {
        return this.mBludPrice * this.mZakazKolvo;
    }

    public int getmZakazType() {
        return mZakazType;
    }

    public void setmZakazType(int mZakazType) {
        this.mZakazType = mZakazType;
    }
}
