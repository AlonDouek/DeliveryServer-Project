using DeliveryServerBL.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

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


        [Route("Login")]
        [HttpGet]
        public UserDTO Login([FromQuery] string email, [FromQuery] string pass)
        {
            User u = context.Login(email, pass);
            if (u != null)
            {

                UserDTO uDTO = new UserDTO(u);

                HttpContext.Session.SetObject("theUser", u);

                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;

                return uDTO;
            }
            else
            {

                Response.StatusCode = (int)System.Net.HttpStatusCode.Forbidden;
                return null; 
            }
        }

        [Route("SignUp")]
        [HttpGet]
        public UserDTO SignUp([FromQuery] string firstName, [FromQuery] string lastName, [FromQuery] string email, [FromQuery] string username, [FromQuery] string password)
        {
            UserDTO uDto = HttpContext.Session.GetObject<UserDTO>("user");
            //Check if user logged in!
            if (uDto == null)
            {
               
                User p = context.SignUp(firstName, lastName, email, password);

                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;

                if (p != null)
                    return new UserDTO(p);
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
