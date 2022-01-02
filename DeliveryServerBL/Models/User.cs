using System;
using System.Collections.Generic;

#nullable disable

namespace DeliveryServer.ModelsBL
{
    public partial class User
    {
        public User()
        {
            Orders = new HashSet<Order>();
        }

        public int UserId { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Address { get; set; }
        public int PhoneNumber { get; set; }
        public int CreditCard { get; set; }

        public virtual ICollection<Order> Orders { get; set; }
    }
}
