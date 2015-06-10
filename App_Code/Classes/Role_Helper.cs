using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for Role_Helper
/// </summary>
public class Role_Helper
{
    Helper HP = new Helper();
	public DataSet SelectAllRole()
    {
        HP.OpenConnection();
        return HP.ExcuteSelectQuery("select * from [ROLES]");
    }
    public DataSet SelectRoleAdmin()
    {
        HP.OpenConnection();
        return HP.ExcuteSelectQuery("select * from [ROLES] where [ROLE_ID] in (1,4,5)");
    }
   
}