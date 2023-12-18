package com.desmond.bms.controller;

import com.desmond.bms.bean.LoginUser;
import com.desmond.bms.service.BookInfoService;
import com.desmond.bms.service.BorrowService;
import com.desmond.bms.utils.SecurityContextUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/auth")
public class UserIndexController {
    @Autowired
    private BookInfoService bookInfoService;

    @Autowired
    private BorrowService borrowService;

    @GetMapping("/user_index")
    public String showIndex(Model model, HttpServletRequest request) {
        SecurityContext securityContext = SecurityContextUtil.getSecurityContextFromSession(request);
        if (securityContext != null && securityContext.getAuthentication().isAuthenticated()) {
            LoginUser authUser = (LoginUser) securityContext.getAuthentication().getPrincipal();
            model.addAttribute("username", authUser.getUser().getUsername());
            model.addAttribute("bookList", bookInfoService.findAll());
            model.addAttribute("borrowedList", borrowService.findByUserId(authUser.getUser().getId()));
            return "user_index";
        } else {
            return "redirect:/login";
        }
    }

    @GetMapping(value = "/search_book")
    public String findBookInfoBySearch (Model model, HttpServletRequest request, @RequestParam String keyword){
        SecurityContext securityContext = SecurityContextUtil.getSecurityContextFromSession(request);
        if (securityContext != null && securityContext.getAuthentication().isAuthenticated()) {
            LoginUser authUser = (LoginUser) securityContext.getAuthentication().getPrincipal();
            model.addAttribute("username", authUser.getUser().getUsername());
            model.addAttribute("bookList", bookInfoService.findBySearch(keyword));
            return "user_index";
        } else {
            return "redirect:/login";
        }
    }
}
