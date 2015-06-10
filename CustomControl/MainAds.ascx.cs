using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CustomControl_MainAds : System.Web.UI.UserControl
{
    string className;

    public string ClassName
    {
        get { return mt.CssClass; }
        set { mt.CssClass = value; }
    }
    string imgAdsPro;

    public string ImgAdsPro
    {
        get { return imgAds.Src; }
        set { imgAds.Src = value; }
    }
    string imgGenerPro;

    public string ImgGenerPro
    {
        get { return imgGener.Src; }
        set { imgGener.Src = value; }
    }
    string imgTypePro;

    public string ImgTypePro
    {
        get { return imgType.Src; }
        set { imgType.Src = value; }
    }
    string lblMarkerNamePro;

    public string LblMarkerNamePro
    {
        get { return lblMarkerName.InnerText; }
        set { lblMarkerName.InnerText = value; }
    }
    string lblDatePro;

    public string LblDatePro
    {
        get { return lblDate.InnerHtml; }
        set { lblDate.InnerHtml = value; }
    }

    string lbladsContentPro;

    public string LbladsContentPro
    {
        get { return lbladsContent.InnerText; }
        set { lbladsContent.InnerText = value; }
    }
    string type;

    public string Type
    {
        get { return type; }
        set { type = value; }
    }
    string gener;

    public string Gener
    {
        get { return gener; }
        set { gener = value; }
    }


    string markerIdPro;

    public string MarkerIdPro
    {
        get { return markerId.Value; }
        set { markerId.Value = value; }
    }
    string adsIdpro;

    public string AdsIdpro
    {
        get { return adsId.Value; }
        set { adsId.Value = value; }
    }
    private string clintClickMap;

    public string ClintClickMap
    {
        set { btnShowOnMap.OnClientClick = value; }
    }

    public delegate void myevent(object sender, EventArgs e);
    //public event myevent mapClick;

    public event myevent clickInfo;
    public event myevent location;



    protected void Page_Load(object sender, EventArgs e)
    {


    }


    protected void btnMarkerInfo_Click(object sender, EventArgs e)
    {
        if (clickInfo != null)
        {
            clickInfo(this, new EventArgs());
        }
    }

    protected void btnShowOnMap_Click(object sender, EventArgs e)
    {
        if (location!=null)
        {
            location(this, new EventArgs());
        }
    }
}