using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Runtime.Serialization.Json;
using System.Data;
public partial class Pages_AdminPanel : System.Web.UI.Page
{
    public static AdvertismentHelper ah = new AdvertismentHelper();
    public static MarkerHelper mh = new MarkerHelper();
    GenreHelper GH = new GenreHelper();
    CategoriesHelper CatH = new CategoriesHelper();
    UserHelper uh = new UserHelper();
    Role_Helper rh = new Role_Helper();
    bool State=true;
    bool PassState = true;
    int Phone = 0;
    int AdminId;
    USER ADMINUSER=new USER();
    List<USER> Edit = new List<USER>();
   
    public class Data
    {
        public string ColumnName = "";
        public int Value = 0;
        public Data(string columnName, int value)
        {
            ColumnName = columnName;
            Value = value;
        }
    }
    public static List<Data> GetData(DataSet ds)
    {
        List<Data> DATA = new List<Data>();
        string ColName = "";
        int Value = 0;
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            ColName = dr[0].ToString();
            Value = int.Parse(dr[1].ToString());
            DATA.Add(new Data(ColName, Value));
        }
        return DATA;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
        string Url_Param = Request.QueryString["AP"];
        if (Url_Param != null)
        {
            MV_ADMIN.ActiveViewIndex = int.Parse(Url_Param);
           
        }
        ReturnAdminId();
        MV_ADMIN.ActiveViewIndex = 6;
        if (!IsPostBack)
        {

            for (int i = 0; i < GH.SelectAllGeners().Tables[0].Rows.Count; i++)
            {
                lb_Current_Cate.Items.Add(GH.SelectAllGeners().Tables[0].Rows[i][1].ToString());
            }


            if (lb_Current_Cate.SelectedIndex == -1)
            {
                CateNewName.Text = "No Category Choose";
                NameGenerModal.Text = "Select From Gener List";
            }
            ReturnAdminInfo();
            FillMainNewInfo();
            GetBlockData();
            SetMangeAdmin();
            GETBEST_MARKER();
        }
        //}
        //if (Request.QueryString["AP"] == "7")
        //{
        //    MV_ADMIN.ActiveViewIndex = 7;
        //}
        //if(Request.QueryString["AP"]=="8")
        //{
        //    MV_ADMIN.ActiveViewIndex = 8;
        //}
        //if(Request.QueryString["AP"]=="9")
        //{
        //    MV_ADMIN.ActiveViewIndex = 9;

            lb_AdminBlockState.Text = "";
            lb_UserBlockState.Text = "";
        //}
        //if(Request.QueryString["AP"]=="10")
        //{
        //    MV_ADMIN.ActiveViewIndex = 10;
            
        //}
        //if (Request.QueryString["AP"] == "11")
        //{
        //    MV_ADMIN.ActiveViewIndex = 11;
        //}
       
            RefNewAdminAllRole();
            AdminUserNameValibale.Text = "this UserName Is Avalibale";
            AdminUserNameValibale.Attributes.Add("style", "color:green");
           
        
    }
    [WebMethod]
    public static List<Data> GETCHARTDATA()
    {
        return GetData(mh.ReturnNewMarkerLast7ForChart());
    }
    [WebMethod]
    public static List<Data> GetChartDataForMonth()
    {
        return GetData(mh.ReturnNewMarkerLastMonthForChart());
    }
    [WebMethod]
    [ScriptMethod]
    public static void SetApproveAds(int ID)
    {
        ah.ApproveEventByID(ID);
    }
    [WebMethod]
    [ScriptMethod]
    public static void SetApprove(int ID)
    {
        mh.ApproveMark(ID);
    }
    [WebMethod]
    [ScriptMethod]
    public static void SetWait(int ID)
    {
        mh.WaitMarker(ID);
    }
    [WebMethod]
    [ScriptMethod]
    public static void Denied(int ID)
    {

    }
    [WebMethod]
    [ScriptMethod]
    public static void DeleteAds(int ID)
    {
        ah.DeleteAdsById(ID);
    }
    protected void lb_Current_Cate_SelectedIndexChanged(object sender, EventArgs e)
    {
        CateNewName.Text = lb_Current_Cate.SelectedValue.ToString();
    }
    protected void lb_CurrentGener_SelectedIndexChanged(object sender, EventArgs e)
    {
        NameGenerModal.Text = lb_CurrentGener.SelectedItem.ToString();
    }
    protected void btn_CompleteEdit_Click(object sender, EventArgs e)
    {
        int Index = lb_Current_Cate.SelectedIndex;

        if (Index != -1)
        {
            int CurrentCateId = int.Parse(GH.SelectAllGeners().Tables[0].Rows[Index][0].ToString());
            GH.UpdateGener(CurrentCateId, CateNewName.Text);
        }
        RefrechAndFillCurCateList();
    }
    public int GetIdCate()
    {
        int Index = lb_CurrentGener.SelectedIndex;
        int Index_cate = lb_Current_Cate.SelectedIndex;
        if (Index_cate != -1 && Index != -1)
        {
            DataSet CateCur = CatH.SelectAllSubCategories(int.Parse(GH.SelectAllGeners().Tables[0].Rows[Index_cate][0].ToString()));
            int CateId = int.Parse(CateCur.Tables[0].Rows[Index][0].ToString());
            return CateId;
        }
        return -1;
    }
    public void RefrechAndFillCurrentGenerList()
    {
        lb_CurrentGener.Items.Clear();
        int Index = lb_Current_Cate.SelectedIndex;
        if (Index != -1)
        {
            for (int i = 0; i < CatH.SelectAllSubCategories(int.Parse(GH.SelectAllGeners().Tables[0].Rows[Index][0].ToString())).Tables[0].Rows.Count; i++)
            {
                lb_CurrentGener.Items.Add(CatH.SelectAllSubCategories(int.Parse(GH.SelectAllGeners().Tables[0].Rows[Index][0].ToString())).Tables[0].Rows[i][2].ToString());
            }
        }
    }
    public void RefrechAndFillCurCateList()
    {
        lb_Current_Cate.Items.Clear();
        for (int i = 0; i < GH.SelectAllGeners().Tables[0].Rows.Count; i++)
        {
            lb_Current_Cate.Items.Add(GH.SelectAllGeners().Tables[0].Rows[i][1].ToString());
        }
    }
    protected void btn_EditCate_Click(object sender, EventArgs e)
    {

    }
    protected void btn_DeleteCate_Click(object sender, EventArgs e)
    {

    }
    protected void btn_ShowGenerCate_Click(object sender, EventArgs e)
    {
        RefrechAndFillCurrentGenerList();
    }
    protected void DeleteCateComplete_Click(object sender, EventArgs e)
    {

    }
    protected void btn_AddNewGenerForCate_Click(object sender, EventArgs e)
    {
        if (lb_Current_Cate.SelectedIndex != -1)
        {
            int GenerId = int.Parse(GH.SelectAllGeners().Tables[0].Rows[lb_Current_Cate.SelectedIndex][0].ToString());
            for (int i = 0; i < lbGenerNew.Items.Count; i++)
            {
                CatH.AddCategory(GenerId, lbGenerNew.Items[i].Text);
            }
            lbGenerNew.Items.Clear();
            NewGener_Name.Text = null;
            RefrechAndFillCurrentGenerList();
        }
    }
    protected void btn_saveModalEditGener_Click(object sender, EventArgs e)
    {
        int CateId = GetIdCate();
        int IndexCurrGener = lb_CurrentGener.SelectedIndex;
        if (NameGenerModal.Text != null && NameGenerModal.Text != "" && NameGenerModal.Text != " ")
        {
            CatH.EditCateById(CateId, NameGenerModal.Text);
        }
        RefrechAndFillCurrentGenerList();
    }
    protected void SaveDeleteGener_Click(object sender, EventArgs e)
    {
        int CateId = GetIdCate();
        if (CateId != -1)
        {
            CatH.DeleteCateById(CateId);
            RefrechAndFillCurrentGenerList();
            NameGenerModal.Text = "Please Select From Gener List ";
        }
    }
    protected void GnerToListAddModal_Click(object sender, EventArgs e)
    {
        if (NewGener_Name.Text != null && NewGener_Name.Text != "" && NewGener_Name.Text != " ")
        {
            lbGenerNew.Items.Add(NewGener_Name.Text);
            NewGener_Name.Text = " ";
        }
        //Message
    }
    protected void btn_SaveForm_Click(object sender, EventArgs e)
    {
        if (txt_NwCateName.Text != null && txt_NwCateName.Text != "" && txt_NwCateName.Text != " ")
        {
            GH.AddGener(txt_NwCateName.Text);
            int CateNwId = int.Parse(GH.SelectAllGeners().Tables[0].Rows[GH.SelectAllGeners().Tables[0].Rows.Count - 1][0].ToString());
            if (lb_NewGener.Items != null)
            {
                for (int i = 0; i < lb_NewGener.Items.Count; i++)
                {
                    CatH.AddCategory(CateNwId, lb_NewGener.Items[i].Text);
                }
            }

        }
        else
        {
            //message Gener Should Not Empty
            if (lb_NewGener.Items == null)
            {

            }
            //Message Cant Save
        }
        RefrechAndFillCurCateList();
    }
   
    public void RefNewAdminAllRole()
    {
        if (!IsPostBack)
        {
            DDL_NewAdminAllRole.Items.Clear();
            for (int i = 0; i < rh.SelectRoleAdmin().Tables[0].Rows.Count; i++)
            {
                DDL_NewAdminAllRole.Items.Add(rh.SelectRoleAdmin().Tables[0].Rows[i][1].ToString());
            }
        }
    }
    public bool CheckFromUserName()
    {
        if (!IsNullOrWhiteSpace(NewAdminUserName.Text))
        {
            for (int i = 0; i < uh.SelectAllUsers().Tables[0].Rows.Count; i++)
            {
                if (NewAdminUserName.Text == uh.SelectAllUsers().Tables[0].Rows[i][4].ToString())
                {
                    State = false;
                    AdminUserNameValibale.Text = "This UserName Is Really Taken";
                    AdminUserNameValibale.Style.Add("color", "red");
                }
            }
        }
        else
        {
            AdminUserNameValibale.Text = "UserName Not Can Be Empty ";
            AdminUserNameValibale.Style.Add("color", "red");
        }
        return State;
    }
    public void GeneratePhone()
    {
        for(int i =0;i<uh.SelectAllUsers().Tables[0].Rows.Count;i++)
        {
            if(Phone.ToString()==uh.SelectAllUsers().Tables[0].Rows[i][9].ToString())
            {
                Phone+=1;
            }
        }
    }
    protected void btn_CheckAvalibale_Click(object sender,EventArgs e)
    {
        CheckFromUserName();
        AdminUserNameValibale.Visible = true;
    }
    public bool CheckNewAdminPassword()
    {
       if(NewAdminPassword.Text.Trim()!=NewAdminPasswordAgin.Text.Trim())
       {
           PassState = false;
           PassMatchState.Text = "Pass word is not much";
       }
       else
       {
           PassMatchState.Text = "";
           PassState = true;
       }
       return PassState;
    }
   
    protected void SaveNewAdmin_Click(object sender, EventArgs e)
    {
        if (NewAdminUserName.Text != "" && NewAdminPassword.Text != "" && NewAdminPassword.Text != " "&& NewAdminUserName.Text != " ")
        {
            if (State == true && PassState == true)
            {
                USER NewAdmin = new USER();
                GeneratePhone();
                NewAdmin.ROLE_ID = int.Parse(rh.SelectRoleAdmin().Tables[0].Rows[DDL_NewAdminAllRole.SelectedIndex][0].ToString());
                NewAdmin.USERNAME = NewAdminUserName.Text;
                NewAdmin.FIRST_NAME = "null";
                NewAdmin.LAST_NAME = "null";
                NewAdmin.GENDER = "Male";
                NewAdmin.PASSWORD = NewAdminPassword.Text;
                NewAdmin.ACCOUNT_TYPE_ID = 1;
                NewAdmin.EMAIL = NewAdminUserName.Text + "@3alyamen.com";
                NewAdmin.CELLPHONE = Phone.ToString();
                string res = uh.AddNewUser(NewAdmin);
                if (res == "Done")
                {
                    PassMatchState.Text = "Done";
                    Response.Redirect("AdminPanel.aspx?AP=7");
                    
                }
                else
                {
                    PassMatchState.Text = res;
                }
            }
            else
            {
                if (PassState == false)
                {
                    PassMatchState.Text = "password not match";
                }
            }
        }
        else
        {
            //user name or password empty;
        }
    }
    protected void NewAdminPasswordAgin_TextChanged(object sender, EventArgs e)
    {
        CheckNewAdminPassword();
    }

    public void ReturnAdminInfo()
    {
        for (int i = 0; i < uh.GetAllAdmin().Tables[0].Rows.Count; i++)
        {
            if ((string)Session["userName"] == uh.GetAllAdmin().Tables[0].Rows[i][4].ToString())
            {
                AdminUserNameEdit.Text = uh.GetAllAdmin().Tables[0].Rows[i][4].ToString();
                if (uh.GetAllAdmin().Tables[0].Rows[i][2].ToString() != "null")
                {
                    AdminInfoView.Text = uh.GetAllAdmin().Tables[0].Rows[i][2].ToString();
                    FNameAdmin.Text = uh.GetAllAdmin().Tables[0].Rows[i][2].ToString();
                }
                if (uh.GetAllAdmin().Tables[0].Rows[i][3].ToString() != "null")
                {
                    AdminInfoView.Text += uh.GetAllAdmin().Tables[0].Rows[i][3].ToString();
                    LNameAdmin.Text = uh.GetAllAdmin().Tables[0].Rows[i][3].ToString();
                }
                if (uh.GetAllAdmin().Tables[0].Rows[i][9].ToString().Length == 10)
                {
                    AdminMobile.Text = uh.GetAllAdmin().Tables[0].Rows[i][9].ToString();
                    AdminMobileView.Text = uh.GetAllAdmin().Tables[0].Rows[i][9].ToString();
                }
                if (!uh.GetAllAdmin().Tables[0].Rows[i][5].ToString().Contains("@3alyamen.com"))
                {
                    EmailAdminView.Text = uh.GetAllAdmin().Tables[0].Rows[i][5].ToString();
                   AdminEmail.Text = uh.GetAllAdmin().Tables[0].Rows[i][5].ToString();
                }
                AdminGenderView.Text = uh.GetAllAdmin().Tables[0].Rows[i][10].ToString();
                if(ADMINUSER.GENDER.Equals(CK_AdmainMaleGender.Text))
                {
                    CK_AdmainMaleGender.Checked = true;
                }
                else
                {
                    CK_AdminFamleGender.Checked = false;
                }
            }
        }
    }
       
    public int ReturnAdminId()
    {
        
        for(int i=0;i<uh.GetAllAdmin().Tables[0].Rows.Count;i++)
        {
            if((string)Session["userName"]==uh.GetAllAdmin().Tables[0].Rows[i][4].ToString())
            {
                AdminId= int.Parse(uh.GetAllAdmin().Tables[0].Rows[i][0].ToString());
                ADMINUSER.FIRST_NAME = uh.GetAllAdmin().Tables[0].Rows[i][2].ToString();
                ADMINUSER.LAST_NAME = uh.GetAllAdmin().Tables[0].Rows[i][3].ToString();
                ADMINUSER.GENDER = uh.GetAllAdmin().Tables[0].Rows[i][10].ToString();
                ADMINUSER.EMAIL = uh.GetAllAdmin().Tables[0].Rows[i][5].ToString();
                ADMINUSER.CELLPHONE = uh.GetAllAdmin().Tables[0].Rows[i][9].ToString();
                ADMINUSER.PASSWORD=uh.GetAllAdmin().Tables[0].Rows[i][6].ToString();
            }
        }
        return AdminId;
    }
    public void GetBlockData()
    {
        REP_AdminHasBlocked.DataSource = uh.GetAllAdminBlocked();
        REP_AdminHasBlocked.DataBind();
        REP_UserHasBlocked.DataSource = uh.GetAllUserBlocked();
        REP_UserHasBlocked.DataBind();
        REP_MarkerHasBlocked.DataSource = mh.GetMarkerBlocked();
        REP_MarkerHasBlocked.DataBind();
        
        REP_USERS.DataSource = uh.GetNewUsersLast7();
        REP_USERS.DataBind();
        LB_numUser.Text = "NEW USER IN LAST WEEK ";
    }
    
    protected void AdminUnblock_OnClick(object sender,EventArgs e)
    {
        WebUserControl_blocked wub = (WebUserControl_blocked)sender;
        for(int i =0 ;i<uh.GetAllAdminBlocked().Tables[0].Rows.Count;i++)
        {
            if(uh.GetAllAdminBlocked().Tables[0].Rows[i][4].ToString()==wub.NAME)
            {
                lb_AdminBlockState.Text = "Admin " + wub.NAME + " Has Remove  block";
                uh.RemoveAdminBlockById(int.Parse(uh.GetAllAdminBlocked().Tables[0].Rows[i][0].ToString()));
                
            }
            else
            {
                lb_AdminBlockState.Text = "some thing wrong";
            }
        }
    }
    protected void UserUnblock_OnClick(object sender,EventArgs e)
    {
        WebUserControl_blocked wub = (WebUserControl_blocked)sender;
        for(int i=0;i<uh.GetAllUserBlocked().Tables[0].Rows.Count;i++)
        {
            if(uh.GetAllUserBlocked().Tables[0].Rows[i][4].ToString()==wub.NAME)
            {
                uh.RemoveAdminBlockById(int.Parse(uh.GetAllUserBlocked().Tables[0].Rows[i][0].ToString()));
               lb_UserBlockState.Text = "User " + wub.NAME + "Has Remove Block ";
                
            }
            else
            {
                lb_UserBlockState.Text = "Some thing Wrong";
            }
        }
    }
    protected void LB_BlockAdmin_Click(object sender, EventArgs e)
    {
        if(IsNullOrWhiteSpace(txt_UserNameAdminForBlock.Text))
        {
           lb_AdminBlockState.Text = "Admin UserName Not Should Be Empty";
        }
        else
        {
            for (int i = 0; i < uh.GetAdminActiveName().Tables[0].Rows.Count; i++)
            {
                if (uh.GetAllAdmin().Tables[0].Rows[i][4].ToString() == txt_UserNameAdminForBlock.Text)
                {
                    uh.SetUserBlockById(int.Parse(uh.GetAllAdmin().Tables[0].Rows[i][0].ToString()));
                }
            }
            lb_AdminBlockState.Text="";
            txt_UserNameAdminForBlock.Text = "";
            Response.Redirect("AdminPanel.aspx?AP=9");
        }
       
    }
    protected void LB_BlockUser_Click(object sender, EventArgs e)
    {
        if(IsNullOrWhiteSpace(txt_UserNameUserForBlock.Text))
        {
            lb_UserBlockState.Text = "User UserName NOt Should by empty";
        }
        else
        {
            for(int i=0;i<uh.GetAllUserForBlock().Tables[0].Rows.Count;i++)
            {
                if(uh.GetAllUserForBlock().Tables[0].Rows[i][4].ToString()==txt_UserNameUserForBlock.Text)
                {
                    uh.SetUserBlockById(int.Parse(uh.GetAllUserForBlock().Tables[0].Rows[i][0].ToString()));
                }
            }
            lb_UserBlockState.Text = "";
            txt_UserNameUserForBlock.Text = "";
            Response.Redirect("AdminPanel.aspx?AP=9");
        }
    }
    protected void MarkUnblock_OnClick(object sender, EventArgs e)
    {
        WebUserControl_blocked wub = (WebUserControl_blocked)sender;
        for(int i =0 ; i<mh.GetMarkerBlocked().Tables[0].Rows.Count;i++)
        {
            if(mh.GetMarkerBlocked().Tables[0].Rows[i][4].ToString()==wub.NAME)
            {
                mh.RemoveMarkBlockById(int.Parse(mh.GetMarkerBlocked().Tables[0].Rows[i][0].ToString()));
            }
            else
            {
                //some thing wrong
            }
        }
    }
    protected void LB_BlockMark_Click(object sender, EventArgs e)
    {
        if(IsNullOrWhiteSpace(txt_MarkerNameForBlock.Text))
        {
            lb_MarkBlockState.Text = "MARKER NAME SHOULD NOT BY EMPTY";
        }
        else
        {
            for(int i=0;i<mh.GetAvalibaleMarkForBlock().Tables[0].Rows.Count;i++)
            {
                if(mh.GetAvalibaleMarkForBlock().Tables[0].Rows[i][4].ToString()==txt_MarkerNameForBlock.Text)
                {
                    mh.BlockMarker(int.Parse(mh.GetAvalibaleMarkForBlock().Tables[0].Rows[i][0].ToString()));
                }
            }
            txt_MarkerNameForBlock.Text = "";
            lb_MarkBlockState.Text = "";
            Response.Redirect("AdminPanel.aspx?AP=9");
        }
    }
    public void SetMangeAdmin()
    {
        REP_AdminMang.DataSource = uh.GetAllAdmin();
        REP_AdminMang.DataBind();
    }
    protected void AdminName_OnLoad(object sender,EventArgs e)
    {
        if (!IsPostBack)
        {
            WebUserControl_AdminMang wuam = (WebUserControl_AdminMang)sender;
            for (int i = 0; i < uh.GetAllAdmin().Tables[0].Rows.Count; i++)
            {
                if (uh.GetAllAdmin().Tables[0].Rows[i][4].ToString() == wuam.ADMINNAME)
                {
                    for (int j = 0; j < rh.SelectRoleAdmin().Tables[0].Rows.Count; j++)
                        if (int.Parse(uh.GetAllAdmin().Tables[0].Rows[i][1].ToString()) == int.Parse(rh.SelectRoleAdmin().Tables[0].Rows[j][0].ToString()))
                        {
                            wuam.AADMINTYPE = rh.SelectRoleAdmin().Tables[0].Rows[j][1].ToString();
                            wuam.ADMNDESC = rh.SelectRoleAdmin().Tables[0].Rows[j][2].ToString();
                        }
                }
            }
        }  
    }
    protected void ChangeType_OnSelectChange(object sender,EventArgs e)
    {
        WebUserControl_AdminMang wua = (WebUserControl_AdminMang)sender;
       // AdminTypeC = wua.AADMINTYPE;
        btn_CancelMangeAdmin.Enabled = true;
        USER u = new USER();
        u.ROLE_ID =int.Parse(rh.SelectRoleAdmin().Tables[0].Rows[wua.SelectedRole][0].ToString());
        u.USERNAME = wua.ADMINNAME;
       
            //for (int i = 0; i < Edit.Count; i++)
            //{
            //    if (u.USERNAME == Edit[i].USERNAME)
            //    {
            //        Edit.Remove(Edit[i]);
            //    }
            //    Edit.Add(u);
            //}
        
         Edit.Add(u); 
         
        //foreach (USER item in Edit)
        //{
        //    lb_adMinSettingMessage.Text += item.USERNAME + ",+," + item.ROLE_ID;
        //}
    }
    protected void btn_SaveMangeAdmin_Click(object sender, EventArgs e)
    {
        
       // lb_adMinSettingMessage.Visible = true;
    }
    protected void btn_RemoveAdmin_Click(object sender, EventArgs e)
    {
        WebUserControl_AdminMang wuam = (WebUserControl_AdminMang)sender;
        btn_CancelMangeAdmin.Enabled = true;
    }
    public void FillMainNewInfo()
    {
        NEWMARKNum.Text = mh.ReturnNewMarkers().Tables[0].Rows.Count.ToString();
        NEWADSNum.Text = ah.ReturnNewAds().Tables[0].Rows.Count.ToString();
        NEWUSERSNUM.Text = uh.GetNewUsersLast7().Tables[0].Rows.Count.ToString();
    }
    protected void LB_NEWMARK_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=1");
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=4");
    }

    protected void LB_NEWUSERS_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx?AP=11");
    }
    protected void btn_ShowAllUser_Click(object sender, EventArgs e)
    {
        
        if (btn_ShowAllUser.Text == "Show ALL USERS")
        {
            REP_USERS.DataSource = uh.SelectAllUser();
            REP_USERS.DataBind();
            btn_ShowAllUser.Text = "Show Less USERS";
            btn_ShoMoreUser.Visible = false;
            LB_numUser.Text = "ALL USER";
        }
        else
        {
            REP_USERS.DataSource = uh.GetNewUsersLast7();
            REP_USERS.DataBind();
            btn_ShowAllUser.Text = "Show ALL USERS";
            btn_ShoMoreUser.Visible = true;
            LB_numUser.Text = "NEW USER IN LAST WEEK ";
        }
    }
    protected void btn_ShoMoreUser_Click(object sender, EventArgs e)
    {
        if (btn_ShoMoreUser.Text == "Show More USERS")
        {
            REP_USERS.DataSource = uh.GetNewUsersLast30();
            REP_USERS.DataBind();
            btn_ShoMoreUser.Text="Show Less USERS";
            LB_numUser.Text = "NEW USER IN LAST MONTH ";
        }
        else
        {
            REP_USERS.DataSource = uh.GetNewUsersLast7();
            REP_USERS.DataBind();
            btn_ShoMoreUser.Text = "Show More USERS";
            LB_numUser.Text = "NEW USER IN LAST WEEK ";
        }
    }
    public void GETBEST_MARKER()
    {
        DataTable TABLEMARK = mh.GetMarkerVisit().Tables[0];
        DataView DV = TABLEMARK.DefaultView;
        DV.Sort = "VISITS_COUNTER DESC";
        TABLEMARK = DV.ToTable();
        DataTable New = new DataTable();

        List<string> DR = new List<string>();
        List<int> DRN = new List<int>();
        if (DV.ToTable().Rows.Count > 5)
        {
            for (int i = 0; i < 6; i++)
            {
                DR.Add(DV.ToTable().Rows[i][0].ToString());
                DRN.Add(int.Parse(DV.ToTable().Rows[i][1].ToString()));
            }
        }
        else
        {
            for (int i = 0; i < DV.ToTable().Rows.Count; i++)
            {
                DR.Add(DV.ToTable().Rows[i][0].ToString());
                DRN.Add(int.Parse(DV.ToTable().Rows[i][1].ToString()));
            }
            DR.Add("NO MARKER");
            DRN.Add(0);
        }
        New.Columns.Add("VISITS_COUNTER");
        {
            for (int i = 0; i < DR.Count; i++)
            {
                New.Rows.Add(DRN[i]);
            }
        }
        New.Columns.Add("MARKERNAME");
        {
            for (int i = 0; i < DR.Count; i++)
            {
                New.Rows[i][1] = DR[i];
            }
        }
        REP_BESTMARKERS.DataSource = New;
        REP_BESTMARKERS.DataBind();

    }
    protected void AddGenerToList_Click(object sender, EventArgs e)
    {
        if(!IsNullOrWhiteSpace(txt_NwGenerName.Text))
        {
            lb_NewGener.Items.Add(txt_NwGenerName.Text);
            txt_NwGenerName.Text = "";
        }
        else
        {
            //message gener name not should be empty
        }
    }
    //public void setPermissionByAdminType()
    //{
    //    string URL = Request.QueryString["AP"];
        
    //}
    //edit Info
    protected void EditPassActive_Click(object sender, EventArgs e)
    {
        AdminPassInfoEdit.Visible = true;
        EditPassActive.Visible = false;
    }
    protected void OldAdminPassword_TextChanged(object sender, EventArgs e)
    {
        btn_SaveAdminEditPassword.Enabled = true;
    }
    protected void NewAdminPass_TextChanged(object sender, EventArgs e)
    {
        btn_SaveAdminEditPassword.Enabled = true;
    }
    protected void NewAdminPassA_TextChanged(object sender, EventArgs e)
    {
        btn_SaveAdminEditPassword.Enabled = true;
    }
    protected void btn_CancelEditAdminPass_Click(object sender, EventArgs e)
    {
        AdminPassInfoEdit.Visible = false;
        EditPassActive.Visible = true;
        btn_SaveAdminEditPassword.Enabled = false;
        OldAdminPassword.Text = "";
        NewAdminPass.Text = "";
        NewAdminPassA.Text = "";
        AdminPassNewAWarning.Text = "";
        AdminPassNewAWrong.Text = "";
        AdminPassNewWrong.Text = "";
    }
    protected void btn_SaveAdminEditPassword_Click(object sender, EventArgs e)
    {
        if(!IsNullOrWhiteSpace(OldAdminPassword.Text))
        {
            if(!IsNullOrWhiteSpace(NewAdminPass.Text)&&!IsNullOrWhiteSpace(NewAdminPassA.Text))
            {
                if(NewAdminPassA.Text.Equals(NewAdminPass.Text))
                {
                    AdminPassNewAWarning.Text = "";
                    if(OldAdminPassword.Text.Equals(ADMINUSER.PASSWORD))
                    {
                        if (NewAdminPass.Text.Equals(ADMINUSER.PASSWORD))
                        {
                            AdminPassNewAWarning.Style.Add("color", "red");
                            AdminPassNewAWarning.Text = "Cannot Use Old Password Plese Insert New Password";
                        }
                        else
                        {
                            ADMINUSER.PASSWORD = NewAdminPass.Text;
                            ADMINUSER.USER_ID = AdminId;
                            string PassEditRes = uh.EditPassword(ADMINUSER);
                            if (PassEditRes == "Done")
                            {
                                //AdminPassNewAWarning.Style.Add("color", "Green");
                                //AdminPassNewAWarning.Text = "Password Has Changing Success";
                                AdminPassInfoEdit.Visible = false;
                                EditPassActive.Visible = true;
                                btn_SaveAdminEditPassword.Enabled = false;
                                OldAdminPassword.Text = "";
                                NewAdminPass.Text = "";
                                NewAdminPassA.Text = "";
                                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Changeing PassWord Success')", true);
                            }
                            else
                            {
                                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('" + PassEditRes + "')", true);
                            }
                        }
                    }
                    else
                    {
                        AdminPassNewAWarning.Style.Add("color", "red");
                        AdminPassNewAWarning.Text = "Password You Insert Is Not Correct Plese Check And Insert Password Again";
                    }
                }
                else
                {
                    AdminPassNewAWarning.Style.Add("color", "red");
                    AdminPassNewAWarning.Text = "Passwords Do Not Mutch Please Check from Password";
                }
            }
            else
            {
                AdminPassNewWrong.Text = (string.IsNullOrEmpty(NewAdminPass.Text))?"this Filed Is Required":"";
                AdminPassNewAWrong.Text = (string.IsNullOrEmpty(NewAdminPassA.Text)) ? "this Filed Is Required" : "";
            }
        }
        else
        {
            AdminOldPassWrong.Text = "Old PassWord Should Not Be Empty ";
        }
    }
    protected void EditAdminEmailActive_Click(object sender, EventArgs e)
    {
        AdminEmailInfoEdit.Visible = true;
        EditAdminEmailActive.Visible = false;
        EmailAdminView.Visible = false;
    }
    protected void CancelEmailEditAdmin_Click(object sender, EventArgs e)
    {
        AdminEmailInfoEdit.Visible = false;
        EditAdminEmailActive.Visible = true;
        EmailAdminView.Visible = true;
        if (!AdminEmail.Text.Equals(ADMINUSER.EMAIL))
        {
            AdminEmail.Text = ADMINUSER.EMAIL;
        }
    }
    protected void AdminEmail_TextChanged(object sender, EventArgs e)
    {
        SaveEditEmailAdmin.Enabled = true;
        EmailAdminView.Visible = true;
    }
    //
    protected void FNameAdmin_TextChanged(object sender,EventArgs e)
    {
        SaveEditInfoAdmin.Enabled = true;
    }
    protected void LNameAdmin_TextChanged(object sender, EventArgs e)
    {
        SaveEditInfoAdmin.Enabled = true;
    }
    protected void EditAdminInfo_Click(object sender,EventArgs e)
    {
        EditInfoAdmin.Visible = true;
        EditAdminInfo.Visible = false;
        AdminInfoView.Visible = false;
    }
    protected void CancelEditInfoAdmin_Click(object sender,EventArgs e)
    {
        EditInfoAdmin.Visible = false;
        EditAdminInfo.Visible = true;
        AdminInfoView.Visible = true;
        SaveEditInfoAdmin.Enabled = false;
        if (!FNameAdmin.Text.Equals(ADMINUSER.FIRST_NAME)&&!LNameAdmin.Text.Equals(ADMINUSER.LAST_NAME))
        {
            FNameAdmin.Text =ADMINUSER.FIRST_NAME;
            LNameAdmin.Text = ADMINUSER.LAST_NAME;
        }
        
    }
    //
    protected void AdminMobile_TextChanged(object sender,EventArgs e)
    {
        SaveEditAdminMobile.Enabled = true;
    }
    protected void EditCillPhoneActive_Click(object sender,EventArgs e)
    {
        AdminCellPhoneEdit.Visible = true;
        EditCillPhoneActive.Visible = false;
    }
    protected void CancelEditAdminMobile_Click(object sender,EventArgs e)
    {
        AdminCellPhoneEdit.Visible = false;
        EditCillPhoneActive.Visible = true;
        SaveEditAdminMobile.Enabled = false;
        if (!AdminMobile.Text.Equals(ADMINUSER.CELLPHONE))
        {
            AdminMobile.Text = ADMINUSER.CELLPHONE;
        }
    }
    //
    protected void CK_AdmainMaleGender_CheckedChanged(object sender, EventArgs e)
    {
        SaveEditGenderAdmin.Enabled = true;
        if(CK_AdmainMaleGender.Checked==true)
        {
            CK_AdminFamleGender.Checked = false;
        }
        else
        {
            CK_AdminFamleGender.Checked = true;
        }
    }
    protected void CK_AdminFamleGender_CheckedChanged(object sender, EventArgs e)
    {
        SaveEditGenderAdmin.Enabled = true;
        if (CK_AdminFamleGender.Checked == true)
        {
            CK_AdmainMaleGender.Checked = false;
        }
        else
        {
            CK_AdmainMaleGender.Checked = true;
        }
    }
    protected void EditGenderAdminActive_Click(object sender,EventArgs e)
    {
        AdminGenderEdit.Visible = true;
        EditGenderAdminActive.Visible = false;
        AdminGenderView.Visible = false;
    }
    protected void  CancelEditGenderAdmin_Click(object sender,EventArgs e)
    {
        AdminGenderEdit.Visible = false;
        EditGenderAdminActive.Visible = true;
        AdminGenderView.Visible = true;
        SaveEditGenderAdmin.Enabled = false;
        if(ADMINUSER.GENDER.Equals(CK_AdmainMaleGender.Text))
        {
            CK_AdmainMaleGender.Checked = true;
        }
        else
        {
            CK_AdminFamleGender.Checked = true;
        }
    }
    protected void SaveEditInfoAdmin_Click(object sender, EventArgs e)
    {
        if(!IsNullOrWhiteSpace(FNameAdmin.Text)&&!IsNullOrWhiteSpace(FNameAdmin.Text))
        {
            USER NewUser = new USER();
            for(int i=0;i<uh.GetAllAdmin().Tables[0].Rows.Count;i++)
            {
                if(AdminId.ToString()==uh.GetAllAdmin().Tables[0].Rows[i][0].ToString())
                {
                    if(FNameAdmin.Text.Equals(uh.GetAllAdmin().Tables[0].Rows[i][2].ToString()))
                    {
                        if (LNameAdmin.Text.Equals(uh.GetAllAdmin().Tables[0].Rows[i][3].ToString()))
                        {
                            InfoEditWarning.Style.Add("color", "red");
                            InfoEditWarning.Text = "You did not make any changes please Insert new Information to save";
                        }
                        else
                        {
                            NewUser.FIRST_NAME = FNameAdmin.Text;
                            NewUser.LAST_NAME = LNameAdmin.Text;
                            NewUser.USER_ID = AdminId;
                            string EditInfoRes = uh.EditPersonalInfo(NewUser);
                            InfoEditWarning.Style.Add("color", "green");
                            InfoEditWarning.Text = EditInfoRes;
                            if(EditInfoRes=="Done")
                            {
                                AdminInfoView.Text = NewUser.FIRST_NAME + NewUser.LAST_NAME;
                                AdminInfoView.Visible = true;
                                EditAdminInfo.Visible = true;
                                EditInfoAdmin.Visible = false;
                            }
                        }
                    }
                    else
                    {
                        NewUser.FIRST_NAME = FNameAdmin.Text;
                        NewUser.LAST_NAME = LNameAdmin.Text;
                        NewUser.USER_ID = AdminId;
                        string EditInfoRes = uh.EditPersonalInfo(NewUser);
                        InfoEditWarning.Style.Add("color", "green");
                        InfoEditWarning.Text = EditInfoRes;
                        if (EditInfoRes == "Done")
                        {
                            AdminInfoView.Text = NewUser.FIRST_NAME + NewUser.LAST_NAME;
                            AdminInfoView.Visible = true;
                            EditAdminInfo.Visible = true;
                            EditInfoAdmin.Visible = false;
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Changeing Info Success')", true);
                        }
                    }
                   
                }
            }
        }
        else
        {
            if(string.IsNullOrEmpty(FNameAdmin.Text))
            {
                FNameWarning.Text = "Required Can Not be FirstName Empty";
            }
            if(string.IsNullOrEmpty(LNameAdmin.Text))
            {
                LNameWarning.Text = "Required Can Not be LastName Empty";
            }
        }
    }
    protected void SaveEditEmailAdmin_Click(object sender, EventArgs e)
    {
        if(!IsNullOrWhiteSpace(AdminEmail.Text))
        {
            if (AdminEmail.Text.Equals(ADMINUSER.EMAIL))
            {
                AdminEmailWarning.Style.Add("color","red");
                AdminEmailWarning.Text = "You did not make any changes please Insert new Email To Save";
            }
            else
            {
                ADMINUSER.EMAIL = AdminEmail.Text;
                ADMINUSER.USER_ID = AdminId;
                string AdminEmailRes = uh.EditEmail(ADMINUSER);
                AdminEmailWarning.Style.Add("color", "green");
                AdminEmailWarning.Text = AdminEmailRes;
                if(AdminEmailRes=="Done")
                {
                    EmailAdminView.Text = ADMINUSER.EMAIL;
                    EmailAdminView.Visible = true;
                    AdminEmailInfoEdit.Visible = false;
                    EditAdminEmailActive.Visible = true;
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Changeing Email Success')", true);
                }
            }
        }
        else
        {
            if(string.IsNullOrEmpty(AdminEmail.Text))
            {
                AdminEmailWRong.Style.Add("Color", "Red");
                AdminEmailWRong.Text = "Required Can Not Be Filed Empty please Insert Email To Save Change";
            }
        }
    }
    protected void SaveEditAdminMobile_Click(object sender, EventArgs e)
    {
        if(!IsNullOrWhiteSpace(AdminMobile.Text))
        {
            if(AdminMobile.Text.Equals(ADMINUSER.CELLPHONE))
            {
                AdminMobileWrning.Style.Add("Color", "Red");
                AdminMobileWrning.Text = "You did not make any changes please Insert new Mobile To Save";
            }
            else
            {
                ADMINUSER.CELLPHONE = AdminMobile.Text;
                ADMINUSER.USER_ID=AdminId;
                string adminMobileRes = uh.EditCellPhone(ADMINUSER);
                AdminMobileWrning.Style.Add("color", "green");
                AdminEmailWarning.Text = adminMobileRes;
                if(adminMobileRes=="Done")
                {
                    AdminMobileView.Text = ADMINUSER.CELLPHONE;
                    AdminMobileView.Visible = true;
                    EditCillPhoneActive.Visible = true;
                    AdminCellPhoneEdit.Visible = false;
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Changing Mobile Success')", true);
                }
            }
        }
        else
        {
            if(string.IsNullOrEmpty(AdminMobile.Text))
            {
                AdminMobileWrong.Text = "Required Can Not Be Filed Empty please Insert mobile To Save Change";
            }
        }
    }
    public static bool IsNullOrWhiteSpace(string value)
    {
        if (value != null)
        {
            for (int i = 0; i < value.Length; i++)
            {
                if (!char.IsWhiteSpace(value[i]))
                {
                    return false;
                }
            }
        }
        return true;
    }

    protected void SaveEditGenderAdmin_Click(object sender, EventArgs e)
    {
        if(CK_AdmainMaleGender.Checked==false&&CK_AdminFamleGender.Checked==false)
        {
            AdminGenderWarning.Style.Add("color", "red");
            AdminGenderWarning.Text = "THi Filed Required Cannot Leave Gender Empty";
        }
        else
        {
            ADMINUSER.GENDER = (CK_AdmainMaleGender.Checked == true) ? CK_AdmainMaleGender.Text : CK_AdminFamleGender.Text;
            string GenderRes = uh.EditAdminGender(ADMINUSER, AdminId);
            AdminGenderWarning.Style.Add("Color", "Green");
            AdminGenderWarning.Text = GenderRes;
            AdminGenderView.Text = ADMINUSER.GENDER;
            AdminGenderView.Visible = true;
            EditGenderAdminActive.Visible = true;
            AdminGenderEdit.Visible = false;
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Changeing Gender Success')", true);
        }
    }
}