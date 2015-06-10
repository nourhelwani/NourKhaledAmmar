using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Pages_CompleteSignUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Fill Acount Type Drop Down List
        if (!IsPostBack)
        {
            AccountHelper Acount = new AccountHelper();
            DataSet AcountTypeDataSet = Acount.SelectAllAcountType();
            DropAcountType.DataSource = AcountTypeDataSet.Tables[0];
            DropAcountType.DataTextField = "DESCRIPTION";
            DropAcountType.DataValueField = "ACCOUNT_TYPE_ID";
            DropAcountType.DataBind();
        }
    }
    protected void btnSignUp_Click(object sender, EventArgs e)
    {
        UserHelper Userhelper = new UserHelper();
        //Check if Phone NUmper is Exitst
        bool PhoneNumberFound = Userhelper.CheckPhoneNumberByUsername(tboxCellPhone.Text);
        if (PhoneNumberFound)
        {
            lblError.Text = "The Phone is Already Exitst ...";
            lblError.Visible = true;
        }
        else
        {
            //check The gender Choosing
            string Gender = "";
            if (DropGender.SelectedItem.ToString() != "Select Gender")
            {
                Gender = DropGender.SelectedItem.ToString();
                //Fill User Data
                USER NewUser = new USER();
                NewUser.USERNAME = (string)Session["userName"];
                NewUser.PASSWORD = (string)Session["passWord"];
                NewUser.EMAIL = (string)Session["Email"];
                NewUser.ROLE_ID = 2;
                NewUser.FIRST_NAME = tboxFirstName.Text;
                NewUser.LAST_NAME = tboxLastName.Text;
                NewUser.CELLPHONE = tboxCellPhone.Text;
                NewUser.ACCOUNT_TYPE_ID = int.Parse(DropAcountType.SelectedValue);
                NewUser.GENDER = Gender;
                string Result = Userhelper.AddNewUser(NewUser);
                if (Result == "Done")
                {
                    DataSet InfodataSet = Userhelper.GetUserInfoByUsername((string)Session["userName"]);
                    Session["userId"] = InfodataSet.Tables[0].Rows[0][0].ToString();
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    lblError.Text = Result;
                    lblError.Visible = true;
                }

            }
            else
            {
                lblGenderError.Text = "Choose your Gender";
                lblGenderError.Visible = true;
            }

        }
    }
    
}