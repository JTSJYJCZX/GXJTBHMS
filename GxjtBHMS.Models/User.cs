using GxjtBHMS.Infrastructure.Domain;

namespace GxjtBHMS.Models
{
    public class User: EntityBase<int>
    {
        ISpecification<User> _userIsActiveSpecification = new UserIsActiveSpecification();
        public string UserName { get; set; }
        public string Password { get; set; }
        public virtual UserState State { get; set; }
        public int StateId { get; set; }

        public bool IsActive()
        {
            return _userIsActiveSpecification.IsSatisfiedBy(this);
        }
    }

    public enum UserStateEnum
    {
        Normal = 1,
        Suspended
    }
}
