package com.example.waiter;

import com.example.waiter.model.db.orders.Orders;

import java.util.ArrayList;
import java.util.Iterator;

public class OrdersArr {
    private int mOpenOrders = 0;
    private ArrayList<Order> mOrders = new ArrayList();
    private int mOrdersCnt = 0;
    private int mOrdersSumm = 0;

    /*public void setUpOrders(String orders) {
        this.mOrders.clear();
        if (orders.compareTo("0") != 0) {
            String[] d = orders.split("[|]");
            this.mOrdersCnt = d.length;
            this.mOrdersSumm = 0;
            for (int i = 0; i < this.mOrdersCnt; i++) {
                Order c = new Order(d[i]);
                this.mOrders.add(c);

                if (c.getZakrit().compareTo("24:00") != 0) {
                    this.mOpenOrders++;
                }
                this.mOrdersSumm += c.getSumma();
            }


        }
//        Collections.sort(this.mOrders, new Comparator<Order>() {
//            @Override
//            public int compare(Order lhs, Order rhs) {
//                // -1 - less than, 1 - greater than, 0 - equal, all inversed for descending
//                return lhs.getZakrit().length() > rhs.getZakrit().length() ? -1 : (lhs.getZakrit().length() < rhs.getZakrit().length()) ? 1 : 0;
//            }
//        });
    }*/

    public void setUpOrders(ArrayList<Orders> orders) {
        this.mOrders.clear();

        if (orders.size() > 0) {

            this.mOrdersCnt = orders.size();
            this.mOrdersSumm = 0;
            for (int i = 0; i < this.mOrdersCnt; i++) {
                Order c = new Order(orders.get(i));
                this.mOrders.add(c);
                System.out.println(c.getOtkrit());
                if (c.getZakrit().compareTo("24:00") != 0) {
                    this.mOpenOrders++;
                }
                this.mOrdersSumm += c.getSumma();
            }


        }
//        Collections.sort(this.mOrders, new Comparator<Order>() {
//            @Override
//            public int compare(Order lhs, Order rhs) {
//                // -1 - less than, 1 - greater than, 0 - equal, all inversed for descending
//                return lhs.getZakrit().length() > rhs.getZakrit().length() ? -1 : (lhs.getZakrit().length() < rhs.getZakrit().length()) ? 1 : 0;
//            }
//        });
    }

    public ArrayList<Order> getOrders() {
        return this.mOrders;
    }

    public Order getOrder(int idOrder) {
        Iterator i = this.mOrders.iterator();
        while (i.hasNext()) {
            Order c = (Order) i.next();
            if (c.getOrderId() == idOrder) {
                return c;
            }
        }
        return null;
    }

    public int getOrdersCnt() {
        return this.mOrdersCnt;
    }

    public int getOrdersSumm() {
        return this.mOrdersSumm;
    }

    public int getmOpenOrders() {
        return this.mOpenOrders;
    }
}
