using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace Contacts.Models.Helper
{
    public class DbConfig
    {
        public string ConnectionStr { get; private set; }
        public SqlConnection Connction { get; private set; }

        public DbConfig()
        {
            this.ConnectionStr = WebConfigurationManager.ConnectionStrings["Contact"].ConnectionString;
        }

        public SqlConnection OpenConnection()
        {
            SqlConnection conn = new SqlConnection(ConnectionStr);
            conn.Open();

            return conn;
        }
    }
}