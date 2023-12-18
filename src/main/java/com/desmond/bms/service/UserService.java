package com.desmond.bms.service;


import com.desmond.bms.bean.User;

public interface UserService {
    User findUserById(String id);
    User findByUsername(String username);
    void save(User user);
    void deleteUserById(String userId);
    void updateUser(User user);
}