package com.desmond.bms.service.impl;

import com.desmond.bms.bean.BookType;
import com.desmond.bms.dao.BookTypeDao;
import com.desmond.bms.service.BookTypeService;
import com.desmond.bms.utils.GenUUID;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookTypeServiceImpl implements BookTypeService {

    private final BookTypeDao bookTypeDao;

    public BookTypeServiceImpl(BookTypeDao bookTypeDao) {
        this.bookTypeDao = bookTypeDao;
    }

    @Override
    public List<BookType> findAll() {
        return bookTypeDao.findAll();
    }

    @Override
    public BookType findById(String id) {
        return bookTypeDao.findById(id);
    }

    @Override
    public void save(BookType bookType) {
        bookType.setId(GenUUID.getUUID());
        bookTypeDao.save(bookType);
    }

    @Override
    public void update(BookType bookType) {
        bookTypeDao.update(bookType);
    }

    @Override
    public void deleteById(String id) {
        bookTypeDao.deleteById(id);
    }
}
