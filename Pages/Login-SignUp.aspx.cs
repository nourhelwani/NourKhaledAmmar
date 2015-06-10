using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Pages_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AccountHelper Acount = new AccountHelper();
            DataSet AcountTypeDataSet = Acount.SelectAllAcountType();
            DropAcountType.DataSource = AcountTypeDataSet.Tables[0];
            DropAcountType.DataTextField = "DESCRIPTION";
            DropAcountType.DataValueField = "ACCOUNT_TYPE_ID";
            DropAcountType.DataBind();
        }
        if (Request.Cookies["UserInfo"] != null)
        {
            HttpCookie userInfoCookie = Request.Cookies["UserInfo"];
            tboxUsername.Text = userInfoCookie["UserName"];
            tboxPassword.Text = userInfoCookie["PassWord"];
        }
    }
    protected void signinbtn_Click(object sender, EventArgs e)
    {
        UserHelper Userhelper = new UserHelper();
        bool found = Userhelper.CheckUserNameAndPassWord(tboxUsername.Text, tboxPassword.Text.GetHashCode().ToString());
        if (found)
        {
            if (cboxRememper.Checked)
            {
                HttpCookie UserInfoCookie = new HttpCookie("UserInfo");
                UserInfoCookie["UserName"] = tboxUsername.Text;
                UserInfoCookie["PassWord"] = tboxPassword.Text;
                UserInfoCookie.Expires = DateTime.Now.AddYears(1);
                Response.Cookies.Add(UserInfoCookie);
            }
            string[] UserInfo = Userhelper.GetEmailAndRoleTypeAndUserId(tboxUsername.Text);
            Session["userName"] = tboxUsername.Text;
            Session["userId"] = UserInfo[0];
            Session["Email"] = UserInfo[1];
            Session["roldId"] = UserInfo[2];
            Response.Redirect("Home.aspx");
        }
        else
        {
            lblError.Text = "invild UserName Or Password";
            lblError.Visible = true;
        }
    }
    protected void btnCompleateInfo_Click(object sender, EventArgs e)
    {
        UserHelper UserHelper = new UserHelper();
        string Result = UserHelper.CheckUserNameAndEmail(tboxuserNameSignUp.Text, tboxEmail.Text);
        if (Result == "Done")
        {
            Session["userName"] = tboxuserNameSignUp.Text;
            Session["Email"] = tboxEmail.Text;
            Session["PassWord"] = tboxPasswordSignUp.Text.GetHashCode().ToString();
  //          lblUserName.Text = "Welcome : " + tboxuserNameSignUp.Text + " Complete Your Information plase...";
            lblUserName.Text = "Welcome : " + (string)Session["PassWord"] + " Complete Your Information plase...";
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "myKey", "ShowCompleateSignUpDiv();", true);
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "myKey", "showSignUpBtn();", true);
            lblErrorSignUp.Visible = true;
            lblErrorSignUp.Text = Result;
        }
    }
    protected void btnSignUp_Click(object sender, EventArgs e)
    {
        UserHelper Userhelper = new UserHelper();
        //Check if Phone NUmper is Exitst
        bool PhoneNumberFound = Userhelper.CheckPhoneNumberIfFound(tboxCellPhone.Text);
        if (PhoneNumberFound)
        {
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "myKey", "ShowCompleateSignUpDiv();", true);//used for show complete signUpForm
            lblErrorCompleateSignUP.Text = "The Phone is Already Exitst ...";
            lblErrorCompleateSignUP.Visible = true;
        }
        else //if phoneNumber is not exist
        {
            //check The gender Choosing
            string Gender = "";
            if (DropGender.SelectedItem.ToString() != "Select Gender")
            {
                Gender = DropGender.SelectedItem.ToString();
                //Fill User Data
                USER NewUser = new USER();
                NewUser.USERNAME = (string)Session["userName"];
                NewUser.PASSWORD =(string) Session["PassWord"];
                NewUser.EMAIL = (string)Session["Email"];
                NewUser.ROLE_ID = 2;//Have Edit
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
                    Session["roldId"] = "2";//have Edit
                    Response.Redirect("Home.aspx");
                }
                else //if don't insert new user to database
                {
                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "myKey", "ShowCompleateSignUpDiv();", true);//used for show complete signUpForm
                    lblErrorCompleateSignUP.Text = Result;
                    lblErrorCompleateSignUP.Visible = true;
                }
            }
            else //if don't select Gender
            {
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "myKey", "ShowCompleateSignUpDiv();", true);//used for show complete signUpForm
                lblGenderError.Text = "Choose your Gender";
                lblGenderError.Visible = true;
            }

        }
    }
}