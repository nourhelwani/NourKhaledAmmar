using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebUserControl_AdminMang : System.Web.UI.UserControl
{
    public Role_Helper rh = new Role_Helper();
    public delegate void Del(object sender, EventArgs e);
    public event Del AddClick;
    public event Del Changed;
    public event Del Load;
    public string ADMINNAME
    {
        set { this.LB_AdminName.Text = value; }
        get { return this.LB_AdminName.Text; }
    }
    public string ADMNDESC
    {
        set { this.LB_Desc.Text = value; }
        get { return this.LB_Desc.Text; }
    }
    public string AADMINTYPE
    {
        set
        {
            for(int i=0;i<AdminType.Items.Count;i++)
            {
                if(AdminType.Items[i].Text==value)
                {
                    AdminType.SelectedIndex = i;
                }
            }
        }
        get
        {
            return this.AdminType.SelectedItem.Text;
        }
     }
    public int SelectedRole
    {
        get { return AdminType.SelectedIndex; }
    }
    protected void RemoveAdmin_OnClick(object sender, EventArgs e)
    {
       if(AddClick!=null)
       {
           AddClick(this, e);
       }
    }
    
    protected void ChangeType_OnSelectChange(object sender,EventArgs e)
    {
        if (Changed != null)
            Changed(this, e);
    }
    protected void AdminName_onload(object sender,EventArgs e)
    {
        if(Load!=null)
        {
            Load(this, e);
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AdminType.Items.Clear();
            for (int i = 0; i < rh.SelectRoleAdmin().Tables[0].Rows.Count; i++)
            {
                AdminType.Items.Add(rh.SelectRoleAdmin().Tables[0].Rows[i][1].ToString());
            }
        }
    }

}