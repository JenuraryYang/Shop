using ManagerShop.dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ManagerShop.Controllers
{
    public class GoodsTypeController : Controller
    {
        //
        // GET: /GoodsType/

        shopDBEntities shop = new shopDBEntities();

        public ActionResult GoodsTypeSelect()
        {

            //获取父级菜单
            List<CommodityTypeInfo> F_Commodity = new List<CommodityTypeInfo>();

            F_Commodity = shop.CommodityTypeInfo.Where(a => a.CTI_CTI_ID == null).ToList();
            //获取子级菜单

            List<CommodityTypeInfo> S_list = new List<CommodityTypeInfo>();


            S_list = shop.CommodityTypeInfo.Where(a => a.CTI_CTI_ID != null).ToList();

            //foreach (var item in F_Commodity)
            //{
            //    S_list.Add(shop.CommodityTypeInfo.Where(a => a.CTI_CTI_ID == item.CTI_ID).FirstOrDefault()); 
            //}

            ViewBag.F_list = F_Commodity;
            ViewBag.S_list = S_list;
            

            //SCList = GType;
            return View();
        }

        /// <summary>
        /// 新增新类型
        /// </summary>
        /// <returns></returns>

        public ActionResult GoodsTypeInsert()
        {
            
            //获取父级菜单
            List<CommodityTypeInfo> F_Commodity = new List<CommodityTypeInfo>();

            F_Commodity = shop.CommodityTypeInfo.Where(a => a.CTI_CTI_ID == null).ToList();

            ViewBag.F_Select = F_Commodity;


            return View();
        }
        /// <summary>
        /// 处理页面参数
        /// </summary>
        /// <returns></returns>
        public ActionResult GoodsTypeInsert_2(string CTI_Name,string CTI_ID)
        {
            

            if (Convert.ToInt32(CTI_ID) == 0)
            {
                CommodityTypeInfo F_Info = new CommodityTypeInfo();
                F_Info.CTI_Name = CTI_Name;
                F_Info.CTI_CTI_ID=null;
                shop.CommodityTypeInfo.Add(F_Info);

                //shop.Entry(F_Info).State = System.Data.EntityState.Added;
                int count = shop.SaveChanges();

                if (count > 0)
                {
                    return RedirectToAction("GoodsTypeSelect", "GoodsType");
                }
                else
                {
                    string ErrorMsg = "抱歉，新增失败,可以继续~~~";

                    if (Session["ErrorMsg"] != null)
                    {
                        Session["ErrorMsg"] = null;
                    }
                    Session["ErrorMsg"] = ErrorMsg;
                    return RedirectToAction("GoodsTypeError", "GoodsType");
                }
            }
            else
            {
                CommodityTypeInfo S_Info = new CommodityTypeInfo();

                S_Info.CTI_Name = CTI_Name;
                S_Info.CTI_CTI_ID = Convert.ToInt32(CTI_ID);
                shop.CommodityTypeInfo.Add(S_Info);

                //shop.Entry(F_Info).State = System.Data.EntityState.Added;
                int count = shop.SaveChanges();

                if (count > 0)
                {
                    return RedirectToAction("GoodsTypeSelect", "GoodsType");
                }
                else
                {

                    string ErrorMsg = "抱歉，新增失败,可以继续~~~";

                    if (Session["ErrorMsg"] != null)
                    {
                        Session["ErrorMsg"] = null;
                    }
                    Session["ErrorMsg"] = ErrorMsg;
                    return RedirectToAction("GoodsTypeError", "GoodsType");

                }
            }

         }

        public ActionResult GoodsTypeDelete(string needID)
        {
            

            //获取最后一个下标

            int index = needID.LastIndexOf(",");

            string newID = needID.Substring(0, index);

            string[] StrID = newID.Split(',');

            int count = 0;

            for (int i = 0; i < StrID.Length; i++)
            {
                int id = Convert.ToInt32(StrID[i]);

                List<CommodityInfo> Glist = shop.CommodityInfo.Where(a => a.CI_CTI_ID == id).ToList();

                if (Glist.Count > 0)
                {
                    
                    string ErrorMsg = "该类里面存在商品，所以不能删除";

                    if (Session["ErrorMsg"] != null)
                    {
                        Session["ErrorMsg"] = null;
                    }
                    Session["ErrorMsg"] = ErrorMsg;
                    return RedirectToAction("GoodsTypeError", "GoodsType");
                }
                CommodityTypeInfo comm = new CommodityTypeInfo();
                comm.CTI_ID = id;
                shop.Entry(comm).State = System.Data.EntityState.Deleted;
            }
            count = shop.SaveChanges();
            if (count > 0)
            {
                return RedirectToAction("GoodsTypeSelect", "GoodsType");
            }
            else
            {

                string ErrorMsg = "抱歉删除失败了";

                if (Session["ErrorMsg"] != null)
                {
                    Session["ErrorMsg"] = null;
                }
                Session["ErrorMsg"] = ErrorMsg;
                return RedirectToAction("GoodsTypeError", "GoodsType");
            }
            

        }

        public ActionResult GoodsTypeError()
        {

            return View();
        
        }
    }
}
