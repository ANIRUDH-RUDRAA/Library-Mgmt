using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using LIBRARY_mangemaent.Models;

namespace LIBRARY_mangemaent.Controllers
{
    public class HomeController : Controller
    {
        //this project is built py by anirudh sharma for the  interview perpous on //29 dec 2024 

        /// <summary>
        /// 
        /// </summary>




        Dbcontext1 dbcontext1 = new Dbcontext1();

        /// <summary>
        /// main function 
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            student student = TempData["StudentData"] as student;
            if (student != null)
            {
                // Use the student data in your view, for example, to populate textboxes
                ViewBag.Student = student;
            }
            return View(student);
        }


        /// <summary>
        /// functuin for save data 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Index1(int id)
        {
            student student = new student();
            if (id != 0)
            {
                student = dbcontext1.students.ToList().Where(A => A.id == id).FirstOrDefault();
                TempData["StudentData"] = student;

            }
            return RedirectToAction("Index");
        }

        //function for edit book master 

        public ActionResult edid_book(int id)
        {
            Book student = new Book();
            if (id != 0)
            {
                student = dbcontext1.books.ToList().Where(A => A.id == id).FirstOrDefault();
                TempData["book"] = student;

            }
            return RedirectToAction("Book");
        }


        //function  is  for  book master 
        [HttpPost]
        public ActionResult Index(student student)
        {
            try
            {
                if (student.id == 0)
                {
                    Dbcontext1 dbcontext1 = new Dbcontext1();

                    dbcontext1.students.Add(student);

                    dbcontext1.SaveChanges();

                    return RedirectToAction("Contact");
                }
                else
                {
                    var data = dbcontext1.students.Where(a => a.id == student.id).FirstOrDefault();
                    data.mobile = student.mobile;
                    data.name = student.name;
                    data.Email = student.Email;
                    dbcontext1.SaveChanges();
                    return RedirectToAction("Contact");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);

            }
            return View(student);
        }

        public ActionResult delete_student(student student)
        {
            var studentToRemove = dbcontext1.students.FirstOrDefault(a => a.id == student.id);

            if (studentToRemove != null)
            {

                dbcontext1.students.Remove(studentToRemove);


                dbcontext1.SaveChanges();
            }


            return RedirectToAction("Contact");
        }




        public ActionResult Book()
        {


            Book book = TempData["book"] as Book;


            return View(book);
        }

        //function for  edit book master 
        public ActionResult Book_save_or_edit(Book book)
        {
            try
            {
                if (book.id == 0)
                {
                    dbcontext1.books.Add(book);
                    dbcontext1.SaveChanges();
                    return RedirectToAction("BookList");
                }
                else
                { var data = dbcontext1.books.Where(a => a.id == book.id).FirstOrDefault();
                    data.name = book.name;
                    data.Quantity = book.Quantity;
                    data.bookcode = book.bookcode;
                    dbcontext1.SaveChanges();
                    return RedirectToAction("BookList");
                }

            }

            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            return RedirectToAction("Book");
        }



        //function for  book master  list 
        public ActionResult BookList()
        { Book book = new Book();
          ViewBag.data = dbcontext1.books.ToList();
           return View(ViewBag.data);
        }


        //function for delete  book master 
        public ActionResult delete_Book(Book book)
        {
            var studentToRemove = dbcontext1.books.FirstOrDefault(a => a.id == book.id);

            if (studentToRemove != null)
            {

                dbcontext1.books.Remove(studentToRemove);


                dbcontext1.SaveChanges();
            }


            return RedirectToAction("BookList");
        }

        public ActionResult libraryitemissue()
        {
            return View();
        }

        //function for dropdown bind 
        public JsonResult lidbrarydatafprbind()
        {
            var data = dbcontext1.students.ToList();

            var data2 = dbcontext1.books.ToList();


            return Json(new { data, data2 }, JsonRequestBehavior.AllowGet);
        }


        //function for liobrary item issue 
        public JsonResult save_or_edit(student_book_issue student_Book_Issues)
        {
            DateTime date = DateTime.Now;
            string data = string.Empty;

            if (student_Book_Issues.type == "Return")
            {
                ///return 
                var issueData = dbcontext1.student_Book_Issues.Where(x => x.Student_id == student_Book_Issues.Student_id && x.book_id == student_Book_Issues.book_id && x.return_date == null).FirstOrDefault();
                if (issueData != null)
                {
                    issueData.return_date = DateTime.Now;
                    dbcontext1.SaveChanges();

                    var booktabledata = dbcontext1.books.FirstOrDefault(a => a.id == student_Book_Issues.book_id);
                    if (booktabledata != null)
                    {
                        booktabledata.Quantity = booktabledata.Quantity + 1;
                        dbcontext1.SaveChanges();
                        data = "Data saved ";
                    }
                    else
                        data = "Book data invalid";
                }
                else
                {
                    data = "student hasn't issued this book which he or she want to return.";
                }
            }
            else
            {
                // Issue

                var issueData = dbcontext1.student_Book_Issues.Where(x => x.Student_id == student_Book_Issues.Student_id && x.book_id == student_Book_Issues.book_id && x.return_date == null).FirstOrDefault();
                if (issueData == null)
                {
                    var booktabledata = dbcontext1.books.FirstOrDefault(a => a.id == student_Book_Issues.book_id);
                    if (booktabledata != null)
                    {
                        if (booktabledata.Quantity > 0)
                        {
                            student_Book_Issues.Issue_date = date;
                            student_Book_Issues.return_date = null;
                            dbcontext1.student_Book_Issues.Add(student_Book_Issues);

                            booktabledata.Quantity = booktabledata.Quantity - 1;
                            dbcontext1.SaveChanges();
                            data = "Data saved";
                        }
                        else
                            data = "book stock out";
                    }
                    else
                        data = "Book data invalid";
                }
                else
                {
                    data = "Book has already issued";
                }

            }
            return Json(data, JsonRequestBehavior.AllowGet);
        }



        /// <summary>
        /// functio fro data table 
        /// </summary>
        /// <returns></returns>
        public JsonResult getTbaledata()
        { List<student_book_issue> student_Book_Issues = new List<student_book_issue>();
            student_Book_Issues = dbcontext1.student_Book_Issues.ToList();
            var data = dbcontext1.Database.SqlQuery<bookdata>("exec BookIssueData").ToList();
          return Json(data, JsonRequestBehavior.AllowGet);
        }




        //function for dashbord 
        public ActionResult SelectOprion()
        {
            List<dashbord> dashbord1 = new List<dashbord>();
            dashbord1 = dbcontext1.Database.SqlQuery<dashbord>("exec dashbordproc").ToList();
            return View(dashbord1);
        }


        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }


        /// <summary>
        /// function for book list display 
        /// </summary>
        /// <returns></returns>
        public ActionResult Contact()
        {
            ViewBag.data = dbcontext1.students.ToList();

            return View(ViewBag.data);
        }
    }
}