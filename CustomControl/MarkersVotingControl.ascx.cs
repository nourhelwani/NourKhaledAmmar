using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CustomControl_MarkersVotingControl : System.Web.UI.UserControl
{

    public delegate void myDelegate(object sender, EventArgs e);
    public event myDelegate btnUp_Click;
    public event myDelegate btnDown_Click;

    public string MarkerID
    {
        set { lblID.Text = value; }
        get { return lblID.Text; }
    }
    public string MarkerName
    {
        get { return lblMarkerName.Text; }
        set { lblMarkerName.Text = value; }
    }
    public string Address
    {
        set { lblAddress.Text = value; }
        get { return lblAddress.Text; }
    }
    public string Type
    {
        get { return lblType.Text; }
        set { lblType.Text = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnVoteUp_Click(object sender, EventArgs e)
    {
        if (btnUp_Click != null)
        {
            btnUp_Click(this, e);
        }
    }
    protected void btnVoteDown_Click(object sender, EventArgs e)
    {
        if (btnDown_Click != null)
        {
            btnDown_Click(this, e);
        }
    }
}