using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Contacts.Models
{
    public class PhoneContact
    {
        public int PhoneContactId { get; set; }
        public int ContactId { get; set; }
        public int PhoneType { get; set; }
        public string Phone { get; set; }
    }
}