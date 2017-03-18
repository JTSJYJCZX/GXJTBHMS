using Microsoft.Office.Interop.Word;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Office.Interop.Graph;
using System.Drawing;
using GxjtBHMS.Web.ViewModels.DataQueryResult;

namespace GxjtBHMS.Web.Controllers
{
    class WordCreater
    {
        object oMissing = System.Reflection.Missing.Value;
        public const string TitleBookmark = "title";
        public const string StrainTableBookmark = "straintable";
        public const string StatisticTableBookmark = "statistictable";
        public const int TableColumnsNumber = 6;

        public void CreatStrainResultDocument(IEnumerable<StrainDatasView> datas)
        {
            //数据源排序
            var datasByOrder = datas.OrderBy(m => m.PointsNumber).ThenByDescending(m => m.Time);
            var groupDatas = datasByOrder.GroupBy(m => m.PointsNumber);

            //创建一个document，并给其加载模板
            _Application oWord;
            _Document oDoc;
            oWord = new Microsoft.Office.Interop.Word.Application();
            object templateName = System.Web.HttpContext.Current.Server.MapPath("~/Files/Template/应变查询结果模板.dotx");
            oDoc = oWord.Documents.Add(templateName, ref oMissing, ref oMissing, ref oMissing);
            oWord.Visible = false;//当前office状态           

            //给标题赋值
            object bookMark = TitleBookmark;
            Bookmark bm = oDoc.Bookmarks.get_Item(ref bookMark);
            bm.Range.Text = GetTitleText(groupDatas);
            oWord.Selection.ParagraphFormat.Alignment = WdParagraphAlignment.wdAlignParagraphCenter;

            //新建表格
            Table strainTable;                    
            object strainTableBookmark = StrainTableBookmark;
            Microsoft.Office.Interop.Word.Range wrdRng = oDoc.Bookmarks.get_Item(ref strainTableBookmark).Range;
            int RowsNumber = datas.Select(m => m.PointsNumber).ToArray().Length;
            strainTable = oDoc.Tables.Add(wrdRng, RowsNumber + 1, TableColumnsNumber, ref oMissing, ref oMissing);

            //设置表头信息
            strainTable.Cell(1, 1).Range.Text = "序号";
            strainTable.Cell(1, 2).Range.Text = "测点编号";
            strainTable.Cell(1, 3).Range.Text = "测点位置";
            strainTable.Cell(1, 4).Range.Text = "应变值";
            strainTable.Cell(1, 5).Range.Text = "监测时间";
            strainTable.Cell(1, 6).Range.Text = "温度";

            //表格赋值
            var testPoint = datasByOrder.Select(m => m.PointsNumber).ToArray();
            var strainValue = datasByOrder.Select(m => m.Strain).ToArray();
            var monitorTime = datasByOrder.Select(m => m.Time).ToArray();
            var temperature = datasByOrder.Select(m => m.Temperature).ToArray();
            for (int r = 2; r < RowsNumber + 2; r++)
            {
                strainTable.Cell(r, 1).Range.Text = (r - 1).ToString();
                strainTable.Cell(r, 2).Range.Text = testPoint[r - 2];
                strainTable.Cell(r, 3).Range.Text = null;
                strainTable.Cell(r, 4).Range.Text = strainValue[r - 2].ToString();
                strainTable.Cell(r, 5).Range.Text = monitorTime[r - 2].ToString();
                strainTable.Cell(r, 6).Range.Text = temperature[r - 2].ToString();
            }

            //设置表格及内容格式
            strainTable.Range.ParagraphFormat.SpaceAfter = 0;
            strainTable.Range.ParagraphFormat.Alignment = WdParagraphAlignment.wdAlignParagraphCenter;
            strainTable.Rows.Alignment = WdRowAlignment.wdAlignRowCenter;
            for (int i = 1; i <= RowsNumber + 1; i++)
            {
                for (int j = 1; j <= TableColumnsNumber; j++)
                {
                    strainTable.Cell(i, j).VerticalAlignment = WdCellVerticalAlignment.wdCellAlignVerticalCenter;
                }
            }        

            //设置表格字体
            strainTable.Rows[1].Range.Font.Bold = 1;
            strainTable.Rows[1].Range.Font.Name = "宋体";
            strainTable.Rows[1].Range.Font.Size = float.Parse("12");

            //设置表格边框
            strainTable.Borders.OutsideLineStyle = WdLineStyle.wdLineStyleDouble;
            strainTable.Borders.OutsideColor = WdColor.wdColorBlack;
            strainTable.Borders.OutsideLineWidth = WdLineWidth.wdLineWidth075pt;
            strainTable.Borders.InsideLineStyle = WdLineStyle.wdLineStyleSingle;
            strainTable.Rows.Height = 20f;
            strainTable.Columns.Width = 70f;

            //创建应变查询结果统计值的表格
            //---  待实现  --


            //绘制曲线图
            InlineShape oShape;
            object oClassType = "MSGraph.Chart.8";
            object statistictableBookmark = StatisticTableBookmark;
            Microsoft.Office.Interop.Word.Range owrdRng = oDoc.Bookmarks.get_Item(ref statistictableBookmark).Range;
            oShape = owrdRng.InlineShapes.AddOLEObject(ref oClassType, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing, ref oMissing);

            Microsoft.Office.Interop.Graph.Chart objChart = (Microsoft.Office.Interop.Graph.Chart)oShape.OLEFormat.Object;
            Microsoft.Office.Interop.Graph.Application oChartApp = objChart.Application;
            objChart.ChartType = XlChartType.xlXYScatterSmooth;
            objChart.Height = 300f;
            objChart.Width = 600f;

            objChart.HasTitle = true;
            objChart.ChartTitle.Text = "应变曲线图";
            objChart.ChartTitle.Font.Size = 10;
            objChart.PlotArea.Interior.Color = Color.White;

            Microsoft.Office.Interop.Graph.Axis axis = (Microsoft.Office.Interop.Graph.Axis)objChart.Axes(1, 1);
            axis.HasTitle = true;
            // 设置X轴的标题（X轴表示什么）
            axis.AxisTitle.Text = "监测时间";
            axis.AxisTitle.Font.Size = 10;

            Microsoft.Office.Interop.Graph.Axis ayis = (Microsoft.Office.Interop.Graph.Axis)objChart.Axes(2, 1);
            ayis.HasTitle = true;
            // 设置X轴的标题（X轴表示什么）
            ayis.AxisTitle.Text = "应变值";
            ayis.AxisTitle.Font.Size = 10;
            axis.CategoryType = Microsoft.Office.Interop.Graph.XlCategoryType.xlTimeScale;


            //给曲线赋值
            DataSheet dataSheet;
            dataSheet = objChart.Application.DataSheet;
            dataSheet.Columns.Clear();
            dataSheet.Rows.Clear();           

            int rowNumber = 0;
            foreach (var item in groupDatas)
            {
                for (int j = 0; j < item.ToArray().Length; j++)
                {
                    dataSheet.Cells[1, j + 2] = item.Select(m => m.Time).ToArray()[j];
                    dataSheet.Cells[rowNumber + 2, j + 2] = item.Select(m => m.Strain).ToArray()[j];
                    dataSheet.Cells[rowNumber + 2, 1] = item.Key;
                }
                rowNumber++;
            }
            try
            {
                oDoc.Save();
            }
            catch
            {

            }
        }

        private static string GetTitleText(IEnumerable<IGrouping<string, StrainDatasView>> groupDatas)
        {
            string titleText = null;
            foreach (var item in groupDatas)
            {
                titleText += item.Key + " ";
            }

            return titleText;
        }
    }
}