using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Contacts.Models
{
    public class EmailAddress
    {
        public int EmailAddressId { get; set; }

        public int ContactId { get; set; }

        public int EmailType { get; set; }

        public string Email { get; set; }
    }
}