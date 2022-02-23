using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DeliveryServerBL.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;


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
        public User SignUp(string email, string pswd, string UserName, string Address, string PhoneNumber, string CreditCard) // add the later values when added
        {

            try
            {
                User p = new User()
                {
                    Username = UserName,
                    Email = email,
                    Password = pswd,
                    Address = Address,
                    PhoneNumber = PhoneNumber,
                    CreditCard = CreditCard

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

        public bool ChangeCredetials(string OGemail,string email, string pswd, string UserName, string Address, string PhoneNumber, string CreditCard)
        {
            User user = this.Users.Where(u => u.Email == OGemail).FirstOrDefault();

            if (UserName != "")
                user.Username = UserName;
            if (Address != "")
                user.Address = Address;
            if (PhoneNumber != "")
                user.PhoneNumber = PhoneNumber;
            if (CreditCard != "")
                user.CreditCard = CreditCard;
            if (pswd != "")
                user.Password = pswd;
            if (email != "")
                user.Email = email;

            SaveChanges();
            return true;

        }
        public bool IsExist(string email)
        {
            User u = this.Users.Where(u => u.Email == email).FirstOrDefault();
            return u != null;
        }

        public List<Restaurant> GetRestaurantsList()
        {
            List<Restaurant> restaurants = new List<Restaurant>();
            foreach (Restaurant m in this.Restaurants)
            {
                restaurants.Add(m);
            }
            return restaurants;
        }
    }
}
