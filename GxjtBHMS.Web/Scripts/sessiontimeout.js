jQuery(function ($) {
    $.ajaxSetup({
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        complete: function (XMLHttpRequest, status) {
            console.log(XMLHttpRequest.responseText);
            if (XMLHttpRequest.getResponseHeader("sessionstatus") == 'timeout') {
                window.location.href = "/User/Login";
                return;
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
             console.log(XMLHttpRequest.responseText);
        }
    });
})