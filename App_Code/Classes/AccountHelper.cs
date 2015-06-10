using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for AcountHelper
/// </summary>
public class AccountHelper
{
    Helper MyHelper = new Helper();
    public DataSet SelectAllAcountType()
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteSelectQuery("select * from ACCOUNT_TYPES");
    }
}