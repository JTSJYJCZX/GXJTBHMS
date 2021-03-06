﻿$(function () {
    $("#AlarmDatasSaveAs").click(function () {
        var testPointPositionId = $("#monitorTestPointsPositionSelect").val();//获取测点位置编号
        var testPointsNumberIds = $("#monitorTestPointsNumberSelect").val();//获取测点编号，本身就是js数组
        var testTypeId = $("#mornitorTestTypeSelect").val();
        var beginTime = $("#datetimepickerStart").val();
        var endTime = $("#datetimepickerEnd").val();
        var url = "/AlarmDatasManagement/AlarmDatasDownloadSearchResult";
        var monitoringDataType = "报警数据_";
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
                MornitoringTestTypeId: testTypeId,
                MornitoringPointsPositionId: testPointPositionId,
                StartTime: beginTime,
                EndTime: endTime,
                MornitoringPointsNumberIds: testPointsNumberIds
            },
            success: function (data) {              
                document.location.href = "/AlarmDatasManagement/OriginCode?guid=" + data + "&pointsPositionId=" + testPointPositionId + "&dataType=" + monitoringDataType;
            },
            error: function (result) {
                alert(result.responseText);
            }
        });
    });
})