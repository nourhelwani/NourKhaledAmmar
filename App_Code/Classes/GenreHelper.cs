using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

public class GenreHelper
{
    Helper helper;
    public GenreHelper()
    {
        helper = new Helper();
    }

    public DataSet SelectAllGeners()
    {
        return helper.ExcuteSelectQuery("select * from [GENERS]");
    }
    public void UpdateGener(int ID, string GenerName)
    {
        helper.OpenConnection();
        helper.ExcuteNonQuary("update [GENERS] set [DESCRIPTION] = '" + GenerName + "' where GENER_ID='" + ID + "';");
    }
    public void AddGener(string GenerName)
    {
        helper.OpenConnection();
        helper.ExcuteNonQuary("insert into [GENERS] (DESCRIPTION)values('" + GenerName + "')");
    }
    public string DeleteGenerById(int GenerId)
    {
        helper.OpenConnection();
        helper.ExcuteNonQuary("delete from CATEGORIES where GENER_ID='" + GenerId + "'");
        return helper.ExcuteNonQuary("delete from GENERS where GENER_ID='" + GenerId + "';");
    }
}