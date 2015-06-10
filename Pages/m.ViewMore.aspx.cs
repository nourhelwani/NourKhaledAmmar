using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
public partial class Pages_ViewMore : System.Web.UI.Page
{
    MarkerHelper markerHelper = new MarkerHelper();
    bool imgClass = true;
    int id;
    protected void Page_Load(object sender, EventArgs e)
    {
         id = int.Parse(Request.QueryString["id"]);
        if (!IsPostBack)
        {
            //for bind Rating
            BindRatingControl();
        }
        string _markerName = "";
        DataSet _data = new DataSet();
        if (id != null)
        {
            try
            {
                _data = markerHelper.GetMarkerInfoByMarkerId(id);
                _markerName = _data.Tables[0].Rows[0]["MARKER_NAME"].ToString();
            }
            catch { Response.Redirect("m.home.aspx"); }

            ///////
            /////
            ///
            //string[] images = markerHelper.getImagesPath(_markerName);


            //List<string> imagesList = new List<string>();
            //for (int i = 0; i < images.Length; i++)
            //{
            //    try
            //    {
            //        string imageName = Path.GetFileName(images[i]);
            //        string path = @"~\images\" + _markerName + "\\" + imageName;
            //        imagesList.Add(path);
            //    }
            //    catch
            //    {
            //        divSlider.Attributes.CssStyle.Add("display", "none");
            //    }
            //}
            //if (imagesList.Count == 0)
            //{
            //    divSlider.Attributes.CssStyle.Add("display", "none");
            //}

            //repImages.DataSource = imagesList;
            //repImages.DataBind();
            markerName.InnerHtml += _markerName;
            address.InnerHtml += _data.Tables[0].Rows[0]["ADDRESS"].ToString();
            description.InnerHtml += _data.Tables[0].Rows[0]["DESCRIPTION"].ToString();
            genner.InnerHtml += _data.Tables[0].Rows[0]["TYPE"].ToString();
            workDay.InnerHtml += _data.Tables[0].Rows[0]["DAYS_OPEN"].ToString();
            workTime.InnerHtml += _data.Tables[0].Rows[0]["TIME_FROM"].ToString()
                + _data.Tables[0].Rows[0]["TIME_TO"].ToString();
            lat.Value = _data.Tables[0].Rows[0]["LAT"].ToString();
            lng.Value = _data.Tables[0].Rows[0]["LNG"].ToString();
        }
        else { Response.Redirect("m.home.aspx"); }



    }
    protected void BindRatingControl()
    {
        //RatingDetailsHelper myHelper = new RatingDetailsHelper();
        //int total = 0;
        //DataSet dt = myHelper.SelectRateForMarker(16);//16 ==>id
        //if (dt.Tables[0].Rows.Count > 0)
        //{
        //    for (int i = 0; i < dt.Tables[0].Rows.Count; i++)
        //    {
        //        total += Convert.ToInt32(dt.Tables[0].Rows[i][2].ToString());
        //    } 
        //    int average = total / (dt.Tables[0].Rows.Count);
        //    ratingControl.CurrentRating = average;
        //    lblRate.Text = "Rating : " + average + " (" + dt.Tables[0].Rows.Count + " Vote) ";
        //}
        //MarkerHelper mHelper = new MarkerHelper();
        DataSet RateDteails = markerHelper.GetRateViaMarkerId(id);//16
        int Rate = int.Parse(RateDteails.Tables[0].Rows[0][0].ToString());
        int CountRate = int.Parse(RateDteails.Tables[0].Rows[0][1].ToString());
        if (CountRate != 0)
        {
            int average = Rate / CountRate;
            ratingControl.CurrentRating = average;
            lblRate.Text = "Rating : " + average + " (" + CountRate + " Vote) ";
        }
        else
        {
            ratingControl.CurrentRating = 0;
            lblRate.Text = "Be First Pirson Rate This..";
        }
    }

    protected void RatingControlChanged(object sender, AjaxControlToolkit.RatingEventArgs e)
    {
        
        MARKER Mrating = new MARKER();
        Mrating.RATE = ratingControl.CurrentRating;
        Mrating.MARKER_ID = id;//16 ==>id
        markerHelper.UpdateRate(Mrating);
        ratingControl.ReadOnly = true;
        BindRatingControl();
    }

    protected void repImages_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Panel divImg = (Panel)e.Item.FindControl("divImg");

        if (imgClass)
        {
            divImg.CssClass = "item active";
            imgClass = false;
        }
        else
        {
            divImg.CssClass = "item";
        }


    }
}