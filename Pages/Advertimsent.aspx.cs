using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.UI.HtmlControls;
using System.IO;

public partial class Pages_Default : System.Web.UI.Page
{
    AdvertismentHelper Adshelper = new AdvertismentHelper();
    GenreHelper generHelper = new GenreHelper();
    MarkerHelper markerHelper = new MarkerHelper();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                DataSet geners = generHelper.SelectAllGeners();
                repCat.DataSource = geners;
                repCat.DataBind();
                panelCat.Style.Add("display", "none");
                divSearchResualt.Style.Add("display", "none");

                Session["ads_type"] = "";
                Session["ads_sort"] = "";
                getAds("", "");
            }
            catch { }

        }

    }

    public void getAds(String sortBy, string typeIs)
    {
        try
        {
            DataSet s = Adshelper.GetAllValidAdvertismetInfo(sortBy, typeIs, false);
            repAds.DataSource = s;
            repAds.DataBind();
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


    protected void repAds_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

        try
        {

            CustomControl_MainAds _userControl = e.Item.FindControl("adsCustomContro") as CustomControl_MainAds;
            ////string[] imagePath = markerHelper.getImagesPath(_userControl.LblMarkerNamePro);
            //try
            //{
            //    string imageName = Path.GetFileName(imagePath[0]);
            //    _userControl.ImgAdsPro = @"~\images\" + _userControl.LblMarkerNamePro + "\\" + imageName;

            //}
            //catch
            //{
            //    _userControl.ImgAdsPro = @"~\images\no_img.png";
            //}


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


    protected void btnLineView_Click(object sender, EventArgs e)
    {
        divSearchResualt.Style.Add("display", "none");
        PanelAds.Attributes.CssStyle.Add("display", "block");
        panelCat.Attributes.CssStyle.Add("display", "none");
        try
        {
            foreach (RepeaterItem repeateitem in repAds.Items)
            {

                CustomControl_MainAds _control = ((CustomControl_MainAds)(repeateitem.FindControl("adsCustomContro")));
                if (_control.ClassName != "col-md-*")
                {

                    _control.ClassName = "col-md-*";
                }

            }
        }
        catch { }
    }

    protected void btnGraidView_Click(object sender, EventArgs e)
    {
        divSearchResualt.Style.Add("display", "none");
        panelCat.Attributes.CssStyle.Add("display", "none");
        PanelAds.Attributes.CssStyle.Add("display", "block");
        //btnGraidView.CssClass = "btn btn-default active";
        //btnLineView.CssClass = "btn btn-default";
        //btnCategotisView.CssClass = "btn btn-default";
        try
        {
            foreach (RepeaterItem repeateitem in repAds.Items)
            {
                CustomControl_MainAds _control = ((CustomControl_MainAds)(repeateitem.FindControl("adsCustomContro")));

                if (_control.ClassName != "col-md-4")
                {

                    _control.ClassName = "col-md-4";
                }
            }
        }
        catch { }
    }

    protected void btnCategotisView_Click(object sender, EventArgs e)
    {
        divSearchResualt.Style.Add("display", "none");
        PanelAds.Attributes.CssStyle.Add("display", "none");
        panelCat.Style.Add("display", "block");
        // btnGraidView.CssClass = "btn btn-default";
        //   btnLineView.CssClass = "btn btn-default";
        //     btnCategotisView.CssClass = "btn btn-default active";

    }

    protected void repCat_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Label s = (Label)e.Item.FindControl("lblCatName");
        Repeater r = (Repeater)e.Item.FindControl("repAdstitle");
        DataSet data = Adshelper.GetAdvertismentViaGeners(s.Text, "", "", false);
        try
        {
            if (data.Tables[0].Rows[0][0] == null)
            {
                Panel _panel = e.Item.FindControl("panelCat") as Panel;
                _panel.Style.Add("display", "none");
            }
        }
        catch
        {
            Panel _panel = e.Item.FindControl("panelCategory") as Panel;
            _panel.Style.Add("display", "none");

        }
        r.DataSource = data;
        r.DataBind();
    }
    public void filrepAdstitle()
    {
        string adsType = (string)Session["ads_type"];
        string adsSort = (string)Session["ads_sort"];
        try
        {
            foreach (RepeaterItem item in repCat.Items)
            {
                Label s = (Label)item.FindControl("lblCatName");
                Repeater r = (Repeater)item.FindControl("repAdstitle");
                DataSet data = Adshelper.GetAdvertismentViaGeners(s.Text, adsSort, adsType, false);

                r.DataSource = data;
                r.DataBind();
                try
                {
                    if (data.Tables[0].Rows[0][0] == null)
                    {
                        Panel _panel = item.FindControl("panelCat") as Panel;
                        _panel.Style.Add("display", "none");
                    }
                }
                catch { }

            }
        }
        catch { }

    }
    protected void repAdstitle_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            LinkButton content = (LinkButton)e.Item.FindControl("linkAdsContent");
            LinkButton markerName = (LinkButton)e.Item.FindControl("linkMarkerName");
            ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
            scriptManager.RegisterAsyncPostBackControl(content);
            scriptManager.RegisterAsyncPostBackControl(markerName);
            content.Text = markerName.Text + " :" + content.Text;
            if (content.Text.Length > 40)
            {

                content.Text = content.Text.Substring(0, 40) + "  ..continue reading";
            }

        }
        catch { }
    }

    protected void linkAdsContent_Click(object sender, EventArgs e)
    {

        try
        {
            LinkButton _sender = (LinkButton)sender;
            string id = _sender.CommandArgument;
            panelCat.Attributes.CssStyle.Add("display", "none");
            PanelAds.Attributes.CssStyle.Add("display", "block");
            //       btnGraidView.CssClass = "btn btn-default";
            //        btnLineView.CssClass = "btn btn-default active";
            //         btnCategotisView.CssClass = "btn btn-default";
            foreach (RepeaterItem repeateitem in repAds.Items)
            {

                CustomControl_MainAds _control = ((CustomControl_MainAds)(repeateitem.FindControl("adsCustomContro")));
                if (_control.ClassName != "col-md-*")
                {

                    _control.ClassName = "col-md-*";
                }

            }

            UpdatePanel1.Update();
            findAdv(id);


        }
        catch { }
    }
    public void findAdv(string id)
    {
        try
        {
            foreach (RepeaterItem item in repAds.Items)
            {
                CustomControl_MainAds _control = ((CustomControl_MainAds)(item.FindControl("adsCustomContro")));
                if (_control.AdsIdpro == id)
                {

                    HtmlControl _panel = (HtmlControl)_control.FindControl("adsMainDiv");
                    string ClinetID = _panel.ClientID;

                    ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(),
                  "scrollToDiv", "scrollToDiv('" + ClinetID + "')", true);

                }

            }
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
            filrepAdstitle();
        }

        catch { }

    }


    protected void SelectSortChange_Click(object sender, EventArgs e)
    {
        try
        {
            Button _sender = (Button)sender;
            btnSelectSortBy.InnerHtml = _sender.Text + " " + "<span class='caret'></span>";
            Session["ads_sort"] = _sender.ToolTip;
            string sortBy = _sender.ToolTip;
            string typeIs = (string)Session["ads_type"];
            getAds(sortBy, typeIs);
            filrepAdstitle();


        }
        catch { }
    }

    public void searchForGennerOrMaker(string text)
    {
        panelCat.Attributes.CssStyle.Add("display", "none");
        PanelAds.Attributes.CssStyle.Add("display", "none");
        divSearchResualt.Attributes.CssStyle.Add("display", "block");

        DataSet _data = Adshelper.GetAdvertismentViaGeners(text, "", "", false);
        if (_data.Tables[0].Rows.Count == 0)
        {
            _data = Adshelper.GetAllValidAdvertismetInfoByMarkerName(text);

        }
        repSearchRuslt.DataSource = _data;

        if (_data.Tables[0].Rows.Count == 0)
        {
            searchResultlbl.Text = "no resualt";
            divSearchRuseltStatus.Attributes.Remove("class");
            divSearchRuseltStatus.Attributes.Add("class", "alert alert-danger");
            repSearchRuslt.DataSource = null;
            repSearchRuslt.DataBind();
            return;
        }
        divSearchRuseltStatus.Attributes.Remove("class");
        divSearchRuseltStatus.Attributes.Add("class", "alert alert-info");
        searchResultlbl.Text = "search resualt";
        repSearchRuslt.DataBind();

    }

    protected void hiddenSearchBtn_Click1(object sender, EventArgs e)
    {
        string text = hiddenSearchParm.Value;
        searchForGennerOrMaker(text);

    }
    protected void btnBackToAds_Click(object sender, EventArgs e)
    {
        divSearchResualt.Attributes.CssStyle.Add("display", "none");
        PanelAds.Attributes.CssStyle.Add("display", "block");


    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string text = searchBox.Value;
        searchForGennerOrMaker(text);

    }
   

    protected void adsCustomContro_clickInfo(object sender, EventArgs e)
    {
        string id = ((CustomControl_MainAds)sender).MarkerIdPro;
        Response.Redirect("ViewMorePage.aspx?index=" + id);
    }
    protected void repSearchRuslt_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {

            CustomControl_MainAds _userControl = e.Item.FindControl("adsCustomContro") as CustomControl_MainAds;
            //string[] imagePath = markerHelper.getImagesPath(_userControl.LblMarkerNamePro);
            //try
            //{
            //    string imageName = Path.GetFileName(imagePath[0]);
            //    _userControl.ImgAdsPro = @"~\images\" + _userControl.LblMarkerNamePro + "\\" + imageName;

            //}
            //catch
            //{
            //    _userControl.ImgAdsPro = @"~\images\no_img.png";
            //}


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