package com.desmond.bms.service;

import com.desmond.bms.bean.Borrow;

import java.util.List;

public interface BorrowService {
    List<Borrow> findAll();

    List<Borrow> findByUserId(String id);

    void save(String bookId, String userId);

    void update(Borrow borrow);

    void deleteById(String id);

    Borrow findByBorrowId(String borrowId);
}
