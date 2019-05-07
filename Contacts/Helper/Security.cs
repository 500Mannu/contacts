using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Contacts.Helper
{
    public class Security
    {
        public string Md5Encryption(string value)
        {
            byte[] data;

            //Create a new instance of MD5CryptoServiceProvider object
            MD5CryptoServiceProvider objMd5Hash = new MD5CryptoServiceProvider();

            //Create a new Stringbuilder to collect the bytes and create a string
            StringBuilder objStringBuilder = new StringBuilder();

            try
            {
                //Convert the input string to a byte array and compute the hash.
                data = objMd5Hash.ComputeHash(Encoding.Default.GetBytes(value));

                //Loop through each byte of the hashed data and format each one as hexadecimal string
                for (int i = 0; i < data.Length; i++)
                {
                    objStringBuilder.Append(data[i].ToString("x2"));
                }
            }
            catch (Exception ex)
            {
                
            }

            return objStringBuilder.ToString();
        }
    }
}