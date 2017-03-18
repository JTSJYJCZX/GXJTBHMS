using GxjtBHMS.Infrastructure.Domain;

namespace GxjtBHMS.Models
{
    internal class UserIsActiveSpecification : CompositeSpecification<User>
    {
        public override bool IsSatisfiedBy(User candidate)
        {
            return candidate.StateId == (int)UserStateEnum.Normal;
        }
    }
}