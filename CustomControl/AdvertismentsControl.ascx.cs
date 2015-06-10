using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CustomControl_AdvertismentsControl : System.Web.UI.UserControl
{
    public string AdvDescription 
    {
        set { lblDesciption.Text = value; }
        get { return lblDesciption.Text; }
    }
    public string StartDate
    {
        set { lblStartDate.Text ="Start : "+ value; }
        get { return lblDesciption.Text; }
    }
    public string EndDate
    {
        set { lblEndDate.Text = "End : " + value; }
        get { return lblEndDate.Text; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }
}