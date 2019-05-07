using Contacts.Helper;
using Contacts.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Contacts.Controllers
{
    public class ContactsController : Controller
    {
        ContactDataAccess da = new ContactDataAccess();

        [HttpGet]
        public ActionResult Index()
        {
            ViewBag.contacts = da.GetContact();
            return View();
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Contact contact)
        {
            try
            {
                string extention = Path.GetExtension(contact.Photo.FileName);
                string path = Server.MapPath("\\Files");
                string name = Guid.NewGuid().ToString() + extention;
                string fileName = path + "\\" + name;

                contact.Photo.SaveAs(fileName);

                contact.FileName = name;
                da.CreateContact(contact);
                ViewBag.contacts = da.GetContact();
            }
            catch (Exception ex)
            {
                
            }

            return RedirectToAction("Index");
        }

        public ActionResult Details(int id)
        {
            Contact contact = da.GetDetails(id);
            ViewBag.contacts = da.GetContact();

            return View("Details", contact);
        }

        public ActionResult Update(Contact contact)
        {
            da.Update(contact);
            return RedirectToAction("details/" + contact.ContactId);
        }

        public ActionResult Delete(int id)
        {
            da.Delete(id);

            return RedirectToAction("../contacts");
        }
    }
}