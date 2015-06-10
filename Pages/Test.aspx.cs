using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Services;

public partial class Pages_Serilization : System.Web.UI.Page
{
    static PostsHelper myHelper = new PostsHelper();

    protected void Page_Load(object sender, EventArgs e)
    {
        hfMarkerID.Value = Convert.ToInt32(Request.QueryString["MarkerID"]) + " ";
        hfUserID.Value = (string)Session["UserID"];
    }
    protected void btnSubmitPost_Click(object sender, EventArgs e)
    {
        myHelper.AddPost(tboxPostDesc.Value, 1, 18);
    }
    [WebMethod]
    public static string AddPost(string Desc, int userId, int markerId)
    {
        return myHelper.AddPost(Desc, markerId, userId);
    }
    //public static string ConvertDataTabletoString()
    //{
    //    SqlConnection connection = new SqlConnection(@"server=Joseph\SQLEXPRESS;database=TestDB;integrated security=true");
    //    connection.Open();
    //    DataTable dt = new DataTable();
    //    SqlDataAdapter adapter = new SqlDataAdapter("select title=city,lat=latitude,lng=longitude,Desciption from [markers]", connection);
    //    adapter.Fill(dt);
    //    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
    //    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
    //    Dictionary<string, object> row;
    //    foreach (DataRow dr in dt.Rows)
    //    {
    //        row = new Dictionary<string, object>();
    //        foreach (DataColumn col in dt.Columns)
    //        {
    //            row.Add(col.ColumnName, dr[col]);
    //        }
    //        rows.Add(row);
    //    }
    //    return serializer.Serialize(rows);
    //}
    //protected void btnOpen_Click(object sender, EventArgs e)
    //{
    //    //DataSet ds = gh.SelectAllGeners();
    //    //ddlTest.DataSource = ds.Tables[0];
    //    //ddlTest.DataTextField = "DESCRIPTION";
    //    //ddlTest.DataValueField = "GENER_ID";
    //    //ddlTest.DataBind();
    //}
    //protected void btnSubmitMarker_Click(object sender, EventArgs e)
    //{
    //    //Adding Marker

    //}
    //[WebMethod]
    //public static string ShowMessage(string message)
    //{
    //    return message + 'a';
    //}
    //[WebMethod]
    //public static string GetAllSubCat(int GenerID)
    //{
    //    return JSONHelper.GetAllSubCategories(GenerID);
    //}

}


class PostsHelper
{
    Helper myHelper;
    public PostsHelper()
    {
        myHelper = new Helper();
    }

    public string AddPost(string Desc, int markerId, int UserId)
    {
        myHelper.OpenConnection();
        return myHelper.ExcuteNonQuary("Insert into [OWNERS_POSTS] values (MARKER_ID = " + markerId + ", USER_ID = " + UserId + " , DESCRIPTION = '" + Desc + "', INITIALIZE_DATE = " + DateTime.Now + ")");
    }
}