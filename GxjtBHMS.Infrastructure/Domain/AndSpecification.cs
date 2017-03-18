namespace GxjtBHMS.Infrastructure.Domain
{
    internal class AndSpecification<T> : CompositeSpecification<T>
    {
        CompositeSpecification<T> _leftSpecification;
        ISpecification<T> _rightSpecification;

        public AndSpecification(CompositeSpecification<T> leftSpecification, ISpecification<T> rightSpecification)
        {
            _leftSpecification = leftSpecification;
            _rightSpecification = rightSpecification;
        }

        public override bool IsSatisfiedBy(T candidate)
        {
            return _leftSpecification.IsSatisfiedBy(candidate) && _rightSpecification.IsSatisfiedBy(candidate);
        }
    }
}