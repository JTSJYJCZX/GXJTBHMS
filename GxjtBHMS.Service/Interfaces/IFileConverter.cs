using System.IO;

namespace GxjtBHMS.Service.Interfaces
{
    public interface IFileConverter
    {
        MemoryStream GetStream(object obj);
    
    }
}
