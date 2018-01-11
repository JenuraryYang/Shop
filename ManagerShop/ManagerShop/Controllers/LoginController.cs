using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.SessionState;

namespace ManagerShop.Controllers
{
    public class LoginController : Controller,IRequiresSessionState
    {
        //
        // GET: /Login/

        /// <summary>
        /// 登录视图(第一次进入登录页面)
        /// </summary>
        /// <returns></returns>
        /// 
        public ActionResult Login_Index()
        {
            return View();
        }
        /// <summary>
        /// 处理用户登陆输入的信息，并跳转
        /// </summary>
        /// <returns></returns>
        public ActionResult Login_index2(string phone_name, string password)
        {

            shopDBEntities shop = new shopDBEntities();

            AdministratorInfo admin = new AdministratorInfo();

            admin = shop.AdministratorInfo.Where(a => (a.AI_Num == phone_name || a.AI_Name == phone_name) && a.AI_LoginPwd == password).FirstOrDefault();

            if (admin == null)
            {

                return RedirectToAction("Login_Index", "Login");
            }
            else
            {
               //记录头像路径（如果该用户不存在自定义头像,那就设置默认头像）
                if (string.IsNullOrEmpty(admin.AI_HImage))
                {
                    admin.AI_HImage = "head/未知头像.jpg";
                }
                if (Session["LoginInfo"] != null)
                {
                    Session["LoginInfo"] = null;
                }
                Session["LoginInfo"] = admin;
                return RedirectToAction("Index_1", "Mindex");
            }
  
        }

        /// <summary>
        /// 注册
        /// </summary>
        /// <returns></returns>
        public ActionResult Register()
        {
            return View();
        }
        /// <summary>
        /// 用户添加数据zih（处理注册）
        /// </summary>
        /// <returns></returns>
        public ActionResult Register_2(string phone,string pass)
        {

            shopDBEntities shop = new shopDBEntities();



            AdministratorInfo admin = new AdministratorInfo();
            admin.AI_Num = phone;
            admin.AI_LoginPwd = pass;
            admin.AI_Date = DateTime.Now;

            shop.Entry(admin).State = System.Data.EntityState.Added;

            int count = shop.SaveChanges();

            if (count > 0)
            {

                return RedirectToAction("Login_Index", "Login");
            }
            else
            {
                return RedirectToAction("Register", "Login");
             }
        }
        
    }
}
