$(function () {
    //初始化分页导航条
    var totalPages = parseInt($("input[name='TotalPages']").val());
    initPaginator('#paginationNav', totalPages, 1);
    $("#paginationNav").css("display", "none");
});
//分页导航回调函数
function accessResource(n) {
    var url = "/ManualInspectionSafetyAssessment/GetManualInspectionSafetyAssessmentReportList";
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
    var url = "/ManualInspectionSafetyAssessment/GetManualInspectionSafetyAssessmentReportList";
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
                $("#unfold").css("display", "none");
                $("#message").css("color", datas.color);
            }
            else {
                $("#message").html("");
                $("#dataQueryList").html(datas);
                $("#unfold").css("display", "none");
                $("#paginationNav").css("display", "block");
            }
        }
    });
});

$(function () {
    $("#ManualInspectionSafetyAssessmentReportUpLoad").click(function () {
        var reportGrade = $("#ManualInspectionAssessmentStateSelect").val()
        var wordFileSize = $("#ManualInspectionwordFileSize").val()
        var url = "/ManualInspectionSafetyAssessment/UploadManualInspectionSafetyAssessmentReport";
        var file = document.getElementById("fileField").files;
        var name = document.getElementById('textfield').value;
        var fileName = name.substring(name.lastIndexOf(".") + 1).toLowerCase();
        //验证文件上传是否为空
        if (name == "" || name == null) {
            $("#message").html("请选择上传文件");
            $("#message").css("color", "red");
        }
            //验证文件的格式
        else if (fileName != "doc" && fileName != "docx") {
            $("#message").html("请选择word格式文件上传");
            $("#message").css("color", "red");
            clearFilePath();
        }
            //验证文件的大小
        else if (file[0].size > wordFileSize) {
            $("#message").html("上传文件不能超过10M");
            $("#message").css("color", "red");
            clearFilePath();
        }
        else
        {
            $.ajaxFileUpload({
                url: url,//url请求命令
                fileElementId: 'fileField',
                dataType: "json",
                contentType: "application/json",
                Type:"POST",
                data: { reportGradeId: reportGrade },
                success: function (datas) {
                    $("#message").html(datas);
                    dataQuery();
                },
                error: function (result) {
                    alert(result.responsetext);
                }
            });
        }});    
})

function ManualInspectionSafetyAssessmentReportDownLoad(saveSender, url) {
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
            document.location.href = "/ManualInspectionSafetyAssessment/OriginCode?guid=" + data + "&ReportName=" + reportName;
        },
        error: function (result) {
            alert(result.responseText);
        }
    });
}




function ManualInspectionSafetyAssessmentReportDelete(saveSender, url) {
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
            $("#message").html(datas);
            dataQuery();
        },
        error: function (result) {
            alert(result.responseText);
        }
    });
}

//刷新重新查询数据列表
function dataQuery() {
    var time = $("#Monthpicker").val();
    var url = "/ManualInspectionSafetyAssessment/GetManualInspectionSafetyAssessmentReportList";
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
                $("#unfold").css("display", "none");
                $("#message").html(datas.message);
                $("#message").css("color", datas.color);
            }
            else {

                $("#dataQueryList").html(datas);
                $("#unfold").css("display", "none");
                $("#paginationNav").css("display", "block");
            }
        }
    });
};

//清楚上传报告路径文本框内容、清楚文件选择器的文本内容
function clearFilePath() {
    $("#textfield").val(""); //清楚上传报告路径文本框内容
    //清楚文件选择器的文本内容
    var file = $("#fileField")
    file.after(file.clone().val(""));
    file.remove();
};


