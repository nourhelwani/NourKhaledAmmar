using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;

public static class JSONHelper
{
    static MarkerHelper mh = new MarkerHelper();
    static CategoriesHelper ch = new CategoriesHelper();
    static GenreHelper gh = new GenreHelper();
    static AdvertismentHelper ah = new AdvertismentHelper();
    static UserHelper UH = new UserHelper();

    public static string SerializeDataset(DataSet ds)
    {
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            row = new Dictionary<string, object>();
            foreach (DataColumn col in ds.Tables[0].Columns)
            {
                row.Add(col.ColumnName, dr[col]);
            }
            rows.Add(row);
        }
        return serializer.Serialize(rows);
    }

    public static string AllMarkers()
    {
        DataSet ds = mh.SelectAllMarkersTest();
        return SerializeDataset(ds);
    }
    public static string AllMarkersHome()
    {
        return JSONHelper.SerializeDataset(mh.SelectAllMarker());
    }
    public static string MarkersInfoForSearch()
    {
        return SerializeDataset(mh.GetMarkersSearchInfo());
    }
    public static string MarkersViaUser(int userID)
    {
        return SerializeDataset(mh.GetMarkerByUserId(userID));
    }
    public static string GetMasterMarkerByUserId(int userId)
    {
        return SerializeDataset(mh.GetMasterByUserId(userId));
    }
    public static string GetMarkerInfoViaID(int markerID)
    {
        return SerializeDataset(mh.SelectMarkerViaID(markerID));
    }
    public static string GetAllSubCategories(int genreID)
    {
        return SerializeDataset(ch.SelectAllSubCategories(genreID));
    }
    public static string GetAllGeners()
    {
        return SerializeDataset(gh.SelectAllGeners());
    }
    public static string GetMarkerCanAddAdvertisment(int UserId)
    {
        DataSet ds = mh.GetMarkerCanAddAdvertisment(UserId);
        return SerializeDataset(ds);
    }
    public static string GetMarkerHaveAvilableAdvertisment(int UserId)
    {
        DataSet ds = mh.GetMarkerHaveAvilableAdvertisment(UserId);
        return SerializeDataset(ds);
    }
    public static string GetAdvertisementInfoViaID(int AdvID)
    {
        return SerializeDataset(ah.GetAdvertisementInfoViaID(AdvID));
    }
    public static string GetMarkerHaveAvilableEvent(int UserId)
    {
        return SerializeDataset(mh.GetMarkerHaveAvilableEvent(UserId));
    }
    public static string GetMarkerByType(string Gener)
    {
        return SerializeDataset(mh.GetMarkerByType(Gener));
    }
    public static string GetMarkerNotEventByUserId(int UserId)
    {
        return SerializeDataset(mh.GetMarkerNotEventByUserId(UserId));
    }
    public static string GetAllMarkerForApprov()
    {
        DataSet ds = mh.GetMarkerNotValid();
        return SerializeDataset(ds);
    }
    public static string GetAllMarkerWaitingApprov()
    {
        DataSet ds = mh.GetMarkerWaitingValid();
        return SerializeDataset(ds);
    }
    public static string GetAllMarkerEventForApprove()
    {
        DataSet ds = ah.GetAllEventToApprove();
        return SerializeDataset(ds);
    }
    public static string GetAllMarkerAdsForApprove()
    {
        DataSet ds = ah.GetAllAdsToApprove();
        return SerializeDataset(ds);
    }
    public static string GetNewMarkers()
    {
        DataSet ds = mh.ReturnNewMarkers();
        return SerializeDataset(ds);
    }
    public static string GetAdminSugget()
    {
        DataSet ds = UH.GetAdminActiveName();
        return SerializeDataset(ds);
    }
}