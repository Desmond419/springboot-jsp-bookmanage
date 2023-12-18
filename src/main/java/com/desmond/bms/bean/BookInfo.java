package com.desmond.bms.bean;

public class BookInfo {
    private String id;
    private String bookTypeId;
    private String bookTypeName;
    private String name;
    private String author;
    private String price;
    private String description;
    private Integer isBorrow;

    public BookInfo() {
    }
    public BookInfo(String id, String name, String author) {
        this.id = id;
        this.name = name;
        this.author = author;
    }

    public BookInfo(String id, String bookTypeId, String bookTypeName, String name, String author, String price, String description, Integer isBorrow) {
        this.id = id;
        this.bookTypeId = bookTypeId;
        this.bookTypeName = bookTypeName;
        this.name = name;
        this.author = author;
        this.price = price;
        this.description = description;
        this.isBorrow = isBorrow;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBookTypeId() {
        return bookTypeId;
    }

    public void setBookTypeId(String bookTypeId) {
        this.bookTypeId = bookTypeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getIsBorrow() {
        return isBorrow;
    }

    public void setIsBorrow(Integer isBorrow) {
        this.isBorrow = (isBorrow == null) ? 0 : isBorrow;
    }

    public String getBookTypeName() {
        return bookTypeName;
    }

    public void setBookTypeName(String bookTypeName) {
        this.bookTypeName = bookTypeName;
    }
}
