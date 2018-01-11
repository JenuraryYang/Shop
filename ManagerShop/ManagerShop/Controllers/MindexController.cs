using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using ManagerShop.dto;
using Newtonsoft.Json;

namespace ManagerShop.Controllers
{
    public class MindexController : Controller
    {
        //
        // GET: /Mindex/

        public ActionResult Index()
        {

           

            return View();
        }

        public ActionResult Index_1(string CI_CTI_ID, string CI_Name, string NowPage)
        {

            //进入首页（显示商品信息）
            shopDBEntities shop = new shopDBEntities();


            //获取店铺名称

            List<StoreInfo> STlist = new List<StoreInfo>();

            STlist = shop.StoreInfo.ToList();

            ViewData["Slist"] = STlist;
            //获取全部(父级)商品类型

            List<CommodityTypeInfo> CtList = new List<CommodityTypeInfo>();
            CtList = shop.CommodityTypeInfo.Where(a=>a.CTI_CTI_ID==null).ToList();

            ViewData["CtList"] = CtList;

            //链接查询

            if(string.IsNullOrEmpty(CI_CTI_ID))
            {
             CI_CTI_ID="0";
            }
            
            //这儿是查询全部商品信息
            var Sinfo = shop.CommodityInfo.Join(shop.CommodityTypeInfo, a => a.CI_CTI_ID, b => b.CTI_ID, (x, y) => new
              {
                  Comminfo = x,
                  CTI_Name = y.CTI_Name,
                  CTI_ID=y.CTI_CTI_ID
              }).Join(shop.StoreInfo, a => a.Comminfo.CI_SI_ID, b => b.SI_ID, (m, n) => new ShopInfo() {
              
                  Comminfo=m.Comminfo,
                  CTI_Name=m.CTI_Name,
                  SI_Name=n.SI_Name,
                  CTI_CTI_ID=m.CTI_ID

              });

            //当前页

            if (string.IsNullOrEmpty(NowPage))
            {
                NowPage = "1";
            }

            int page = Convert.ToInt32(NowPage);
          

            //获取商品类型

            ViewBag.GoodsType = CI_CTI_ID;

            int id = Convert.ToInt32(CI_CTI_ID);
            //这儿进行筛选（根据前台传过来的标识）

           

            var Sinfo1 = Sinfo.Where(a => (a.Comminfo.CI_CTI_ID == id || id == 0)&& (a.Comminfo.CI_Name == "%" + CI_Name+ "%" || CI_Name == null));

      
           //获取总行数

           int allcount = Sinfo1.ToList().Count();

           if (allcount == 0)
           {
               Sinfo1 = Sinfo.Where(a => a.CTI_CTI_ID == id && (a.Comminfo.CI_Name == "%" + CI_Name + "%" || CI_Name == null));

               allcount = Sinfo1.ToList().Count();
            }

           var Sinfo2 = Sinfo1.OrderBy(a => a.Comminfo.CI_ID).Skip((page - 1) * 5).Take(5);

           List<ShopInfo> Slist = Sinfo2.ToList();

           int allpage = allcount / 5;

           if (allcount % 5 != 0)
           {
               allpage++;
           }
           ViewBag.AllPage = allpage;

           //记录当前页

           ViewBag.NowPage = page;

           return View(Slist);
        }
        /// <summary>
        /// index_1的更新数据
        /// </summary>
        /// <returns></returns>
        public ActionResult Index_1_flush(CommodityInfo Cinfo)
        {
            shopDBEntities shop = new shopDBEntities();
            Cinfo.CI_NowPrice = (Convert.ToDouble(Cinfo.CI_Discount) * Convert.ToInt32(Cinfo.CI_Price)).ToString();

            var update = shop.Entry(Cinfo);

            update.State = System.Data.EntityState.Unchanged;
           
            update.Property("CI_Name").IsModified = true;
            update.Property("CI_CTI_ID").IsModified = true;
            update.Property("CI_Num").IsModified = true;
            update.Property("CI_Discount").IsModified = true;
            update.Property("CI_Price").IsModified = true;
            update.Property("CI_NowPrice").IsModified = true;
            update.Property("CI_Is").IsModified = true;
            update.Property("CI_SI_ID").IsModified = true;

            int count = shop.SaveChanges();
            if (count > 0)
            {
                return RedirectToAction("Index_1", "Mindex");
            }
            else
            {
                Response.Write("<script>alert('抱歉更新失败了')</script>");
                return RedirectToAction("Index_1", "Mindex");
            }
            
        }
        /// <summary>
        /// 删除数据
        /// </summary>
        /// <param name="goodsid">商品编号</param>
        /// <returns>首页路径</returns>
        public ActionResult Index_1_delete(string goodsid)
        {

            CommodityInfo commodity = new CommodityInfo();

            commodity.CI_ID = Convert.ToInt32(goodsid);

            shopDBEntities shop = new shopDBEntities();

            //shop.CommodityInfo.Remove(commodity);

            shop.Entry(commodity).State = System.Data.EntityState.Deleted;

            int count = shop.SaveChanges();
            if (count > 0)
            {
                return RedirectToAction("Index_1", "Mindex");
            }
            else
            {
                Response.Write("<script>alert('删除失败，请再次选择！！')</script>");
                return RedirectToAction("Index_1", "Mindex");
            }

           
        }

        /// <summary>
        /// 添加商品InsertGoods
        /// </summary>
        /// <returns></returns>
        public ActionResult Index_2()
        {



            //进入首页（显示商品信息）
            shopDBEntities shop = new shopDBEntities();


            //获取全部店铺名称

            List<StoreInfo> STlist = new List<StoreInfo>();

            STlist = shop.StoreInfo.ToList();

            ViewData["Slist"] = STlist;

            //获取全部商品类型

            List<CommodityTypeInfo> CtList = new List<CommodityTypeInfo>();
            CtList = shop.CommodityTypeInfo.Where(a=>a.CTI_CTI_ID!=null).ToList();

            ViewData["CtList"] = CtList;

            return View();
        }
        /// <summary>
        /// 店主添加商品处理
        /// </summary>
        /// <param name="commodity"></param>
        /// <returns></returns>
        public ActionResult Index_2_Insert(CommodityInfo commodity)
        {
            //int number = Request.Files.Count;

            //处理文件

            string name = Request.Files[0].FileName;

            if (string.IsNullOrEmpty(name))
            {
                name = "default.png";
            }

            //截取后缀

            int index = name.LastIndexOf(".");

            string houz = name.Substring(index+1);

            //判断
            if (houz.ToLower() != "png" && houz.ToLower() != "jpg" && houz.ToLower() != "ico" && houz.ToLower() != "gif")
            {
                Response.Write("<script>alert('文件格式不是图片格式')</script>");
                return RedirectToAction("Index_2", "Mindex");
            }
            //让用户在指定的文件夹里面选择图片，不需要再重新分配地址

            commodity.CI_Url = "IMG/"+ name;

            commodity.CI_SalesNum = 0;

            commodity.CI_NowPrice =(Convert.ToDouble(commodity.CI_Discount) * Convert.ToInt32(commodity.CI_Price)).ToString();

            shopDBEntities shop = new shopDBEntities();

            var insert= shop.Entry(commodity);
            insert.State = System.Data.EntityState.Added;

            int count = shop.SaveChanges();

            if (count > 0)
            {
                return RedirectToAction("Index_1", "Mindex");
            }
            else
            {
                Response.Write("<script>alert('抱歉新添商品失败')</script>");
                return RedirectToAction("Index_2", "Mindex");
            }
            
          
        }
        /// <summary>
        /// 完善注册用户的详细信息(第一次进入)
        /// </summary>
        /// <returns></returns>
        public ActionResult Register_Information()
        {

           

            return View();
        }
        /// <summary>
        /// 父级编号
        /// </summary>
        /// <returns>返回子类型json</returns>
        public JsonResult SonType(int CTI_ID)
        {
            shopDBEntities shop=new shopDBEntities();

            List<CommodityTypeInfo> Clist = shop.CommodityTypeInfo.Where(a=>a.CTI_CTI_ID==CTI_ID).ToList();

            //转换成json 字符串

            string strjson = JsonConvert.SerializeObject(Clist);

            return Json(strjson,JsonRequestBehavior.AllowGet);

        }

        /// <summary>
        /// 处理信息录入
        /// </summary>
        /// <returns></returns>
        public ActionResult Register_Information2(AdministratorInfo admin)
        {
            shopDBEntities shop=new shopDBEntities();


            if (Session["Name"] == null||Session["Name"].ToString()=="")
            {
                AdministratorInfo admin2 = shop.AdministratorInfo.Where(a => a.AI_Name == admin.AI_Name).FirstOrDefault();

                if (admin2 != null)
                {
                    Response.Write("<script>alert('该用户名已被他人所用')</script>");
                    return View("Register_Information");
                }
            }
                //获取文件的完整路径
                string name = Request.Files[0].FileName;
                if (string.IsNullOrEmpty(name))
                {
                    name = "a6.jpg";
                }
                //获取下标（.）
                int index = name.LastIndexOf(".");
                //截取字符串
                string behind = name.Substring(index + 1);
                //判断是否是满足图片格式
                if (behind.ToLower() != "gif" && behind.ToLower() != "png" && behind.ToLower() != "jpg" && behind.ToLower() != "ico")
                {
                    Response.Write("<script>alert('文件格式不满足图片格式！！！')</script>");
                    return View("Register_Information");
                }
                ////随机生成一段字符串
                //string filename = Guid.NewGuid().ToString();
                //生成完整路径（获取项目路经）
                string allname = Server.MapPath("~");

            //用 用户名作为头像的路径

                //图片另存为
                Request.Files[0].SaveAs(allname+"/Needs/head/"+admin.AI_Name+"." + behind);
                //根据用户输入的信息去完善用户数据库
                //(d第一步：先去获取要修改的用户(赋值))
            
            

            AdministratorInfo admininfo = shop.AdministratorInfo.Where(a=>a.AI_LoginPwd==admin.AI_LoginPwd&&a.AI_Num==admin.AI_Num).FirstOrDefault();
            admininfo.AI_Name = admin.AI_Name;
            admininfo.AI_Sex = admin.AI_Sex;
            admininfo.AI_Type = admin.AI_Type;
            admininfo.AI_Date = DateTime.Now;
            admininfo.AI_IDCard = admin.AI_IDCard;
            admininfo.AI_Alipay = admin.AI_Alipay;
            admininfo.AI_HImage = admin.AI_Name + "." + behind;
            
            int count = count = shop.SaveChanges();
            //try
            //{
            //    admininfo.AI_Name = admin.AI_Name;
            //    admininfo.AI_Sex = admin.AI_Sex;
            //    admininfo.AI_Type = admin.AI_Type;
            //    admininfo.AI_Date = DateTime.Now;
            //    admininfo.AI_IDCard = admin.AI_IDCard;
            //    admininfo.AI_Alipay = admin.AI_Alipay;
            //    admininfo.AI_HImage = filename + "." + behind;

            //    count = shop.SaveChanges();
            //}
            //catch (System.Data.Entity.Validation.DbEntityValidationException db)
            //{

            //    var msg = string.Empty;
            //    var errors = (from u in db.EntityValidationErrors select u.ValidationErrors).ToList();
            //    foreach (var item in errors)
            //        msg += item.FirstOrDefault().ErrorMessage;
                
            //}

           

            

            if (count > 0)
            {
                return RedirectToAction("Index_1", "Mindex");
            }
            else
            {
                Response.Write("对不起，信息录入失败？？");

                return View("Register_Information");
            }

        }

        /// <summary>
        /// 点击之后，查看信息
        /// </summary>
        /// <returns></returns>
        public ActionResult SeeMy_Information()
        {
            return View();
        }
        /// <summary>
        /// 上传商品图片
        /// </summary>
        /// <returns></returns>
        public ActionResult GoodsIMGUpload()
        {

            shopDBEntities shop=new shopDBEntities();

            //绑定下拉框
            List<CommodityTypeInfo> Slist = shop.CommodityTypeInfo.Where(a => a.CTI_CTI_ID == null).ToList();

            return View(Slist);
        }

        public JsonResult SaveIMG(string fileurl)
        {

            //获取绝对路径
            string URL=Request.MapPath("~");

            int count = 0;
            //判断是否有上传的文件
            if (Request.Files.Count > 0)
            {
                //遍历
                for (int i = 0; i < Request.Files.Count; i++)
                {

                    string filename = Request.Files[i].FileName;
                    //获取fileurl中文件。判断是否存在同名的文件
                    //StreamReader reader = new StreamReader(URL + "/" + fileurl);

                    string purl=URL + "Needs/img/IMG/" + fileurl;

                    //图片保存

                    string newurl = URL + "Needs/img/IMG/" + fileurl+"/" + filename;

                    Request.Files[i].SaveAs(newurl);

                }
                count = 1;
            }


            return Json(count);
        }

    }
}
