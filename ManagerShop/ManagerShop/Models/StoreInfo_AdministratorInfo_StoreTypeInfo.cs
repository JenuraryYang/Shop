using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerShop.Modelst
{
    public class StoreInfo_AdministratorInfo_StoreTypeInfo
    {
        public int SI_ID { get; set; }//店铺编号
        public string SI_Name { get; set; }//店铺名称
        public string SI_Logo { get; set; }//店铺logo
        public string SI_Intro { get; set; }//店铺描述
        public Nullable<System.DateTime> SI_CreateDate { get; set; }//店铺创建日期
        public string SI_Remark { get; set; }//店铺备注

        public int AI_ID { get; set; }//管理员编号
        public string AI_HImage { get; set; }//头像
        public string AI_Num { get; set; }//手机号
        public string AI_LoginPwd { get; set; }//登录密码
        public string AI_Name { get; set; }//姓名
        public string AI_Sex { get; set; }//性别
        public string AI_IDCard { get; set; }//身份证号
        public string AI_Alipay { get; set; }//支付包
        public string AI_Balance { get; set; }//账户余额
        public Nullable<int> AI_Type { get; set; }//账户类型
        public string AI_Type_c { get; set; }//账户类型
        public Nullable<System.DateTime> AI_Date { get; set; }//账户创建日期

        public int STI_ID { get; set; }//店铺类型编号
        public string STI_Name { get; set; }//店铺类型名称
        public string STI_Remark { get; set; }//店铺类型备注
    }
}