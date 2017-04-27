using NPOI.XWPF.UserModel;
using System.IO;
using NPOI.OpenXmlFormats.Wordprocessing;

namespace GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService
{
    public class CreateReportTable
    {
        public dynamic CreateTable(int exceptionNumber)
        {
            var m_Docx = new XWPFDocument();
            XWPFTable table = m_Docx.CreateTable(2, 5);//创建6行4列表,表头
            
            table.GetRow(0).GetCell(0).SetText("报告名称");
            SetAlign(table.GetRow(0).GetCell(0));//居中设置
            SetAlign(table.GetRow(0).GetCell(1));
            table.GetRow(0).GetCell(3).SetText("报告编号");
            SetAlign(table.GetRow(0).GetCell(3));
            SetAlign(table.GetRow(0).GetCell(4));
            table.GetRow(1).GetCell(0).SetText("评估原因");
            SetAlign(table.GetRow(1).GetCell(0));
            SetAlign(table.GetRow(1).GetCell(1));
            table.GetRow(1).GetCell(3).SetText("时间区段");
            SetAlign(table.GetRow(1).GetCell(3));
            SetAlign(table.GetRow(1).GetCell(4));

            //评估结果
            var m_NewRow = new CT_Row();
            var m_Row = new XWPFTableRow(m_NewRow, table);
            table.AddRow(m_Row);
            var cell = m_Row.CreateCell();
            var cttc = cell.GetCTTc();
            var ctPr = cttc.AddNewTcPr();
            ctPr.AddNewVMerge().val = ST_Merge.restart;//合并行
            ctPr.AddNewVAlign().val = ST_VerticalJc.center;//垂直居中

            cttc.GetPList()[0].AddNewPPr().AddNewJc().val = ST_Jc.center;
            cttc.GetPList()[0].AddNewR().AddNewT().Value = "评估结果";
            cell = m_Row.CreateCell();
            cell.SetText("评估项目");
            SetAlign(cell);
            cell = m_Row.CreateCell();
            cell.SetText("评估结论");
            SetAlign(cell);
            cell = m_Row.CreateCell();
            cell.SetText("");
            SetAlign(cell);
            cell = m_Row.CreateCell();
            cell.SetText("建议");
            SetAlign(cell);

            //
            m_NewRow = new CT_Row();
            m_Row = new XWPFTableRow(m_NewRow, table);
            table.AddRow(m_Row);
            cell = m_Row.CreateCell();
            cttc = cell.GetCTTc();
            ctPr = cttc.AddNewTcPr();
            ctPr.AddNewVMerge().val = ST_Merge.@continue;//合并行
            cell = m_Row.CreateCell();
            cell.SetText("变形评估");
            SetAlign(cell);
            for(int i = 1; i < 4; i++)
            {
                cell = m_Row.CreateCell();
                SetAlign(cell);
            }

            //
            m_NewRow = new CT_Row();
            m_Row = new XWPFTableRow(m_NewRow, table);
            table.AddRow(m_Row);
            cell = m_Row.CreateCell();
            cttc = cell.GetCTTc();
            ctPr = cttc.AddNewTcPr();
            ctPr.AddNewVMerge().val = ST_Merge.@continue;//合并行
            cell = m_Row.CreateCell();
            cell.SetText("应力评估");
            SetAlign(cell);
            for (int i = 1; i < 4; i++)
            {
                cell = m_Row.CreateCell();
                SetAlign(cell);
            }

            //
            m_NewRow = new CT_Row();
            m_Row = new XWPFTableRow(m_NewRow, table);
            table.AddRow(m_Row);
            cell = m_Row.CreateCell();
            cttc = cell.GetCTTc();
            ctPr = cttc.AddNewTcPr();
            ctPr.AddNewVMerge().val = ST_Merge.@continue;//合并行
            cell = m_Row.CreateCell();
            cell.SetText("吊杆及系杆索力评估");
            SetAlign(cell);
            for (int i = 1; i < 4; i++)
            {
                cell = m_Row.CreateCell();
                SetAlign(cell);
            }

            //异常记录
            m_NewRow = new CT_Row();
            m_Row = new XWPFTableRow(m_NewRow, table);
            table.AddRow(m_Row);
            cell = m_Row.CreateCell();
            cttc = cell.GetCTTc();
            ctPr = cttc.AddNewTcPr();
            ctPr.AddNewVMerge().val = ST_Merge.restart;//合并行
            ctPr.AddNewVAlign().val = ST_VerticalJc.center;//垂直居中

            cttc.GetPList()[0].AddNewPPr().AddNewJc().val = ST_Jc.center;
            cttc.GetPList()[0].AddNewR().AddNewT().Value = "异常记录";
            cell = m_Row.CreateCell();
            cell.SetText("检测类型");
            SetAlign(cell);
            cell = m_Row.CreateCell();
            cell.SetText("测点编号");
            SetAlign(cell);
            cell = m_Row.CreateCell();
            cell.SetText("测点位置");
            SetAlign(cell);
            cell = m_Row.CreateCell();
            cell.SetText("异常次数");
            SetAlign(cell);

            //
            for (int i = 1; i <= exceptionNumber; i++)
            {
                m_NewRow = new CT_Row();
                m_Row = new XWPFTableRow(m_NewRow, table);
                table.AddRow(m_Row);
                cell = m_Row.CreateCell();
                cttc = cell.GetCTTc();
                ctPr = cttc.AddNewTcPr();
                ctPr.AddNewVMerge().val = ST_Merge.@continue;//合并行
                //横向创建4个单元格
                for (int j = 1; j < 5; j++)
                {
                    cell = m_Row.CreateCell();
                    SetAlign(cell);
                }
            }

            //合并单元格
            table.GetRow(0).MergeCells(1, 2);
            table.GetRow(1).MergeCells(1, 2);
            table.GetRow(2).MergeCells(2, 3);
            table.GetRow(3).MergeCells(2, 3);
            table.GetRow(4).MergeCells(2, 3);
            table.GetRow(5).MergeCells(2, 3);
            return m_Docx;
        }


        /// <summary>
        /// 设置单元格跨行，合并行
        /// </summary>
        /// <param name="cell"></param>
        /// <param name="stmerge"></param>
        void MergeRow(XWPFTableCell cell, ST_Merge stmerge)
        {
            var cttc = cell.GetCTTc();
            var ctPr = cttc.AddNewTcPr();
            ctPr.AddNewVMerge().val = stmerge;
        }

        XWPFTableRow AddRow(XWPFTable table)
        {
            var m_Row = table.CreateRow();//创建一行
            var m_NewRow = new CT_Row();
            m_Row = new XWPFTableRow(m_NewRow, table);
            table.AddRow(m_Row); //必须要！！
            return m_Row;
        }

        /// <summary>
        /// 设置单元格跨列，合并列
        /// </summary>
        /// <param name="cell"></param>
        /// <param name="spanCount"></param>
        void SetGridSpan(XWPFTableCell cell, int spanCount)
        {
            var cttc = cell.GetCTTc();
            var ctPr = cttc.AddNewTcPr();
            ctPr.gridSpan = new CT_DecimalNumber();
            ctPr.gridSpan.val = spanCount.ToString();
        }

        void SetAlign(XWPFTableCell cell)
        {
            var cttc = cell.GetCTTc();

            var ctPr = cttc.AddNewTcPr();

            ctPr.AddNewVAlign().val = ST_VerticalJc.center;//垂直居中

            cttc.GetPList()[0].AddNewPPr().AddNewJc().val = ST_Jc.center;

        }

        void SetText(XWPFTableCell cell, string value)
        {
            var cttc = cell.GetCTTc();
            cttc.GetPList()[0].AddNewR().AddNewT().Value = value;
        }

    }
}
