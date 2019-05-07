using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Contacts.Models
{
    public class Contact
    {
        public int ContactId { get; set; }

        [Required]
        [Display(Name = "First name")]
        public string FirstName { get; set; }

        [Required]
        [Display(Name = "Last name")]
        public string LastName { get; set; }

        [Required]
        [Display(Name = "Date of birth")]
        public string DoB { get; set; }

        [Required]
        [Display(Name = "Notes")]
        public string Notes { get; set; }

        [Required]
        [Display(Name = "Notes")]
        public HttpPostedFileBase Photo { get; set; }

        public EmailAddress Email { get; set; }

        public PhoneContact Phone { get; set; }

        public List<EmailAddress> EmailList { get; set; }

        public List<PhoneContact> PhoneList { get; set; }

        [Required]
        public string FileName { get; set; }
    }
}