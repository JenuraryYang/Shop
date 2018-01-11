using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerShop.dto
{
    public class OrderUser
    {
        /// <summary>
        /// 买商品的顾客编号（登录编号）
        /// </summary>
        public int?  U_ID { get; set; }
        /// <summary>
        /// 收件人
        /// </summary>
        public string GetName { get; set; }
        /// <summary>
        /// 收件人联系电话
        /// </summary>
        public string  Phone { get; set; }
        /// <summary>
        /// 收货地址
        /// </summary>
        public string Address { get; set; }
        /// <summary>
        /// 详细地址
        /// </summary>
        public string  DetaileAddress { get; set; }

        /// <summary>
        /// 收货状态
        /// </summary>
        public int? IsState { get; set; }
    }
}