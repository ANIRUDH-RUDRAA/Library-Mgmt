using System.Web;
using System.Web.Mvc;

namespace LIBRARY_mangemaent
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
