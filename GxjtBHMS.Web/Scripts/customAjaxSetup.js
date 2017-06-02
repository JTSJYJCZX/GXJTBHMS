jQuery(function ($) {
    $.ajaxSetup({
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        complete: function (XMLHttpRequest, status) {
            if (XMLHttpRequest.getResponseHeader("sessionstatus") == 'timeout') {
                window.location.href = "/User/Login";
                return;
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            console.log("error:" + XMLHttpRequest.responseText);
            if (XMLHttpRequest.getResponseHeader("errorStatus") == '500') {
                window.location.href = "/ErrorPages/ServerError.html";
                return;
            }
        }
    });
})