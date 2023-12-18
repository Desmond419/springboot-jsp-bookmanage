package com.desmond.bms.controller;

import com.desmond.bms.bean.LoginUser;
import com.desmond.bms.bean.User;
import com.desmond.bms.service.UserService;
import com.desmond.bms.utils.BusinessException;
import com.desmond.bms.utils.SecurityContextUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;


@Controller
public class LoginController {
    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserService userService;


    @GetMapping("/login")
    public String showLoginPage(Model model) {
        model.addAttribute("user", new User());
        return "login";
    }

    @PostMapping("/login")
    public String processLogin(@ModelAttribute User user, Model model, HttpServletRequest request) {
        try {
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword()));
            SecurityContextUtil.saveSecurityContextToSession(request, authentication);

            User foundUser = userService.findByUsername(user.getUsername());
            if (user.getRole().equals("admin") && foundUser.getRole().equals("admin")) {
                return "redirect:/auth/admin_index";
            } else if (user.getRole().equals("admin") && !foundUser.getRole().equals("admin")){
                model.addAttribute("error", "您没有Admin权限");
                return "login";
            }
            return "redirect:/auth/user_index";
        } catch (AuthenticationException e) {
            model.addAttribute("error", "用户名或密码错误");
            return "login";
        } catch (BusinessException e) {
            model.addAttribute("error", e.getMessage());
            return "login";
        }
    }
}
