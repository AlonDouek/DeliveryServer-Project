using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace DeliveryServerBL.Models
{
    public partial class DeliveryDBContext : DbContext
    {
        public User Login(string email, string pswd)
        {
            User user = this.Users.Where(u => u.Email == email && u.UserPswd == pswd).FirstOrDefault();
            //
            return user;
        }
        public User SignUp(string email, string pswd, string lName, string fname) // add the later values when added
        {

            try
            {
                User p = new User()
                {
                    FirstName = fname,
                    LastName = lName,
                    Email = email,
                    UserPswd = pswd
                };

                this.Add(p);
                this.SaveChanges();

                return p;
            }
            catch
            {
                return null;
            }

        
        }
    }
}
