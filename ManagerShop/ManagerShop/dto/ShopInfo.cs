using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerShop.dto
{
    public class ShopInfo
    {

        public CommodityInfo Comminfo { get; set; }

        public string CTI_Name { get; set; }

        public string SI_Name { get; set; }

        public  int? CTI_CTI_ID { get; set; }
        
    }
}