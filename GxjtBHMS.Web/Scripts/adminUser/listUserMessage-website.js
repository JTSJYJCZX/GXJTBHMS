$(function () {
    //初始化分页导航条
    var totalPages = parseInt($("input[name='TotalPages']").val());
    initPaginator('#paginationNav', totalPages, 1);
    $("#paginationNav").css("display", "none");
});
//分页导航回调函数
function accessResource(n) {
    var containsUserNameId = $("#ContainsUserNameID").val();//获取测点位置编号
    var userStateId = $("#UserStateID").val();//获取测点编号，本身就是js数组
    var url = "/AdminUser/GetUserMessageList";
    $.ajax({
        url: url,//URL请求命令
        traditional: true,　//jQuery需要调用jQuery.param序列化参数，默认的话，traditional为false，即jquery会深度序列化参数对象，以适应如PHP和Ruby on Rails框架， 我们可以通过设置traditional 为true阻止深度序列化。
        type: "get",
        dataType: "html",
        contentType: "application/x-www-form-urlencoded",//默认设置， 窗体数据被编码为名称/值对
        data: {
            ContainsUserName: containsUserNameId,
            SearchUserStateId: userStateId,
            CurrentPageIndex: n
        },
        success: function (datas) {
            $("#dataQueryList").html(datas);
            $("#paginationNav").css("display","block");
        },
        error: function (result) {
            alert(result.responseText);
        }
    });
}
function saveOperate(sender, url, userId) {
    if (!confirm('是否保存?')) return;
    var $sender = $(sender);
    var userStateId = $sender.parent().prev().find("select").val();
    var headers = getHeadersWithAntiForgeryToken();
    ajaxHandler(url, headers, { userStateId: userStateId, userId: userId });
}

function RetPwd(url, userId) {
    if (!confirm('是否确定重置密码?')) return;
    var headers = getHeadersWithAntiForgeryToken();
    ajaxHandler(url, headers, { userId: userId });
}

$("#btnQuery").click(function () {
    var containsUserNameId = $("#ContainsUserNameID").val();//获取测点位置编号
    var userStateId = $("#UserStateID").val();//获取测点编号，本身就是js数组
    var url = "/AdminUser/GetUserMessageList";
    $.ajax({
        type: 'get',
        url: url,
        data: {
            ContainsUserName: containsUserNameId,
            SearchUserStateId: userStateId
        },
        beforeSend: function () {
            $('body').chardinJs('start')
        },
        complete: function () {
            $('body').chardinJs('stop')
        },
        success: function (datas) {
            if (datas.message) {
                $("#dataQueryList").html("");
                $("#paginationNav").css("display", "none");
                $("#message").html(datas.message);
                $("#message").css("color", datas.color);
            }
            else {
                $("#message").html("");
                $("#dataQueryList").html(datas);
                $("#paginationNav").css("display", "block");
            }
        }
    });
});
