$(function () {
    //初始化分页导航条
    var totalPages = parseInt($("input[name='TotalPages']").val());
    initPaginator('#paginationNav', totalPages, 1);
    returnHandler('#ContainsPointsNumber', '#btnQuery');
    $("#btnQuery").click(function () {
        var url = "/ThresholdValueSetting/GetThresholdValueSettingList";
        $.ajax({
            type: 'get',
            url: url,
            data: {
                ContainsPointsNumber: $("#ContainsPointsNumber").val()
            },
            success: function (datas) {
                if (datas.message) {
                    $("#strainThresholdValueContent").html("");
                    $("#paginationNav").css("display", "none");
                    $("#message").html(datas.message);
                    $("#message").css("color", datas.color);
                }
                else {
                    $("#message").html("");
                    $("#strainThresholdValueContent").html(datas);
                    $("#paginationNav").css("display", "block");
                }
            }
        });
    })

    //$("#btnUniformSetting").click(function () {
    //    var url = "/ThresholdValueSetting/UniformSettingThresholdValue";
    //    $.ajax({
    //        type: 'get',
    //        url: url,
    //        dataType: "html",
    //        data: { },
    //        success: function (datas) {
    //            alert("成功了！");
    //            $("#uniformSetting").html(datas);
    //        }
    //    });
    //})
});
//分页导航回调函数
function accessResource(n) {
    var url = "/ThresholdValueSetting/GetThresholdValueSettingList";
    $.ajax({
        url: url,//URL请求命令
        traditional: true,　//jQuery需要调用jQuery.param序列化参数，默认的话，traditional为false，即jquery会深度序列化参数对象，以适应如PHP和Ruby on Rails框架， 我们可以通过设置traditional 为true阻止深度序列化。
        type: "get",
        dataType: "html",
        contentType: "application/x-www-form-urlencoded",//默认设置， 窗体数据被编码为名称/值对
        data: {
            ContainsPointsNumber: $("#ContainsPointsNumber").val(),
            CurrentPageIndex: n
        },
        success: function (datas) {
            $("#strainThresholdValueContent").html(datas);
            $("#paginationNav").css("display", "block");
        },
        error: function (result) {
            alert(result.responseText);
        }
    });
}

function saveThresholdValue(saveSender, url) {
    if (!confirm('是否操作?')) return;
    var $saveSender = $(saveSender);
    var pointsNumberId = $saveSender.prev().prev().val();
    var pointsNumberVal = $saveSender.prev().val();
    var $textboxArray = findThresholdValuesFromTheSameLineTextBoxs($saveSender);//查询阈值所在的文本框
    var headers = getHeadersWithAntiForgeryToken();
    var isRemoveOP = $saveSender.attr('operate') === "remove";
    var params = {
        PointsNumber: pointsNumberVal,
        PointsNumberId: pointsNumberId
    };

    if (!isRemoveOP) {
        var thresholdValues = [];
        $textboxArray.each(function (i) {
            thresholdValues.push($(this).val());
        });
        params['ThresholdValues'] = thresholdValues;
    } 
    ajaxHandler(url, headers, params);
    if (isRemoveOP) {
        clearCurrentThresholdValues($saveSender);
    }
}

function findThresholdValuesFromTheSameLineTextBoxs(button) {
    return button.parent().parent().find(":text");
}

function clearCurrentThresholdValues(button) {
    button.parent().parent().find(":text").val("");
}