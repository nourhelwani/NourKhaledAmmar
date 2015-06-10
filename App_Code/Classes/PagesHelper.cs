using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for PagesHelper
/// </summary>
public class PagesHelper
{
    Helper MyHelper = new Helper();
	
    public DataSet SelectAllPages()
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteSelectQuery("select * from [PAGES]");
    }
}