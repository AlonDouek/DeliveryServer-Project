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

        public bool ChangeCredetials(string OGemail,string email, string Password, string UserName, string Address, string PhoneNumber, string CreditCard)
        {
            User user = this.Users.Where(u => u.Email == OGemail).FirstOrDefault();

            if (UserName != null)
                user.Username = UserName;
            if (Address != null)
                user.Address = Address;
            if (PhoneNumber != null)
                user.PhoneNumber = PhoneNumber;
            if (CreditCard != null)
                user.CreditCard = CreditCard;
            if (Password != null)
                user.Password = Password;
            if (email != null)
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
            List<Restaurant> restaurants = this.Restaurants.ToList();
            
            return restaurants;
        }
        public List<Menu> GetMenus()
        {
            List<Menu> Menus = this.Menus.ToList();
            
            return Menus;
        }
        public Menu GetMenu(int RestID)
        {
            Menu m = this.Menus.Where(u => u.RestaurantId == RestID).FirstOrDefault();
            return m;
        }
        public int GetRestaurantID(string Name)
        {
            Restaurant sad = (Restaurant)this.Restaurants.Where(r => r.Name == Name);

            return sad.RestaurantId;
        }
    }
}
