namespace GxjtBHMS.Infrastructure.Domain
{
    public interface ISpecification<T>
    {
        bool IsSatisfiedBy(T candiate);
        ISpecification<T> And(ISpecification<T> other);
        ISpecification<T> Not();
    }
}
