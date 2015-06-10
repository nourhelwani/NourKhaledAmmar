using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CustomControl_DefaultMarkerViewControl : System.Web.UI.UserControl
{

    public string ImageUrl
    {
        get { return MarkerMainImage.ImageUrl; }
        set { MarkerMainImage.ImageUrl = value; }
    }
    public string MarkerName
    {
        get { return lblMarkerName.Text; }
        set { lblMarkerName.Text = value; }
    }
    public string MarkerVisits
    {
        get { return lblCounterVisits.Text; }
        set { lblCounterVisits.Text = value; }
    }
    public string MarkerAddress
    {
        get { return lblMarkerAddress.Text; }
        set { lblMarkerAddress.Text = value; }
    }
    public string MarkerStatus
    {
        get { return lblMarkerIsApproved.Text; }
        set { lblMarkerIsApproved.Text = value; }
    }
    public string MarkerDescription
    {
        get { return lblMarkerDescription.Text; }
        set { lblMarkerDescription.Text = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}