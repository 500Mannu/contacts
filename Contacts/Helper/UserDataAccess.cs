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
    public class UserDataAccess
    {
        DbConfig db = new DbConfig();
        SqlConnection con = new SqlConnection();
        Security security = new Security();

        public bool CreateUser(User user)
        {
            bool isCreate = false;
            string password = security.Md5Encryption(user.Password);

            try
            {
                con = db.OpenConnection();

                SqlCommand cmd = new SqlCommand("add_user", con);
                cmd.CommandType = CommandType.StoredProcedure;
                
                cmd.Parameters.AddWithValue("@FirstName", user.FirstName);
                cmd.Parameters.AddWithValue("@LastName", user.LastName);
                cmd.Parameters.AddWithValue("@EmailAddress", user.EmailAddress);
                cmd.Parameters.AddWithValue("@Username", user.Username);
                cmd.Parameters.AddWithValue("@Password", password);

                if (cmd.ExecuteNonQuery() == 1)
                {
                    isCreate = false;
                }
            }
            catch (Exception ex)
            {
                throw;
            }
            finally
            {
                con.Close();
            }

            return isCreate;
        }

        public DataTable Login(Login login)
        {
            bool hasLoggeIn = false;
            string password = security.Md5Encryption(login.Password);
            DataTable dt = new DataTable();

            try
            {
                con = db.OpenConnection();

                SqlCommand cmd = new SqlCommand("user_login", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Username", login.Username);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.ExecuteNonQuery();

                SqlDataAdapter ad = new SqlDataAdapter(cmd);
                
                ad.Fill(dt);

                return dt;
            }
            catch (Exception ex)
            {
                
            }
            finally
            {
                con.Close();
            }

            return dt;
        }

        public User UserSession(bool isLoggedIn, int userId)
        {
            User user = null;

            if (isLoggedIn)
            {
                try
                {
                    con = db.OpenConnection();

                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@UserId", userId);

                    SqlDataReader dr = cmd.ExecuteReader();
                    dr.Read();

                    user.UserId = Convert.ToInt32(dr["UserId"]);
                    user.FirstName = dr["FirstName"].ToString();
                    user.LastName = dr["LastName"].ToString();
                    user.EmailAddress = dr["EmailAddress"].ToString();
                }
                catch (Exception)
                {

                    throw;
                }
                finally
                {
                    con.Close();
                }
            }

            return user;
        }
    }
}