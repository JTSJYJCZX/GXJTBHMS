namespace GxjtBHMS.Web.Models
{
    /// <summary>
    /// 阈值分组类
    /// </summary>
    public class ThresholdValueGroup
    {
        public ThresholdValueGroup()
        {
            PositiveStandardValueGroup = new PositiveStandardValueGroup();
            NegativeStandardValueGroup = new NegativeStandardValueGroup();
        }
        public PositiveStandardValueGroup PositiveStandardValueGroup { get; set; }
        public NegativeStandardValueGroup NegativeStandardValueGroup { get; set; }
    }
}