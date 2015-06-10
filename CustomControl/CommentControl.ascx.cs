using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CustomControl_CommentControl : System.Web.UI.UserControl
{
    public string Email 
    {
        set { lblEmail.Text = value; }
        get { return lblEmail.Text; }
    }
    public string Comment
    {
        set { lblComment.Text = value; }
        get { return lblComment.Text; }
    }
}