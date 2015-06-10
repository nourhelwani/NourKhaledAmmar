using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Masters_ADMIN_MASTER : System.Web.UI.MasterPage
{
    MarkerHelper mh = new MarkerHelper();
    AdvertismentHelper ah = new AdvertismentHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (NumberOfReqMark() > 0)
        {
            LABEL_MARK.Text = NumberOfReqMark().ToString();
        }
        if (NumberOfAds() > 0)
        {
            LABEL_ADS.Text = NumberOfAds().ToString();
        }
        if (NumberOfAds() + NumberOfReqMark() > 0)
        {
            LABEL_CONG.Text = (NumberOfAds() + NumberOfReqMark()).ToString();
        }
        Session["userRoleId"] = "Admin";
        admin.Text = (string)Session["userName"];
    }
    protected void LB_M_MANGER_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=1");
    }
    protected void LB_ALLMArk_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=1");
    }
    protected void LB_AppMArk_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=2");
    }
    protected void LB_WaitMark_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=3");
    }
    protected void LB_AD_MANGER_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=4");
    }
    public int NumberOfReqMark()
    {
        int MarkForApprove = mh.GetMarkerNotValid().Tables[0].Rows.Count;
        int MarkWait = mh.GetMarkerWaitingValid().Tables[0].Rows.Count;
        return (MarkWait + MarkForApprove);
    }
    public int NumberOfAds()
    {
        int ADS = ah.GetAllAdsToApprove().Tables[0].Rows.Count;
        int Event = ah.GetAllEventToApprove().Tables[0].Rows.Count;
        return (ADS + Event);
    }
    protected void LB_EVENT_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=4");
    }

    protected void LB_ADS_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=5");
    }
    protected void LB_CATEMAN_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=6");
    }
    protected void LB_ADMIN_MANGER_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=7");
    }
    protected void lb_AddAdmin_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=8");
    }
    protected void lb_BlockAdmin_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=9");
    }
    protected void lb_EditAdminInfo_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=10");
    }
    protected void lb_AdminSetting_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=7");
    }
}
