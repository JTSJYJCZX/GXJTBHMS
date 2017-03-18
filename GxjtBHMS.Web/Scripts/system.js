function getHeadersWithAntiForgeryToken() {
    var token = $("input[name = '__RequestVerificationToken']").val();
    var headers = {};
    headers["__RequestVerificationToken"] = token;
    return headers;
}

function ajaxHandler(url, headers, params) {
    $.ajax({
        type: 'POST',
        url: url,
        headers: headers,
        data: params,
        success: function (datas) {
            $("#message").html(datas.message);
            $("#message").css("color",datas.color);
        },
        error: function (result) {
            alert(result.responseText)
        }
    });
}

function returnHandler(source, button) {
    $(source).keyup(function (event) {
        if (event.keyCode == 13) {
            $(button).click();
        }
    });
}