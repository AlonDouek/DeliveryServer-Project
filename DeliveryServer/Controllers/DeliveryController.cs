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
    }
}
