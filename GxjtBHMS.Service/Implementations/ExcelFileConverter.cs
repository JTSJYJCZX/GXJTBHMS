﻿using System.IO;
using GxjtBHMS.Service.Interfaces;
using NPOI.HSSF.UserModel;
using System;

namespace GxjtBHMS.Service.Implementations
{
    public class ExcelFileConverter : IFileConverter
    {
        public MemoryStream GetStream(object obj)
        {
            var book = obj as HSSFWorkbook;
            if (obj == null)
            {
                throw new ApplicationException("File is null or type error");
            }
            var ms = new MemoryStream();
            book.Write(ms);
            return ms;
        }
    }
}
