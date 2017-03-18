namespace GxjtBHMS.Service.Messaging.MonitoringDatas
{
    public class DatasQueryResultRequest: DatasQueryResultRequestBase
    {
        public string PointsNumber { set; get; }
        public int TestTypeId { get;  set; }
    }
}
