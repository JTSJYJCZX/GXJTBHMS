$(function () {
    //初始化分页导航条
    var totalPages = parseInt($("input[name='TotalPages']").val());
    initPaginator('#paginationNav', totalPages, 1);
    $("#paginationNav").css("display", "none");
});
//分页导航回调函数
function accessResource(n) {
    var url = "/SecondLevelSafetyAssessment/GetSecondLevelSafetyAssessmentReportList";
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
    var url = "/SecondLevelSafetyAssessment/GetSecondLevelSafetyAssessmentReportList";
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

$(function () {
    $("#SecondLevelSafetyAssessmentReportUpLoad").click(function () {
        var reportGrade = $("#SecondLevelAssessmentStateSelect").val()
        var url = "/secondlevelsafetyassessment/UploadSecondLevelSafetyAssessmentReport";
        $.ajaxFileUpload({
            url: url,//url请求命令
            fileElementId: 'fileField',
            dataType: 'HTML', //返回值类型 一般设置为json
            Type:"POST",
            data: { reportGradeId: reportGrade },
            success: function (datas) {
                $("#datasMessage").html(datas);
                $("#dusj1").div();
             
            },
            error: function (result) {
                alert(result.responsetext);
            }
        });
    });
})

function SecondLevelSafetyAssessmentReportDownLoad(saveSender, url) {
    if (!confirm('是否操作?')) return;
    var $saveSender = $(saveSender);
    var reportPath = $saveSender.prev().val();
    var reportName = $saveSender.prev().prev().val();
    var headers = getHeadersWithAntiForgeryToken();
    $.ajax({
        url: url,//URL请求命令
        traditional: true,　//jQuery需要调用jQuery.param序列化参数，默认的话，traditional为false，即jquery会深度序列化参数对象，以适应如PHP和Ruby on Rails框架， 我们可以通过设置traditional 为true阻止深度序列化。
        type: "get",
        headers: headers,
        beforeSend: function () {
            $('body').chardinJs('start');
        },
        complete: function (data) {
            $('body').chardinJs('stop');
        },
        data: {
            ReportPath: reportPath,
            ReportName:reportName
        },
        success: function (data) {
            document.location.href = "/SecondLevelSafetyAssessment/OriginCode?guid=" + data + "&ReportName=" + reportName;
        },
        error: function (result) {
            alert(result.responseText);
        }
    });
}




function SecondLevelSafetyAssessmentReportDelete(saveSender, url) {
    if (!confirm('是否操作?')) return;
    var $saveSender = $(saveSender);
    var reportPath = $saveSender.prev().val();
    var reportTime = $saveSender.prev().prev().val();
    var headers = getHeadersWithAntiForgeryToken();
    $.ajax({
        url: url,//URL请求命令
        traditional: true,　//jQuery需要调用jQuery.param序列化参数，默认的话，traditional为false，即jquery会深度序列化参数对象，以适应如PHP和Ruby on Rails框架， 我们可以通过设置traditional 为true阻止深度序列化。
        type: "get",
        headers: headers,
        beforeSend: function () {
            $('body').chardinJs('start');
        },
        complete: function (data) {
            $('body').chardinJs('stop');
        },
        data: {
            ReportPath: reportPath,
            ReportTime: reportTime
        },
        success: function (datas) {
               $("#datasMessage").html(datas);
        },
        error: function (result) {
            alert(result.responseText);
        }
    });
}


