package com.example.waiter;

public class CategoryData {
    private int id;
    private String catname;

    public CategoryData(int id, String catname) {
        this.id = id;
        this.catname = catname;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCatname() {
        return catname;
    }

    public void setCatname(String catname) {
        this.catname = catname;
    }
}
