package com.desmond.bms.dao;


import com.desmond.bms.bean.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserDao {
    User findUserById(String id);
    User findByUsername(String username);
    void save(User user);
    void deleteUserById(String userId);
    void updateUser(User user);
}