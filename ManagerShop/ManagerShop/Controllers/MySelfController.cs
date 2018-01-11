using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;

namespace ManagerShop.Controllers
{
    public class MySelfController : Controller
    {
        //
        // GET: /MySelf/

        shopDBEntities shop = new shopDBEntities();

        public ActionResult Index_Information()
        {



            AdministratorInfo admin = Session["LoginInfo"] as AdministratorInfo;

            if (Session["url"] == null)
            {
                Session["url"] = admin.AI_HImage;
            }

            admin = shop.AdministratorInfo.Where(a => a.AI_Num == admin.AI_Num && a.AI_LoginPwd == admin.AI_LoginPwd).FirstOrDefault();
            

            return View(admin);
        }


        public ActionResult UpLoad()
        {

            string img = Request.Files[0].FileName;

            int count= Request.Files.Count;

            //获取图片的路径
            int lindex = img.LastIndexOf("\\");

            string filename = img.Substring(lindex + 1);

            //判断后缀是否满足

            string behind = filename.Substring(filename.IndexOf(".") + 1);

            if (behind.ToLower() != "jpg" && behind.ToLower() != "png" && behind.ToLower() != "jpeg" && behind.ToLower() != "gif")
            {
                Response.Write("<script>alert('头像格式不正确！！！')</script>");
                Response.End();
            }
            //另存为
            //F:\新购物宝\ManagerShop\ManagerShop\Needs\head
            string url = Server.MapPath("~");

            string file = url + @"Needs\head\" + filename;

            Request.Files[0].SaveAs(file);

            if (Session["url"] != null)
            {
                Session["url"] = null;
            }
            Session["url"] = "head/"+filename;

            return RedirectToAction("Index_Information");

        }

        public ActionResult SaveInfo(AdministratorInfo admin)
        {

            AdministratorInfo AdminInfo = shop.AdministratorInfo.Where(a => a.AI_Num == admin.AI_Num).FirstOrDefault();
            //判断用户没有选择性别时默认选中保密
            if (string.IsNullOrEmpty(admin.AI_Sex))
            {
                admin.AI_Sex = "2";
            }

            //判断用户没有选择注册类型时默认选中店主
            if (admin.AI_Type==null)
            {
                admin.AI_Type = 1;
            }
            AdminInfo.AI_Sex = admin.AI_Sex;
            AdminInfo.AI_IDCard = admin.AI_IDCard;
            AdminInfo.AI_Name = admin.AI_Name;
            AdminInfo.AI_Type = admin.AI_Type;
            AdminInfo.AI_Alipay = admin.AI_Alipay;
            AdminInfo.AI_HImage = Session["url"].ToString();

            int count = shop.SaveChanges();
            if (count > 0)
            {
                Session["LoginInfo"] = AdminInfo;
            }
            return RedirectToAction("Index_Information");
        }


        public ActionResult Update_PWD()
        {

            AdministratorInfo admin = Session["LoginInfo"] as AdministratorInfo;

            AdministratorInfo adminInfo = shop.AdministratorInfo.Where(a => a.AI_Num == admin.AI_Num).FirstOrDefault();

            ViewBag.Number = adminInfo.AI_Num;
            ViewBag.Pwd = adminInfo.AI_LoginPwd;

            return View();
        }
        public void Update_Behave(string AI_Num, string AI_LoginPwd)
        {
            AdministratorInfo admin = shop.AdministratorInfo.Where(a => a.AI_Num == "13271941321").FirstOrDefault();
            int count = 0;
            if (admin.AI_LoginPwd == AI_LoginPwd)
            {
                count += 1;
            }
            admin.AI_LoginPwd = AI_LoginPwd;
            count += shop.SaveChanges();
            if (count > 0)
            {
                Response.Write("1");
            }
            else
            {
                Response.Write("0");
            }

       
        }
    }
}
