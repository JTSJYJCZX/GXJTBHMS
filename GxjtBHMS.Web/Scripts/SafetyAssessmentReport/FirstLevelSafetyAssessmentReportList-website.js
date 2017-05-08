$(function () {
    //初始化分页导航条
    var totalPages = parseInt($("input[name='TotalPages']").val());
    initPaginator('#paginationNav', totalPages, 1);
    $("#paginationNav").css("display", "none");
});
//分页导航回调函数
function accessResource(n) {
    var url = "/FirstLevelSafetyAssessment/GetFirstLevelSafetyAssessmentReportList";
    $.ajax({
        url: url,//URL请求命令
        traditional: true,　//jQuery需要调用jQuery.param序列化参数，默认的话，traditional为false，即jquery会深度序列化参数对象，以适应如PHP和Ruby on Rails框架， 我们可以通过设置traditional 为true阻止深度序列化。
        type: "get",
        dataType: "html",
        contentType: "application/x-www-form-urlencoded",//默认设置， 窗体数据被编码为名称/值对
        data: {
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


$("#bttnquery").click(function () {
    var time = $("#Monthpicker").val();
    var url = "/FirstLevelSafetyAssessment/GetFirstLevelSafetyAssessmentReportList";
    $.ajax({
        type: 'get',
        url: url,
        data: {
            Time: time,
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

function downloadReport(sender,url) {
    var $sender = $(sender);
    var op = $sender.attr('operate');
    var reportId = $sender.prev().val();
    var reportName = $sender.prev().prev().val();
    if (op === 'download') {
        $.ajax({
            url: url,//URL请求命令
            traditional: true,　//jQuery需要调用jQuery.param序列化参数，默认的话，traditional为false，即jquery会深度序列化参数对象，以适应如PHP和Ruby on Rails框架， 我们可以通过设置traditional 为true阻止深度序列化。
            type: "get",
            beforeSend: function () {
                $('body').chardinJs('start');
            },
            complete: function (data) {
                $('body').chardinJs('stop');
            },
            data: {
                reportId: reportId,
            },
            success: function (data) {
                document.location.href = "/FirstLevelSafetyAssessment/OriginCode?guid=" + data + "&ReportName=" + reportName;
            },
            error: function (result) {
                alert(result.responseText);
            }
        });
    }
}