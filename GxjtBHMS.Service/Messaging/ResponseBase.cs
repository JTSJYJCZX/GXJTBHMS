using System.IO;

namespace GxjtBHMS.Service.Messaging
{
    public class ResponseBase
    {
        public virtual string Message { get; set; }
        public virtual bool Succeed { get; set; }      
    }
}
