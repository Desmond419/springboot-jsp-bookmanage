<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>Admin Index</title>
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/admin_index.css">
    <script src="/js/bms.js"></script>
</head>
<body>

    <div class="container">
        <div class="header">
            <h2>Welcome, admin(<c:out value="${username}" />)</h2>
            <span id="userMessage" style="color: #757575; font-size: 25px; text-align:center; margin-right: 120px; letter-spacing: 2px">图书管理系统</span>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>

        <!-- Search Bar Section -->
        <div class="search-bar">
            <form action="${pageContext.request.contextPath}/auth/search_book" method="GET" style="display: inline-block;">
                <input type="text" name="keyword" placeholder="Search by Title or Author">
                <button type="submit" class="btn btn-primary">Search</button>
            </form>

            <!-- Add Book Button -->
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addBookModal">
                Add Book
            </button>

            <!-- Add BookType Button -->
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addBookTypeModal">
                Add Book Type
            </button>

            <!-- Add Book Modal -->
            <div class="modal fade" id="addBookModal" tabindex="-1" role="dialog" aria-labelledby="addBookModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addBookModalLabel">Add Book</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <!-- Add your form elements for adding a new book here -->
                            <form action="${pageContext.request.contextPath}/auth/add_book" method="POST">
                                <div class="form-group">
                                    <label for="bookName">Book Name</label>
                                    <input type="text" class="form-control" id="name" name="name" required>
                                </div>
                                <div class="form-group">
                                    <label for="author">Author</label>
                                    <input type="text" class="form-control" id="author" name="author" required>
                                </div>
                                <div class="form-group">
                                    <label for="price">Price</label>
                                    <input type="text" class="form-control" id="price" name="price">
                                </div>
                                <div class="form-group">
                                    <label for="bookType">Book Type</label>
                                    <!-- Add a dropdown for selecting book type -->
                                    <select class="form-control" id="bookTypeId" name="bookTypeId" required>
                                        <!-- Populate options based on available book types -->
                                        <c:forEach var="type" items="${bookTypes}">
                                            <option value="${type.id}">${type.typeName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="description">Description</label>
                                    <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Add Book</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Add BookType Modal -->
            <div class="modal fade" id="addBookTypeModal" tabindex="-1" role="dialog" aria-labelledby="addBookTypeModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addBookTypeModalLabel">Add Book Type</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="${pageContext.request.contextPath}/auth/add_type" method="POST">
                                <div class="form-group">
                                    <label for="bookType">Type Name</label>
                                    <input type="text" class="form-control" id="typeName" name="typeName" required>
                                </div>
                                <button type="submit" class="btn btn-primary">Confirm</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Book List Section -->
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
                    <!-- Iterate through the bookList and display each book -->
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
                                <!-- Edit Book Button -->
                                <button type="button" class="btn btn-primary action-btn" data-toggle="modal" data-target="#editBookModal"
                                        data-book-id="${book.id}" data-book-name="${book.name}" data-book-author="${book.author}"
                                        data-book-price="${book.price}" data-book-typeId="${book.bookTypeId}" data-book-description="${book.description}">
                                    Edit
                                </button>

                                <!-- Edit Book Modal -->
                                <div class="modal fade" id="editBookModal" tabindex="-1" role="dialog" aria-labelledby="editBookModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="editBookModalLabel">Edit Book</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <!-- Add your form elements for editing a book here -->
                                                <form id="editBookForm">
                                                    <div class="form-group">
                                                        <label for="name">Book Name</label>
                                                        <input type="text" class="form-control" id="editName" name="name" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="author">Author</label>
                                                        <input type="text" class="form-control" id="editAuthor" name="author" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="price">Price</label>
                                                        <input type="text" class="form-control" id="editPrice" name="price" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="bookType">Book Type</label>
                                                        <!-- Add a dropdown for selecting book type -->
                                                        <select class="form-control" id="editBookTypeId" name="bookTypeId" required>
                                                            <!-- Populate options based on available book types -->
                                                            <c:forEach var="type" items="${bookTypes}">
                                                                <option value="${type.id}">${type.typeName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="description">Description</label>
                                                        <textarea class="form-control" id="editDescription" name="description" rows="3"></textarea>
                                                    </div>
                                                    <input type="hidden" id="editId" name="id">

                                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Edit Book Button -->
                                <button type="button" class="btn btn-danger action-btn" data-toggle="modal" data-target="#deleteBookModal">
                                    Delete
                                </button>

                               <!-- Delete Book Confirmation Modal -->
                               <div class="modal fade" id="deleteBookModal" tabindex="-1" role="dialog" aria-labelledby="deleteBookModalLabel" aria-hidden="true">
                                   <div class="modal-dialog" role="document">
                                       <div class="modal-content">
                                           <div class="modal-header">
                                               <h5 class="modal-title" id="deleteBookModalLabel">Confirm Deletion</h5>
                                               <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                   <span aria-hidden="true">&times;</span>
                                               </button>
                                           </div>
                                           <div class="modal-body">
                                               <p>Are you sure you want to delete this book?</p>
                                           </div>
                                           <div class="modal-footer">
                                               <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                               <a href="${pageContext.request.contextPath}/auth/delete_book?id=${book.id}" class="btn btn-danger">Delete</a>
                                           </div>
                                       </div>
                                   </div>
                               </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Display Success or Error Message -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${message}
                <script>
                    autoCloseAlert();
                </script>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
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

    <!-- Add this script to your HTML file -->
    <script>
        // 设置编辑表单
        function setEditBookForm(book) {
            console.log('Setting edit form with book data:', book);

            // Set values for the form fields
            $('#editName').val(book.name);
            $('#editAuthor').val(book.author);
            $('#editPrice').val(book.price);
            $('#editBookTypeId').val(book.bookTypeId);
            $('#editDescription').val(book.description);

            // Set the book ID in the hidden input
            $('#editId').val(book.id);
        }


        // 在模态框显示前调用，传递图书信息
        $('#editBookModal').on('shown.bs.modal', function (event) {
            console.log('Modal shown');
            var button = $(event.relatedTarget);
            console.log('Button:', button);
            var book = {
                id: button.data('book-id'),
                name: button.data('book-name'),
                author: button.data('book-author'),
                price: button.data('book-price'),
                bookTypeId: button.data('book-typeId'),
                description: button.data('book-description')
                // Add more properties as needed
            };
            console.log('Book:', book);
            setEditBookForm(book);
        });

        // 处理编辑表单提交事件
        $('#editBookForm').submit(function (e) {
            e.preventDefault();

            // 发起Ajax请求更新图书信息
            $.ajax({
                type: 'POST',  // Use POST or PUT based on your server-side implementation
                url: '${pageContext.request.contextPath}/auth/edit_book',
                data: $('#editBookForm').serialize(),
                success: function (data) {
                    console.log('Book edited successfully');
                    alert('Book edited successfully');
                    window.location.reload();
                },
                error: function (error) {
                    console.error('Error editing book', error);
                    alert('Error editing book: ' + error.responseText);
                }
            });
            $('#editBookModal').modal('hide');
        });
    </script>
</body>
</html>
