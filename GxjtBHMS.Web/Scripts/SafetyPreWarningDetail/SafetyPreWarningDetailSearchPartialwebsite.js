$(function () {
    $("#WindLoadWarningDetail").click(function () {
        var url = "/SafetyPreWarning/GetSafetyWarningDetail";
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
                testTypeId: 1
            },
            success: function (datas) {
                $("#searchContent").html(datas);
            }
        });
    })


    $("#TemperatureWarningDetail").click(function () {
        var url = "/SafetyPreWarning/GetSafetyWarningDetail";
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
                testTypeId: 2
            },
            success: function (datas) {
                $("#searchContent").html(datas);
            }
        });
    })

    $("#CableForceWarningDetail").click(function () {
        var url = "/SafetyPreWarning/GetSafetyWarningDetail";
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
                testTypeId: 3
            },
            success: function (datas) {
                $("#searchContent").html(datas);
            }
        });
    })


    $("#DisplacementWarningDetail").click(function () {
        var url = "/SafetyPreWarning/GetSafetyWarningDetail";
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
                testTypeId: 4
            },
            success: function (datas) {
                $("#searchContent").html(datas);
            }
        });
    })



});



