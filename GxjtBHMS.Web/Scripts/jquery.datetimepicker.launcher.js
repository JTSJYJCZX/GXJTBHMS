

$(function () {

    $('#datetimepickerStart').datetimepicker(
        {
            value: '-1970/01/2', //“-1970/01/1”中-1970表示年份，01表示月份，1表示天数，“-1970/01/1”表示今天，“-1970/01/2”表示昨天，“-1970/02/1”一个月前，“-1971/01/1”表示一年之前。“-”号表示今天的以前，“+”号表示今天以后。
            lang: 'ch',
            format: 'Y-m-d H:i:s',
            yearStart: 2010,//设置最小年份
            yearEnd: 2020,//设置最大年份
            todayButton: false,    //选择今天按钮
            step: 60,
            dayOfWeekStart: 0, //每周开始的时间，周日，周一等等。  
            minDate: '-1971/01/1',//最小可选时间为一年前。
            maxDate: new Date(),
        });

    $('#datetimepickerEnd').datetimepicker(
        {
            value: 'new Date()',
            format: 'Y-m-d H:i:s',
            lang: 'ch',
            yearStart: 2010,//设置最小年份
            yearEnd: 2020,//设置最大年份
            todayButton: true,    //关闭选择今天按钮
            step: 60,
            dayOfWeekStart: 0, //每周开始的时间，周日，周一等等。  
            minDate: '-1971/01/1',//最小可选时间为一年前。
            maxDate: new Date(),
        });
});

