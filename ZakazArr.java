package com.example.waiter;

import com.example.waiter.model.db.bills.Bills;
import com.example.waiter.model.db.bills.BillsList;

import java.util.ArrayList;
import java.util.Iterator;

public class ZakazArr {
    private ArrayList<Zakaz> mZakazs = new ArrayList();

    public void setUpZakaz(String zakazs) {
        this.mZakazs.clear();
        if (zakazs.compareTo("0") != 0) {
            String[] d = zakazs.split("[|]");
            int mZakazsCnt = d.length;
            for (int i = 0; i < mZakazsCnt; i++) {
                this.mZakazs.add(new Zakaz(i + 1, d[i]));
            }
        }
    }

    public void setUpZakaz(ArrayList<Bills> newZ) {
        this.mZakazs.clear();
        if (newZ.size() != 0) {
            int mZakazsCnt = newZ.size();
            for (int i = 0; i < mZakazsCnt; i++) {
                this.mZakazs.add(new Zakaz(i + 1,
                        newZ.get(i).getBLUDID(),
                        newZ.get(i).getNAIM(),
                        newZ.get(i).getCOMENT(),
                        1,
                        newZ.get(i).getPRICE(),
                        newZ.get(i).getTYPE(),
                        newZ.get(i).getSUM()));
            }
        }
    }

    public ArrayList<Zakaz> getZakazs() {
        return this.mZakazs;
    }

    public void AddBludoToZakaz(int idBlud, String Naim,  String Comment, int price, int type,double kolvo) {
        Zakaz c = getZakaz(idBlud);
        if (c != null) {
            c.IncKolvo();
            if (c.getZakazKolvo() == 0) {
                this.mZakazs.remove(c.getZakazNN() - 1);
                return;
            }
            return;
        }
        this.mZakazs.add(new Zakaz((this.mZakazs.size() + 1), idBlud, Naim, Comment, price,type,1));
    }

    public void editCommentZakaz(String Comment, int position){

        Zakaz c = (Zakaz) this.mZakazs.get(position);
        if (c != null) {
            c.setmZakazComment(Comment);
            return;
        }

    }

    public void AddBludoToZakazTyped(int idBlud, String Naim, String Comment, int price, int type,double kolvo) {
        Zakaz c = getZakaz(idBlud);
        if (c != null) {

//            if (c.getZakazKolvo() < 0){
//                c.setZakazKolvo(Double.parseDouble(SchetActivity.formatKolvo(kolvo)));
//            } else {
//                c.IncKolvoTyped(kolvo);
//            }

             c.setZakazKolvo(Double.parseDouble(SchetActivity.formatKolvo(kolvo)));

            if (c.getZakazKolvo() == 0) {
                this.mZakazs.remove(c.getZakazNN() - 1);
                return;
            }
            return;
        }
        this.mZakazs.add(new Zakaz((this.mZakazs.size() + 1), idBlud, Naim, Comment, price,type,kolvo));
    }

    public boolean DecBludoFromZakaz(int position) {
        Zakaz c = (Zakaz) this.mZakazs.get(position);
        if (c.getZakazPrinted() == 0) {
            if (c.getZakazKolvo() < 0) {
                c.IncKolvo();
            } else {
                c.DecKolvo();
            }
            if (c.getZakazKolvo() == 0) {
                this.mZakazs.remove(position);
            }
            return true;
        } else if (c.getZakazKolvo() < 0) {
            return false;
        } else {
            Zakaz c2 = getZakaz(c.getBludId());
            int bludId;
            int allKolvo;
            Iterator i$;
            Zakaz c4;
            if (c2 != null) {
                bludId = ((Zakaz) this.mZakazs.get(position)).getBludId();
                allKolvo = 0;
                i$ = this.mZakazs.iterator();
                while (i$.hasNext()) {
                    c4 = (Zakaz) i$.next();
                    if (c4.getBludId() == bludId) {
                        allKolvo += c4.getZakazKolvo();
                    }
                }
                if (allKolvo <= 0) {
                    return false;
                }
                c2.DecKolvo();
                if (c2.getZakazKolvo() == 0)  {
                    this.mZakazs.remove(c2.getZakazNN() - 1);
                }
            } else {
                bludId = ((Zakaz) this.mZakazs.get(position)).getBludId();
                allKolvo = 0;
                i$ = this.mZakazs.iterator();
                while (i$.hasNext()) {
                    c4 = (Zakaz) i$.next();
                    if (c4.getBludId() == bludId) {
                        allKolvo += c4.getZakazKolvo();
                    }
                }
                if (allKolvo <= 0) {
                    return false;
                }
                Zakaz c3 = new Zakaz(this.mZakazs.size() + 1, c.getBludId(), c.getZakazNaim(), c.getmZakazComment(), c.getBludPrice(),c.getmZakazType(),c.getZakazKolvo());
                c3.setZakazKolvo(-1);
                this.mZakazs.add(c3);
            }
            return true;
        }
    }

    public boolean DecBludoFromZakazTyped(int position, double kolvo) {
        Zakaz c = (Zakaz) this.mZakazs.get(position);
        if (c.getZakazPrinted() == 0) {
            if (c.getZakazKolvo() < 0) {
                /*if (c.DecKolvoTyped(kolvo) == -111){
                    return false;
                }*/
                double ckolvo = c.DecKolvoTyped(kolvo);
                if (ckolvo == -111){
                    return false;
                } else if(ckolvo > 0){
                    this.mZakazs.remove(position);
                }
                //c.IncKolvo();
            } else {
                if (kolvo > c.getZakazKolvo()){
                    this.mZakazs.remove(position);
                }else {
                    if (c.DecKolvoTyped(kolvo) == -111){
                        return false;
                    }
                }
            }
            if (c.getZakazKolvo() == 0) {
                this.mZakazs.remove(position);
            }
            return true;
        } else if (c.getZakazKolvo() < 0) {
            return false;
        } else {
            Zakaz c2 = getZakaz(c.getBludId());
            int bludId;
            double allKolvo;
            Iterator i$;
            Zakaz c4;
            if (c2 != null) {
                bludId = ((Zakaz) this.mZakazs.get(position)).getBludId();
                allKolvo = 0;
                i$ = this.mZakazs.iterator();
                while (i$.hasNext()) {
                    c4 = (Zakaz) i$.next();
                    if (c4.getBludId() == bludId) {
                        allKolvo += c4.getZakazKolvo();
                    }
                }
                if (allKolvo <= 0) {
                    return false;
                }
                if (allKolvo < kolvo) {
                    return false;
                }
                double ckolvo = c2.DecKolvoTypedPrinted(-kolvo);
                if (ckolvo == -111){
                    return false;
                } else if(ckolvo > 0){
                    this.mZakazs.remove(c2.getZakazNN() - 1);
                }
                if (c2.getZakazKolvo() == 0) {
                    this.mZakazs.remove(c2.getZakazNN() - 1);
                }
            } else {
                bludId = ((Zakaz) this.mZakazs.get(position)).getBludId();
                allKolvo = 0;
                i$ = this.mZakazs.iterator();
                while (i$.hasNext()) {
                    c4 = (Zakaz) i$.next();
                    if (c4.getBludId() == bludId) {
                        allKolvo += c4.getZakazKolvo();
                    }
                }
                if (allKolvo <= 0) {
                    return false;
                }
                if (allKolvo < kolvo) {
                    return false;
                }
                Zakaz c3 = new Zakaz(this.mZakazs.size() + 1, c.getBludId(), c.getZakazNaim(), c.getmZakazComment(), c.getBludPrice(),c.getmZakazType(),c.getZakazKolvo());
                c3.setZakazKolvo(-kolvo);
                this.mZakazs.add(c3);
            }
            return true;
        }
    }

    public Zakaz getZakaz(int idBlud) {
        Iterator i$ = this.mZakazs.iterator();
        while (i$.hasNext()) {
            Zakaz c = (Zakaz) i$.next();
            if (c.getBludId() == idBlud && c.getZakazPrinted() == 0) {
                return c;
            }
        }
        return null;
    }

    public Zakaz getZakaz2(int idBlud) {
        Iterator i$ = this.mZakazs.iterator();
        while (i$.hasNext()) {
            Zakaz c = (Zakaz) i$.next();
            if (c.getBludId() == idBlud) {
                return c;
            }
        }
        return null;
    }

    public int getZakazsSumm() {
        int summ = 0;
        Iterator i$ = this.mZakazs.iterator();
        while (i$.hasNext()) {
            summ += ((Zakaz) i$.next()).getZakazSumm();
        }
        return summ;
    }

    public int getZakazsSize() {
        return this.mZakazs.size();
    }
}
