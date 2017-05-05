$(function () {
    //初始化分页导航条
    var totalPages = parseInt($("input[name='TotalPages']").val());
    initPaginator('#paginationNav', totalPages, 1);
    $("#paginationNav").css("display", "none");
});
//分页导航回调函数
function accessResource(n) {
    var url = "/AnomalousEventManagement/GetAllAnomalousEvents";
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
            $("#AnomalousEventManagementSearchContent").html(datas);
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
    $("#allBtnquery").click(function () {
        var url = "/AnomalousEventManagement/GetAllAnomalousEvents";
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
            },
            success: function (datas) {
                
                resetLoadDataFlags();
                $("#AnomalousEventManagementSearchContent").html(datas);
                //$("#paginationNav").css("display", "none");
           
            }
        });
    })  

    function resetLoadDataFlags() {
        isLoadDataList = false;
        isLoadStatisticResult = false;
    }
})

