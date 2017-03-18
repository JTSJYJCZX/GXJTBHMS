$(function () {
    $('.selectpicker').selectpicker({
        style: 'btn-info',
        size: 4
    });

    $("#mornitorTestTypeSelectFirst").change(function () {
        var testTypeId = $(this).val();//获取测试类型下拉列表的值（1、2....等）
        var $testPointsPositionSelect = $("#monitorTestPointsPositionSelectFirst");//h获取测点位置下拉列表元素
        $.ajax({
            url: "/MonitoringDatasComparingQuery/GetMonitoringPointsPositionsByTestTypeId?testTypeId=" + testTypeId,//URL请求命令
            type: "get",
            dataType: "json",
            contentType: "application/json",
            success: function (datas) {
                var tmpOptionsHTML = "";
                $testPointsPositionSelect.html("");//清空测点位置下拉项
                $.each(datas, function (i, data) {
                    tmpOptionsHTML += "<option value=" + data.Value + ">" + data.Text + "</option>";
                });
                $testPointsPositionSelect.append(tmpOptionsHTML);
                monitorTestPointsPositionSelectFirstChange();
            },
            error: function (result) {
                alert(result.responseText);
            }
        });
    });

    $("#monitorTestPointsPositionSelectFirst").change(function () {
        monitorTestPointsPositionSelectFirstChange();
    });

    function monitorTestPointsPositionSelectFirstChange() {
        var pointsPosition = $("#monitorTestPointsPositionSelectFirst").val();//获取测点位置下拉列表的值（1、2....等）
        var $testPointsNumberSelect = $("#monitorTestPointsNumberSelectFirst");//获取测点编号下拉列表元素
        $.ajax({
            url: "/MonitoringDatasComparingQuery/GetMonitoringPointsNumbersByPointsPositions?pointsPositions=" + pointsPosition,//URL请求命令
            type: "get",
            dataType: "json",
            contentType: "application/json",
            success: function (datas) {
                var tmpOptionsHTML = "";
                $testPointsNumberSelect.html("");//清空测点编号下拉项
                $.each(datas, function (i, data) {
                    tmpOptionsHTML += "<option value=" + data.Value + ">" + data.Text + "</option>";
                });
                $testPointsNumberSelect.append(tmpOptionsHTML);
                $('.selectpicker').selectpicker('refresh');
            },
            error: function (result) {
                alert(result.responseText);
            }
        });
    }

    $("#mornitorTestTypeSelectSecond").change(function () {
        var testTypeId = $(this).val();//获取测试类型下拉列表的值（1、2....等）
        var $testPointsPositionSelect = $("#monitorTestPointsPositionSelectSecond");//h获取测点位置下拉列表元素
        $.ajax({
            url: "/MonitoringDatasComparingQuery/GetMonitoringPointsPositionsByTestTypeId?testTypeId=" + testTypeId,//URL请求命令
            type: "get",
            dataType: "json",
            contentType: "application/json",
            success: function (datas) {
                var tmpOptionsHTML = "";
                $testPointsPositionSelect.html("");//清空测点位置下拉项
                $.each(datas, function (i, data) {
                    tmpOptionsHTML += "<option value=" + data.Value + ">" + data.Text + "</option>";
                });
                $testPointsPositionSelect.append(tmpOptionsHTML);
                monitorTestPointsPositionSelectSecondChange();
            },
            error: function (result) {
                alert(result.responseText);
            }
        });
    });

    $("#monitorTestPointsPositionSelectSecond").change(function () {
        monitorTestPointsPositionSelectSecondChange();
    });

    function monitorTestPointsPositionSelectSecondChange() {
        var pointsPosition = $("#monitorTestPointsPositionSelectSecond").val();//获取测点位置下拉列表的值（1、2....等）
        var $testPointsNumberSelect = $("#monitorTestPointsNumberSelectSecond");//获取测点编号下拉列表元素
        $.ajax({
            url: "/MonitoringDatasComparingQuery/GetMonitoringPointsNumbersByPointsPositions?pointsPositions=" + pointsPosition,//URL请求命令
            type: "get",
            dataType: "json",
            contentType: "application/json",
            success: function (datas) {
                var tmpOptionsHTML = "";
                $testPointsNumberSelect.html("");//清空测点编号下拉项
                $.each(datas, function (i, data) {
                    tmpOptionsHTML += "<option value=" + data.Value + ">" + data.Text + "</option>";
                });
                $testPointsNumberSelect.append(tmpOptionsHTML);
                $('.selectpicker').selectpicker('refresh');
            },
            error: function (result) {
                alert(result.responseText);
            }
        });
    }

    $("#bttnquery").click(function () {
        var url = "/MonitoringDatasComparingQuery/ComparingQuery";
        $.ajax({
            url: url,//URL请求命令
            traditional: true,　//jQuery需要调用jQuery.param序列化参数，默认的话，traditional为false，即jquery会深度序列化参数对象，以适应如PHP和Ruby on Rails框架， 我们可以通过设置traditional 为true阻止深度序列化。
            type: "get",
            data: { },
            success: function (datas) {                
                $("#searchContent").html(datas);
            }
        });
    })
})
