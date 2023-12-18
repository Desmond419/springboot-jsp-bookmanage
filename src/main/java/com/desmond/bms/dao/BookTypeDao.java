package com.desmond.bms.dao;

import com.desmond.bms.bean.BookType;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BookTypeDao {

    List<BookType> findAll();

    BookType findById(String id);

    void save(BookType bookType);

    void update(BookType bookType);

    void deleteById(String id);
}
