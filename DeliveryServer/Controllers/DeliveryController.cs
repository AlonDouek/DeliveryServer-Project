using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DeliveryServer.DTO;
using DeliveryServerBL.Models;
using System.IO;


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
        //<binding protocol="http" bindingInformation="*:16340:127.0.0.1" />
        //<binding protocol = "https" bindingInformation="*:44323:127.0.0.1" />

        #region d
        //[Route("Login")]
        //[HttpPost]
        //public User Login([FromBody] LogInDTO logInDTO)
        //{
        //    string email = logInDTO.Email;
        //    string pass = logInDTO.Password;
        //    User u = context.Login(email, pass);
        //    if (u != null)
        //    {
        //        HttpContext.Session.SetObject("theUser", u);

        //        Response.StatusCode = (int)System.Net.HttpStatusCode.OK;

        //        return u;
        //    }
        //    else
        //    {

        //        Response.StatusCode = (int)System.Net.HttpStatusCode.Forbidden;
        //        return null;
        //    }
        //}
        #endregion

        [Route("Login")]
        [HttpGet]
        public User Login([FromQuery] string email, [FromQuery] string pass)
        {
            User user = context.Login(email, pass);

            //Check user name and password
            if (user != null)
            {
                HttpContext.Session.SetObject("theUser", user);

                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;

                //Important! Due to the Lazy Loading, the user will be returned with all of its contects!!
                return user;
            }
            else
            {

                Response.StatusCode = (int)System.Net.HttpStatusCode.Forbidden;
                return null;
            }
        }

        [Route("SignUp")]
        [HttpGet]
        public User SignUp([FromQuery] string Username, [FromQuery] string password, [FromQuery] string email, [FromQuery] string Address, [FromQuery] string PhoneNumber, [FromQuery] string CreditCard)
        {
            User uDto = HttpContext.Session.GetObject<User>("user");

            if (uDto == null)
            {
               
                User p = context.SignUp(Username, email, password, Address, PhoneNumber, CreditCard);

                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;

                if (p != null)
                    return new User(p);
                else
                    return null;
            }
            else
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.Forbidden;
                return null;
            }
        }

        [Route("ChangeInfo")]
        [HttpGet]
        public void ChangeInfo([FromQuery] string email)
        {

        }

    }
}
