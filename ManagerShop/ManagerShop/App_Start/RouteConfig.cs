using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace ManagerShop
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}/{name}/{page}",
                defaults: new { controller = "Login", action = "Login_index", id = UrlParameter.Optional, name = UrlParameter.Optional, page = UrlParameter.Optional }
            );
        }
    }
}