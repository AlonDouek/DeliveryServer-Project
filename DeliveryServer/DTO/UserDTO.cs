using System;
using System.Collections.Generic;

#nullable disable

namespace DeliveryServer.ModelsBL
{
    public partial class UserDTO
    {
        public UserDTO()
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

        public UserDTO(User p)
        {
            UserId = p.UserId;
            Username = p.Username;
            Email = p.Email;
            Password = p.Password;
        }
    }
}
