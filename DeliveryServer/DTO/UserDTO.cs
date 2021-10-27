using System;
using System.Collections.Generic;

#nullable disable

namespace DeliveryServerBL.Models
{
    public partial class UserDTO
    {
        public int Id { get; set; }
        public string Email { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string UserPswd { get; set; }

        public UserDTO()
        {
        }

        public UserDTO(User p)
        {
            Id = p.Id;
            LastName = p.LastName;
            FirstName = p.FirstName;
            Email = p.Email;
            UserPswd = p.UserPswd;
        }



    }
}
