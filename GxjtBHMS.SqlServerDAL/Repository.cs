using GxjtBHMS.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;


namespace GxjtBHMS.SqlServerDAL
{
    public abstract class Repository<T, TId> where T : EntityBase<TId>
    {
        /// <summary>
        /// 循环处理条件
        /// </summary>
        /// <param name="ps">条件委托数组</param>
        /// <param name="result">数据源</param>
        /// <returns>数据源</returns>
        protected IEnumerable<T> DealWithConditions(IList<Func<T, bool>> ps, IEnumerable<T> result)
        {
            if (ps != null && ps.Count > 0)
            {
                foreach (var item in ps)
                {
                    result = result.Where(item);
                }
            }
            return result;
        }

        protected IQueryable<T> DealWithNavigationPropertys(string[] navigationPropertys, IQueryable<T> source)
        {
            if (navigationPropertys != null && navigationPropertys.Length > 0)
            {
                foreach (var item in navigationPropertys)
                {
                    source = source.Include(item);
                }
            }
            return source;
        }

        public virtual int GetCountByContains(IList<Func<T, bool>> ps, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = ctx.Set<T>();
                var query = DealWithNavigationPropertys(navigationProperties, source);
                var result = DealWithConditions(ps, query);
                return result.Count();
            }
        }

        public virtual int GetCountByContains(params string[] navigationProperties)
        {
            return GetCountByContains(null, navigationProperties);
        }

        public void Add(T newOne)
        {
            using (var ctx = new BHMSContext())
            {
                ctx.Set<T>().Add(newOne);
                ctx.SaveChanges();
            }
        }

        public void Save(T model)
        {
            using (var ctx = new BHMSContext())
            {
                ctx.Entry(model).State = EntityState.Modified;
                ctx.SaveChanges();
            }
        }

        public T GetModel(TId id)
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.Set<T>().Find(id);
            }
        }

        public void Remove(T entity)
        {
            using (var ctx = new BHMSContext())
            {
                ctx.Entry(entity).State = EntityState.Deleted;
                ctx.SaveChanges();
            }
        }

        public virtual IEnumerable<T> FindBy(Func<T, bool> p, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            if (p != null)
            {
                return FindBy(new Func<T, bool>[] { p }, currentPageIndex, pageSize, navigationProperties);
            }
            return FindBy(new Func<T, bool>[] { }, currentPageIndex, pageSize, navigationProperties);
        }

        public virtual IEnumerable<T> FindBy(IList<Func<T, bool>> ps, int currentPageIndex, int pageSize, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.Set<T>());//处理导航属性

                var result = DealWithConditions(ps.ToArray(), source);//处理条件筛选

                return result
                    .OrderBy(m => m.Id)
                    .Skip((currentPageIndex - 1) * pageSize)
                    .Take(pageSize)
                    .ToList(); //排序、分页
            }
        }

        public virtual IEnumerable<T> FindBy(IList<Func<T, bool>> ps, params string[] navigationProperties)
        {
            using (var ctx = new BHMSContext())
            {
                var source = DealWithNavigationPropertys(navigationProperties, ctx.Set<T>());//处理导航属性

                var result = DealWithConditions(ps.ToArray(), source);//处理条件筛选

                return result
                    .OrderBy(m => m.Id)
                    .ToList(); //排序、分页
            }
        }


        public virtual IEnumerable<T> FindBy(Func<T, bool> p = null, params string[] navigationProperties)
        {

            using (var ctx = new BHMSContext())
            {
                var result = DealWithNavigationPropertys(navigationProperties, ctx.Set<T>());
                return p == null ? result.ToList() : result.Where(p).ToList();
            }
        }

        public virtual IEnumerable<T> FindAll()
        {
            using (var ctx = new BHMSContext())
            {
                return ctx.Set<T>().ToList();
            }
        }
    }
}
