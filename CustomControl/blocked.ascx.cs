using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebUserControl_blocked : System.Web.UI.UserControl
{
    public delegate void Action(object sender, EventArgs e);
    public event Action AddClick;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
   protected void RemoveBlock_OnClick(object sender,EventArgs e)
    {
       if(AddClick !=null)
       {
           AddClick(this, e);
       }
    }
    public string NAME
   {
       set { this.NameBlocked.Text = value; }
       get { return this.NameBlocked.Text; }
   }
}