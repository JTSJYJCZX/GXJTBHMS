$(function () {
    //初始化分页导航条
    var totalPages = parseInt($("input[name='TotalPages']").val());
    initPaginator('#paginationNav', totalPages, 1);
    $("#paginationNav").css("display", "none");
});
//分页导航回调函数
function accessResource(n) {
    var testTypeId = $("#mornitorTestTypeSelect").val();
    var testPointPositionId = $("#monitorTestPointsPositionSelect").val();//获取测点位置编号
    var testPointsNumberIds = $("#monitorTestPointsNumberSelect").val();//获取测点编号，本身就是js数组
    var beginTime = $("#datetimepickerStart").val();
    var endTime = $("#datetimepickerEnd").val();
    var url = "/AlarmDatasManagement/GetAlarmDatas";
    $.ajax({
        url: url,//URL请求命令
        traditional: true,　//jQuery需要调用jQuery.param序列化参数，默认的话，traditional为false，即jquery会深度序列化参数对象，以适应如PHP和Ruby on Rails框架， 我们可以通过设置traditional 为true阻止深度序列化。
        type: "get",
        dataType: "html",
        contentType: "application/x-www-form-urlencoded",//默认设置， 窗体数据被编码为名称/值对
        data: {
            MornitoringTestTypeId: testTypeId,
            MornitoringPointsPositionId: testPointPositionId,
            StartTime: beginTime,
            EndTime: endTime,
            MornitoringPointsNumberIds: testPointsNumberIds,
            CurrentPageIndex: n
        },
        success: function (datas) {
            $("#AlarmDatasTable").html(datas);
            $("#paginationNav").css("display", "block");
        },
        error: function (result) {
            alert(result.responseText);
        }
    });
}





var isLoadDataList = false;//是否加载数据列表
var isLoadStatisticResult = false;//是否加载数据统计列表
$(function () {
    $('.selectpicker').selectpicker({
        style: 'btn-info',
        size: 4
    });

    $("#mornitorTestTypeSelect").change(function () {
        var testTypeId = $(this).val();//获取测试类型下拉列表的值（1、2....等）
        var $testPointsPositionSelect = $("#monitorTestPointsPositionSelect");//h获取测点位置下拉列表元素
        $.ajax({
            url: "/AlarmDatasManagement/GetMonitoringPointsPositionsByTestTypeId?testTypeId=" + testTypeId,//URL请求命令
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
                monitorTestPointsPositionSelectChange();
            },
            error: function (result) {
                alert(result.responseText);
            }
        });
    });

    $("#monitorTestPointsPositionSelect").change(function () {
        monitorTestPointsPositionSelectChange();
    });

    function monitorTestPointsPositionSelectChange() {
        var pointsPosition = $("#monitorTestPointsPositionSelect").val();//获取测点位置下拉列表的值（1、2....等）
        var $testPointsNumberSelect = $("#monitorTestPointsNumberSelect");//获取测点编号下拉列表元素
        $.ajax({
            url: "/AlarmDatasManagement/GetMonitoringPointsNumbersByPointsPositions?pointsPositions=" + pointsPosition,//URL请求命令
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

    $("#bttnAlarmDatasQuery").click(function () {
        var testTypeId = $("#mornitorTestTypeSelect").val();//获取测试类型编号
        var testPointPositionId = $("#monitorTestPointsPositionSelect").val();//获取测点位置编号
        var testPointsNumberIds = $("#monitorTestPointsNumberSelect").val();//获取测点编号，本身就是js数组
        var beginTime = $("#datetimepickerStart").val();
        var endTime = $("#datetimepickerEnd").val();
        var url = "/AlarmDatasManagement/AlarmDatasQuery";
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
                MornitoringTestTypeId: testTypeId,
                MornitoringPointsPositionId: testPointPositionId,
                StartTime: beginTime,
                EndTime: endTime,
                MornitoringPointsNumberIds: testPointsNumberIds,
            },
            success: function (datas) {
                
                resetLoadDataFlags();
                $("#alarmDatasSearchContent").html(datas);
                //$("#paginationNav").css("display", "none");
           
            }
        });
    })  

    function resetLoadDataFlags() {
        isLoadDataList = false;
        isLoadStatisticResult = false;
    }
})

function getTable() {
    var testTypeId = $("#mornitorTestTypeSelect").val();
    var testPointPositionId = $("#monitorTestPointsPositionSelect").val();//获取测点位置编号
    var testPointsNumberIds = $("#monitorTestPointsNumberSelect").val();//获取测点编号，本身就是js数组
    var beginTime = $("#datetimepickerStart").val();
    var endTime = $("#datetimepickerEnd").val();
    var url = "/AlarmDatasManagement/GetAlarmDatas";
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
            MornitoringTestTypeId: testTypeId,
            MornitoringPointsPositionId: testPointPositionId,
            MornitoringPointsNumberIds: testPointsNumberIds,
            StartTime: beginTime,
            EndTime: endTime
        },
        success: function (datas) {
            $("#AlarmDatasTable").html(datas);
            $("#paginationNav").css("display", "block");
        }
    });
}