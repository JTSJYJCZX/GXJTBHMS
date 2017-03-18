namespace GxjtBHMS.Service.Messaging.MonitoringDatas.DatasQuery
{
    public class GetPagedDatasResponse : ResponseBase
    {
        public dynamic Datas { get; set; }
        public string ResultName { get; set; }
    }
}
