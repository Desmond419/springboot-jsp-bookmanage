package com.desmond.bms.controller;

import com.desmond.bms.bean.BookInfo;
import com.desmond.bms.bean.BookType;
import com.desmond.bms.bean.LoginUser;
import com.desmond.bms.service.BookInfoService;
import com.desmond.bms.service.BookTypeService;
import com.desmond.bms.service.BorrowService;
import com.desmond.bms.utils.SecurityContextUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/auth")
public class AdminIndexController {
    @Autowired
    private BookInfoService bookInfoService;

    @Autowired
    private BookTypeService bookTypeService;

    @GetMapping("/admin_index")
    public String showIndex(Model model, HttpServletRequest request) {
        SecurityContext securityContext = SecurityContextUtil.getSecurityContextFromSession(request);
        if (securityContext != null && securityContext.getAuthentication().isAuthenticated()) {
            LoginUser authUser = (LoginUser) securityContext.getAuthentication().getPrincipal();
            model.addAttribute("username", authUser.getUser().getUsername());
            model.addAttribute("bookList", bookInfoService.findAll());
            model.addAttribute("bookTypes", bookTypeService.findAll());
            return "admin_index";
        } else {
            return "redirect:/login";
        }
    }

    @PostMapping("/add_book")
    public String addBook(@ModelAttribute BookInfo bookInfo, RedirectAttributes redirectAttributes, HttpServletRequest request) {
        SecurityContext securityContext = SecurityContextUtil.getSecurityContextFromSession(request);
        if (securityContext != null && securityContext.getAuthentication().isAuthenticated()) {
            bookInfoService.save(bookInfo);
            redirectAttributes.addFlashAttribute("message", "Book Added!");
            return "redirect:/auth/admin_index";
        } else {
            return "redirect:/login";
        }
    }

    @PostMapping("/add_type")
    public String addBookType(@ModelAttribute BookType bookType, RedirectAttributes redirectAttributes,
                              HttpServletRequest request) {

        SecurityContext securityContext = SecurityContextUtil.getSecurityContextFromSession(request);
        if (securityContext != null && securityContext.getAuthentication().isAuthenticated()) {
            bookTypeService.save(bookType);
            redirectAttributes.addFlashAttribute("message", "Book Type Added!");
            return "redirect:/auth/admin_index";
        } else {
            return "redirect:/login";
        }
    }

    @GetMapping("/delete_book")
    public String deleteBook(@RequestParam String id, RedirectAttributes redirectAttributes, HttpServletRequest request) {

        SecurityContext securityContext = SecurityContextUtil.getSecurityContextFromSession(request);
        if (securityContext != null && securityContext.getAuthentication().isAuthenticated()) {
            bookInfoService.deleteById(id);
            redirectAttributes.addFlashAttribute("message", "Book Deleted!");
            return "redirect:/auth/admin_index";
        } else {
            return "redirect:/login";
        }
    }

    @PostMapping("/edit_book")
    public String editBook(@ModelAttribute BookInfo bookInfo, RedirectAttributes redirectAttributes, HttpServletRequest request) {

        SecurityContext securityContext = SecurityContextUtil.getSecurityContextFromSession(request);
        if (securityContext != null && securityContext.getAuthentication().isAuthenticated()) {
            bookInfoService.update(bookInfo);
            redirectAttributes.addFlashAttribute("message", "Book Edited!");
            return "redirect:/auth/admin_index";
        } else {
            return "redirect:/login";
        }
    }
}
