using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebUserControl_MessageControl : System.Web.UI.UserControl
{
    public delegate void Del(object sender, EventArgs e);
    public event Del ShowMessage;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public string MESSAGEFROM
    {
        set { this.MessageFrom.Text = value; }
        get { return this.MessageFrom.Text; }
    }
    public string MESSAGETITLE
    {
        set {this.MessageTitle.Text = value; }
        get { return this.MessageTitle.Text; }
    }
    public string MESSAGETIME
    {
        set { this.MessageTime.Text= value; }
        get { return this.MessageTime.Text; }
    }
    public Boolean SELECTMESSAGE
    {
        set { this.SelectMessage.Checked = value; }
        get { return this.SelectMessage.Checked; }
    }
    protected void MessageFrom_Click(object sender, EventArgs e)
    {
        if (ShowMessage != null)
            ShowMessage(this, e);
    }
    
}