namespace GxjtBHMS.Web.ViewModels
{
    public class PaginatorModel
    {
        public int CurrentPageIndex { get; set; }
        public int PageSize { get; set; }
        public long TotalCounts { get; set; }
        public long TotalPages { get; set; }
    }
}