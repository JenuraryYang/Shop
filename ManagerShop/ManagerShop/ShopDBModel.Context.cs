﻿//------------------------------------------------------------------------------
// <auto-generated>
//    此代码是根据模板生成的。
//
//    手动更改此文件可能会导致应用程序中发生异常行为。
//    如果重新生成代码，则将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace ManagerShop
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class shopDBEntities : DbContext
    {
        public shopDBEntities()
            : base("name=shopDBEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<AdministratorInfo> AdministratorInfo { get; set; }
        public DbSet<ActivityInfo> ActivityInfo { get; set; }
        public DbSet<BuyerInfo> BuyerInfo { get; set; }
        public DbSet<CollectGoodsInfo> CollectGoodsInfo { get; set; }
        public DbSet<CommodityInfo> CommodityInfo { get; set; }
        public DbSet<CommodityTypeInfo> CommodityTypeInfo { get; set; }
        public DbSet<CouponInfo> CouponInfo { get; set; }
        public DbSet<FootprintInfo> FootprintInfo { get; set; }
        public DbSet<MyAddressInfo> MyAddressInfo { get; set; }
        public DbSet<OrderFormInfo> OrderFormInfo { get; set; }
        public DbSet<ReckoningInfo> ReckoningInfo { get; set; }
        public DbSet<ShopCartInfo> ShopCartInfo { get; set; }
        public DbSet<StoreInfo> StoreInfo { get; set; }
        public DbSet<StoreTypeInfo> StoreTypeInfo { get; set; }
        public DbSet<Express> Express { get; set; }
        public DbSet<Dic_OrderFormInfo_OFI_States1> Dic_OrderFormInfo_OFI_States1集 { get; set; }
    }
}
