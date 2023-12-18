package com.desmond.bms.dao;

import com.desmond.bms.bean.Borrow;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BorrowDao {

    List<Borrow> findAll();

    List<Borrow> findByUserId(String id);

    void save(Borrow borrow);

    void update(Borrow borrow);

    void deleteById(String id);

    Borrow findByBorrowId(String borrowId);
}
