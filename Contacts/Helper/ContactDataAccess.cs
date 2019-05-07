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
    public class ContactDataAccess
    {
        DbConfig db = new DbConfig();
        SqlConnection con = new SqlConnection();
        User user = (User)HttpContext.Current.Session["userObj"];

        public bool CreateContact(Contact contact)
        {
            bool isCreated = false;

            try
            {
                con = db.OpenConnection();

                SqlCommand cmd = new SqlCommand("create_contact", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@UserId", user.UserId);
                cmd.Parameters.AddWithValue("@FirstName", contact.FirstName);
                cmd.Parameters.AddWithValue("@LastName", contact.LastName);
                cmd.Parameters.AddWithValue("@DoB", contact.DoB);
                cmd.Parameters.AddWithValue("@Notes", contact.Notes);
                cmd.Parameters.AddWithValue("@Photo", contact.FileName);

                if (cmd.ExecuteNonQuery() == 1)
                {
                    isCreated = true;

                    SqlDataReader dr = cmd.ExecuteReader();
                    dr.Read();

                    int contactId = Convert.ToInt32(dr["ContactId"]);

                    dr.Close();

                    //create phone contact
                    contact.Phone.ContactId = contactId;
                    contact.Phone.PhoneType = 1;

                    SqlCommand phoneCmd = new SqlCommand("create_phone_contact", con);
                    phoneCmd.CommandType = CommandType.StoredProcedure;

                    phoneCmd.Parameters.AddWithValue("@ContactId", contact.Phone.ContactId);
                    phoneCmd.Parameters.AddWithValue("@PhoneType", contact.Phone.PhoneType);
                    phoneCmd.Parameters.AddWithValue("@Phone", contact.Phone.Phone);

                    phoneCmd.ExecuteNonQuery();

                    //create email contact
                    contact.Email.ContactId = contactId;
                    contact.Email.EmailType = 1;

                    SqlCommand emailCmd = new SqlCommand("create_email_address", con);
                    emailCmd.CommandType = CommandType.StoredProcedure;

                    emailCmd.Parameters.AddWithValue("@ContactId", contact.Email.ContactId);
                    emailCmd.Parameters.AddWithValue("@EmailType", contact.Email.EmailType);
                    emailCmd.Parameters.AddWithValue("@EmailAddress", contact.Email.Email);

                    emailCmd.ExecuteNonQuery();
                    
                }
            }
            catch (Exception ex)
            {
                isCreated = true;
            }
            finally
            {
                con.Close();
            }

            return isCreated;
        }

        public List<Contact> GetContact()
        {
            List<Contact> contacts = new List<Contact>();
            List<EmailAddress> email = EmailList();
            List<PhoneContact> phone = PhoneList();

            try
            {
                SqlCommand cmd = new SqlCommand("get_contacts", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserId", user.UserId);

                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    int contactId = Convert.ToInt32(dr["ContactId"]);
                    contacts.Add(new Contact()
                    {
                        ContactId = contactId,
                        FirstName = dr["FirstName"].ToString(),
                        LastName = dr["LastName"].ToString(),
                        DoB = dr["DoB"].ToString(),
                        Notes = dr["Notes"].ToString(),
                        FileName = dr["Photo"].ToString(),
                        Email = email.Where(c => c.ContactId == contactId).FirstOrDefault(),
                        Phone = phone.Where(p =>  p.ContactId == contactId).FirstOrDefault()
                    });
                }

                dr.Close();
            }
            catch (Exception ex)
            {

                //throw;
            }

            return contacts;
        }

        public List<EmailAddress> EmailList()
        {
            con = db.OpenConnection();

            //get emails
            SqlCommand emailCmd = new SqlCommand("get_contact_email", con);
            emailCmd.CommandType = CommandType.StoredProcedure;

            SqlDataReader emailDr = emailCmd.ExecuteReader();
            List<EmailAddress> email = new List<EmailAddress>();

            while (emailDr.Read())
            {
                email.Add(new EmailAddress()
                {
                    ContactId = Convert.ToInt32(emailDr["ContactId"]),
                    Email = emailDr["EmailAddress"].ToString(),
                    EmailType = Convert.ToInt32(emailDr["EmailType"]),
                });
            }

            emailDr.Close();

            return email;
        }

        public List<PhoneContact> PhoneList()
        {
            con = db.OpenConnection();

            //get emails
            SqlCommand cmd = new SqlCommand("get_phone_details", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataReader dr = cmd.ExecuteReader();
            List<PhoneContact> phone = new List<PhoneContact>();

            while (dr.Read())
            {
                phone.Add(new PhoneContact()
                {
                    ContactId = Convert.ToInt32(dr["ContactId"]),
                    Phone = dr["Phone"].ToString(),
                    PhoneType = Convert.ToInt32(dr["PhoneType"]),
                });
            }

            dr.Close();

            return phone;
        }

        public Contact GetDetails(int id)
        {
            Contact contact = new Contact();
            List<EmailAddress> emails = EmailList();
            List<PhoneContact> phone = PhoneList();

            try
            {
                con = db.OpenConnection();

                SqlCommand cmd = new SqlCommand("get_contact_details", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ContactId", id);

                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    contact.ContactId = Convert.ToInt32(dr["ContactId"]);
                    contact.FirstName = dr["FirstName"].ToString();
                    contact.LastName = dr["LastName"].ToString();
                    contact.DoB = dr["DoB"].ToString();
                    contact.Notes = dr["Notes"].ToString();
                    contact.FileName = dr["Photo"].ToString();
                    contact.Email = emails.Where(e => e.ContactId == id).FirstOrDefault();
                    contact.Phone = phone.Where(p => p.ContactId == id).FirstOrDefault(); 
                }
            }
            catch (Exception ex)
            {
                
            }
            finally
            {
                con.Close();
            }

            return contact;
        }

        public void Delete(int id)
        {
            try
            {
                con = db.OpenConnection();

                SqlCommand cmd = new SqlCommand("delete_contact", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@contactId", id);

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                
            }
            finally
            {
                con.Close();
            }
        }

        public void Update(Contact contact)
        {
            try
            {
                con = db.OpenConnection();

                SqlCommand cmd = new SqlCommand("update_contact", con);
                cmd.CommandType = CommandType.StoredProcedure;

                string firstName = contact.FirstName == null ? "" : contact.FirstName;
                string lastName = contact.LastName == null ? "" : contact.LastName;
                string dob = contact.DoB == null ? "" : contact.DoB;
                string email = contact.Email.Email == null ? "" : contact.Email.Email;
                string phone = contact.Phone.Phone == null ? "" : contact.Phone.Phone;
                string notes = contact.Notes == null ? "" : contact.Notes;

                cmd.Parameters.AddWithValue("@ContactId", contact.ContactId);
                cmd.Parameters.AddWithValue("@FirstName", firstName);
                cmd.Parameters.AddWithValue("@LastName", lastName);
                cmd.Parameters.AddWithValue("@DoB", dob);
                cmd.Parameters.AddWithValue("@EmailAddress", email);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.AddWithValue("@Notes", notes);

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {

            }
            finally
            {
                con.Close();
            }
        }
    }
}