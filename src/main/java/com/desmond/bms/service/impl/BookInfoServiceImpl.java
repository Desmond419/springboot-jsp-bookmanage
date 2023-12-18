package com.desmond.bms.service.impl;

import com.desmond.bms.bean.BookInfo;
import com.desmond.bms.dao.BookInfoDao;
import com.desmond.bms.service.BookInfoService;
import com.desmond.bms.utils.GenUUID;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookInfoServiceImpl implements BookInfoService {

    private final BookInfoDao bookInfoDao;

    public BookInfoServiceImpl(BookInfoDao bookInfoDao) {
        this.bookInfoDao = bookInfoDao;
    }

    @Override
    public List<BookInfo> findAll() {
        return bookInfoDao.findAll();
    }

    @Override
    public BookInfo findById(String id) {
        return bookInfoDao.findById(id);
    }

    @Override
    public void save(BookInfo bookInfo) {
        bookInfo.setId(GenUUID.getUUID());
        bookInfo.setIsBorrow(bookInfo.getIsBorrow());
        bookInfoDao.save(bookInfo);
    }

    @Override
    public void update(BookInfo bookInfo) {
        bookInfo.setIsBorrow(bookInfo.getIsBorrow());
        bookInfoDao.update(bookInfo);
    }

    @Override
    public void deleteById(String id) {
        bookInfoDao.deleteById(id);
    }

    @Override
    public List<BookInfo> findBySearch(String keyword) {
        return bookInfoDao.findBySearch(keyword);
    }
}
