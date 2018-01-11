using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ManagerShop;
using ManagerShop.Modelst;

namespace ManagerShop.Public_Data
{
    /// <summary>
    /// 店铺操作
    /// 日期：17-10-24
    /// </summary>
    public class StoreInfoDal
    {
        /// <summary>
        /// 添加店铺
        /// </summary>
        /// <param name="_id">店主编号</param>
        /// <param name="_tid">店铺类型编号</param>
        /// <param name="_name">店铺名称</param>
        /// <param name="_logo">店铺标志图片</param>
        /// <param name="_intro">店铺描述</param>
        /// <param name="_remark">店铺备注</param>
        /// <returns>true：添加店铺成功，false：添加店铺失败</returns>
        public static bool Add(int _id, int _tid, string _name, string _logo, string _intro, string _remark)
        {
            //创建一个shopDBEntities对象
            shopDBEntities sde = new shopDBEntities();

            //创建一个店铺信息对象
            StoreInfo si = new StoreInfo()
            {
                SI_AI_ID = _id,
                SI_STI_ID = _tid,
                SI_CreateDate = DateTime.Now,
                SI_Intro = _intro,
                SI_Logo = _logo,
                SI_Name = _name,
                SI_Remark = _remark
            };

            //添加
            sde.Entry(si).State = System.Data.EntityState.Added;

            //提交
            int count = sde.SaveChanges();


            return IsYes(count);
        }

        /// <summary>
        /// 删除店铺
        /// </summary>
        /// <param name="_id">店铺编号</param>
        /// <returns>true：删除成功，false：删除失败</returns>
        public static bool Delete(int _id)
        {
            //创建一个shopDBEntities对象
            shopDBEntities sde = new shopDBEntities();

            //删除
            sde.Entry(new StoreInfo() { SI_ID = _id }).State = System.Data.EntityState.Deleted;

            //提交结果
            return IsYes(sde.SaveChanges());
        }

        /// <summary>
        /// 修改店铺信息
        /// </summary>
        /// <param name="_id">店铺编号</param>
        /// <param name="uid">店主编号</param>
        /// <param name="_tid">店铺类型编号</param>
        /// <param name="_name">店铺名称</param>
        /// <param name="_logo">店铺标志图片</param>
        /// <param name="_intro">店铺描述</param>
        /// <param name="remark">店铺备注</param>
        /// <returns>true：修改成功，false：修改失败</returns>
        public static bool Update(int _id, int uid, int _tid, string _name, string _logo, string _intro, string remark)
        {
            //创建一个店铺对象
            StoreInfo si = new StoreInfo()
            {
                SI_ID = _id,
                SI_AI_ID = uid,
                SI_STI_ID = _tid,
                SI_Logo = _logo,
                SI_Name = _name,
                SI_Intro = _intro,
                SI_Remark = remark
            };

            //创建一个shopDBEntities对象
            shopDBEntities sde = new shopDBEntities();

            //修改
            sde.Entry(si).State = System.Data.EntityState.Modified;

            //提交
            return IsYes(sde.SaveChanges());
        }


        /// <summary>
        /// 通过店铺编号查询店铺信息
        /// </summary>
        /// <param name="_id">店铺编号</param>
        /// <returns>店铺信息</returns>
        public static StoreInfo Select(int _id)
        {
            //创建一个shopDBEntities对象
            shopDBEntities sde = new shopDBEntities();

            //查询
            return sde.StoreInfo.Where(a => a.SI_ID == _id).FirstOrDefault();
        }

        /// <summary>
        /// 通过用户编号尝试查询店铺信息
        /// </summary>
        /// <param name="uid">用户编号哦</param>
        /// <returns>查询的店铺结果</returns>
        public static StoreInfo Select_u(int uid)
        {
            //创建一个shopDBEntities对象
            shopDBEntities sde = new shopDBEntities();

            //查询
            return sde.StoreInfo.Where(a => a.SI_AI_ID == uid).FirstOrDefault();
        }

        /// <summary>
        /// 查询所有店铺信息
        /// </summary>
        /// <returns></returns>
        public static List<StoreInfo> Select()
        {
            //创建一个shopDBEntities对象
            shopDBEntities sde = new shopDBEntities();

            return sde.StoreInfo.Where(a => 1 == 1).ToList();
        }

        /// <summary>
        /// 查询所有店铺信息
        /// </summary>
        /// <returns></returns>
        public static List<StoreInfo_AdministratorInfo_StoreTypeInfo> Select_u()
        {
            //创建一个shopDBEntities对象
            shopDBEntities sde = new shopDBEntities();

            //链表查询店铺信息
            return sde.StoreInfo.GroupJoin(sde.AdministratorInfo, a => a.SI_AI_ID, b => b.AI_ID, (x, y) => new
            {
                c = x,
                d = y
            }).SelectMany(a => a.d.DefaultIfEmpty(), (c, d) => new
            {
                e = c.c,
                f = d
            }).GroupJoin(sde.StoreTypeInfo, a => a.e.SI_STI_ID, b => b.STI_ID, (e, f) => new
            {
                g = e.e,
                h = e.f,
                i = f
            }).SelectMany(a => a.i.DefaultIfEmpty(), (j, k) => new StoreInfo_AdministratorInfo_StoreTypeInfo()
            {
                AI_ID = j.h.AI_ID,
                AI_Alipay = j.h.AI_Alipay,
                AI_Balance = j.h.AI_Balance,
                AI_Date = j.h.AI_Date,
                AI_HImage = j.h.AI_HImage,
                AI_IDCard = j.h.AI_IDCard,
                AI_LoginPwd = j.h.AI_LoginPwd,
                AI_Name = j.h.AI_Name,
                AI_Num = j.h.AI_Num,
                AI_Sex = j.h.AI_Sex,
                AI_Type = j.h.AI_Type,
                AI_Type_c = AI_Type(j.h.AI_Type??-1),
                SI_CreateDate = j.g.SI_CreateDate,
                SI_ID = j.g.SI_ID,
                SI_Intro = j.g.SI_Intro,
                SI_Logo = j.g.SI_Logo,
                SI_Name = j.g.SI_Name,
                SI_Remark = j.g.SI_Remark,
                STI_ID = k.STI_ID,
                STI_Name = k.STI_Name,
                STI_Remark = k.STI_Remark
            }).ToList();
        }

        /// <summary>
        /// 帐号类型查询
        /// </summary>
        /// <param name="_tid"></param>
        /// <returns></returns>
        private static string AI_Type(int _tid)
        {
            switch (_tid)
            {
                case 0:
                    return "管理员";
                case 1:
                    return "店主";
                case 2:
                    return "客服";
                default:
                    return "";
            }
        }


        /// <summary>
        /// 操作结果
        /// </summary>
        /// <param name="count">操作中受影响的行数</param>
        /// <returns>是否执行成功 true：成功 ，false：失败</returns>
        private static bool IsYes(int count)
        {
            if (count > 0)
                return true;
            return false;
        }
    }
}