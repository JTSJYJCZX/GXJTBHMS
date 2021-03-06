﻿

$(function () {
    var d = new Date();
    var t = d.getTime();
    t -= 82800000;
    d = new Date(t);
    $('#datetimepickerStart').datetimepicker(
        {
            value: d, //“-1970/01/1”中-1970表示年份，01表示月份，1表示天数，“-1970/01/1”表示今天，“-1970/01/2”表示昨天，“-1970/02/1”一个月前，“-1971/01/1”表示一年之前。“-”号表示今天的以前，“+”号表示今天以后。
            lang: 'ch',
            format: 'Y-m-d H:00',
            yearStart: 2010,//设置最小年份
            yearEnd: 2020,//设置最大年份
            todayButton: false,    //选择今天按钮
            step: 60,
            dayOfWeekStart: 0, //每周开始的时间，周日，周一等等。  
            minDate: '-1971/01/1',//最小可选时间为一年前。
            maxDate: new Date(),
        });
    var d = new Date();
    var t = d.getTime();
    t += 3600000;
    d = new Date(t);
    $('#datetimepickerEnd').datetimepicker(
        {
            value: d,
            format: 'Y-m-d H:00',
            lang: 'ch',
            yearStart: 2010,//设置最小年份
            yearEnd: 2020,//设置最大年份
            todayButton: true,    //关闭选择今天按钮
            step: 60,
            dayOfWeekStart: 0, //每周开始的时间，周日，周一等等。  
            minDate: '-1971/01/1',//最小可选时间为一年前。
            maxDate: new Date(),
        });

    //安全评估中月份模糊搜索
        $('#Monthpicker').datetimepicker(
        {
            value: 'new Date()',
            format: 'Y-m',
            lang: 'ch',
            yearStart: 2010,//设置最小年份
            yearEnd: 2020,//设置最大年份
            dayOfWeekStart: 0, //每周开始的时间，周日，周一等等。  
            timepicker: false,
        });



});

