//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class CouponInfo
    {
        public int CPI_ID { get; set; }
        public string CPI_Type { get; set; }
        public string CPI_MaxMoney { get; set; }
        public string CPI_MinusMoney { get; set; }
        public Nullable<int> CPI_CouponType { get; set; }
        public Nullable<int> CPI_CI_ID { get; set; }
        public Nullable<System.DateTime> CPI_BeginDate { get; set; }
        public Nullable<System.DateTime> CPI_EndDate { get; set; }
        public Nullable<int> CPI_IS { get; set; }
    }
}
