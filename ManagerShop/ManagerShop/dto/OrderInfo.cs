using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerShop.dto
{
    public class OrderInfo
    {
        public int OFI_ID { get; set; }

        public int? OFI_Number { get; set; }

        public string GetName { get; set; }

        public string NowPrice { get; set; }

        public string FullAddress { get; set; }

        public string Phone { get; set; }

        public string CI_Image { get; set; }

        public int? CTI_ID { get; set; }

        public string CTI_Type { get; set; }

        public string GoodsName { get; set; }

        public int? IsState { get; set; }

    }
}