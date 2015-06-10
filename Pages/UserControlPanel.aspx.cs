using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.IO;

public partial class Pages_UserControlPanel : System.Web.UI.Page
{

    MarkerHelper markerHelper = new MarkerHelper();
    GenreHelper genreHelper = new GenreHelper();
    CategoriesHelper CategoryHelper = new CategoriesHelper();
    PhoneHelper phoneHelper = new PhoneHelper();
    MarkerCategoryHelper markerCategoryHelper = new MarkerCategoryHelper();
    static MarkerHelper staticMarkerHelper = new MarkerHelper();
    static CategoriesHelper webCategoryHelper = new CategoriesHelper();

    protected void Page_Load(object sender, EventArgs e)
    {
        hfDeterminOP.Value = "branch";
        if (!IsPostBack)
        {
            //Setup Default View

            DataSet AllMarkersForCurrentUser = markerHelper.GetMarkerByUserId(18);
            DefaultDataList.DataSource = AllMarkersForCurrentUser.Tables[0];
            DefaultDataList.DataBind();

            //for Show Control Panel H ref
            if (Request.QueryString["index"] != null)
            {
                int Index = int.Parse(Request.QueryString["index"]);
                if (Index == 0)
                {
                    DataSet allGenres = genreHelper.SelectAllGeners();
                    ddlSelectGenre.DataSource = allGenres.Tables[0];
                    ddlSelectGenre.DataTextField = "DESCRIPTION";
                    ddlSelectGenre.DataValueField = "GENER_ID";
                    ddlSelectGenre.DataBind();
                    ddlSelectGenre.Attributes["onChange"] = "ChangeLabelText();";
                    MultiUserPanal.ActiveViewIndex = Index;
                }
                else if (Index == 2)
                {
                    UserHelper UserHelper = new UserHelper();
                    DataSet DsUserInfo = UserHelper.GetUserInfoByUsername("eminem");
                    tboxUserName.Text = DsUserInfo.Tables[0].Rows[0][4].ToString();
                    tboxFirstName.Text = DsUserInfo.Tables[0].Rows[0][2].ToString();
                    tboxLastName.Text = DsUserInfo.Tables[0].Rows[0][3].ToString();
                    tboxEmail.Text = DsUserInfo.Tables[0].Rows[0][5].ToString();
                    tboxCellPhone.Text = DsUserInfo.Tables[0].Rows[0][9].ToString();
                    MultiUserPanal.ActiveViewIndex = Index;
                }
                else if (Index == 3)
                {
                    DataSet allGenres = genreHelper.SelectAllGeners();
                    ddlSelectGenreAdv.DataSource = allGenres.Tables[0];
                    ddlSelectGenreAdv.DataTextField = "DESCRIPTION";
                    ddlSelectGenreAdv.DataValueField = "GENER_ID";
                    ddlSelectGenreAdv.DataBind();
                    ddlSelectGenreAdv.Attributes["onChange"] = "ChangeLabelTextAdv();";
                    MultiUserPanal.ActiveViewIndex = 3;
                }
                else if (Index == 4)
                {
                    AdvertismentHelper myHelper = new AdvertismentHelper();
                    //Promote Advertisment
                    DataSet dsAdv = myHelper.GetAdvertismentCanPromot(3);//HAve USer Id
                    if (dsAdv.Tables[0].Rows.Count > 0)
                    {
                        repeterPromoteAdv.DataSource = dsAdv.Tables[0];
                        repeterPromoteAdv.DataBind();
                    }
                    else
                        lblerrorPromote.Visible = true;
                    MultiUserPanal.ActiveViewIndex = Index;
                }
                else MultiUserPanal.ActiveViewIndex = Index;
            }
        }
    }
    protected void btnSubmitMarker_Click(object sender, EventArgs e)
    {
        //Adding Marker
        if (hfSelectedID.Value.Length == 0)
        {
            MARKER markerToAdd = new MARKER();
            //markerToAdd.USER_ID = (int)Session["userId"];
            markerToAdd.USER_ID = 18;
            markerToAdd.MARKER_NAME = tboxMarkerName.Value;
            markerToAdd.LAT = Convert.ToDecimal(hfLat.Value);
            markerToAdd.LNG = Convert.ToDecimal(hfLng.Value);
            markerToAdd.DESCRIPTION = tboxDescription.Value;
            markerToAdd.TYPE = hfSelectedGenre.Value;
            markerToAdd.ADDRESS = hfAddress.Value;
            string result;
            if (hfWorkingDays.Value.Length == 0 && hfWorkingHoursFrom.Value.Length == 0 && hfWorkingHoursTo.Value.Length == 0)
            {
                result = markerHelper.AddMarker(markerToAdd);
                queryTest.Text = result;
            }
            else
            {
                markerToAdd.DAYS_OPEN = hfWorkingDays.Value;
                markerToAdd.TIME_FROM = TimeSpan.Parse(hfWorkingHoursFrom.Value);
                markerToAdd.TIME_TO = TimeSpan.Parse(hfWorkingHoursTo.Value);
                result = markerHelper.AddMarkerWithOpeningTime(markerToAdd);
                queryTest.Text = result;
            }
            if (!Directory.Exists(Server.MapPath("~") + "\\Photos\\" + tboxMarkerName.Value + "-" + hfAddress.Value))
                Directory.CreateDirectory(Server.MapPath("~") + "\\Photos\\" + tboxMarkerName.Value + "-" + hfAddress.Value);
        }
        //Adding Branch
        else if (hfSelectedID.Value.Length > 0)
        {
            DataSet usersMarkers = markerHelper.GetMasterByUserId(18);
            int SelectedMasterID = Convert.ToInt32(usersMarkers.Tables[0].Rows[Convert.ToInt32(hfSelectedID.Value)][0]);
            MARKER markerToAdd = new MARKER();
            //markerToAdd.USER_ID = (int)Session["userId"];
            markerToAdd.MARKER_NAME = tboxMarkerName.Value;
            markerToAdd.USER_ID = 18;
            markerToAdd.MASTER_ID = SelectedMasterID;
            markerToAdd.LAT = Convert.ToDecimal(hfLat.Value);
            markerToAdd.LNG = Convert.ToDecimal(hfLng.Value);
            markerToAdd.DESCRIPTION = tboxDescription.Value;
            markerToAdd.ADDRESS = hfAddress.Value;
            markerToAdd.TYPE = hfSelectedGenre.Value;
            string result = markerHelper.AddBranch(markerToAdd);
            queryTest.Text = result;
            hfSelectedID.Value = string.Empty;
            if (!Directory.Exists(Server.MapPath("~") + "\\Photos\\" + tboxMarkerName.Value + "-" + hfAddress.Value))
                Directory.CreateDirectory(Server.MapPath("~") + "\\Photos\\" + tboxMarkerName.Value + "-" + hfAddress.Value);
        }
        //Adding Phone Number
        if (tboxPhone.Value.Length > 0)
        {

            PHONE phoneToAdd = new PHONE();
            phoneToAdd.MARKER_ID = markerHelper.GetLastInsertedMarkerID();
            phoneToAdd.PHONE_NUMBER = tboxPhone.Value;
            phoneHelper.AddPhoneNumber(phoneToAdd);
        }
        //Adding Marker to Marker_Category
        MARKERS_CATEGORy markerCategoryToAdd = new MARKERS_CATEGORy();
        markerCategoryToAdd.MARKER_ID = markerHelper.GetLastInsertedMarkerID();
        markerCategoryToAdd.CATEGORY_ID = Convert.ToInt32(hfSelectedCategory.Value);
        markerCategoryHelper.AddRecord(markerCategoryToAdd);
    }

    protected void btnEditInfo_Click(object sender, EventArgs e)
    {
        Response.Redirect("UserControlPanel.aspx?index=3");
    }
    protected void lbtnEditLastName_Click(object sender, EventArgs e)
    {
        tboxEditFirstName.Text = tboxFirstName.Text;
        tboxEditLastName.Text = tboxLastName.Text;
        divUserInformation.Visible = false;
        MultiUserInfo.ActiveViewIndex = 0;
    }
    protected void lbtnEditEmail_Click(object sender, EventArgs e)
    {
        tboxEditEmail.Text = tboxEmail.Text;
        divUserInformation.Visible = false;
        MultiUserInfo.ActiveViewIndex = 1;
    }
    protected void lbtnEditCellPhone_Click(object sender, EventArgs e)
    {
        tboxEditCellPhone.Text = tboxCellPhone.Text;
        divUserInformation.Visible = false;
        MultiUserInfo.ActiveViewIndex = 2;
    }
    protected void lbtnEditPassword_Click(object sender, EventArgs e)
    {
        divUserInformation.Visible = false;
        MultiUserInfo.ActiveViewIndex = 3;
    }
    protected void btnBackPerosnal_Click(object sender, EventArgs e)
    {
        Response.Redirect("UserControlPanel.aspx?index=2");
    }
    protected void btnDonePersonalInfo_Click(object sender, EventArgs e)
    {
        USER myUser = new USER();
        myUser.FIRST_NAME = tboxEditFirstName.Text;
        myUser.LAST_NAME = tboxEditLastName.Text;
        myUser.USER_ID = (int)Session["userId"];
        UserHelper myhelper = new UserHelper();
        lblErrorPersonal.Text = myhelper.EditPersonalInfo(myUser);
    }
    protected void btnDoneEmail_Click(object sender, EventArgs e)
    {
        UserHelper MyHelper = new UserHelper();
        bool Result = MyHelper.CheckPasswordByUserId((int)Session["userId"], tboxPasswordOnEmail.Text.GetHashCode().ToString());
        if (Result)
        {
            USER myUser = new USER();
            myUser.USER_ID = (int)Session["userId"];
            myUser.EMAIL = tboxEditEmail.Text;
            UserHelper myhelper = new UserHelper();
            lblErrorEmail.Text = myhelper.EditEmail(myUser);
        }
        else
            lblErrorEmail.Text = "Error Password";
    }
    protected void btnDoneCellPhone_Click(object sender, EventArgs e)
    {
        UserHelper myhelper = new UserHelper();
        bool Result = myhelper.CheckPhoneNumberIfFound(tboxEditCellPhone.Text);
        if (!Result)
        {
            USER myUser = new USER();
            myUser.USER_ID = (int)Session["userId"];
            myUser.CELLPHONE = tboxEditCellPhone.Text;
            lblErrorCellPhone.Text = myhelper.EditCellPhone(myUser);
        }
        else
            lblErrorCellPhone.Text = "This Number Is Already Exist..";
    }
    protected void btnDoneEditPassword_Click(object sender, EventArgs e)
    {
        UserHelper MyHelper = new UserHelper();
        bool Result = MyHelper.CheckPasswordByUserId((int)Session["userId"], tboxOldPassword.Text.GetHashCode().ToString());
        if (Result)
        {
            USER myUser = new USER();
            myUser.USER_ID = (int)Session["userId"];
            myUser.PASSWORD = tboxNewPassword.Text.GetHashCode().ToString();
            lblErrorPassword.Text = MyHelper.EditPassword(myUser);
        }
        else
            lblErrorPassword.Text = "Error Password";
    }
    protected void btnSubmitMarkerAdv_Click(object sender, EventArgs e)
    {
        PhoneHelper phoneHelper = new PhoneHelper();
        //Fill Marker Info
        MARKER myMarker = new MARKER();
        myMarker.USER_ID = 3;//int.Parse(session["userId"]);
        myMarker.ADDRESS = hfAddressAdv.Value;
        myMarker.MARKER_NAME = tboxMarkerNameAdv.Value;
        myMarker.DESCRIPTION = tboxDescriptionAdv.Value;
        myMarker.LAT = Convert.ToDecimal(hfLatAdv.Value);
        myMarker.LNG = Convert.ToDecimal(hfLngAdv.Value);
        myMarker.TYPE = hfSelectedGenreAdv.Value;
        myMarker.IS_EVENT = 1;
        if (hfWorkingDaysAdv.Value.Length == 0 && hfWorkingHoursFromAdv.Value.Length == 0 && hfWorkingHoursToAdv.Value.Length == 0)
            markerHelper.AddMarker(myMarker);
        else
        {
            myMarker.DAYS_OPEN = hfWorkingDaysAdv.Value;
            myMarker.TIME_FROM = TimeSpan.Parse(hfWorkingHoursFromAdv.Value);
            myMarker.TIME_TO = TimeSpan.Parse(hfWorkingHoursToAdv.Value);
            markerHelper.AddMarkerWithOpeningTime(myMarker);
        }
        Directory.CreateDirectory(Server.MapPath("~") + "\\Photos\\" + tboxMarkerNameAdv.Value + "-" + hfAddressAdv.Value);
        MarkerHelper myhelper = new MarkerHelper();
        string Result = myhelper.AddMarkerForEvent(myMarker); //Add MArker to dataBase
        if (Result == "Done")
        {
            //Get Last MArker Add to Table
            int MarkerId = myhelper.GetLastInsertedMarkerID();
            //For Insert Phone to database
            PHONE myPhone = new PHONE();
            myPhone.MARKER_ID = MarkerId;
            myPhone.PHONE_NUMBER = tboxMarkerPhoneAdv.Value;
            phoneHelper.AddPhoneNumber(myPhone);
            //for Add Marker Id to Insert Event to This Marker
            hiddenMarkerId.Value = MarkerId.ToString();
            ClientScript.RegisterStartupScript(GetType(), "hwa", "alert('" + Session["markerId"] + "')", true);
            ClientScript.RegisterStartupScript(this.GetType(), "hwa", "$('#divAdvertismentInfo').modal('show')", true);
        }
        ClientScript.RegisterStartupScript(GetType(), "hwa", "alert('" + Session["markerId"] + "')", true);
        //lblResultAdv.Text = Result;
    }
    protected void btnSubmitAdvertisment_Click(object sender, EventArgs e)
    {
        AdvertismentHelper advHelper = new AdvertismentHelper();
        ADVERTISMENT myAdv = new ADVERTISMENT();
        //if Event 
        if (int.Parse(hiddenAdvertismentType.Value) == 1)
        {
            myAdv.MARKER_ID = int.Parse(hiddenMarkerId.Value);
            myAdv.ADVERTISMENT_TYPE_ID = 1;
            myAdv.IS_PROMOTED = 1;
        }
        else //If Advertisement
        {
            myAdv.MARKER_ID = int.Parse(hiddenMarkerId.Value);
            myAdv.ADVERTISMENT_TYPE_ID = int.Parse(hiddenAdvertismentType.Value);
            myAdv.IS_PROMOTED = 0;
        }
        //Get Date
        DateTime date = ConvertToDateTime(tboxExpireDate.Text);
        //Fill Advertisement Or Event Info 
        myAdv.DESCRIPTION = tboxAdvertismentDesciption.Value;
        myAdv.EXPIRE_DATE = date;
        //Insert Advertisement
        string Result = advHelper.AddNewAdvertisment(myAdv);
        //ClientScript.RegisterStartupScript(GetType(), "hwa", "alert('" + Result + "');", true);
        //ClientScript.RegisterStartupScript(GetType(), "hwa", "alert('" + hiddenResult.Value +"');", true);
    }
    protected void btnSubmitEditAdv_Click(object sender, EventArgs e)
    {
        AdvertismentHelper Helper = new AdvertismentHelper();
        ADVERTISMENT myAdv = new ADVERTISMENT();
        //get Date
        DateTime date = ConvertToDateTime(tboxExpiteDateAdvEdit.Text);
        //Fill Advertisement Info
        myAdv.ADVERTISMENT_ID = int.Parse(hiddenEditAdvId.Value);
        myAdv.DESCRIPTION = tboxEditAdvertismentDesc.Value;
        myAdv.EXPIRE_DATE = date;
        string Result = Helper.UpdateAdvertismentInfo(myAdv);
        //ClientScript.RegisterStartupScript(GetType(), "hwa", "alert('" + hiddenEditAdvId.Value + "','"+tboxEditAdvertismentDesc.Value+"','"+tboxExpiteDateAdvEdit+"');", true);
        //ClientScript.RegisterStartupScript(GetType(), "hwa", "alert('" + Result + "');", true);
    }
    protected void btnSubmitEditEvent_Click(object sender, EventArgs e)
    {
        AdvertismentHelper Helper = new AdvertismentHelper();
        ADVERTISMENT myAdv = new ADVERTISMENT();
        //get Date
        DateTime date = ConvertToDateTime(tboxExpireDateEventEdit.Text);
        //Fill Advertisement Info
        myAdv.ADVERTISMENT_ID = int.Parse(hiddenEventIdEditEvent.Value);
        myAdv.DESCRIPTION = tboxEventDescEdit.Value;
        myAdv.EXPIRE_DATE = date;
        string Result = Helper.UpdateAdvertismentInfo(myAdv);
        //ClientScript.RegisterStartupScript(GetType(), "hwa", "alert('" + hiddenEditAdvId.Value + "','"+tboxEditAdvertismentDesc.Value+"','"+tboxExpiteDateAdvEdit+"');", true);
        ClientScript.RegisterStartupScript(GetType(), "hwa", "alert('" + Result + "');", true);
    }
    private DateTime ConvertToDateTime(string strDateTime)
    {
        //method for Convert String to Date 
        DateTime dtFinaldate; string sDateTime;
        try { dtFinaldate = Convert.ToDateTime(strDateTime); }
        catch (Exception f)
        {
            string[] sDate = strDateTime.Split('-');
            sDateTime = sDate[2] + '-' + sDate[1] + '-' + sDate[0];
            dtFinaldate = DateTime.Parse(sDateTime);
        }
        return dtFinaldate;
    }
    protected void btnsubmitedit_Click(object sender, EventArgs e)
    {
        string result = markerHelper.EditMarker(tboxEditMarkerDescription.InnerText, Convert.ToInt32(lblEditMarkerId.Text));
        Response.Write(result);
    }
    protected void OnPromoteAdvertisment_Click(object sender, EventArgs e)
    {

        CustomControl_PromoteAdvertismentControl Pac = new CustomControl_PromoteAdvertismentControl();
        Pac = (CustomControl_PromoteAdvertismentControl)sender;
        AdvertismentHelper advHelper = new AdvertismentHelper();
        string Result = advHelper.PromoteAdvertisment(int.Parse(Pac.AdvertismetID));
        if (Result == "Done")
        {
            DataSet dsAdv = advHelper.GetAdvertismentCanPromot(3);//HAve USer Id
            if (dsAdv.Tables[0].Rows.Count > 0)
            {
                repeterPromoteAdv.DataSource = dsAdv.Tables[0];
                repeterPromoteAdv.DataBind();
            }
            else
            {
                repeterPromoteAdv.Visible = false;
                lblerrorPromote.Visible = true;
            }

        }
        else
        {
            lblerrorPromote.Visible = true;
            lblerrorPromote.Text = Result;
        }
    }
    protected void btnUploadSubmit_Click(object sender, EventArgs e)
    {
        string markerName = hFieldMarkerName.Value,
               markerAddress = hFieldMarkerAddress.Value;

        HttpPostedFile uploadedFile = FileUploadfirst.PostedFile as HttpPostedFile;
        HttpPostedFile uploadedFileSecond = FileUploadSecond.PostedFile as HttpPostedFile;
        HttpPostedFile uploadedFileThird = FileUploadThird.PostedFile as HttpPostedFile;

        try
        {

            if (FileUploadfirst.HasFile && uploadedFile.ContentLength < 1500000)
                FileUploadfirst.SaveAs(Server.MapPath("~") + "\\Photos\\" + markerName + "-" + markerAddress + "\\" + FileUploadfirst.FileName);
            if (FileUploadSecond.HasFile && uploadedFileSecond.ContentLength < 1500000)
                FileUploadSecond.SaveAs(Server.MapPath("~") + "\\Photos\\" + markerName + "-" + markerAddress + "\\" + FileUploadSecond.FileName);
            if (FileUploadThird.HasFile && uploadedFileThird.ContentLength < 1500000)
                FileUploadThird.SaveAs(Server.MapPath("~") + "\\Photos\\" + markerName + "-" + markerAddress + "\\" + FileUploadThird.FileName);

        }
        catch (Exception)
        {
            
            throw;
        }
    }
    public string CheckIfMarkersApproved(object status)
    {
        if ((int)status == 0)
            return "Pending..";
        else return "Approved";
    }
    public object CheckIfPhotoExists(object reference)
    {
        if (reference != DBNull.Value)
            return reference;
        else return @"\Photos\1.png";
    }
    [WebMethod]
    public static string GetAllSubCats(int GenreID)
    {
        return JSONHelper.GetAllSubCategories(GenreID);
    }
    [WebMethod]
    public static string GetAdvertisementInformationJSON(int advertisementID)
    {
        return JSONHelper.GetAdvertisementInfoViaID(advertisementID);
    }
    [WebMethod]
    public static string CheckMarkerToAddAvdrtisment(int markerId)
    {
        AdvertismentHelper AdvHelper = new AdvertismentHelper();
        DataSet ds = AdvHelper.GetAdvertismentViaMarkerId(markerId);
        bool CanAddAdv = true;
        if (ds.Tables[0].Rows.Count == 0)
            return "true";
        else
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                DateTime ExpireDate = (DateTime)ds.Tables[0].Rows[i][5];
                if (ExpireDate > DateTime.Now)
                    CanAddAdv = false;
            }
            if (CanAddAdv) return "true";
            else return "false";
        }
    }
    [WebMethod]
    public static string GetUserMarkers(int userID)
    {
        //Pass userID
        return JSONHelper.SerializeDataset(staticMarkerHelper.GetMarkerByUserId(18));
    }
}