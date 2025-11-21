package com.example.waiter;

import com.example.waiter.model.db.foods.Foods;

import java.util.ArrayList;
import java.util.Iterator;

public class BludsArr {
    private ArrayList<Bluds> mBluds;
    private int mBludsCnt;

    public BludsArr() {
        this.mBludsCnt = 0;
        this.mBluds = new ArrayList();
        this.mBludsCnt = 0;
    }

    public void setUpBluds(String bluds) {
        this.mBluds.clear();
        this.mBludsCnt = 0;
        if (bluds.compareTo("0") != 0) {
            String[] d = bluds.split("[|]");
            this.mBludsCnt = d.length;
            for (int i = 0; i < this.mBludsCnt; i++) {
                this.mBluds.add(new Bluds(d[i]));
            }
        }
    }

    public void setUpBluds(ArrayList<Foods> bluds) {
        this.mBluds.clear();
        this.mBludsCnt = 0;
        if (bluds.size() != 0) {
            this.mBludsCnt = bluds.size();
            for (int i = 0; i < this.mBludsCnt; i++) {
                this.mBluds.add(new Bluds(bluds.get(i).getBLUDID(),
                        bluds.get(i).getNAIM(),
                        bluds.get(i).getPRICE(),
                        bluds.get(i).getTYPE()));
            }
        }
    }

    public ArrayList<Bluds> getBluds() {
        return this.mBluds;
    }

    public Bluds getBludo(int idBlud) {
        Iterator i$ = this.mBluds.iterator();
        while (i$.hasNext()) {
            Bluds c = (Bluds) i$.next();
            if (c.getBludId() == idBlud) {
                return c;
            }
        }
        return null;
    }

    public int getBludsCnt() {
        return this.mBludsCnt;
    }
}
