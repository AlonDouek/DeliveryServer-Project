using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DeliveryServer.DTO;
using DeliveryServerBL.Models;
using System.IO;
using System.Collections;
using DeliveryApp.DTO;
using Newtonsoft.Json;

namespace DeliveryServer.Controllers
{
    [Route("DeliveryAPI")]
    [ApiController]
    public class DeliveryController : ControllerBase
    {
        #region Add connection to the db context using dependency injection
        DeliveryDBContext context;
        public DeliveryController(DeliveryDBContext context)
        {
            this.context = context;
        }
        #endregion

        //do the thing in the config to make it work
        //<binding protocol = "http" bindingInformation="*:16340:127.0.0.1" />
        //<binding protocol = "https" bindingInformation="*:44323:127.0.0.1" />



        [Route("Login")]
        [HttpGet]
        public User Login([FromQuery] string email, [FromQuery] string pass)
        {
            User user = context.Login(email, pass);
            string a ="4";
            if (user != null)
            {
                HttpContext.Session.SetObject("theUser", user);
                
                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;

                return user;
            }
            else
            {

                Response.StatusCode = (int)System.Net.HttpStatusCode.Forbidden;
                return null;
            }
        }


      

        [Route("SignUp")]
        [HttpPost]
        public bool SignUp([FromBody] User user)
        {
            
            if (this.context.IsExist(user.Email))
                return false;
            else
            {
                this.context.Users.Add(user);
                this.context.SaveChanges();
                return true;
            }
        }

       

        [Route("ChangeCredentials")]
        [HttpGet]
        public bool ChangeCredentials([FromQuery] string CUEmail, [FromQuery] string Email, [FromQuery] string Password, [FromQuery] string Username, [FromQuery] string Address, [FromQuery] string CreditCard, [FromQuery] string PhoneNumber)
        { 
            if (!(this.context.IsExist(CUEmail)))
                return false;
            else
            {
                this.context.ChangeCredetials(CUEmail, Email, Password, Username, Address, PhoneNumber, CreditCard);
                this.context.SaveChanges();
                return true;
            }
            
        }


        [Route("getRestaurants")]
        [HttpGet]
        public string GetResList()
        {
            List<Restaurant> restaurants = context.GetRestaurantsList();
            try
            {
                JsonSerializerSettings options = new JsonSerializerSettings
                {
                    PreserveReferencesHandling = PreserveReferencesHandling.All
                };

                string json = JsonConvert.SerializeObject(restaurants , options);

                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
                return json;
            }
            catch(Exception e)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.InternalServerError;
                return null;
            }
        }

        [Route("getMenus")]
        [HttpGet]
        public string GetMenuList()
        {
            List<Menu> Menus = context.GetMenusList();
            try
            {
                JsonSerializerSettings options = new JsonSerializerSettings
                {
                    PreserveReferencesHandling = PreserveReferencesHandling.All
                };

                string json = JsonConvert.SerializeObject(Menus, options);

                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
                return json;
            }
            catch (Exception e)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.InternalServerError;
                return null;
            }
        }


    }
}
