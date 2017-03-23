$(function () {
    $('.selectpicker').selectpicker({
        style: 'btn-info',
        size: 4
    });

    $("#mornitorTestTypeSelect").change(function () {
        var testTypeId = $(this).val();//获取测试类型下拉列表的值（1、2....等）
        var $testPointsPositionSelect = $("#monitorTestPointsPositionSelect");//h获取测点位置下拉列表元素
        $.ajax({
            url: "/ThresholdValueSetting/GetMonitoringPointsPositionsByTestTypeId?testTypeId=" + testTypeId,//URL请求命令
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
                $('.selectpicker').selectpicker('refresh');
            },
            error: function (result) {
                alert(result.responseText);
            }
        });
    });

   


    $("#bttnquery").click(function () {
        var testTypeId = $("#mornitorTestTypeSelect").val();//获取测试类型编号
        var testPointPositionId = $("#monitorTestPointsPositionSelect").val();//获取测点位置编号
        var url = "/ThresholdValueSetting/GetThresholdValueSettingListByPullDownSearchBar";
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
            },
            success: function (datas) {
                $("#searchContent").html(datas);
            }
        });
    })

})
