package com.desmond.bms.service.impl;

import com.desmond.bms.bean.Borrow;
import com.desmond.bms.dao.BorrowDao;
import com.desmond.bms.service.BorrowService;
import com.desmond.bms.utils.GenUUID;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class BorrowServiceImpl implements BorrowService {

    private final BorrowDao borrowDao;

    public BorrowServiceImpl(BorrowDao borrowDao) {
        this.borrowDao = borrowDao;
    }

    @Override
    public List<Borrow> findAll() {
        return borrowDao.findAll();
    }

    @Override
    public List<Borrow> findByUserId(String id) {
        return borrowDao.findByUserId(id);
    }

    @Override
    public void save(String bookId, String userId) {
        LocalDateTime currentTime = LocalDateTime.now();
        LocalDateTime oneWeekLater = currentTime.plusWeeks(1);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        Borrow borrow = new Borrow();
        borrow.setId(GenUUID.getUUID());
        borrow.setBookId(bookId);
        borrow.setUserId(userId);
        borrow.setBorrowTime(currentTime.format(formatter));
        borrow.setReturnTime(oneWeekLater.format(formatter));
        borrowDao.save(borrow);
    }

    @Override
    public void update(Borrow borrow) {
        borrowDao.update(borrow);
    }

    @Override
    public void deleteById(String id) {
        borrowDao.deleteById(id);
    }

    @Override
    public Borrow findByBorrowId(String borrowId) {
        return borrowDao.findByBorrowId(borrowId);
    }
}
