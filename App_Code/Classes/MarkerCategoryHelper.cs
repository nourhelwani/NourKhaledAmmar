using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class MarkerCategoryHelper
{
    Helper myHelper;
    public MarkerCategoryHelper()
	{
        myHelper = new Helper();
	}

    public string AddRecord(MARKERS_CATEGORy toAdd)
    {
        myHelper.OpenConnection();
        return myHelper.ExcuteNonQuary("insert into [MARKERS_CATEGORIES] (MARKER_ID,CATEGORY_ID) values(" + toAdd.MARKER_ID + "," + toAdd.CATEGORY_ID + ")");
    }
}