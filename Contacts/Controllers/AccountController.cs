using Contacts.Helper;
using Contacts.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Contacts.Controllers
{
    public class AccountController : Controller
    {
        UserDataAccess da = new UserDataAccess();

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(Login login)
        {
            User user = da.Login(login);

            if (user != null)
            {
                //get loggedin user object
                Session["userObj"] = user;

                return RedirectToAction("../contacts");
            }
            else
            {
                return View("Index", login);
            }
        }

        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("../account");
        }

        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(User user)
        {
            if (da.CreateUser(user) == true)
            {
                return RedirectToAction("../account");
            }

            return View(user);
        }
    }
}
