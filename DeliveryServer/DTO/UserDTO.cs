
using DeliveryServerBL.Models;
using System;
using System.Collections.Generic;

#nullable disable

namespace DeliveryServer.DTO
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
        public String PhoneNumber { get; set; }
        public String CreditCard { get; set; }

        public virtual ICollection<Order> Orders { get; set; }

        public UserDTO(User u)
        {
            this.Email = u.Email;
            this.Username = u.Username;
            this.Password = u.Password;
            this.Address = u.Address;
            this.PhoneNumber = u.PhoneNumber;
            this.CreditCard = u.CreditCard;

        }
    }
}
