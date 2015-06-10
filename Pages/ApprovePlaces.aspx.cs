using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

public partial class Pages_ApprovePlaces : System.Web.UI.Page
{
    MarkerHelper myMarkerHelper = new MarkerHelper();
    static MarkerHelper staticMarkerHelper = new MarkerHelper();

    protected void Page_Load(object sender, EventArgs e)
    {
        DataSet ds = myMarkerHelper.SelectAllPendingMarkers();
        if (!IsPostBack)
        {
            myRepeater.DataSource = ds.Tables[0];
            myRepeater.DataBind();
        }
    }
    [WebMethod]
    public static string GetMarkerPosition(int markerID)
    {
        return JSONHelper.SerializeDataset(staticMarkerHelper.GetMarkerPosition(markerID));
    }
    [WebMethod]
    public static void VoteUp(int markerID)
    {
        staticMarkerHelper.VoteUp(markerID);
    }
    [WebMethod]
    public static void VoteDown(int markerID)
    {
        staticMarkerHelper.VoteDown(markerID);
    }
}