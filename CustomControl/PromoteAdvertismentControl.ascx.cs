using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CustomControl_PromoteAdvertismentControl : System.Web.UI.UserControl
{
    public delegate void Del(object sender, EventArgs e);
    public event Del Promote;
    public string MarkerName
    {
        get { return lblMarkerName.Text; }
        set { lblMarkerName.Text = value; }
    }
    public string AdvertismentDiscreption
    {
        get { return lblDescription.Text; }
        set { lblDescription.Text = value; }
    }
    public string ExpireDate
    {
        get { return lblExpireDate.Text; }
        set { lblExpireDate.Text = value; }
    }
    public string AdvertismetImage
    {
        get { return imgAdvIcon.ImageUrl; }
        set { imgAdvIcon.ImageUrl = value; }
    }
    public string AdvertismetID
    {
        get { return AdvertismentID.Text; }
        set { AdvertismentID.Text = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnPromote_Click(object sender, EventArgs e)
    {
        if (Promote != null)
        {
            Promote(this, e);
        }
    }
}



