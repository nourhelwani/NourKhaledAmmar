using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for AdvertismentHelper
/// </summary>
public class AdvertismentHelper
{
    Helper myHelper;
    public AdvertismentHelper()
    {
        myHelper = new Helper();
    }
    public string AddNewAdvertisment(ADVERTISMENT adv)
    {
        myHelper.OpenConnection();
        return myHelper.ExcuteNonQuary("insert into [ADVERTISMENTS] (ADVERTISMENT_TYPE_ID,MARKER_ID,DESCRIPTION,EXPIRE_DATE,IS_PROMOTED) values('" + adv.ADVERTISMENT_TYPE_ID + "','" + adv.MARKER_ID + "','" + adv.DESCRIPTION + "','" + adv.EXPIRE_DATE.ToString("yyyy-MM-dd") + "','" + adv.IS_PROMOTED + "')");
    }
    public DataSet GetAdvertismentCanPromot(int UserId)
    {
        myHelper.OpenConnection();
        return myHelper.ExcuteSelectQuery("select  MARKERS.MARKER_NAME,MARKERS.ADDRESS,ADVERTISMENTS.DESCRIPTION Adertisment_Description ,ADVERTISMENTS.EXPIRE_DATE ,ADVERTISMENTS.ADVERTISMENT_ID from ADVERTISMENTS right join MARKERS on MARKERS.MARKER_ID=ADVERTISMENTS.MARKER_ID where MARKERS.USER_ID='" + UserId + "' and MARKERS.IS_EVENT=0 and ADVERTISMENTS.ADVERTISMENT_TYPE_ID=2 and ADVERTISMENTS.EXPIRE_DATE>'" + DateTime.Now.ToString("yyyy-MM-dd") + "' and ADVERTISMENTS.IS_PROMOTED=0");
    }
    public string PromoteAdvertisment(int AdvID)
    {
        myHelper.OpenConnection();
        return myHelper.ExcuteNonQuary("update ADVERTISMENTS set IS_PROMOTED=1 where ADVERTISMENT_ID='" + AdvID + "'");
    }
    public DataSet GetAdvertisementInfoViaID(int AdvertisementID)
    {
        myHelper.OpenConnection();
        return myHelper.ExcuteSelectQuery("select * from [ADVERTISMENTS] where ADVERTISMENT_ID=" + AdvertisementID);
    }
    public string UpdateAdvertismentInfo(ADVERTISMENT adv)
    {
        myHelper.OpenConnection();
        return myHelper.ExcuteNonQuary("update ADVERTISMENTS set DESCRIPTION='" + adv.DESCRIPTION + "',EXPIRE_DATE='" + adv.EXPIRE_DATE.ToString("yyyy-MM-dd") + "' where ADVERTISMENT_ID='" + adv.ADVERTISMENT_ID + "'");
    }
    public DataSet GetAdvertismentViaMarkerId(int MarkerId)
    {
        myHelper.OpenConnection();
        return myHelper.ExcuteSelectQuery("select * from ADVERTISMENTS where MARKER_ID='" + MarkerId + "'");
    }
    public DataSet ReturnNewAds()
    {
        myHelper.OpenConnection();
        return myHelper.ExcuteSelectQuery("select * from ADVERTISMENTS where CURRENT_TIMESTAMP-INITIALIZE_DATE<=7");
    }
    public DataSet GetAllAdsToApprove()
    {
        myHelper.OpenConnection();
        return myHelper.ExcuteSelectQuery("select MARKERS.MARKER_NAME MN,MARKERS.LAT MLA,MARKERS.LNG MLN,ADVERTISMENTS.*,ADVERTISMENT_TYPES.DESCRIPTION ADST_T from MARKERS inner join ADVERTISMENTS on MARKERS.MARKER_ID=ADVERTISMENTS.MARKER_ID and ADVERTISMENTS.IS_PROMOTED=1 and ADVERTISMENTS.IS_APPROVE_PROMOT=0 inner join ADVERTISMENT_TYPES on ADVERTISMENT_TYPES.ADVERTISMENT_TYPE_ID=ADVERTISMENTS.ADVERTISMENT_TYPE_ID and ADVERTISMENT_TYPES.ADVERTISMENT_TYPE_ID=2;");
    }
    public void DeleteAdsById(int AdsID)
    {
        myHelper.OpenConnection();
        myHelper.ExcuteNonQuary("delete from [ADVERTISMENTS] where ADVERTISMENT_ID='" + AdsID + "';");
    }
    public DataSet GetAllEventToApprove()
    {
        myHelper.OpenConnection();
        return myHelper.ExcuteSelectQuery("select MARKERS.MARKER_NAME MN,MARKERS.LAT MLA,MARKERS.LNG MLN,ADVERTISMENTS.*,ADVERTISMENT_TYPES.DESCRIPTION ADST_T from MARKERS inner join ADVERTISMENTS on MARKERS.MARKER_ID=ADVERTISMENTS.MARKER_ID and ADVERTISMENTS.IS_PROMOTED=1 and ADVERTISMENTS.IS_APPROVE_PROMOT=0 inner join ADVERTISMENT_TYPES on ADVERTISMENT_TYPES.ADVERTISMENT_TYPE_ID=ADVERTISMENTS.ADVERTISMENT_TYPE_ID and ADVERTISMENT_TYPES.ADVERTISMENT_TYPE_ID=1;");
    }
    public void ApproveEventByID(int ID)
    {
        myHelper.OpenConnection();
        myHelper.ExcuteNonQuary("update ADVERTISMENTS set IS_APPROVE_PROMOT = 1 where ADVERTISMENT_ID=" + ID);
    }
    public DataSet GetAllValidAdvertismetInfo(String sortType, string typeIs, bool isApprovePromted)
    {
        string where = "";
        if (typeIs != "")
        {
            where = "and ADS_TYPE='" + typeIs + "'";
        }

        if (isApprovePromted == true)
        {
            where += " where IS_APPROVE_PROMOT= 1";
        }


        string s = sortType.ToUpper();
        switch (s)
        {
            case "NEWEST":
                myHelper.OpenConnection();
                return myHelper.ExcuteSelectQuery("select * from [ENABLED_ADVERTISMENTS]    " + where + " order by INITIALIZE_DATE DESC");
            case "OLDEST":
                myHelper.OpenConnection();
                return myHelper.ExcuteSelectQuery("select * from [ENABLED_ADVERTISMENTS]   " + where + " order by INITIALIZE_DATE");
            case "MOSTVISTED":
                myHelper.OpenConnection();
                return myHelper.ExcuteSelectQuery("select * from [ENABLED_ADVERTISMENTS]   " + where + " order by VISITS_COUNTER DESC");
            case "CATEGORY":
                myHelper.OpenConnection();
                return myHelper.ExcuteSelectQuery("select * from [ENABLED_ADVERTISMENTS]   " + where + " order by GENERS");

        }
        myHelper.OpenConnection();
        return myHelper.ExcuteSelectQuery("select * from [ENABLED_ADVERTISMENTS]   " + where + " order by INITIALIZE_DATE DESC");
    }
    public DataSet getIntilizeAndExpireDate(string adsID)
    {
        myHelper.OpenConnection();
        return myHelper.ExcuteSelectQuery("select INITIALIZE_DATE,EXPIRE_DATE FROM [ENABLED_ADVERTISMENTS] where ADVERTISMENT_ID=" + adsID + "");
    }

    public DataSet GetAllValidAdvertismetInfoByMarkerName(string markerName)
    {
        return myHelper.ExcuteSelectQuery("select * from [ENABLED_ADVERTISMENTS] where MARKER_NAME='" + markerName + "'");

    }
    public DataSet GetAdvertismentViaGeners(string generName, string sortBy, string type, bool isApprovePromted)
    {
        string where = "";
        if (type != "")
        {
            where = "and ADS_TYPE='" + type + "'";
        }

        if (isApprovePromted == true)
        {
            where += "IS_APPROVE_PROMOT= 1";
        }

        string s = sortBy.ToUpper();
        switch (s)
        {
            case "NEWEST":
                myHelper.OpenConnection();
                return myHelper.ExcuteSelectQuery("select * from [ENABLED_ADVERTISMENTS]  where   GENERS='" + generName + "' " + where + " order by INITIALIZE_DATE DESC");
            case "OLDEST":
                myHelper.OpenConnection();
                return myHelper.ExcuteSelectQuery("select * from [ENABLED_ADVERTISMENTS]  where  GENERS='" + generName + "' " + where + " order by INITIALIZE_DATE");
            case "MOSTVISTED":
                myHelper.OpenConnection();
                return myHelper.ExcuteSelectQuery("select * from [ENABLED_ADVERTISMENTS]  where  GENERS='" + generName + "' " + where + " order by VISITS_COUNTER DESC");
            case "CATEGORY":
                myHelper.OpenConnection();
                return myHelper.ExcuteSelectQuery("select * from [ENABLED_ADVERTISMENTS]  where  GENERS='" + generName + "' " + where + " order by GENERS");
            default: myHelper.OpenConnection();
                return myHelper.ExcuteSelectQuery("select * from [ENABLED_ADVERTISMENTS]  where  GENERS='" + generName + "' " + where + " order by INITIALIZE_DATE DESC");
        }
    }
}