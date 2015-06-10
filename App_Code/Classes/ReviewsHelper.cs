using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for ReviewsHelper
/// </summary>
public class ReviewsHelper
{
    Helper myHelper = new Helper();
    public DataSet GetAllCommentsByMarkerId(int MarkerID)
    {
        myHelper.OpenConnection();
        return myHelper.ExcuteSelectQuery("select * from REVIEWS where MARKER_ID='"+MarkerID+"'");
    }
    public string InsertNewReview(REVIEW myReview)
    {
        myHelper.OpenConnection();
        return myHelper.ExcuteNonQuary("insert into REVIEWS (MARKER_ID,DESCRIPTION,EMAIL) values ('" + myReview.MARKER_ID + "','" + myReview.DESCRIPTION + "','" + myReview.EMAIL + "')");
    }
	
}