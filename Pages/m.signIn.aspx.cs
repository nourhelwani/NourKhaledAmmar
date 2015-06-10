using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_m_signIn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Unnamed_Click(object sender, EventArgs e)
    {
        Response.Redirect("m.home.aspx");
    }

    protected void signinbtn_Click(object sender, EventArgs e)
    {
        UserHelper Userhelper = new UserHelper();
        bool found = Userhelper.CheckUserNameAndPassWord(tboxUsername.Text, tboxPassword.Text.GetHashCode().ToString());
        if (found)
        {
            string[] UserInfo = Userhelper.GetEmailAndRoleTypeAndUserId(tboxUsername.Text);
            Session["userName"] = tboxUsername.Text;
            Session["userId"] = UserInfo[0];
            Session["Email"] = UserInfo[1];
            Session["roldId"] = UserInfo[2];
            Response.Redirect("m.home.aspx");
        }
        else
        {
            lblError.Text = "invild UserName Or Password";
            lblError.Visible = true;
        }
    }
}