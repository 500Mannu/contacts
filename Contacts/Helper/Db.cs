using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace Contacts.Models.Helper
{
    public class Db
    {
        public string ConnectionStr { get; private set; }
        public SqlConnection Connction { get; private set; }

        public Db()
        {
            this.ConnectionStr = WebConfigurationManager.ConnectionStrings["Contact"].ConnectionString;
        }

        private SqlConnection OpenConnection()
        {
            SqlConnection conn = new SqlConnection(ConnectionStr);
            conn.Open();

            return conn;
        }
    }
}