
function initChart() {
    var seriesColors = ["#4bb2c5", "#c5b47f", "#EAA228", "#579575", "#CE0000", "#BE77FF", "#E1E100", "#408080", "#7E3D76", "#984B4B"];
    var testTypeIdFirst = $("#mornitorTestTypeSelectFirst").val();//获取测试类型编号
    var testPointPositionIdFirst = $("#monitorTestPointsPositionSelectFirst").val();//获取测点位置编号
    var testPointsNumberIdsFirst = $("#monitorTestPointsNumberSelectFirst").val();//获取测点编号，本身就是js数组
    var testTypeIdSecond = $("#mornitorTestTypeSelectSecond").val();//获取测试类型编号
    var testPointPositionIdSecond = $("#monitorTestPointsPositionSelectSecond").val();//获取测点位置编号
    var testPointsNumberIdsSecond = $("#monitorTestPointsNumberSelectSecond").val();//获取测点编号，本身就是js数组
    var beginTime = $("#datetimepickerStart").val();
    var endTime = $("#datetimepickerEnd").val();
    var chartDatas = ajaxDataRenderer("/MonitoringDatasComparingQuery/GetChartDatasComparing", {
        MornitoringTestTypeId: testTypeIdFirst,
        MornitoringPointsPositionId: testPointPositionIdFirst,
        MornitoringPointsNumberIds: testPointsNumberIdsFirst,
        MornitoringTestTypeIdSecond: testTypeIdSecond,
        MornitoringPointsPositionIdSecond: testPointPositionIdSecond,
        MornitoringPointsNumberIdsSecond: testPointsNumberIdsSecond,
        StartTime: beginTime,
        EndTime: endTime,
    });
    var chartDatas1 = dealWithChartDatas(chartDatas.c1);  
    var chartDatas2 = dealWithChartDatas(chartDatas.c2);
    var datas = wrapChartDatas(chartDatas1, chartDatas2);
    $.jqplot.config.enablePlugins = true;
    plot1 = $.jqplot('chart1', datas.MaxValueArray,
    {
        title: {
            text: $("#mornitorTestTypeSelectFirst").find("option:selected").text() + '与' + $("#mornitorTestTypeSelectSecond").find("option:selected").text() + '最大值对比曲线图',
            textAlign: 'center',
            show: true,//设置当前标题是否显示  
            color: '#4bb2c5',
            fontSize: '20px',
        },
        animate: true,
        animateReplot: true,
        cursor: {
            style: 'crosshair',
            show: true,
            zoom: true,
            showTooltip: false,
            tooltipFormatString: '%.4P',
            useAxesFormatters: false,
        },
        seriesDefaults: {
            show: true,
            lineWidth: 1,
            pointLabels: {
                show: false,
                formatString: "%.0f",
                location: "s",
                ypadding: 1,
            },
            markerOptions: {
                show: false,
                lineWidth: 1,
                size: 12
            },
            rendererOptions: {
                smooth: true
            }
        },
        series: [
             {
                 label: chartDatas1.seriesParams,
                 lineWidth: 3,
                 yaxis: 'yaxis',
                 markerOptions:
                 {
                     formatString: '%.2f',
                     fontSize: '10pt'
                 }
             },
             {
                 label: chartDatas2.seriesParams,
                 lineWidth: 3,
                 yaxis: 'y2axis',
                 markerOptions:
                 {
                     formatString: '%.2f',
                     fontSize: '10pt'
                 }
             },
        ],
        axes: {
            xaxis: {
                label: "监测日期",  //x轴显示标题
                pad: 0,
                renderer: $.jqplot.DateAxisRenderer, //x轴绘制方式
                labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                tickOptions: {
                    formatString: '%F %T', fontSize: '10pt', angle: -20
                },
                showTicks: true,
                rendererOptions: { drawBaseline: false },
                drawMajorGridlines: false
            },
            yaxis: {
                show: true,
                label: $("#mornitorTestTypeSelectFirst").find("option:selected").text() + chartDatas1.unitParams[0], // y轴显示标题
                labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                renderer: $.jqplot.LinearAxisRenderer,  // 设置横（纵）轴上数据加载的渲染器
                autoscale: true,
                max: null,
                min: null,
                //tickInterval: 10,     //网格线间隔大小
                numberTicks: 5,
                tickOptions: { fontSize: '10pt' },
                rendererOptions: {
                    forceTickAt0: true,
                    drawBaseline: false
                }
            },
            y2axis: {
                show: true,
                label: $("#mornitorTestTypeSelectSecond").find("option:selected").text() + chartDatas2.unitParams[0], // y轴显示标题
                labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                renderer: $.jqplot.LinearAxisRenderer,  // 设置横（纵）轴上数据加载的渲染器
                autoscale: true,
                max: null,
                min: null,
                //tickInterval: 10,     //网格线间隔大小
                numberTicks: 5,
                tickOptions: { fontSize: '10pt' },
                rendererOptions: {
                    forceTickAt0: true,
                    drawBaseline: false
                }
            },
        },
        highlighter: {
            lineWidthAdjust: 5,
            show: true,
            showLabel: true,
            tooltipAxes: 'both',
            sizeAdjust: 15,
            tooltipLocation: 'ne',
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

    //    plot1 = $.jqplot('chart2', datas.MinValueArray,
    //{
    //    title: {
    //        text: $("#mornitorTestTypeSelectFirst").find("option:selected").text() + '与' + $("#mornitorTestTypeSelectSecond").find("option:selected").text() + '最小值对比曲线图',
    //        textAlign: 'center',
    //        show: true,//设置当前标题是否显示  
    //        color: '#4bb2c5',
    //        fontSize: '20px',
    //    },
    //    animate: true,
    //    animateReplot: true,
    //    cursor: {
    //        style: 'crosshair',
    //        show: true,
    //        zoom: true,
    //        showTooltip: false,
    //        tooltipFormatString: '%.4P',
    //        useAxesFormatters: false,
    //    },
    //    seriesDefaults: {
    //        show: true,
    //        lineWidth: 1,
    //        pointLabels: {
    //            show: false,
    //            formatString: "%.0f",
    //            location: "s",
    //            ypadding: 1,
    //        },
    //        markerOptions: {
    //            show: false,
    //            lineWidth: 1,
    //            size: 12
    //        },
    //        rendererOptions: {
    //            smooth: true
    //        }
    //    },
    //    series: [
    //         {
    //             label: chartDatas1.seriesParams,
    //             lineWidth: 3,
    //             yaxis: 'yaxis',
    //             markerOptions:
    //             {
    //                 formatString: '%.2f',
    //                 fontSize: '10pt'
    //             }
    //         },
    //         {
    //             label: chartDatas2.seriesParams,
    //             lineWidth: 3,
    //             yaxis: 'y2axis',
    //             markerOptions:
    //             {
    //                 formatString: '%.2f',
    //                 fontSize: '10pt'
    //             }
    //         },
    //    ],
    //    axes: {
    //        xaxis: {
    //            label: "监测日期",  //x轴显示标题
    //            pad: 0,
    //            renderer: $.jqplot.DateAxisRenderer, //x轴绘制方式
    //            labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
    //            tickRenderer: $.jqplot.CanvasAxisTickRenderer,
    //            tickOptions: {
    //                formatString: '%F %T', fontSize: '10pt', angle: -20
    //            },
    //            showTicks: true,
    //            rendererOptions: { drawBaseline: false },
    //            drawMajorGridlines: false
    //        },
    //        yaxis: {
    //            show: true,
    //            label: $("#mornitorTestTypeSelectFirst").find("option:selected").text() + chartDatas1.unitParams[0], // y轴显示标题
    //            labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
    //            renderer: $.jqplot.LinearAxisRenderer,  // 设置横（纵）轴上数据加载的渲染器
    //            autoscale: true,
    //            max: null,
    //            min: null,
    //            //tickInterval: 10,     //网格线间隔大小
    //            numberTicks: 5,
    //            tickOptions: { fontSize: '10pt' },
    //            rendererOptions: {
    //                forceTickAt0: true,
    //                drawBaseline: false
    //            }
    //        },
    //        y2axis: {
    //            show: true,
    //            label: $("#mornitorTestTypeSelectSecond").find("option:selected").text() + chartDatas2.unitParams[0], // y轴显示标题
    //            labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
    //            renderer: $.jqplot.LinearAxisRenderer,  // 设置横（纵）轴上数据加载的渲染器
    //            autoscale: true,
    //            max: null,
    //            min: null,
    //            //tickInterval: 10,     //网格线间隔大小
    //            numberTicks: 5,
    //            tickOptions: { fontSize: '10pt' },
    //            rendererOptions: {
    //                forceTickAt0: true,
    //                drawBaseline: false
    //            }
    //        },
    //    },
    //    highlighter: {
    //        lineWidthAdjust: 5,
    //        show: true,
    //        showLabel: true,
    //        tooltipAxes: 'both',
    //        sizeAdjust: 15,
    //        tooltipLocation: 'ne',
    //    },
    //    legend: {
    //        renderer: $.jqplot.EnhancedLegendRenderer,  //渲染器,实现分类标签的功能
    //        show: true,//设置是否出现分类名称框（即所有分类的名称出现在图的某个位置）    
    //        location: 'ne',
    //        placement: 'outsideGrid',
    //        background: '',   //背景颜色
    //        textColor: '',//字体颜色
    //        rowSpacing: '3px',
    //        xoffset: 20,        // 分类名称框距图表区域上边框的距离（单位px）  
    //        yoffset: -50        // 分类名称框距图表区域左边框的距离(单位px)  
    //    }
    //});

    //    plot1 = $.jqplot('chart3', datas.AverageValueArray,
    //{
    //    title: {
    //        text: $("#mornitorTestTypeSelectFirst").find("option:selected").text() + '与' + $("#mornitorTestTypeSelectSecond").find("option:selected").text() + '平均值对比曲线图',
    //        textAlign: 'center',
    //        show: true,//设置当前标题是否显示  
    //        color: '#4bb2c5',
    //        fontSize: '20px',
    //    },
    //    animate: true,
    //    animateReplot: true,
    //    cursor: {
    //        style: 'crosshair',
    //        show: true,
    //        zoom: true,
    //        showTooltip: false,
    //        tooltipFormatString: '%.4P',
    //        useAxesFormatters: false,
    //    },
    //    seriesDefaults: {
    //        show: true,
    //        lineWidth: 1,
    //        pointLabels: {
    //            show: false,
    //            formatString: "%.0f",
    //            location: "s",
    //            ypadding: 1,
    //        },
    //        markerOptions: {
    //            show: false,
    //            lineWidth: 1,
    //            size: 12
    //        },
    //        rendererOptions: {
    //            smooth: true
    //        }
    //    },
    //    series: [
    //         {
    //             label: chartDatas1.seriesParams,
    //             lineWidth: 3,
    //             yaxis: 'yaxis',
    //             markerOptions:
    //             {
    //                 formatString: '%.2f',
    //                 fontSize: '10pt'
    //             }
    //         },
    //         {
    //             label: chartDatas2.seriesParams,
    //             lineWidth: 3,
    //             yaxis: 'y2axis',
    //             markerOptions:
    //             {
    //                 formatString: '%.2f',
    //                 fontSize: '10pt'
    //             }
    //         },
    //    ],
    //    axes: {
    //        xaxis: {
    //            label: "监测日期",  //x轴显示标题
    //            pad: 0,
    //            renderer: $.jqplot.DateAxisRenderer, //x轴绘制方式
    //            labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
    //            tickRenderer: $.jqplot.CanvasAxisTickRenderer,
    //            tickOptions: {
    //                formatString: '%F %T', fontSize: '10pt', angle: -20
    //            },
    //            showTicks: true,
    //            rendererOptions: { drawBaseline: false },
    //            drawMajorGridlines: false
    //        },
    //        yaxis: {
    //            show: true,
    //            label: $("#mornitorTestTypeSelectFirst").find("option:selected").text() + chartDatas1.unitParams[0], // y轴显示标题
    //            labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
    //            renderer: $.jqplot.LinearAxisRenderer,  // 设置横（纵）轴上数据加载的渲染器
    //            autoscale: true,
    //            max: null,
    //            min: null,
    //            //tickInterval: 10,     //网格线间隔大小
    //            numberTicks: 5,
    //            tickOptions: { fontSize: '10pt' },
    //            rendererOptions: {
    //                forceTickAt0: true,
    //                drawBaseline: false
    //            }
    //        },
    //        y2axis: {
    //            show: true,
    //            label: $("#mornitorTestTypeSelectSecond").find("option:selected").text() + chartDatas2.unitParams[0], // y轴显示标题
    //            labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
    //            renderer: $.jqplot.LinearAxisRenderer,  // 设置横（纵）轴上数据加载的渲染器
    //            autoscale: true,
    //            max: null,
    //            min: null,
    //            //tickInterval: 10,     //网格线间隔大小
    //            numberTicks: 5,
    //            tickOptions: { fontSize: '10pt' },
    //            rendererOptions: {
    //                forceTickAt0: true,
    //                drawBaseline: false
    //            }
    //        },
    //    },
    //    highlighter: {
    //        lineWidthAdjust: 5,
    //        show: true,
    //        showLabel: true,
    //        tooltipAxes: 'both',
    //        sizeAdjust: 15,
    //        tooltipLocation: 'ne',
    //    },
    //    legend: {
    //        renderer: $.jqplot.EnhancedLegendRenderer,  //渲染器,实现分类标签的功能
    //        show: true,//设置是否出现分类名称框（即所有分类的名称出现在图的某个位置）    
    //        location: 'ne',
    //        placement: 'outsideGrid',
    //        background: '',   //背景颜色
    //        textColor: '',//字体颜色
    //        rowSpacing: '3px',
    //        xoffset: 20,        // 分类名称框距图表区域上边框的距离（单位px）  
    //        yoffset: -50        // 分类名称框距图表区域左边框的距离(单位px)  
    //    }
    //});

    //能让分类隐藏和显示选中的折线
    var seriesShow = new Array(datas.seriesParams.length);
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
}

function wrapChartDatas(source1, source2) {
    var result = new Object();
    var MaxValueArray = [],seriesParams = [];
    $.each(source1.MaxValueArray, function (i, data) {
        MaxValueArray.push(data);
    });
    $.each(source2.MaxValueArray, function (i, data) {
        MaxValueArray.push(data);
    });
    $.each(source1.seriesParams, function (i, data) {
        seriesParams.push(data);
    });
    $.each(source2.seriesParams, function (i, data) {
        seriesParams.push(data);
    });
    result.MaxValueArray = MaxValueArray;
    result.seriesParams = seriesParams;
    return result;
}


function dealWithChartDatas(source) {
    var result = new Object();
    var MaxValueArray = [], seriesParams = [], unitParams = [];
    MaxValueArray = fillChartMaxValueDataArray(source);
    //MinValuedataArray = fillChartMinValueDataArray(source);
    //AverageValuedataArray = fillChartAverageValueDataArray(source);
    seriesParams = fillChartSeriesParams(source);
    unitParams = fillChartUnitParams(source);
    result.MaxValueArray = MaxValueArray;
    //result.MinValuedataArray = MinValuedataArray;
    //result.AverageValuedataArray = AverageValuedataArray;
    result.seriesParams = seriesParams;
    result.unitParems = unitParams;
    return result;
}

function fillChartMaxValueDataArray(source) {
    var MaxValueArray = [];
    $.each(source.Datas, function (i, item) {
        var itemMaxArray = [];
        $.each(item.Models, function (j, myitem) {
            itemMaxArray.push(myitem.CreateDateTime, myitem.MaxValue);
        });
        MaxValueArray.push(itemMaxArray);
    });
    return MaxValueArray;
    
}




function fillChartSeriesParams(source) {
    var seriesParams = [];
    $.each(source.Datas, function (i, item) {
        seriesParams.push(item.CategoryName);
    });
    return seriesParams;
}

function fillChartUnitParams(source) {
    var unitParams = [];
    $.each(source.Datas, function (i, item) {
        unitParams.push(item.Unit);
    });
    return unitParams;
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
            ret = datas;
        }
    });
    return ret;
}
