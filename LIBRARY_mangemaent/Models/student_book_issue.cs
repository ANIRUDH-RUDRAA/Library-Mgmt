using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LIBRARY_mangemaent.Models
{
    public class student_book_issue
    {

        ///id	Student_id	Issue_date	return_date	type 
        ///


        public int id { get; set; }
        public int Student_id { get; set; }
        public int book_id { get; set; }
        public DateTime Issue_date { get; set; }
        public DateTime ?return_date { get; set; }

        public string type { get; set; }






    }
}