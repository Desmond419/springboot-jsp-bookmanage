function redirectToLogin() {
    setTimeout(function () {
        window.location.href = "/login";
    }, 3000); // 3秒后自动跳转到 login
}

function autoCloseAlert() {
    // 2秒后自动关闭提示框
    setTimeout(function() {
        $('.alert').alert('close');
    }, 2000);
}
