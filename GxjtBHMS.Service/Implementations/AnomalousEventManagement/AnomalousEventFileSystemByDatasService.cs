using GxjtBHMS.Service.ViewModels.AnomalousEventManagement;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System.Collections.Generic;

namespace GxjtBHMS.Service.Implementations.AnomalousEventManagement
{
    public class AnomalousEventFileSystemByDatasService
    {
        public object ConvertToDocumentByDatas(List<AnomalousEventManagementModel> datas)
        {
            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet("异常事件查询结果");
            IRow headRow = sheet.CreateRow(0);
            headRow.CreateCell(0).SetCellValue("序号");
            headRow.CreateCell(1).SetCellValue("监测时间");
            headRow.CreateCell(2).SetCellValue("测试类型");
            headRow.CreateCell(3).SetCellValue("测点位置");
            headRow.CreateCell(4).SetCellValue("测点编号");
            headRow.CreateCell(5).SetCellValue("异常原因");
            for (int i = 0; i < datas.ToArray().Length; i++)
            {
                IRow row = sheet.CreateRow(i + 1);
                row.CreateCell(0).SetCellValue(i + 1);
                row.CreateCell(1).SetCellValue(datas.ToArray()[i].Time);
                row.CreateCell(2).SetCellValue(datas.ToArray()[i].TestType);

                row.CreateCell(3).SetCellValue(datas.ToArray()[i].PointsPosition);
                row.CreateCell(4).SetCellValue(datas.ToArray()[i].PointsNumber);
                row.CreateCell(5).SetCellValue(datas.ToArray()[i].AnomalousEventReason);
            }
            return workbook;
        }
    }
}
