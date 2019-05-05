using Contacts.Models;
using Contacts.Models.Helper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Contacts.Helper
{
    public class DataAccess
    {
        DbConfig dbObj = new DbConfig();

        public SqlCommand Authentication(User user)
        {
            SqlCommand cmd = new SqlCommand();
            //CommandType = CommandType.StoredProcedure;

            return cmd;
        }

        public SqlCommand Register(User user)
        {
            SqlCommand cmd = new SqlCommand();

            return cmd;
        }
    }
}