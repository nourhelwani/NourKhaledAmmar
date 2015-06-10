using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

public class CategoriesHelper
{
    Helper myHelper;
	public CategoriesHelper()
	{
        myHelper = new Helper();
    }

    public DataSet SelectAllSubCategories(int GenreID)
    {
        return myHelper.ExcuteSelectQuery("select * from [CATEGORIES] where GENER_ID="+GenreID);
    }
    public void EditCateById(int CatId, string NewDesc)
    {
        myHelper.OpenConnection();
        myHelper.ExcuteNonQuary("update [CATEGORIES] set [DESCRIPTION]='" + NewDesc + "' where CATEGORY_ID='" + CatId + "';");
    }
    public void AddCategory(int Gener_ID, string Desc)
    {
        myHelper.OpenConnection();
        myHelper.ExcuteNonQuary("insert into [CATEGORIES]  (GENER_ID,DESCRIPTION) VALUES ('" + Gener_ID + "','" + Desc + "');");
    }
    public void DeleteCateById(int CateId)
    {
        myHelper.OpenConnection();
        myHelper.ExcuteNonQuary("delete from CATEGORIES where CATEGORY_ID ='" + CateId + "';");
    }
}