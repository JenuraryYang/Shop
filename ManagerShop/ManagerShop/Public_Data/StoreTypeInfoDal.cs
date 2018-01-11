using ManagerShop;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerShop.Public_Data
{
    /// <summary>
    /// 店铺类型操作
    /// 日期：17-10-24
    /// </summary>
    public class StoreTypeInfoDal
    {
        /// <summary>
        /// 添加店铺类型
        /// </summary>
        /// <param name="_name">店铺类型名称</param>
        /// <param name="_remark">店铺类型备注</param>
        /// <returns>是否添加成功 true：添加店铺类型成功，false：添加店铺类型失败</returns>
        public static bool Add(string _name, string _remark)
        {
            //创建一个shopDBEntities对象
            shopDBEntities sde = new shopDBEntities();

            //创建一个StoreType对象
            StoreTypeInfo sti = new StoreTypeInfo() { STI_Name = _name, STI_Remark = _remark };

            //添加
            sde.Entry(sti).State = System.Data.EntityState.Added;

            //提交数据库
            int count = sde.SaveChanges();

            //是否添加成功
            return IsYes(count);
        }

        /// <summary>
        /// 是否执行成功
        /// </summary>
        /// <param name="count">操作受影响的行数</param>
        /// <returns>是否执行成功的执行结果 true：成功，false：失败</returns>
        private static bool IsYes(int count)
        {
            if (count > 0)
                return true;
            return false;
        }

        /// <summary>
        /// 修改商铺类型信息
        /// </summary>
        /// <param name="_id">店铺类型编号</param>
        /// <param name="_name">店铺类型名称</param>
        /// <param name="_remark">是否执行成功 true:成功，false：失败</param>
        public static bool Update(int _id, string _name, string _remark)
        {
            //创建一个shopDBEntities对象
            shopDBEntities sde = new shopDBEntities();

            //修改
            sde.Entry(new StoreTypeInfo() { STI_ID = _id, STI_Name = _name, STI_Remark = _remark }).State = System.Data.EntityState.Modified;

            //提交
            int count = sde.SaveChanges();

            //判断是否成功
            return IsYes(count);
        }

        /// <summary>
        /// 删除店铺类型
        /// </summary>
        /// <param name="_id">店铺类型编号</param>
        /// <returns>是否删除成功  true：删除成功，false：删除失败</returns>
        public static bool Delete(int _id)
        {
            //创建一个shopDBEntities对象
            shopDBEntities sde = new shopDBEntities();

            //删除
            sde.Entry(new StoreTypeInfo() { STI_ID = _id }).State = System.Data.EntityState.Deleted;

            //提交数据库
            int count = sde.SaveChanges();

            return IsYes(count);
        }


        /// <summary>
        /// 查询所有店铺类型信息
        /// </summary>
        /// <returns>所有店铺类型</returns>
        public static List<StoreTypeInfo> Select()
        {
            //创建一个shopDBEntities对象
            shopDBEntities sde = new shopDBEntities();

            //查询所有店铺类型信息
            List<StoreTypeInfo> slis = sde.StoreTypeInfo.Where(a => 1 == 1).ToList();


            //返回查询的全表信息
            return slis;
        }

        /// <summary>
        /// 通过店铺类型编号查询店铺类型信息
        /// </summary>
        /// <param name="_id">店铺类型编号</param>
        /// <returns>店铺类型所有信息</returns>
        public static StoreTypeInfo Select(int _id)
        {
            //创建一个shopDBEntities对象
            shopDBEntities sde = new shopDBEntities();

            //查询
            StoreTypeInfo sti = sde.StoreTypeInfo.Where(a => a.STI_ID == _id).FirstOrDefault();

            //返回查询结果
            return sti;
        }
    }
}