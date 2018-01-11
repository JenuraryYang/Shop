using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerShop.dto
{
    public class OrderGoods
    {
        /// <summary>
        /// 买家编号
        /// </summary>
        public int? BuyID { get; set; }
        /// <summary>
        /// 订单里的商品图
        /// </summary>
        public string GoodsImage { get; set; }
        /// <summary>
        /// 商品名称
        /// </summary>
        public string GoodsName { get; set;}
        /// <summary>
        /// 商品购买数量
        /// </summary>
        public int? BuyNumber { get; set; }
        /// <summary>
        /// 该商品用的钱
        /// </summary>
        public string Price { get; set; }

        public int? TypeID { get; set; }

        /// <summary>
        /// 商品类型名字
        /// </summary>
        public string TypeName { get; set; }
        /// <summary>
        /// 商品类型
        /// </summary>
        public string GoodsType { get; set; }
        /// <summary>
        /// 收件人
        /// </summary>
        public string Getname { get; set; }
        /// <summary>
        /// 收件地址编号
        /// </summary>
        public int? AddressID { get; set; }
        /// <summary>
        /// 状态
        /// </summary>
        public int? IsState { get; set; }
        /// <summary>
        /// 订单编号
        /// </summary>
        public int? OrderID { get; set; }
    }
}