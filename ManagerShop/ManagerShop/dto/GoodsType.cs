using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerShop.dto
{

    /**
      
     * 处理有父子关系的商品类型
     
     */
    public class GoodsType
    {

        public int F_CTI_ID { get; set; }  //父级编号
        
        public string  F_CTI_Name { get; set; }

        public CommodityTypeInfo S_C_Type { get; set; }
        
    }
}