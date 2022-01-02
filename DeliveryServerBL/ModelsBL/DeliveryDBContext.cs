using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DeliveryServer.ModelsBL;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using DeliveryServerBL.Models;

namespace DeliveryServerBL.Models
{
    public partial class DeliveryDBContext : DbContext
    {
        public User Login(string email, string pswd)
        {
            User user = this.Users.Where(u => u.Email == email && u.Password == pswd).FirstOrDefault();
            //
            return user;
        }
        public User SignUp(string email, string pswd, string UserName) // add the later values when added
        {

            try
            {
                User p = new User()
                {
                    Username = UserName,
                    Email = email,
                    Password = pswd
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
