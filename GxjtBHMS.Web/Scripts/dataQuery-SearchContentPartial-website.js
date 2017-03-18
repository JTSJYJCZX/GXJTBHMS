$(function () {
    $("#OriginalValueSaveAs").click(function () {
        var testPointPositionId = $("#monitorTestPointsPositionSelect").val();//获取测点位置编号
        var testPointsNumberIds = $("#monitorTestPointsNumberSelect").val();//获取测点编号，本身就是js数组
        var testTypeId = $("#mornitorTestTypeSelect").val();
        var beginTime = $("#datetimepickerStart").val();
        var endTime = $("#datetimepickerEnd").val();
        var url = "/MonitoringDatas/OriginalValueDownloadSearchResult";
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
                document.location.href = "/MonitoringDatas/OriginCode?guid=" + data + "&typeId=" + testTypeId;
            },
            error: function (result) {
                alert(result.responseText);
            }
        });
    });

    $("#EigenvalueSaveAs").click(function () {
        var testPointPositionId = $("#monitorTestPointsPositionSelect").val();//获取测点位置编号
        var testPointsNumberIds = $("#monitorTestPointsNumberSelect").val();//获取测点编号，本身就是js数组
        var testTypeId = $("#mornitorTestTypeSelect").val();
        var beginTime = $("#datetimepickerStart").val();
        var endTime = $("#datetimepickerEnd").val();
        var url = "/MonitoringDatas/EigenvalueDownloadSearchResult";
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
                document.location.href = "/MonitoringDatas/OriginCode?guid=" + data;
            },
            error: function (result) {
                alert(result.responseText);
            }
        });
    });
});

function initChart() {
    var seriesColors = ["#4bb2c5", "#c5b47f", "#EAA228", "#579575", "#CE0000", "#BE77FF", "#E1E100", "#408080", "#7E3D76", "#984B4B"];
    var testTypeId = $("#mornitorTestTypeSelect").val();
    var testPointPositionId = $("#monitorTestPointsPositionSelect").val();//获取测点位置编号
    var testPointsNumberIds = $("#monitorTestPointsNumberSelect").val();//获取测点编号，本身就是js数组
    var beginTime = $("#datetimepickerStart").val();
    var endTime = $("#datetimepickerEnd").val();
    var chartDatas = ajaxDataRenderer("/MonitoringDatas/GetChartDatas", {
        MornitoringTestTypeId: testTypeId,
        MornitoringPointsPositionId: testPointPositionId,
        StartTime: beginTime,
        EndTime: endTime,
        MornitoringPointsNumberIds: testPointsNumberIds,
    });
    
    $.jqplot.config.enablePlugins = true;
    plot1 = $.jqplot('chart1', chartDatas.MaxdataArray,
    {
        title: {
            text: $("#mornitorTestTypeSelect").find("option:selected").text() + '最大值曲线图',   // 设置当前图的标题    
            show: true,//设置当前标题是否显示  
            color: '#4bb2c5',
            fontSize: '20px',
        },
        seriesColors: seriesColors,    //设置默认的分类颜色
        animate: true,          //什么作用？
        animateReplot: true,    //什么作用？
        seriesDefaults: {             //如果有多个分类，通过该配置设置各个分类的公有属性。
            show: true,               //设置是否渲染整个图表区域（即显示图表中内容）
            xaxis: 'xaxis', // either 'xaxis' or 'x2axis'.    
            yaxis: 'yaxis', // either 'yaxis' or 'y2axis'.    
            lineWidth: 2,
            showLine: true, //是否显示图表中的折线
            showMarker: true, //是否强调显示图中的数据节点 
            //renderer: $.jqplot.PieRenderer,  // 利用渲染器（这里是利用饼图PieRenderer）渲染现有图表，从而转换成所需图表 
            rendererOptions: {
                smooth: true
            },
            //markerRenderer: $.jqplot.MarkerRenderer,   //利用标记渲染器渲染现有图表。
            markerOptions: {
                show: true,             // 是否在图中显示数据点    
                style: 'filledCircle',  // 各个数据点在图中显示的方式，默认是"filledCircle"(实心圆点),    
                //其他几种方式circle，diamond, square, filledCircle,filledDiamond or filledSquare.    
                lineWidth: 0.1,       // 数据点各个的边的宽度（如果设置过大，各个边会重复，会显示的类似于实心点）    
                size: 8,            // 数据点的大小    
                color: '',    // 数据点的颜色    
                shadow: false,       // 是否为数据点显示阴影区（增加立体效果）    
            },
            isDragable: true,//是否允许拖动（如果dragable包已引入）,默认可拖动  
            dragable: {
                color: undefined,       // 当拖动数据点是，拖动线与拖动数据点颜色  
                constrainTo: 'none',    //设置拖动的的范围: 'x'（只能在横向上拖动）,  
                // 'y'（只能在纵向上拖动）, or 'none'（无限制）.  
            },
        },
        series: chartDatas.seriesParams, //如果有多个分类需要显示，这在此处设置各个分类的相关配置属性 eg.设置各个分类在分类名称框中的分类名称[label: 'Traps Division'},{label: 'Decoy Division'},{label: 'Harmony Division'}]配置参数设置同seriesDefaults    

        axesDefaults: {
            labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
            renderer: $.jqplot.LinearAxisRenderer,  // 设置横（纵）轴上数据加载的渲染器
            rendererOptions: {},   // 设置renderer的Option配置对象，线状图不需要设置
        },

        axisDefaults: {                  // 通过该配置设置各个轴的公有属性。
            labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
            show: true,  // 是否渲染轴，自动确定。
            autoscale: true,
            pad: 1.2,       // 一个相乘因子，（数据在横（纵）轴上最大值-数据在横（纵）轴上最小值）*pad值=该轴显示的横（纵）坐标区间长度该轴显示的横（纵）坐标区间长度=横（纵）坐标显示的最大值-横（纵）坐标显示的最小值，如果设置了max和min的值的话，那么会优先考虑min和max设置的值。
            numberTicks: 20,  //一个相除因子，用于设置横（纵）坐标刻度间隔横（纵）坐标刻度间隔值=横（纵）坐标区间长度/(numberTicks-1)   
            labelRenderer: $.jqplot.CanvasAxisLabelRenderer, //该渲染器主要用于将显示于刻度处的值显示于两个刻度之间，当然其表达意思也发生变化，因为刻度值处值表示某个点处的值，而它则代表某个范围内的值。该渲染器比较适合与柱状图联合使用。
            renderer: $.jqplot.LinearAxisRenderer,  // 设置横（纵）轴上数据加载的渲染器   
            renderer: $.jqplot.DateAxisRenderer, //该渲染器主要用于显示刻度为日期格式的坐标轴，它增强了javascript的本地数据处理能力，它几乎支持所有的日期格式。另外，该渲染器还提供了强大的格式化功能，它能将数据中日期字符串格式化为你需要的格式并显示在坐标轴的刻度线上。
            //showticks: true,        /// 是否显示刻度线以及坐标轴上的刻度值    
            //showtickmarks: true,    //设置是否显示刻度    
            //useseriescolor: true     //如果有多个纵（横）坐标轴，通过该属性设置这些坐标轴是否以不同颜色显示
        },
        axes: {
            xaxis: {
                label: "监测日期",       //x轴显示标题  
                pad: 0,
                renderer: $.jqplot.DateAxisRenderer, //x轴绘制方式
                labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                tickOptions: {
                    formatString: '%F %T',   // 梃置坐标轴上刻度值显示格式  
                    fontSize: '10px',    //刻度值的字体大小    
                    fontFamily: 'Tahoma', //刻度值上字体    
                    angle: 40,           //刻度值与坐标轴夹角，角度为坐标轴正向顺时针方向    
                    fontWeight: 'normal', //字体的粗细    
                    fontStretch: 1//刻度值在所在方向（坐标轴外）上的伸展(拉伸)度    
                },
                drawMajorGridlines: true   //画主网格线

            },

            yaxis: {

                label: $("#mornitorTestTypeSelect").find("option:selected").text() + chartDatas.unitParems[0], // y轴显示标题
                tickOptions: {
                    mark: 'inside',    // 设置横（纵）坐标刻度在坐标轴上显示方式，分为坐标轴内，外，穿过坐标轴显示    
                    // 值也分为：'outside', 'inside' 和 'cross',    
                    showMark: true,     //设置是否显示刻度    
                    showGridLine: true, // 是否在图表区域显示刻度值方向的网格线    
                    markSize: 4,        // 每个刻度线顶点距刻度线在坐标轴上点距离（像素为单位）,如果mark值为 'cross', 那么每个刻度线都有上顶点和下顶点，刻度线与坐标轴,在刻度线中间交叉，那么这时这个距离×2,    
                    show: true,         // 是否显示刻度线，与刻度线同方向的网格线，以及坐标轴上的刻度值    
                    showLabel: true,    // 是否显示刻度线以及坐标轴上的刻度值    
                    fontSize: '10px',    //刻度值的字体大小    
                    fontFamily: 'Tahoma', //刻度值上字体    
                    angle: 40,           //刻度值与坐标轴夹角，角度为坐标轴正向顺时针方向    
                    fontWeight: 'normal', //字体的粗细    
                    fontStretch: 1//刻度值在所在方向（坐标轴外）上的伸展(拉伸)度    
                },
                drawMajorGridlines: true   //画主网格线
            }
        },

        cursor: {
            show: true,
            zoom: true,
            showTooltip: false

        },

        highlighter: {
            show: true,
            lineWidthAdjust: 2.5,   //当鼠标移动到放大的数据点上时，设置增大的数据点的宽度         
            sizeAdjust: 7.5,
            showTooltip: true,      // 是否显示提示信息栏
            tooltipLocation: 'nw',  // 提示信息显示位置（英文方向的首写字母）: n, ne, e, se, s, sw, w, nw.    
            fadeTooltip: true,      // 设置提示信息栏出现和消失的方式（是否淡入淡出）    
            tooltipFadeSpeed: "fast",//设置提示信息栏淡入淡出的速度： slow, def, fast, 或者是一个毫秒数的值.    
            tooltipOffset: 2,       // 提示信息栏据被高亮显示的数据点的偏移位置，以像素计。    
            tooltipAxes: 'both',    // 提示信息框显示数据点那个坐标轴上的值，目前有横/纵/横纵三种方式。
            tooltipSeparator: ', ', // 提示信息栏不同值之间的间隔符号    
            useAxesFormatters: true, // 提示信息框中数据显示的格式是否和该数据在坐标轴上显示格式一致 
            tooltipFormatString: '%.5P',
        },
        legend: {
            renderer: $.jqplot.EnhancedLegendRenderer,  //渲染器,实现分类标签的功能
            show: true,//设置是否出现分类名称框（即所有分类的名称出现在图的某个位置）    
            location: 'ne',
            placement: 'outsideGrid',
            background: '',   //背景颜色
            textColor: '',//字体颜色
            rowSpacing: '3px',
            xoffset: 20,        // 分类名称框距图表区域上边框的距离（单位px）  
            yoffset: -50        // 分类名称框距图表区域左边框的距离(单位px)  
        }

    });

    plot1 = $.jqplot('chart2', chartDatas.MindataArray,
    {
        title: {
            text: $("#mornitorTestTypeSelect").find("option:selected").text() + '最小值曲线图',   // 设置当前图的标题    
            show: true,//设置当前标题是否显示  
            color: '#4bb2c5',
            fontSize: '20px',
        },
        seriesColors: seriesColors,    //设置默认的分类颜色
        animate: true,          //什么作用？
        animateReplot: true,    //什么作用？
        seriesDefaults: {             //如果有多个分类，通过该配置设置各个分类的公有属性。
            show: true,               //设置是否渲染整个图表区域（即显示图表中内容）
            xaxis: 'xaxis', // either 'xaxis' or 'x2axis'.    
            yaxis: 'yaxis', // either 'yaxis' or 'y2axis'.    
            lineWidth: 2,
            showLine: true, //是否显示图表中的折线
            showMarker: true, //是否强调显示图中的数据节点 
            //renderer: $.jqplot.PieRenderer,  // 利用渲染器（这里是利用饼图PieRenderer）渲染现有图表，从而转换成所需图表 
            rendererOptions: {
                smooth: true
            },
            //markerRenderer: $.jqplot.MarkerRenderer,   //利用标记渲染器渲染现有图表。
            markerOptions: {
                show: true,             // 是否在图中显示数据点    
                style: 'filledCircle',  // 各个数据点在图中显示的方式，默认是"filledCircle"(实心圆点),    
                //其他几种方式circle，diamond, square, filledCircle,filledDiamond or filledSquare.    
                lineWidth: 0.1,       // 数据点各个的边的宽度（如果设置过大，各个边会重复，会显示的类似于实心点）    
                size: 8,            // 数据点的大小    
                color: '',    // 数据点的颜色    
                shadow: false,       // 是否为数据点显示阴影区（增加立体效果）    
            },
            isDragable: true,//是否允许拖动（如果dragable包已引入）,默认可拖动  
            dragable: {
                color: undefined,       // 当拖动数据点是，拖动线与拖动数据点颜色  
                constrainTo: 'none',    //设置拖动的的范围: 'x'（只能在横向上拖动）,  
                // 'y'（只能在纵向上拖动）, or 'none'（无限制）.  
            },
        },
        series: chartDatas.seriesParams, //如果有多个分类需要显示，这在此处设置各个分类的相关配置属性 eg.设置各个分类在分类名称框中的分类名称[label: 'Traps Division'},{label: 'Decoy Division'},{label: 'Harmony Division'}]配置参数设置同seriesDefaults    

        axesDefaults: {
            labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
            renderer: $.jqplot.LinearAxisRenderer,  // 设置横（纵）轴上数据加载的渲染器
            rendererOptions: {},   // 设置renderer的Option配置对象，线状图不需要设置
        },
        axisDefaults: {                  // 通过该配置设置各个轴的公有属性。
            labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
            show: true,  // 是否渲染轴，自动确定。
            autoscale: true,
            pad: 1.2,       // 一个相乘因子，（数据在横（纵）轴上最大值-数据在横（纵）轴上最小值）*pad值=该轴显示的横（纵）坐标区间长度该轴显示的横（纵）坐标区间长度=横（纵）坐标显示的最大值-横（纵）坐标显示的最小值，如果设置了max和min的值的话，那么会优先考虑min和max设置的值。
            numberTicks: 20,  //一个相除因子，用于设置横（纵）坐标刻度间隔横（纵）坐标刻度间隔值=横（纵）坐标区间长度/(numberTicks-1)   
            labelRenderer: $.jqplot.CanvasAxisLabelRenderer, //该渲染器主要用于将显示于刻度处的值显示于两个刻度之间，当然其表达意思也发生变化，因为刻度值处值表示某个点处的值，而它则代表某个范围内的值。该渲染器比较适合与柱状图联合使用。
            renderer: $.jqplot.LinearAxisRenderer,  // 设置横（纵）轴上数据加载的渲染器   
            renderer: $.jqplot.DateAxisRenderer, //该渲染器主要用于显示刻度为日期格式的坐标轴，它增强了javascript的本地数据处理能力，它几乎支持所有的日期格式。另外，该渲染器还提供了强大的格式化功能，它能将数据中日期字符串格式化为你需要的格式并显示在坐标轴的刻度线上。
            //showticks: true,        /// 是否显示刻度线以及坐标轴上的刻度值    
            //showtickmarks: true,    //设置是否显示刻度    
            //useseriescolor: true     //如果有多个纵（横）坐标轴，通过该属性设置这些坐标轴是否以不同颜色显示
        },
        axes: {
            xaxis: {
                label: "监测日期",       //x轴显示标题  
                pad: 0,
                renderer: $.jqplot.DateAxisRenderer, //x轴绘制方式
                labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                tickOptions: {
                    formatString: '%F %T',   // 梃置坐标轴上刻度值显示格式  
                    fontSize: '10px',    //刻度值的字体大小    
                    fontFamily: 'Tahoma', //刻度值上字体    
                    angle: 40,           //刻度值与坐标轴夹角，角度为坐标轴正向顺时针方向    
                    fontWeight: 'normal', //字体的粗细    
                    fontStretch: 1//刻度值在所在方向（坐标轴外）上的伸展(拉伸)度    
                },
                drawMajorGridlines: true   //画主网格线

            },

            yaxis: {

                label: $("#mornitorTestTypeSelect").find("option:selected").text() + chartDatas.unitParems[0], // y轴显示标题
                tickOptions: {
                    mark: 'inside',    // 设置横（纵）坐标刻度在坐标轴上显示方式，分为坐标轴内，外，穿过坐标轴显示    
                    // 值也分为：'outside', 'inside' 和 'cross',    
                    showMark: true,     //设置是否显示刻度    
                    showGridLine: true, // 是否在图表区域显示刻度值方向的网格线    
                    markSize: 4,        // 每个刻度线顶点距刻度线在坐标轴上点距离（像素为单位）,如果mark值为 'cross', 那么每个刻度线都有上顶点和下顶点，刻度线与坐标轴,在刻度线中间交叉，那么这时这个距离×2,    
                    show: true,         // 是否显示刻度线，与刻度线同方向的网格线，以及坐标轴上的刻度值    
                    showLabel: true,    // 是否显示刻度线以及坐标轴上的刻度值    
                    fontSize: '10px',    //刻度值的字体大小    
                    fontFamily: 'Tahoma', //刻度值上字体    
                    angle: 40,           //刻度值与坐标轴夹角，角度为坐标轴正向顺时针方向    
                    fontWeight: 'normal', //字体的粗细    
                    fontStretch: 1//刻度值在所在方向（坐标轴外）上的伸展(拉伸)度    
                },
                drawMajorGridlines: true   //画主网格线
            }
        },

        cursor: {
            show: true,
            zoom: true,
            showTooltip: false

        },

        highlighter: {
            show: true,
            lineWidthAdjust: 2.5,   //当鼠标移动到放大的数据点上时，设置增大的数据点的宽度         
            sizeAdjust: 7.5,
            showTooltip: true,      // 是否显示提示信息栏
            tooltipLocation: 'nw',  // 提示信息显示位置（英文方向的首写字母）: n, ne, e, se, s, sw, w, nw.    
            fadeTooltip: true,      // 设置提示信息栏出现和消失的方式（是否淡入淡出）    
            tooltipFadeSpeed: "fast",//设置提示信息栏淡入淡出的速度： slow, def, fast, 或者是一个毫秒数的值.    
            tooltipOffset: 2,       // 提示信息栏据被高亮显示的数据点的偏移位置，以像素计。    
            tooltipAxes: 'both',    // 提示信息框显示数据点那个坐标轴上的值，目前有横/纵/横纵三种方式。
            tooltipSeparator: ', ', // 提示信息栏不同值之间的间隔符号    
            useAxesFormatters: true, // 提示信息框中数据显示的格式是否和该数据在坐标轴上显示格式一致 
            tooltipFormatString: '%.5P',
        },
        legend: {
            renderer: $.jqplot.EnhancedLegendRenderer,  //渲染器,实现分类标签的功能
            show: true,//设置是否出现分类名称框（即所有分类的名称出现在图的某个位置）    
            location: 'ne',
            placement: 'outsideGrid',
            background: '',   //背景颜色
            textColor: '',//字体颜色
            rowSpacing: '3px',
            xoffset: 20,        // 分类名称框距图表区域上边框的距离（单位px）  
            yoffset: -50        // 分类名称框距图表区域左边框的距离(单位px)  
        }

    });

    plot1 = $.jqplot('chart3', chartDatas.AveragedataArray,
{
    title: {
        text: $("#mornitorTestTypeSelect").find("option:selected").text() + '平均值曲线图',   // 设置当前图的标题    
        show: true,//设置当前标题是否显示  
        color: '#4bb2c5',
        fontSize: '20px',
    },
    seriesColors: seriesColors,    //设置默认的分类颜色
    animate: true,          //什么作用？
    animateReplot: true,    //什么作用？
    seriesDefaults: {             //如果有多个分类，通过该配置设置各个分类的公有属性。
        show: true,               //设置是否渲染整个图表区域（即显示图表中内容）
        xaxis: 'xaxis', // either 'xaxis' or 'x2axis'.    
        yaxis: 'yaxis', // either 'yaxis' or 'y2axis'.    
        lineWidth: 2,
        showLine: true, //是否显示图表中的折线
        showMarker: true, //是否强调显示图中的数据节点 
        //renderer: $.jqplot.PieRenderer,  // 利用渲染器（这里是利用饼图PieRenderer）渲染现有图表，从而转换成所需图表 
        rendererOptions: {
            smooth: true
        },
        //markerRenderer: $.jqplot.MarkerRenderer,   //利用标记渲染器渲染现有图表。
        markerOptions: {
            show: true,             // 是否在图中显示数据点    
            style: 'filledCircle',  // 各个数据点在图中显示的方式，默认是"filledCircle"(实心圆点),    
            //其他几种方式circle，diamond, square, filledCircle,filledDiamond or filledSquare.    
            lineWidth: 0.1,       // 数据点各个的边的宽度（如果设置过大，各个边会重复，会显示的类似于实心点）    
            size: 8,            // 数据点的大小    
            color: '',    // 数据点的颜色    
            shadow: false,       // 是否为数据点显示阴影区（增加立体效果）    
        },
        isDragable: true,//是否允许拖动（如果dragable包已引入）,默认可拖动  
        dragable: {
            color: undefined,       // 当拖动数据点是，拖动线与拖动数据点颜色  
            constrainTo: 'none',    //设置拖动的的范围: 'x'（只能在横向上拖动）,  
            // 'y'（只能在纵向上拖动）, or 'none'（无限制）.  
        },
    },
    series: chartDatas.seriesParams, //如果有多个分类需要显示，这在此处设置各个分类的相关配置属性 eg.设置各个分类在分类名称框中的分类名称[label: 'Traps Division'},{label: 'Decoy Division'},{label: 'Harmony Division'}]配置参数设置同seriesDefaults    

    axesDefaults: {
        labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
        renderer: $.jqplot.LinearAxisRenderer,  // 设置横（纵）轴上数据加载的渲染器
        rendererOptions: {},   // 设置renderer的Option配置对象，线状图不需要设置
    },
    axisDefaults: {                  // 通过该配置设置各个轴的公有属性。
        labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
        show: true,  // 是否渲染轴，自动确定。
        autoscale: true,
        pad: 1.2,       // 一个相乘因子，（数据在横（纵）轴上最大值-数据在横（纵）轴上最小值）*pad值=该轴显示的横（纵）坐标区间长度该轴显示的横（纵）坐标区间长度=横（纵）坐标显示的最大值-横（纵）坐标显示的最小值，如果设置了max和min的值的话，那么会优先考虑min和max设置的值。
        numberTicks: 20,  //一个相除因子，用于设置横（纵）坐标刻度间隔横（纵）坐标刻度间隔值=横（纵）坐标区间长度/(numberTicks-1)   
        labelRenderer: $.jqplot.CanvasAxisLabelRenderer, //该渲染器主要用于将显示于刻度处的值显示于两个刻度之间，当然其表达意思也发生变化，因为刻度值处值表示某个点处的值，而它则代表某个范围内的值。该渲染器比较适合与柱状图联合使用。
        renderer: $.jqplot.LinearAxisRenderer,  // 设置横（纵）轴上数据加载的渲染器   
        renderer: $.jqplot.DateAxisRenderer, //该渲染器主要用于显示刻度为日期格式的坐标轴，它增强了javascript的本地数据处理能力，它几乎支持所有的日期格式。另外，该渲染器还提供了强大的格式化功能，它能将数据中日期字符串格式化为你需要的格式并显示在坐标轴的刻度线上。
        //showticks: true,        /// 是否显示刻度线以及坐标轴上的刻度值    
        //showtickmarks: true,    //设置是否显示刻度    
        //useseriescolor: true     //如果有多个纵（横）坐标轴，通过该属性设置这些坐标轴是否以不同颜色显示
    },
    axes: {
        xaxis: {
            label: "监测日期",       //x轴显示标题  
            pad: 0,
            renderer: $.jqplot.DateAxisRenderer, //x轴绘制方式
            labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
            tickRenderer: $.jqplot.CanvasAxisTickRenderer,
            tickOptions: {
                formatString: '%F %T',   // 梃置坐标轴上刻度值显示格式  
                fontSize: '10px',    //刻度值的字体大小    
                fontFamily: 'Tahoma', //刻度值上字体    
                angle: 40,           //刻度值与坐标轴夹角，角度为坐标轴正向顺时针方向    
                fontWeight: 'normal', //字体的粗细    
                fontStretch: 1//刻度值在所在方向（坐标轴外）上的伸展(拉伸)度    
            },
            drawMajorGridlines: true   //画主网格线

        },

        yaxis: {

            label: $("#mornitorTestTypeSelect").find("option:selected").text() + chartDatas.unitParems[0], // y轴显示标题
            tickOptions: {
                mark: 'inside',    // 设置横（纵）坐标刻度在坐标轴上显示方式，分为坐标轴内，外，穿过坐标轴显示    
                // 值也分为：'outside', 'inside' 和 'cross',    
                showMark: true,     //设置是否显示刻度    
                showGridLine: true, // 是否在图表区域显示刻度值方向的网格线    
                markSize: 4,        // 每个刻度线顶点距刻度线在坐标轴上点距离（像素为单位）,如果mark值为 'cross', 那么每个刻度线都有上顶点和下顶点，刻度线与坐标轴,在刻度线中间交叉，那么这时这个距离×2,    
                show: true,         // 是否显示刻度线，与刻度线同方向的网格线，以及坐标轴上的刻度值    
                showLabel: true,    // 是否显示刻度线以及坐标轴上的刻度值    
                fontSize: '10px',    //刻度值的字体大小    
                fontFamily: 'Tahoma', //刻度值上字体    
                angle: 40,           //刻度值与坐标轴夹角，角度为坐标轴正向顺时针方向    
                fontWeight: 'normal', //字体的粗细    
                fontStretch: 1//刻度值在所在方向（坐标轴外）上的伸展(拉伸)度    
            },
            drawMajorGridlines: true   //画主网格线
        }
    },

    cursor: {
        show: true,
        zoom: true,
        showTooltip: false

    },

    highlighter: {
        show: true,
        lineWidthAdjust: 2.5,   //当鼠标移动到放大的数据点上时，设置增大的数据点的宽度         
        sizeAdjust: 7.5,
        showTooltip: true,      // 是否显示提示信息栏
        tooltipLocation: 'nw',  // 提示信息显示位置（英文方向的首写字母）: n, ne, e, se, s, sw, w, nw.    
        fadeTooltip: true,      // 设置提示信息栏出现和消失的方式（是否淡入淡出）    
        tooltipFadeSpeed: "fast",//设置提示信息栏淡入淡出的速度： slow, def, fast, 或者是一个毫秒数的值.    
        tooltipOffset: 2,       // 提示信息栏据被高亮显示的数据点的偏移位置，以像素计。    
        tooltipAxes: 'both',    // 提示信息框显示数据点那个坐标轴上的值，目前有横/纵/横纵三种方式。
        tooltipSeparator: ', ', // 提示信息栏不同值之间的间隔符号    
        useAxesFormatters: true, // 提示信息框中数据显示的格式是否和该数据在坐标轴上显示格式一致 
        tooltipFormatString: '%.5P',
    },
    legend: {
        renderer: $.jqplot.EnhancedLegendRenderer,  //渲染器,实现分类标签的功能
        show: true,//设置是否出现分类名称框（即所有分类的名称出现在图的某个位置）    
        location: 'ne',
        placement: 'outsideGrid',
        background: '',   //背景颜色
        textColor: '',//字体颜色
        rowSpacing: '3px',
        xoffset: 20,        // 分类名称框距图表区域上边框的距离（单位px）  
        yoffset: -50        // 分类名称框距图表区域左边框的距离(单位px)  
    }

});



    //能让分类隐藏和显示选中的折线
    var seriesShow = new Array(chartDatas.seriesParams.length);
    $.each(seriesShow, function (i, data) {
        seriesShow[i] = true;
    });
    $('#chart1').bind('jqplotClick', function (ev, gridpos, datapos, neighbor, plot) {
        var seriesIndex = neighbor.seriesIndex;
        if (seriesShow[seriesIndex]) {
            plot.drawSeries({
                showLine: false,
            }, seriesIndex);
            seriesShow[seriesIndex] = false;
        }
        else {
            plot.drawSeries({
                showLine: true,
            }, seriesIndex);
            seriesShow[seriesIndex] = true;
        }
    });


    //能让分类隐藏和显示选中的折线
    var seriesShow = new Array(chartDatas.seriesParams.length);
    $.each(seriesShow, function (i, data) {
        seriesShow[i] = true;
    });
    $('#chart2').bind('jqplotClick', function (ev, gridpos, datapos, neighbor, plot) {
        var seriesIndex = neighbor.seriesIndex;
        if (seriesShow[seriesIndex]) {
            plot.drawSeries({
                showLine: false,
            }, seriesIndex);
            seriesShow[seriesIndex] = false;
        }
        else {
            plot.drawSeries({
                showLine: true,
            }, seriesIndex);
            seriesShow[seriesIndex] = true;
        }
    });


    //能让分类隐藏和显示选中的折线
    var seriesShow = new Array(chartDatas.seriesParams.length);
    $.each(seriesShow, function (i, data) {
        seriesShow[i] = true;
    });
    $('#chart3').bind('jqplotClick', function (ev, gridpos, datapos, neighbor, plot) {
        var seriesIndex = neighbor.seriesIndex;
        if (seriesShow[seriesIndex]) {
            plot.drawSeries({
                showLine: false,
            }, seriesIndex);
            seriesShow[seriesIndex] = false;
        }
        else {
            plot.drawSeries({
                showLine: true,
            }, seriesIndex);
            seriesShow[seriesIndex] = true;
        }
    });

}

function ajaxDataRenderer(url, params) {
    var ret;
    $.ajax({
        async: false,
        traditional: true,　//jQuery需要调用jQuery.param序列化参数，默认的话，traditional为false，即jquery会深度序列化参数对象，以适应如PHP和Ruby on Rails框架， 我们可以通过设置traditional 为true阻止深度序列化。
        url: url,
        dataType: 'json',
        data: params,
        success: function (datas) {
            ret = dealWithChartDatas(datas);
        }
    });
    return ret;
}

function dealWithChartDatas(source) {
    var result = new Object();
    var MaxdataArray = []; MindataArray = []; AveragedataArray = [];seriesParams = [], unitParams=[];
    MaxdataArray = fillChartMaxDataArray(source);
    MindataArray = fillChartMinDataArray(source);
    AveragedataArray = fillChartAverageDataArray(source);
    seriesParams = fillChartSeriesParams(source);
    unitParams = fillChartUnitParams(source);
    result.MaxdataArray = MaxdataArray;
    result.MindataArray = MindataArray;
    result.AveragedataArray = AveragedataArray;
    result.seriesParams = seriesParams;
    result.unitParems = unitParams;
    return result;
}

function fillChartUnitParams(source) {
    var unitParams = [];
    $.each(source, function (i, item) {
        unitParams.push([item.Unit]);
        });
    return unitParams;
}

function fillChartMaxDataArray(source) {
    var MaxdataArray = [];
    $.each(source, function (i, item) {
        var itemMaxArray = [];
        $.each(item.Models, function (j, myitem) {
            itemMaxArray.push([myitem.CreateDateTime, myitem.MaxValue ]);
        });
        MaxdataArray.push(itemMaxArray);
    });
    return MaxdataArray;
}

function fillChartMinDataArray(source) {
    var MindataArray = [];
    $.each(source, function (i, item) {
        var itemMinArray = [];
        $.each(item.Models, function (j, myitem) {
            itemMinArray.push([myitem.CreateDateTime, myitem.MinValue]);
        });
        MindataArray.push(itemMinArray);
    });
    return MindataArray;
}

function fillChartAverageDataArray(source) {
    var AveragedataArray = [];
    $.each(source, function (i, item) {
        var itemAverageArray = [];
        $.each(item.Models, function (j, myitem) {
            itemAverageArray.push([myitem.CreateDateTime, myitem.AverageValue]);
        });
        AveragedataArray.push(itemAverageArray);
    });
    return AveragedataArray;
}


function fillChartSeriesParams(source) {
    var seriesParams = [];
    $.each(source, function (i, item) {
        var obj =
                  {
                      label: item.CategoryName,
                      lineWidth: 3,
                      markerOptions:
                          {
                              formatString: '%.2f',
                              fontSize: '10pt'
                          }
                  };
        seriesParams.push(obj);
    });
    return seriesParams;
}
