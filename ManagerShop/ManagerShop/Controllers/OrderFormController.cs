using ManagerShop.dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;


namespace ManagerShop.Controllers
{
    public class OrderFormController : Controller
    {
        //
        // GET: /OrderForm/
        //

        shopDBEntities shop = new shopDBEntities();
       /// <summary>
        /// 全部订单信息（根据订单状态和搜索条件）
       /// </summary>
       /// <returns></returns>
        public ActionResult OrderFormInfo(string IsState,string conditions)
        {

            
            //订单编号（订单表），收件人（地址表）， 联系电话，收件人地址，订单金额（商品表），派送方式
            //订单表  有卖家编号=>联系地址表  获取收件人，联系电话，地址 还有商品编号 获取商品现价 

           List<OrderInfo> OList = new List<OrderInfo>();

           OList = GetList();

            int? IS=Convert.ToInt32(IsState);
            if (string.IsNullOrEmpty(IsState)||IsState=="no")
            {
                IS = null;
            }
            if (conditions == "")
                conditions = null;
            //判断前台输入的条件（Conditions）
            List<OrderInfo> OrderList = null;
    
                long phone =0;

                try
                {
                    phone = Convert.ToInt64(conditions);

                    string Phone = phone.ToString();

                    OrderList = OList.Where(a => (a.IsState == IS || IsState == null) && (a.Phone == Phone || conditions == null)).ToList();
                }
                catch (Exception)
                {

                    OrderList = OList.Where(a => (a.IsState == IS || IsState == null) && (a.GetName == conditions || conditions == null)).ToList();
                }
            return View(OrderList);
        }

        /// <summary>
        /// 订单详情(个人订单的详细信息)
        /// </summary>
        public ActionResult OrderDetailInfo(string getname)
        {

            //第一步（绑定下拉框）

            List<string> Ulsit = new List<string>();
            //ef查询
            var User = GetAllOrderUser();

           var  v = User.GroupBy(a => a.GetName).Select(a => new {
             GetName=a.Key
            });

           Ulsit = v.Select(a => a.GetName).ToList();
            ViewBag.Ulist = Ulsit; //绑定下拉框去除重复的收件人名字

            //绑定快递信息Div
            List<Express> Elist = shop.Express.ToList();

            ViewBag.Elist = Elist;

            List<OrderUser> UserList = User.ToList();

            if (string.IsNullOrEmpty(getname))
            {
                getname = null;
            }

            OrderUser OUser=UserList.Where(a=>a.GetName==getname||getname==null).First();

            ViewBag.OneUser = OUser; //显示下拉框选择的收件人的详细信息
            //获取该买家全部商品信息
            List<OrderGoods> Glist = new List<OrderGoods>();

            
            //获取买家买的商品信息
            var goods = shop.OrderFormInfo.Join(shop.CommodityInfo, a => a.OFI_CI_ID, b => b.CI_ID, (x, y) => new OrderGoods()
            {
                BuyID=x.OFI_BI_ID,
                GoodsImage=y.CI_Url,
                GoodsName=y.CI_Name,
                TypeID=y.CI_CTI_ID,
                BuyNumber=x.OFI_Number,
                Price=y.CI_NowPrice,
                AddressID=x.OFI_SAI_ID,
                IsState=x.OFI_States,
                OrderID=x.OFI_ID
            }).ToList();
            //获取商品类型
         Glist = goods.Join(shop.CommodityTypeInfo, a => a.TypeID, b => b.CTI_ID, (x, y) => new OrderGoods()
            {
                BuyID=x.BuyID,
                GoodsImage = x.GoodsImage,
                GoodsName = x.GoodsName,
                TypeID = x.TypeID,
                TypeName=y.CTI_Name,
                BuyNumber = x.BuyNumber,
                Price = x.Price,
                GoodsType = y.CTI_Name,
                AddressID=x.AddressID,
                IsState=x.IsState,
                OrderID = x.OrderID
            }).ToList();

            //这儿获取收件人姓名

      var   GNameList = Glist.Join(shop.MyAddressInfo, a => a.AddressID, b => b.MAI_ID, (x, y) => new OrderGoods()
             {
                 BuyID = x.BuyID,
                 GoodsName = x.GoodsName,
                 GoodsImage=x.GoodsImage,
                 TypeID = x.TypeID,
                 TypeName=x.TypeName,
                 BuyNumber = x.BuyNumber,
                 Price = x.Price,
                 GoodsType = x.GoodsType,
                 Getname = y.MAI_Name,
                 IsState=x.IsState,
                 OrderID = x.OrderID
             }).ToList();

      if (string.IsNullOrEmpty(getname))
      {
          getname = OUser.GetName;
      }

      List<OrderGoods> GLIST = GNameList.Where(a => a.Getname == getname).ToList();

            
            return View(GLIST);
        }
        /// <summary>
        /// 确认订单
        /// </summary>
        /// <param name="orderid"></param>
        public void Decise_Order(string orderid, int? express_id)
        {

            int count = 0;

           //解析字符串转换成多个int值
            if (orderid.Contains(','))
            {
                string[] order_ID = orderid.Split(',');
                for (int i = 0; i < orderid.Length; i++)
                {
                    int? id = Convert.ToInt32(order_ID[i]);
                    //修改该订单的状态
                    OrderFormInfo order = shop.OrderFormInfo.Where(a => a.OFI_ID == id).FirstOrDefault();

                    order.OFI_States = 2;

                    if (!string.IsNullOrEmpty(express_id.ToString()))
                    {
                        order.Express_ID = express_id;
                    }
                    count = shop.SaveChanges();
                }
            }
            else
            {
                int? idS = Convert.ToInt32(orderid);
                //修改该订单的状态
                OrderFormInfo order = shop.OrderFormInfo.Where(a => a.OFI_ID == idS).FirstOrDefault();

                order.OFI_States = 2;

                if (!string.IsNullOrEmpty(express_id.ToString()))
                {
                    order.Express_ID = express_id;
                }
                count = shop.SaveChanges();
            }
            Response.Write(count);

        }

        public List<OrderInfo> GetList()
        { 
        
            List<OrderInfo>  Olist=new List<OrderInfo>();

            var need = shop.OrderFormInfo.Join(shop.MyAddressInfo, a => a.OFI_SAI_ID, b => b.MAI_ID, (x, y) => new
            {

                MyOrder = x,
                Myadddress = y

            }).Join(shop.CommodityInfo, a => a.MyOrder.OFI_CI_ID, b => b.CI_ID, (x, y) => new OrderInfo()
            {

                OFI_ID = x.MyOrder.OFI_ID,
                OFI_Number = x.MyOrder.OFI_Number,
                GetName = x.Myadddress.MAI_Name,
                GoodsName = y.CI_Name,
                FullAddress = x.Myadddress.MAI_Province + x.Myadddress.MAI_City + x.Myadddress.MAI_County + x.Myadddress.MAI_Town + x.Myadddress.MAI_MinuteAddress,
                Phone = x.Myadddress.MAI_Phone,
                IsState = x.MyOrder.OFI_States,
                NowPrice = y.CI_NowPrice,
                CI_Image=y.CI_Url,
                CTI_ID=y.CI_CTI_ID
            });

            Olist = need.ToList();

            return Olist;

        }

        /// <summary>
        /// 获取全部的收件人信息
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        public IQueryable<OrderUser> GetAllOrderUser()
        {
            //顾客没有填写地址而是选择默认地址的信息（判断顾客选择的是哪个默认地址）
            IQueryable<OrderUser> Iuser = shop.OrderFormInfo.Join(shop.MyAddressInfo, a => a.OFI_SAI_ID, b => b.MAI_ID, (x, y) => new OrderUser()
            {
                U_ID = x.OFI_BI_ID,
                GetName = y.MAI_Name,
                Address = y.MAI_Province,
                DetaileAddress = y.MAI_City + y.MAI_County + y.MAI_Town + y.MAI_MinuteAddress,
                Phone = y.MAI_Phone,
                IsState = x.OFI_States
            });
            return Iuser;
        }
        /// <summary>
        /// 修改订单信息
        /// </summary>
        /// <param name="strjson">前台返回的json对象</param>
        public void Update_order(string strjson)
        {

            //反序列化（将json字符串转换成对象）
            Update_OrderInfo U_Order = new Update_OrderInfo();
            U_Order = JsonConvert.DeserializeObject<Update_OrderInfo>(strjson);
            
            //修改数据库
            //得到订单编号
            int orderid = Convert.ToInt32(U_Order.OFI_ID);

            //修改订单信息
            OrderFormInfo Order_update= shop.OrderFormInfo.Where(a => a.OFI_ID == orderid).FirstOrDefault();

            Order_update.OFI_Number = Convert.ToInt32(U_Order.OFI_Number);
            Order_update.OFI_States = Convert.ToInt32(U_Order.IsState);


            //修改默认地址信息

            MyAddressInfo Address_Update = shop.MyAddressInfo.Where(a=>a.MAI_ID==Order_update.OFI_SAI_ID).FirstOrDefault();

            Address_Update.MAI_Name = U_Order.GetName;
            Address_Update.MAI_Phone = U_Order.Phone;

            int count = shop.SaveChanges();

            if (count > 0)
            {
                Response.Write("success");
            }
            else
            {
                Response.Write("fail");
            }
        }

        public void Delete_Order(string orderid)
        {

            int count = 0;

            if (orderid.Contains(','))
            {
                string[] str_id = orderid.Split(',');
                for (int i = 0; i < str_id.Length; i++)
                {
                    int ids = Convert.ToInt32(str_id[i]);

                    OrderFormInfo order = new OrderFormInfo() { OFI_ID = ids };

                    shop.Entry(order).State = System.Data.EntityState.Deleted;
                    count = shop.SaveChanges();
                }
            }
            else
            {

                int id = Convert.ToInt32(orderid);

                OrderFormInfo order = new OrderFormInfo() { OFI_ID = id };

                shop.Entry(order).State = System.Data.EntityState.Deleted;
                count = shop.SaveChanges();
            }

            Response.Write(count);

        }
    }
}
