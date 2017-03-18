namespace GxjtBHMS.Infrastructure.Domain
{
    internal class NotSpecification<T> : CompositeSpecification<T>
    {
        private CompositeSpecification<T> _innerSpecification;

        public NotSpecification(CompositeSpecification<T> innerSpecification)
        {
            _innerSpecification = innerSpecification;
        }

        public override bool IsSatisfiedBy(T candidate)
        {
            return !_innerSpecification.IsSatisfiedBy(candidate);
        }
    }
}