using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Contacts.Models.Helper
{
    public class DataAccess
    {
        Db dbObj = new Db();

        public SqlCommand UserAuthentication()
        {
            SqlCommand cmd = new SqlCommand();
            //CommandType = CommandType.StoredProcedure;

            return cmd;
        }
    }
}