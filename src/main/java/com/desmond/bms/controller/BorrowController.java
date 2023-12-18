package com.desmond.bms.controller;

import com.desmond.bms.bean.BookInfo;
import com.desmond.bms.bean.Borrow;
import com.desmond.bms.bean.LoginUser;
import com.desmond.bms.service.BookInfoService;
import com.desmond.bms.service.BorrowService;
import com.desmond.bms.utils.BusinessException;
import com.desmond.bms.utils.SecurityContextUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Objects;

@Controller
@RequestMapping("/auth")
public class BorrowController {

    @Autowired
    private BorrowService borrowService;

    @Autowired
    private BookInfoService bookInfoService;

    @GetMapping("/borrow")
    public String borrowBook (RedirectAttributes redirectAttributes, HttpServletRequest request, @RequestParam String bookId) {
        SecurityContext securityContext = SecurityContextUtil.getSecurityContextFromSession(request);
        if (securityContext != null && securityContext.getAuthentication().isAuthenticated()) {
            LoginUser authUser = (LoginUser) securityContext.getAuthentication().getPrincipal();

            BookInfo foundBook = bookInfoService.findById(bookId);
            if (Objects.isNull(foundBook)) {
                redirectAttributes.addFlashAttribute("error", "Book not found");
                return "redirect:/auth/user_index";
            } else if (foundBook.getIsBorrow() == 1) {
                redirectAttributes.addFlashAttribute("error", "Stock invalid (Borrowed)");
                return "redirect:/auth/user_index";
            }
            borrowService.save(foundBook.getId(), authUser.getUser().getId());
            // 更新书籍的isBorrow状态
            foundBook.setIsBorrow(1);
            bookInfoService.update(foundBook);
            redirectAttributes.addFlashAttribute("message", "Borrow successful!");
            return "redirect:/auth/user_index";
        } else {
            return "redirect:/login";
        }
    }

    @GetMapping("/return")
    public String returnBorrow (RedirectAttributes redirectAttributes, HttpServletRequest request, @RequestParam String borrowId) {
        SecurityContext securityContext = SecurityContextUtil.getSecurityContextFromSession(request);
        if (securityContext != null && securityContext.getAuthentication().isAuthenticated()) {
            try {
                Borrow foundBorrow = borrowService.findByBorrowId(borrowId);
                BookInfo foundBook = bookInfoService.findById(foundBorrow.getBookId());
                borrowService.deleteById(foundBorrow.getId());
                // 更新书籍的isBorrow状态
                foundBook.setIsBorrow(0);
                bookInfoService.update(foundBook);
                redirectAttributes.addFlashAttribute("message", "Return successful!");
                return "redirect:/auth/user_index";
            } catch (BusinessException e) {
                redirectAttributes.addFlashAttribute("error", e.getMessage());
                return "redirect:/auth/user_index";
            }
        } else {
            return "redirect:/login";
        }
    }
}
