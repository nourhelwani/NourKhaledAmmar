using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class Pages_m_home : System.Web.UI.Page
{
    GenreHelper myGenreHelper = new GenreHelper();
    MarkerHelper markerHelper = new MarkerHelper();
    protected void Page_Load(object sender, EventArgs e)
    {

        DataSet ds = myGenreHelper.SelectAllGeners();
        if (!IsPostBack)
        {
            Session["mobile"] = true;
            if (Session["UserName"] != null)
            {
                btnSignIn.InnerHtml = "Logout";
            }
            else
            {
                btnSignIn.InnerHtml = "SignIn";
            }
            myRepeater.DataSource = ds.Tables[0];
            myRepeater.DataBind();
        }

        if (!IsPostBack)
        {
            getAds("NEWEST", "");
            Session["ads_type"] = "";
            Session["ads_sort"] = "NEWEST";

        }

    }

    public void getAds(String sortBy, string typeIs)
    {
        AdvertismentHelper ads = new AdvertismentHelper();
        DataSet s = ads.GetAllValidAdvertismetInfo(sortBy, typeIs, true);
        repAds.DataSource = s;
        repAds.DataBind();

    }
    protected void SelectSortChange_Click(object sender, EventArgs e)
    {

        Button _sender = (Button)sender;

        Session["ads_sort"] = _sender.ToolTip;
        string sortBy = _sender.ToolTip;
        string typeIs = (string)Session["ads_type"];
        try
        {
            getAds(sortBy, typeIs);
        }
        catch { }
    }
    protected void SelectTypeChange_Click(object sender, EventArgs e)
    {
        try
        {
            Button _sender = (Button)sender;
            btnSelectType.InnerHtml = _sender.Text + " " + "<span class='caret'></span>";
            Session["ads_type"] = _sender.ToolTip;
            string sortBy = (string)Session["ads_sort"];
            string typeIs = _sender.ToolTip;
            getAds(sortBy, typeIs);
        }
        catch { }

    }

    public void SetIcons(CustomControl_MainAds _userControl)
    {
        if (_userControl.Type.ToLower() == "event")
        {
            _userControl.ImgTypePro = @"~\Icons\event.png";
        }
        else
        {
            _userControl.ImgTypePro = @"~\Icons\ads.png";
        }
        switch (_userControl.Gener)
        {
            case "Bank":
                _userControl.ImgGenerPro = @"~\Icons\Bank.png";
                break;
            case "bus Station":
                _userControl.ImgGenerPro = @"~\Icons\bus Station.png";
                break;
            case "Cafe":
                _userControl.ImgGenerPro = @"~\Icons\Cafe.png";
                break;
            case "Company":
                _userControl.ImgGenerPro = @"~\Icons\Company.png";
                break;
            case "Condominium Complex":
                _userControl.ImgGenerPro = @"~\Icons\Condominium Complex.png";
                break;
            case "Gym":
                _userControl.ImgGenerPro = @"~\Icons\Gym.png";
                break;
            case "Hospital":
                _userControl.ImgGenerPro = @"~\Icons\Hospital.png";
                break;
            case "Movie Theater":
                _userControl.ImgGenerPro = @"~\Icons\Movie Theater.png";
                break;
            case "Resort":
                _userControl.ImgGenerPro = @"~\Icons\Resort.png";
                break;
            case "Resturant":
                _userControl.ImgGenerPro = @"~\Icons\Resturant.png";
                break;
            case "Service":
                _userControl.ImgGenerPro = @"~\Icons\Service.png";
                break;
            case "Shopping Mall":
                _userControl.ImgGenerPro = @"~\Icons\Shopping Mall.png";
                break;
            case "Therapist":
                _userControl.ImgGenerPro = @"~\Icons\Therapist.png";
                break;
            case "University":
                _userControl.ImgGenerPro = @"~\Icons\University.png";
                break;
            case "Worship":
                _userControl.ImgGenerPro = @"~\Icons\Worship.png";
                break;
        }
    }

    protected void adsCustomContro_clickInfo(object sender, EventArgs e)
    {
        string id = ((CustomControl_MainAds)sender).MarkerIdPro;
        Response.Redirect("m.ViewMore.aspx?id=" + id);
    }
    protected void ads_clickLocation(object sender, EventArgs e)
    {
        CustomControl_MainAds _userControl = (CustomControl_MainAds)sender;
        DataSet _data = markerHelper.GetMarkerInfoByMarkerId(int.Parse(_userControl.MarkerIdPro));
        string lat = "";
        string lng = "";
        try
        {
            lat = _data.Tables[0].Rows[0]["LAT"].ToString();
            lng = _data.Tables[0].Rows[0]["LNG"].ToString();
        }
        catch { }
        ScriptManager.RegisterStartupScript(this, this.GetType(),
             "showLocation", "dorwMarker(" + lat + "," + lng + ")", true);

    }
    protected void repAds_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

        try
        {

            CustomControl_MainAds _userControl = e.Item.FindControl("adsCustomContro") as CustomControl_MainAds;
            //add photo
            int id = int.Parse(_userControl.MarkerIdPro);
            string markerName = _userControl.LblMarkerNamePro;
            string mapPath = Server.MapPath("~");
            string Address = (markerHelper.getMarkerAddress(id)).Tables[0].Rows[0]["ADDRESS"].ToString();
            string imageFolderPath = "" + mapPath + "\\Photos\\" + markerName + "-" + Address;

            List<ImageList> images = markerHelper.getImagesPath(markerName, Address, imageFolderPath);
            if (images != null)
            {

                bool mainImageExist = false;
                foreach (ImageList image in images)
                {
                    if (image.fileName == "main.jpg" || image.fileName == "main.png")
                    {
                        _userControl.ImgAdsPro = image.teldePath;
                        mainImageExist = true;
                    }

                }

                if (!mainImageExist)
                {
                    try
                    {
                        _userControl.ImgAdsPro = images[0].teldePath;
                    }
                    catch
                    {
                        _userControl.ImgAdsPro = @"~\Photos\no image.png";
                    }
                }

            }
            else
            {
                  _userControl.ImgAdsPro = @"~\Photos\no image.png";
            }








            ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
            scriptManager.RegisterAsyncPostBackControl(_userControl.FindControl("btnShowOnMap"));
            int markerid = 0;
            markerid = int.Parse(_userControl.MarkerIdPro);
            DataSet _data = markerHelper.GetMarkerInfoByMarkerId(markerid);
            string lat = _data.Tables[0].Rows[0]["LAT"].ToString();
            string lng = _data.Tables[0].Rows[0]["LNG"].ToString();
            _userControl.ClintClickMap = "showAdsOnMap(" + lat + "," + lng + ")";

            SetIcons(_userControl);
        }
        catch { }

    }



}