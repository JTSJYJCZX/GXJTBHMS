﻿using NPOI.XWPF.UserModel;
using NPOI.OpenXmlFormats.Wordprocessing;
using GxjtBHMS.Infrastructure.Helpers;
using System;

namespace GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService
{
    public class NPOIReportProcessor: AbstractFirstLevelSafetyReport
    {
        public override dynamic CreateReport(ReportDownloadModel Datas)
        {
            var m_Docx = new XWPFDocument();
            XWPFTable table = m_Docx.CreateTable(2, 5);//创建6行4列表,表头

            SetReportTableHeaderValue(table);

            var m_NewRow = new CT_Row();
            var m_Row = new XWPFTableRow(m_NewRow, table);
            XWPFTableCell cell;
            CT_Tc cttc;
            CT_TcPr ctPr;
            //评估结果
            CreateAssessmentResultsCell(table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);

            //异常记录
            CreateExceptionRecordsCell(Datas, table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);

            //合并单元格
            MergeUnnecessaryCell(table);


            //给报告模板赋值
            SetReportHeaderValue(Datas, table);
            //评估结果
            SetAssessmentResultsValue(Datas, table);
            //异常记录

            SetExceptionRecordsValue(Datas, table);
            return m_Docx;
        }

        static void SetExceptionRecordsValue(ReportDownloadModel Datas, XWPFTable table)
        {
            int j = ServiceConstant.FirstExceptionRecordRowNumber;
            foreach (var item in Datas.ExceptionRecordModels)
            {
                table.GetRow(j).GetCell(1).SetText(item.TestType);
                table.GetRow(j).GetCell(2).SetText(item.MonitoringPointsNumbers);
                table.GetRow(j).GetCell(3).SetText(item.MonitoringPointsPositions);
                table.GetRow(j).GetCell(4).SetText(item.ExceptionNumber.ToString());
                j++;
            }
        }

        static void SetAssessmentResultsValue(ReportDownloadModel Datas, XWPFTable table)
        {
            table.GetRow(3).GetCell(2).SetText(Datas.ResultsModel.DisplacementAssessmentResult);
            table.GetRow(3).GetCell(3).SetText(Datas.ResultsModel.DisplacementAssessmentSuggestion);
            table.GetRow(4).GetCell(2).SetText(Datas.ResultsModel.StrainAssessmentResult);
            table.GetRow(4).GetCell(3).SetText(Datas.ResultsModel.StrainAssessmentSuggestion);
            table.GetRow(5).GetCell(2).SetText(Datas.ResultsModel.CableForceAssessmentResult);
            table.GetRow(5).GetCell(3).SetText(Datas.ResultsModel.CableForceAssessmentSuggestion);
        }

        static void SetReportHeaderValue(ReportDownloadModel Datas, XWPFTable table)
        {
            table.GetRow(0).GetCell(3).SetText(Datas.ReportModel.ReportPeriods);
            table.GetRow(1).GetCell(1).SetText(Datas.ReportModel.AssessmentReasons.AssessmentReasons);
            table.GetRow(1).GetCell(3).SetText(DateTimeHelper.FormatDate(Datas.ReportModel.ReportTime));
        }

        static void MergeUnnecessaryCell(XWPFTable table)
        {
            table.GetRow(0).MergeCells(1, 2);
            table.GetRow(1).MergeCells(1, 2);
            table.GetRow(2).MergeCells(2, 3);
            table.GetRow(3).MergeCells(2, 3);
            table.GetRow(4).MergeCells(2, 3);
            table.GetRow(5).MergeCells(2, 3);
        }

        void CreateExceptionRecordsCell(ReportDownloadModel Datas, XWPFTable table, out CT_Row m_NewRow, out XWPFTableRow m_Row, out XWPFTableCell cell, out CT_Tc cttc, out CT_TcPr ctPr)
        {
            DealWithMergeCell(table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);
            StartMergeRow(cttc, ctPr, "异常记录");
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
            for (int i = 1; i <= Datas.ExceptionRecordNumber; i++)
            {
                m_NewRow = new CT_Row();
                m_Row = new XWPFTableRow(m_NewRow, table);
                table.AddRow(m_Row);
                cell = m_Row.CreateCell();
                cttc = cell.GetCTTc();
                ctPr = cttc.AddNewTcPr();
                ctPr.AddNewVMerge().val = ST_Merge.@continue;//合并行
                //横向创建4个单元格
                for (int k = 1; k < 5; k++)
                {
                    cell = m_Row.CreateCell();
                    SetAlign(cell);
                }
            }
        }

        /// <summary>
        /// 创建评估结果单元格
        /// </summary>
        /// <param name="table"></param>
        /// <param name="m_NewRow"></param>
        /// <param name="m_Row"></param>
        /// <param name="cell"></param>
        /// <param name="cttc"></param>
        /// <param name="ctPr"></param>
        void CreateAssessmentResultsCell(XWPFTable table, out CT_Row m_NewRow, out XWPFTableRow m_Row, out XWPFTableCell cell, out CT_Tc cttc, out CT_TcPr ctPr)
        {
            //评估结果表头
            CreateAssessmentResultHeaderAndSetValue(table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);

            //创建位移评估结果单元格
            CreateDisplacementAssessmentResultCell(table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);

            //创建应力评估结果单元格
            CreateStressAssessmentResultCell(table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);

            //创建索力评估结果单元格
            CreateCableForceAssessmentResultCell(table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);
        }

        void CreateCableForceAssessmentResultCell(XWPFTable table, out CT_Row m_NewRow, out XWPFTableRow m_Row, out XWPFTableCell cell, out CT_Tc cttc, out CT_TcPr ctPr)
        {
            DealWithMergeCell(table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);
            ctPr.AddNewVMerge().val = ST_Merge.@continue;//合并行
            cell = m_Row.CreateCell();
            cell.SetText("吊杆及系杆索力评估");
            SetAlign(cell);
            for (int i = 1; i < 4; i++)
            {
                cell = m_Row.CreateCell();
                SetAlign(cell);
            }
        }

        void CreateStressAssessmentResultCell(XWPFTable table, out CT_Row m_NewRow, out XWPFTableRow m_Row, out XWPFTableCell cell, out CT_Tc cttc, out CT_TcPr ctPr)
        {
            DealWithMergeCell(table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);
            ctPr.AddNewVMerge().val = ST_Merge.@continue;//合并行
            cell = m_Row.CreateCell();
            cell.SetText("应力评估");
            SetAlign(cell);
            for (int i = 1; i < 4; i++)
            {
                cell = m_Row.CreateCell();
                SetAlign(cell);
            }
        }

        void CreateDisplacementAssessmentResultCell(XWPFTable table, out CT_Row m_NewRow, out XWPFTableRow m_Row, out XWPFTableCell cell, out CT_Tc cttc, out CT_TcPr ctPr)
        {
            DealWithMergeCell(table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);
            ctPr.AddNewVMerge().val = ST_Merge.@continue;//合并行
            cell = m_Row.CreateCell();
            cell.SetText("变形评估");
            SetAlign(cell);
            for (int i = 1; i < 4; i++)
            {
                cell = m_Row.CreateCell();
                SetAlign(cell);
            }
        }

        void CreateAssessmentResultHeaderAndSetValue(XWPFTable table, out CT_Row m_NewRow, out XWPFTableRow m_Row, out XWPFTableCell cell, out CT_Tc cttc, out CT_TcPr ctPr)
        {
            DealWithMergeCell(table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);
            StartMergeRow(cttc, ctPr, "评估结果");
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
        }

        void SetReportTableHeaderValue(XWPFTable table)
        {
            table.GetRow(0).GetCell(0).SetText("报告名称");
            SetAlign(table.GetRow(0).GetCell(0));//居中设置
            table.GetRow(0).GetCell(1).SetText("梧州西江四桥安全一级评估报告");
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
        }

        /// <summary>
        /// 对合并单元格的首单元格进行设置，并居中对齐
        /// </summary>
        /// <param name="cttc"></param>
        /// <param name="ctPr"></param>
        /// <param name="mergeCellValue"></param>
        static void StartMergeRow(CT_Tc cttc, CT_TcPr ctPr,string mergeCellValue)
        {
            ctPr.AddNewVMerge().val = ST_Merge.restart;//合并行
            ctPr.AddNewVAlign().val = ST_VerticalJc.center;//垂直居中
            cttc.GetPList()[0].AddNewPPr().AddNewJc().val = ST_Jc.center;
            cttc.GetPList()[0].AddNewR().AddNewT().Value = mergeCellValue;
        }

        /// <summary>
        /// 对合并单元格进行前处理
        /// </summary>
        /// <param name="table"></param>
        /// <param name="m_NewRow"></param>
        /// <param name="m_Row"></param>
        /// <param name="cell"></param>
        /// <param name="cttc"></param>
        /// <param name="ctPr"></param>
        static void DealWithMergeCell(XWPFTable table, out CT_Row m_NewRow, out XWPFTableRow m_Row, out XWPFTableCell cell, out CT_Tc cttc, out CT_TcPr ctPr)
        {
            m_NewRow = new CT_Row();
            m_Row = new XWPFTableRow(m_NewRow, table);
            table.AddRow(m_Row);
            cell = m_Row.CreateCell();
            cttc = cell.GetCTTc();
            ctPr = cttc.AddNewTcPr();
        }

        /// <summary>
        /// 单元格居中对齐
        /// </summary>
        /// <param name="cell"></param>
        void SetAlign(XWPFTableCell cell)
        {
            var cttc = cell.GetCTTc();
            var ctPr = cttc.AddNewTcPr();
            ctPr.AddNewVAlign().val = ST_VerticalJc.center;//垂直居中
            cttc.GetPList()[0].AddNewPPr().AddNewJc().val = ST_Jc.center;
        }

        protected override void BuildHeader()
        {
            throw new NotImplementedException();
        }

        protected override void BuildContent()
        {
            throw new NotImplementedException();
        }
    }
}
