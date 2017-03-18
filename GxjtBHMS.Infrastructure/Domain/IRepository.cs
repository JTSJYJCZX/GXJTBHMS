namespace GxjtBHMS.Infrastructure.Domain
{
    public interface IRepository<T>
    {
        void Save(T entity);
        void Add(T entity);
        void Remove(T entity);
    }
}
