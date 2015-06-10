using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Data;

public partial class Pages_KhaledTest : System.Web.UI.Page
{
    MarkerHelper mHelper = new MarkerHelper();
    int Id;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Request.QueryString["index"] != null)
        {
            Id = int.Parse(Request.QueryString["index"]);

            if (!IsPostBack)
            {
                //for show login-logout button
                if (Session["userId"] == null)
                {
                    //       lbtnLogOut.ToolTip = "logIn";
                }
                //add visitor to this marker
                mHelper.UpdateVisitCounter(Id);//16==>id
                //For Fill comments
                ReviewsHelper reviews = new ReviewsHelper();
                DataSet ds = reviews.GetAllCommentsByMarkerId(Id);//16 ==> id
                if (ds.Tables[0].Rows.Count > 0)// if HAve Comments
                {
                    repeterComments.DataSource = ds.Tables[0];
                    repeterComments.DataBind();
                }
                else//if Don't Have Any Comment
                {
                    linkNocomments.Visible = true;
                    linkNocomments.Text = "Add your Review Now ";
                }
                //for Fill Advertisments
                AdvertismentHelper AdvHelper = new AdvertismentHelper();
                DataSet AdvDS = AdvHelper.GetAdvertismentViaMarkerId(Id); //16 ==> id
                if (AdvDS.Tables[0].Rows.Count > 0)
                {
                    repeaterAdvertisment.DataSource = AdvDS.Tables[0];
                    repeaterAdvertisment.DataBind();
                }
                else//if Don't Have Any Advertisment
                {
                    lblDontHaveAdv.Text = "Don't Have ADvertisment to Show";
                    lblDontHaveAdv.Visible = true;
                }
                //for bind Rating
                BindRatingControl();
                //for fill the Label ==> (info)
                PhoneHelper pHelper = new PhoneHelper();
                DataSet markerInfo = mHelper.GetMarkerInfoByMarkerId(Id);//16 ==> Id
                DataSet PhoneNumber = pHelper.GetPhoneNumberByMarkerId(Id);//16 ==> Id
                hiddenLat.Value = markerInfo.Tables[0].Rows[0][7].ToString();
                hiddenLng.Value = markerInfo.Tables[0].Rows[0][6].ToString();
                lblMarkerName.Text = markerInfo.Tables[0].Rows[0][4].ToString();
                lblMarkerAddress.Text = markerInfo.Tables[0].Rows[0][8].ToString();
                lblDescription.Text = markerInfo.Tables[0].Rows[0][5].ToString();
                lblGener.Text = markerInfo.Tables[0].Rows[0][12].ToString();
                lblWorkTime.Text = markerInfo.Tables[0].Rows[0][15].ToString() + " To " + markerInfo.Tables[0].Rows[0][16].ToString();
                lblAvalabileDay.Text = markerInfo.Tables[0].Rows[0][14].ToString();
                lblPhoneNumber.Text = PhoneNumber.Tables[0].Rows[0][0].ToString();
                lblWebSite.Text = "www.google.com";
            }
        }
    }
    protected void RatingControlChanged(object sender, AjaxControlToolkit.RatingEventArgs e)
    {
        MARKER Mrating = new MARKER();
        Mrating.RATE = ratingControl.CurrentRating;
        Mrating.MARKER_ID = Id;//16 ==>id
        mHelper.UpdateRate(Mrating);
        ratingControl.ReadOnly = true;
        BindRatingControl();
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
        DataSet RateDteails = mHelper.GetRateViaMarkerId(Id);//16
        int Rate =int.Parse( RateDteails.Tables[0].Rows[0][0].ToString());
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
    protected void AddComment_Click(object sender, EventArgs e)
    {
        ReviewsHelper reviewHelper = new ReviewsHelper();
        REVIEW myReview = new REVIEW();
        myReview.MARKER_ID = Id;//16==>id
        myReview.DESCRIPTION = tboxComment.Value;
        myReview.EMAIL = tboxEmail.Value;
        string Result=reviewHelper.InsertNewReview(myReview);
        if (Result=="Done")
        {
            //to re-fill repeter in new comment
            DataSet ds = reviewHelper.GetAllCommentsByMarkerId(Id);//16 ==> id
            repeterComments.DataSource = ds.Tables[0];
            repeterComments.DataBind();    
        }
        else
            ClientScript.RegisterStartupScript(GetType(), "hwa", "alert('" + Result + "');", true);   
    }
    protected void tnLogOut_Click(object sender, EventArgs e)
    {
        Response.Redirect("dsa");
    }
}