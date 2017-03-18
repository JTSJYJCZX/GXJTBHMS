using System.Collections.Generic;

namespace GxjtBHMS.Models
{
    public class UserState
    {
        public int Id { get; set; }
        public string Description { get; set; }
        public string StateName { get; set; }
        public virtual ICollection<User> Users { get; set; }
    }
}