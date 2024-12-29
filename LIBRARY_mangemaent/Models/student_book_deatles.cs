using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LIBRARY_mangemaent.Models
{
    public class student_book_deatles
    {
        public  int id  { get; set; }
        public  string stuname { get; set; }


        public   string issuedate  { get; set; }
        public string returndate  { get; set; }
        public string type  { get; set; }
        public string bookname  { get; set; }

    }
}