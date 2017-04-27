$(function () {

    $("#btnQuery").click(function () {        
        var url = "/ThresholdValueSetting/GetThresholdValueSettingList";
        $.ajax({
            url: url,//URL请求命令
            traditional: true,　//jQuery需要调用jQuery.param序列化参数，默认的话，traditional为false，即jquery会深度序列化参数对象，以适应如PHP和Ruby on Rails框架， 我们可以通过设置traditional 为true阻止深度序列化。
            type: "get",
            dataType: "html",
            contentType: "application/x-www-form-urlencoded",//默认设置， 窗体数据被编码为名称/值对
            beforeSend: function () {
                $('body').chardinJs('start')
            },
            complete: function () {
                $('body').chardinJs('stop')
            },
            data: {
                ContainsPointsNumber: $("#ContainsPointsNumber").val()
            },
            success: function (datas) {
                $("#searchContent").html(datas);
            }
        });
    })
});




function saveThresholdValue(saveSender, url) {
    if (!confirm('是否操作?')) return;
    var $saveSender = $(saveSender);
    var testTypeId = $saveSender.prev().prev().prev().val();
    var pointsNumberId = $saveSender.prev().prev().val();
    var pointsNumberVal = $saveSender.prev().val();
    var $textboxArray = findThresholdValuesFromTheSameLineTextBoxs($saveSender);//查询阈值所在的文本框
    var headers = getHeadersWithAntiForgeryToken();
    var isRemoveOP = $saveSender.attr('operate') === "remove";
    var params = {
        TestTypeId:testTypeId,
        PointsNumber: pointsNumberVal,
        PointsNumberId: pointsNumberId
    };
    var thresholdValues = [];
   
    if (!isRemoveOP) {
        $textboxArray.each(function (i) {
            thresholdValues.push($(this).val());
        });
    }
    else {
        $textboxArray.each(function (i) {
            thresholdValues.push("");
        });
    }
    params['ThresholdValues'] = thresholdValues;
    ajaxHandler(url, headers, params);
}

function findThresholdValuesFromTheSameLineTextBoxs(button) {
    return button.parent().parent().find(":text");
}

function clearCurrentThresholdValues(button) {
    button.parent().parent().find(":text").val("");   
}