using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;


public partial class Pages_Home : System.Web.UI.Page
{
    static MarkerHelper myMarkerHelper = new MarkerHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GenreHelper genreHelper = new GenreHelper();
            DataSet allGenres = genreHelper.SelectAllGeners();
            ddlGenerName.DataSource = allGenres.Tables[0];
            ddlGenerName.DataTextField = "DESCRIPTION";
            ddlGenerName.DataValueField = "GENER_ID";
            ddlGenerName.DataBind();
            ddlGenerName.Attributes["onChange"] = "ChangeLabelText();";
            lblGenerName.Value = ddlGenerName.Items[0].ToString();
        }
    }
    [WebMethod]
    public static string MarkerInfoViaID(int id)
    {
        return JSONHelper.SerializeDataset(myMarkerHelper.SelectMarkerViaID(id));
    }
    [WebMethod]
    public static string MarkerInfoViaMarkerName(string markerName)
    {
        return JSONHelper.SerializeDataset(myMarkerHelper.SelectMarkerViaMarkerName(markerName));
    }
    [WebMethod]
    public static string GetMarkerByType(string MarkerType)
    {
        return JSONHelper.GetMarkerByType(MarkerType);
    }
}