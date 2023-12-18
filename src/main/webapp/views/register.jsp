<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/login.css">
    <script src="/js/bms.js"></script>
    <style>
        .center-text {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="backgroundImg">
        <div class="center">
            <form action="${pageContext.request.contextPath}/register" method="post">
                <h2 class="sign-in">图书管理系统-注册</h2>

                <!-- Display success message -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success center-text" role="alert">
                        ${message}
                        <!-- Call JavaScript function to redirect after 5 seconds -->
                        <script>
                            redirectToLogin();
                        </script>
                    </div>
                </c:if>

                <!-- Display error message -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger center-text" role="alert">
                        ${error}
                    </div>
                </c:if>

                <div class="form-group">
                    <label for="username" class="sr-only">Username</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
                </div>

                <div class="form-group">
                    <label for="password" class="sr-only">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                </div>

                <div class="form-group">
                    <label for="email" class="sr-only">Email</label>
                    <input type="text" class="form-control" id="email" name="email" placeholder="Email" required>
                </div>

                <button type="submit" class="btn btn-primary">Submit</button>

                <div style='margin-top: 25px'>
                    <p style='color: white'>Already have account? <a href="/login">Sign in now!</a></p>
                </div>
            </form>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
