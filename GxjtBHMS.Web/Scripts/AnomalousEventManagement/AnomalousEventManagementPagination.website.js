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
    var beginTime = $("#datetimepickerStart").val();
    var endTime = $("#datetimepickerEnd").val();
    var url = "/AnomalousEventManagement/GetAnomalousEvents";
    $.ajax({
        url: url,//URL请求命令
        traditional: true,　//jQuery需要调用jQuery.param序列化参数，默认的话，traditional为false，即jquery会深度序列化参数对象，以适应如PHP和Ruby on Rails框架， 我们可以通过设置traditional 为true阻止深度序列化。
        type: "get",
        dataType: "html",
        contentType: "application/x-www-form-urlencoded",//默认设置， 窗体数据被编码为名称/值对
        data: {
            TestTypeId: testTypeId,
            PointsPositionId: testPointPositionId,
            StartTime: beginTime,
            EndTime: endTime,
            CurrentPageIndex: n
        },
        success: function (datas) {
            $("#AnomalousEventManagementSearchContent").html(datas);
            $("#dataQuery").css("display", "block");
            $("#message").css("display", "none");

            //$("#paginationNav").css("display", "block");
        },
        error: function (result) {
            alert(result.responseText);

        }
    });
}


