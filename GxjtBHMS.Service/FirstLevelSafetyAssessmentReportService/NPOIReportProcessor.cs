using NPOI.XWPF.UserModel;
using NPOI.OpenXmlFormats.Wordprocessing;
using GxjtBHMS.Infrastructure.Helpers;

namespace GxjtBHMS.Service.FirstLevelSafetyAssessmentReportService
{
    public class NPOIReportProcessor : AbstractFirstLevelSafetyReport
    {
        XWPFDocument _docx = new XWPFDocument();
        XWPFTable _table;//创建6行4列表,表头

        protected override void BuildHeader()
        {
            XWPFParagraph p0 = _docx.CreateParagraph();
            p0.Alignment = ParagraphAlignment.CENTER;
            XWPFRun r0 = p0.CreateRun();
            r0.SetText("一级安全评估报告");
            r0.SetTextPosition(1);
            r0.FontFamily = "宋体";
            r0.FontSize = 24;
            r0.IsBold = true;
            _table = _docx.CreateTable(2, 5);
            SetReportTableHeaderValue(_table);
            //给报告表头赋值
            SetReportHeaderValue(_source, _table);
        }

        protected override void BuildContent()
        {
            var m_NewRow = new CT_Row();
            var m_Row = new XWPFTableRow(m_NewRow, _table);

            XWPFTableCell cell;
            CT_Tc cttc;
            CT_TcPr ctPr;
            //评估结果
            CreateAssessmentResultsCell(_table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);
            //异常记录
            CreateExceptionRecordsCell(_source, _table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);
            //合并单元格
            MergeUnnecessaryCell(_table);
            //评估结果赋值
            SetAssessmentResultsValue(_source, _table);
            //异常记录赋值
            SetExceptionRecordsValue(_source, _table);
            _result = _docx;
        }


        /// <summary>
        /// 创建评估报告表格表头
        /// </summary>
        /// <param name="table"></param>
        void SetReportTableHeaderValue(XWPFTable table)
        {
            SetBoldFontCell(table.GetRow(0).GetCell(0), "报告名称");
            table.GetRow(0).GetCell(1).SetText("梧州西江四桥安全一级评估报告");
            SetAlign(table.GetRow(0).GetCell(1));
            SetBoldFontCell(table.GetRow(0).GetCell(3), "报告编号");
            SetAlign(table.GetRow(0).GetCell(4));
            SetBoldFontCell(table.GetRow(1).GetCell(0), "评估原因");
            SetAlign(table.GetRow(1).GetCell(1));
            SetBoldFontCell(table.GetRow(1).GetCell(3), "时间区段");
            SetAlign(table.GetRow(1).GetCell(4));
        }


        /// <summary>
        /// 创建评估结果单元格
        /// </summary>
        /// <param name="table">评估表格</param>
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

        //创建“评估结果”表格表头部分
        void CreateAssessmentResultHeaderAndSetValue(XWPFTable table, out CT_Row m_NewRow, out XWPFTableRow m_Row, out XWPFTableCell cell, out CT_Tc cttc, out CT_TcPr ctPr)
        {
            DealWithMergeCell(table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);
            StartMergeRow(cttc, ctPr, "评估结果");
            cell = m_Row.CreateCell();
            SetBoldFontCell(cell, "评估项目");
            SetAlign(cell);
            cell = m_Row.CreateCell();
            SetBoldFontCell(cell, "评估结论");
            SetAlign(cell);
            cell = m_Row.CreateCell();
            cell.SetText("");
            SetAlign(cell);
            cell = m_Row.CreateCell();
            SetBoldFontCell(cell, "建议");
            SetAlign(cell);
        }

        //创建评估报告位移评估结果单元格
        void CreateDisplacementAssessmentResultCell(XWPFTable table, out CT_Row m_NewRow, out XWPFTableRow m_Row, out XWPFTableCell cell, out CT_Tc cttc, out CT_TcPr ctPr)
        {
            DealWithMergeCell(table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);
            ctPr.AddNewVMerge().val = ST_Merge.@continue;//合并行
            cell = m_Row.CreateCell();
            SetBoldFontCell(cell, "变形评估");
            SetAlign(cell);
            for (int i = 1; i < 4; i++)
            {
                cell = m_Row.CreateCell();
                SetAlign(cell);
            }
        }

        //创建评估报告应力评估结果单元格
        void CreateStressAssessmentResultCell(XWPFTable table, out CT_Row m_NewRow, out XWPFTableRow m_Row, out XWPFTableCell cell, out CT_Tc cttc, out CT_TcPr ctPr)
        {
            DealWithMergeCell(table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);
            ctPr.AddNewVMerge().val = ST_Merge.@continue;//合并行
            cell = m_Row.CreateCell();
            SetBoldFontCell(cell, "应力评估");
            SetAlign(cell);
            for (int i = 1; i < 4; i++)
            {
                cell = m_Row.CreateCell();
                SetAlign(cell);
            }
        }

        //创建评估报告索力评估结果单元格
        void CreateCableForceAssessmentResultCell(XWPFTable table, out CT_Row m_NewRow, out XWPFTableRow m_Row, out XWPFTableCell cell, out CT_Tc cttc, out CT_TcPr ctPr)
        {
            DealWithMergeCell(table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);
            ctPr.AddNewVMerge().val = ST_Merge.@continue;//合并行
            cell = m_Row.CreateCell();
            SetBoldFontCell(cell, "吊杆及系杆索力评估");
            SetAlign(cell);
            for (int i = 1; i < 4; i++)
            {
                cell = m_Row.CreateCell();
                SetAlign(cell);
            }
        }
        void CreateExceptionRecordsCell(ReportDownloadModel Datas, XWPFTable table, out CT_Row m_NewRow, out XWPFTableRow m_Row, out XWPFTableCell cell, out CT_Tc cttc, out CT_TcPr ctPr)
        {
            DealWithMergeCell(table, out m_NewRow, out m_Row, out cell, out cttc, out ctPr);
            StartMergeRow(cttc, ctPr, "异常记录");
            cell = m_Row.CreateCell();
            SetBoldFontCell(cell, "检测类型");
            SetAlign(cell);
            cell = m_Row.CreateCell();
            SetBoldFontCell(cell, "测点编号");
            SetAlign(cell);
            cell = m_Row.CreateCell();
            SetBoldFontCell(cell, "测点位置");
            SetAlign(cell);
            cell = m_Row.CreateCell();
            SetBoldFontCell(cell, "异常次数");
            SetAlign(cell);

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
        /// 合并多余单元格
        /// </summary>
        /// <param name="table"></param>
        static void MergeUnnecessaryCell(XWPFTable table)
        {
            table.GetRow(0).MergeCells(1, 2);
            table.GetRow(1).MergeCells(1, 2);
            table.GetRow(2).MergeCells(2, 3);

        }


        /// <summary>
        /// 对评估报告表格表头动态赋值
        /// </summary>
        /// <param name="Datas"></param>
        /// <param name="table"></param>
        static void SetReportHeaderValue(ReportDownloadModel Datas, XWPFTable table)
        {
            table.GetRow(0).GetCell(4).SetText(Datas.ReportModel.ReportPeriods);
            table.GetRow(1).GetCell(1).SetText(Datas.ReportModel.AssessmentReasons.AssessmentReasons);
            table.GetRow(1).GetCell(4).SetText(DateTimeHelper.FormatDateTime(Datas.ReportModel.ReportTime));
        }

        /// <summary>
        /// 对“评估结果”动态赋值，若测试类型为异常，则“评估结果”内容为红色字体
        /// </summary>
        /// <param name="Datas"></param>
        /// <param name="table"></param>
        void SetAssessmentResultsValue(ReportDownloadModel Datas, XWPFTable table)
        {
            int disExceptionNumber = 0;
            int strExceptionNumber = 0;
            int cabExceptionNumber = 0;
            foreach (var item in Datas.ExceptionRecordModels)
            {
                switch (item.TestType)
                {
                    case "索力":
                        cabExceptionNumber++;
                        break;
                    case "位移":
                        disExceptionNumber++;
                        break;
                    case "钢拱肋应变":
                        strExceptionNumber++;
                        break;
                    case "钢格构应变":
                        strExceptionNumber++;
                        break;
                    case "混凝土应变":
                        strExceptionNumber++;
                        break;
                    default:
                        break;
                }
            }

            if (disExceptionNumber > 0)
            {
                SetRedFontCell(table.GetRow(3).GetCell(2), Datas.ResultsModel.DisplacementAssessmentResult);
            }
            else
            {
                table.GetRow(3).GetCell(2).SetText(Datas.ResultsModel.DisplacementAssessmentResult);
            }
            table.GetRow(3).GetCell(4).SetText(Datas.ResultsModel.DisplacementAssessmentSuggestion);

            if (strExceptionNumber > 0)
            {
                SetRedFontCell(table.GetRow(4).GetCell(2), Datas.ResultsModel.StrainAssessmentResult);
            }
            else
            {
                table.GetRow(4).GetCell(2).SetText(Datas.ResultsModel.StrainAssessmentResult);
            }
            table.GetRow(4).GetCell(4).SetText(Datas.ResultsModel.StrainAssessmentSuggestion);

            if (strExceptionNumber > 0)
            {
                SetRedFontCell(table.GetRow(5).GetCell(2), Datas.ResultsModel.CableForceAssessmentResult);
            }
            else
            {
                table.GetRow(5).GetCell(2).SetText(Datas.ResultsModel.CableForceAssessmentResult);
            }
            table.GetRow(5).GetCell(4).SetText(Datas.ResultsModel.CableForceAssessmentSuggestion);
            table.GetRow(3).MergeCells(2, 3);
            table.GetRow(4).MergeCells(2, 3);
            table.GetRow(5).MergeCells(2, 3);
        }

        /// <summary>
        /// 异常记录动态赋值
        /// </summary>
        /// <param name="Datas"></param>
        /// <param name="table"></param>
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

        /// <summary>
        /// 对合并单元格的首单元格进行设置，并居中对齐
        /// </summary>
        /// <param name="cttc"></param>
        /// <param name="ctPr"></param>
        /// <param name="mergeCellValue"></param>
        static void StartMergeRow(CT_Tc cttc, CT_TcPr ctPr, string mergeCellValue)
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

        /// <summary>
        /// 字体加粗单元格设置
        /// </summary>
        /// <param name="cell">单元格</param>
        /// <param name="value">单元格值</param>
        void SetBoldFontCell(XWPFTableCell cell, string value)
        {
            XWPFParagraph pIO = cell.AddParagraph();
            pIO.Alignment = ParagraphAlignment.CENTER;
            XWPFRun rIO = pIO.CreateRun();
            rIO.IsBold = true;
            rIO.SetText(value);
            SetAlign(cell);
            cell.RemoveParagraph(0);
        }

       void SetRedFontCell(XWPFTableCell cell,string value)
        {
            XWPFParagraph pIO = cell.AddParagraph();
            pIO.Alignment = ParagraphAlignment.CENTER;
            XWPFRun rIO = pIO.CreateRun();
            rIO.SetColor("red");
            rIO.SetText(value);
            SetAlign(cell);
            cell.RemoveParagraph(0);
        }
    }
}
