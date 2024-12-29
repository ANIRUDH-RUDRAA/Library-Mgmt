using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace LIBRARY_mangemaent.Models
{
    public class student
    {
        [Key]
        public int id { get; set; }

        public String name { get; set; }

        public String Email { get; set; }

        public String mobile { get; set; }


    }
}