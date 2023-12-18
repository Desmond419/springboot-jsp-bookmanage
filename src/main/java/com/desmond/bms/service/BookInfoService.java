package com.desmond.bms.service;

import com.desmond.bms.bean.BookInfo;

import java.util.List;

public interface BookInfoService {
    List<BookInfo> findAll();

    BookInfo findById(String id);

    void save(BookInfo bookInfo);

    void update(BookInfo bookInfo);

    void deleteById(String id);

    List<BookInfo> findBySearch(String keyword);
}
