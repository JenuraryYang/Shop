using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace DAL
{
    public class DBhelper
    {
        //获取链接字符串
        public static string strconnn = System.Configuration.ConfigurationManager.ConnectionStrings["conn"].ToString();


        public static DataSet GetDate(string procname,params SqlParameter[] p)
        {
            return new DataSet();
        }

    }
}
