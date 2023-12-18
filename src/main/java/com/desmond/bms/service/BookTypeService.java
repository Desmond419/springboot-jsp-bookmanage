package com.desmond.bms.service;

import com.desmond.bms.bean.BookType;

import java.util.List;

public interface BookTypeService {
    List<BookType> findAll();

    BookType findById(String id);

    void save(BookType bookType);

    void update(BookType bookType);

    void deleteById(String id);
}
