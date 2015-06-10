using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_ChangeMainImage : System.Web.UI.Page
{
    string markerName, markerAddress;
    protected void Page_Load(object sender, EventArgs e)
    {
        markerName = markerAddress = "";
        if (Request.QueryString["name"] != null && Request.QueryString["address"] != null)
        {
            markerAddress = Request.QueryString["address"] as string;
            markerName = Request.QueryString["name"] as string;

            if (!Directory.Exists(Server.MapPath("~") + "\\Photos\\" + markerName + "-" + markerAddress))
            {
                noPhotoPanel.Visible = true;
            }
            if (!noPhotoPanel.Visible)
            {
                List<ImageList> imagesDataSource = new List<ImageList>();
                if (!IsPostBack)
                {
                    DirectoryInfo di = new DirectoryInfo(Server.MapPath("~") + "\\Photos\\" + markerName + "-" + markerAddress);
                    foreach (var File in di.GetFiles())
                    {
                        imagesDataSource.Add(new ImageList { FileName = markerName + "-" + markerAddress + "\\" + File.Name });
                    }
                    imagesRepeater.DataSource = imagesDataSource;
                    imagesRepeater.DataBind();
                }
            }
        }
        else noPhotoPanel.Visible = true;
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("UserControlPanel.aspx");
    }
    protected void btnSubmitChanges_Click(object sender, EventArgs e)
    {
        string SelectedImagePath = hfSelectedImage.Value;

        #region Changing FilesNames Dynamically
        /*FileInfo selectedPhoto = new FileInfo(Server.MapPath("~") + SelectedImagePath);
        string[] AllPhotos = Directory.GetFiles(Server.MapPath("~") + @"Photos\" + markerName + "-" + markerAddress);
        Random counter = new Random();
        int index = 0;
        for (int i = 0; i < AllPhotos.Length; i++)
        {
            if (AllPhotos[i] == selectedPhoto.FullName)
            {
                index = i;
                break;
            }
        }
        AllPhotos = AllPhotos.Where(val => val != selectedPhoto.FullName).ToArray();
        //Changing Photos Names To Random
        foreach (string filePath in AllPhotos)
        {
            try
            {
                FileInfo currentFile = new FileInfo(filePath);
                currentFile.MoveTo(Server.MapPath("~") + @"\Photos\" + markerName + "-" + markerAddress + @"\" + counter.Next(0,1000) + ".jpg");
            }
            catch (Exception) { }
        }
        //Changing The Selected File Name
        if (selectedPhoto.Exists)
        {
            try
            {
                Rename(SelectedImagePath, "main.jpg");
            }
            catch (Exception) { }
        }
        Response.Redirect("ChangeMainImage.aspx?name=" + markerName + "&address=" + markerAddress);*/
        #endregion

        MarkerHelper myHelper = new MarkerHelper();
        myHelper.ChangeMainImage(markerName, markerAddress, SelectedImagePath);
        Response.Redirect("UserControlPanel.aspx");
    }
    private void Rename(string Path, string NewName)
    {
        FileInfo info = new FileInfo(Server.MapPath("~") + Path);
        if (info.Exists)
            info.MoveTo(Server.MapPath("~") + "Photos\\" + Request.QueryString["name"] as string + "-" + Request.QueryString["address"] as string + "\\" + NewName);
        else Page.Title = Server.MapPath("~") + "Photos\\" + Path;
    }
}