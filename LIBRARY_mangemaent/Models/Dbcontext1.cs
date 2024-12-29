using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Linq;
using System.Web;

namespace LIBRARY_mangemaent.Models
{
    public class Dbcontext1 : DbContext
    
    {
        public Dbcontext1() : base("Library_management")
        {
        }
        public DbSet<student> students { get; set; }
        public DbSet<Book> books { get; set;  }

        public DbSet<student_book_issue> student_Book_Issues{ get; set; } 


        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
          
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();
            base.OnModelCreating(modelBuilder);
        } 






    }
}