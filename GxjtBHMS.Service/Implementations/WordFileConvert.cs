using System.IO;
using GxjtBHMS.Service.Interfaces;
using System;
using NPOI.XWPF.UserModel;

namespace GxjtBHMS.Service.Implementations
{
   public class WordFileConvert: IFileConverter
    {
        public MemoryStream GetStream(object obj)
        {
            var book = obj as XWPFDocument;
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
