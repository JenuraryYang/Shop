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
    
    public partial class ReckoningInfo
    {
        public int RI_ID { get; set; }
        public Nullable<int> RI_BI_ID { get; set; }
        public Nullable<int> RI_CI_ID { get; set; }
        public Nullable<int> RI_CPI_ID { get; set; }
        public string RI_Amount { get; set; }
        public Nullable<int> RI_States { get; set; }
        public Nullable<System.DateTime> RI_TransactionDate { get; set; }
        public string RI_Remark { get; set; }
    }
}