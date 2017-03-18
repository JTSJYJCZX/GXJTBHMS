using System;
using System.Collections.Generic;

namespace GxjtBHMS.Infrastructure.Domain
{
    public interface IReadOnlyRepository<T,TId>
    {
        T GetModel(TId id);
        IEnumerable<T> FindBy(Func<T, bool> p, params string[] navigationProperties);
        IEnumerable<T> FindBy(IList<Func<T, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties);
        IEnumerable<T> FindBy(IList<Func<T, bool>> ps, params string[] navigationProperties);
        IEnumerable<T> FindBy(Func<T, bool> p, int currentPageIndex, int pageSize, params string[] navigationProperties);
        int GetCountByContains(IList<Func<T, bool>> ps,params string[] navigationProperties);
        int GetCountByContains(params string[] navigationProperties);
        IEnumerable<T> FindAll();
    }
}
