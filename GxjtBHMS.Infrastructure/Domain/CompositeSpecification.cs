﻿namespace GxjtBHMS.Infrastructure.Domain
{
    public abstract class CompositeSpecification<T> : ISpecification<T>
    {
        public ISpecification<T> And(ISpecification<T> other)
        {
            return new AndSpecification<T>(this, other);
        }

        public abstract bool IsSatisfiedBy(T candidate);

        public ISpecification<T> Not()
        {
            return new NotSpecification<T>(this);
        }
    }
}
