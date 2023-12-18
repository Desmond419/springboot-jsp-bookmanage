package com.desmond.bms.dao;

import com.desmond.bms.bean.BookInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BookInfoDao {

    List<BookInfo> findAll();

    BookInfo findById(String id);

    void save(BookInfo bookInfo);

    void update(BookInfo bookInfo);

    void deleteById(String id);

    List<BookInfo> findBySearch(String keyword);
}
