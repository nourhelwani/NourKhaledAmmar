using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for PageRoles_Helper
/// </summary>
public class PageRoles_Helper
{
    Helper MyHelper = new Helper();
    public DataSet GetPageByRoleId(int ID)
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteSelectQuery("select PAGES.*,ROLES_PAGES.*from PAGES,ROLES_PAGES where ROLES_PAGES.PAGE_ID=PAGES.PAGE_ID and ROLES_PAGES.ROLE_ID='" + ID + "';");
    }
}