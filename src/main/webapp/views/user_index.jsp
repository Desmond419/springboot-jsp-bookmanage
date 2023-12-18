<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>User Index</title>
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/user_index.css">
    <script src="/js/bms.js"></script>
</head>
<body>

    <div class="container">
        <div class="header">
            <h2>Welcome, <c:out value="${username}" /></h2>
            <span id="userMessage" style="color: #757575; font-size: 25px; text-align:center; margin-right: 120px; letter-spacing: 2px">图书管理系统</span>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>

        <div class="search-bar">
            <form action="${pageContext.request.contextPath}/auth/search_book" method="GET" style="display: inline-block;">
                <input type="text" name="keyword" placeholder="Search by Title or Author">
                <button type="submit" class="btn btn-primary">Search</button>
            </form>

            <!-- Borrowed Books 的 modal -->
            <button type="button" class="btn btn-info" data-toggle="modal" data-target="#borrowedBooksModal">
                Return Books
            </button>
        </div>

        <!-- Borrowed Books Modal -->
        <div class="modal fade" id="borrowedBooksModal" tabindex="-1" role="dialog" aria-labelledby="borrowedBooksModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="borrowedBooksModalLabel">Borrowed Books</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="borrowed-list">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Book Name</th>
                                    <th>Borrow Time</th>
                                    <th>Due Date</th>
                                    <th>Operation</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="borrowed" items="${borrowedList}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${borrowed.bookName}</td>
                                        <td>${borrowed.borrowTime}</td>
                                        <td style="color: green">${borrowed.returnTime}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/auth/return?borrowId=${borrowed.id}"
                                            class="btn btn-info action-btn">Return</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="book-list">
            <h3 style="color: black">Book List</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Book Name</th>
                        <th>Author</th>
                        <th>Price</th>
                        <th>Type</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Operation</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="book" items="${bookList}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${book.name}</td>
                            <td class="textLimit">${book.author}</td>
                            <td>${book.price}</td>
                            <td>${book.bookTypeName}</td>
                            <td class="textLimit">${book.description}</td>
                            <td style="color: ${book.isBorrow eq 0 ? 'green' : 'gray'};">
                                <c:choose>
                                    <c:when test="${book.isBorrow eq 0}">
                                        Not Borrowed
                                    </c:when>
                                    <c:when test="${book.isBorrow eq 1}">
                                        Borrowed
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${book.isBorrow eq 0}">
                                        <a href="${pageContext.request.contextPath}/auth/borrow?bookId=${book.id}" class="btn btn-success action-btn">Borrow</a>
                                    </c:when>
                                    <c:when test="${book.isBorrow eq 1}">
                                        <button class="btn btn-secondary action-btn" disabled>Borrow</button>
                                    </c:when>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${message}
                <script>
                    autoCloseAlert();
                </script>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${error}
                <script>
                    autoCloseAlert();
                </script>
            </div>
        </c:if>
    </div>

     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
