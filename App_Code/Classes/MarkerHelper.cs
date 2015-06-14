using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.IO;

/// <summary>
/// Summary description for MarkerHelper
/// </summary>
/// 

public class MarkerHelper
{
    Helper Helper;

    public MarkerHelper()
    {
        Helper = new Helper();
    }

    public DataSet SelectMarkerViaID(int markerID)
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select * from [MARKERS] where MARKER_ID=" + markerID);
    }

    public DataSet SelectAllMarker()
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select * from [MARKERS]");
    }

    public DataSet SelectAllPendingMarkers()
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select * from [MARKERS] where IS_APPORVED=0");
    }

    public DataSet SelectAllMarkersXMLOutput()
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("Select * From [MARKERS] FOR XML RAW,elements,root(\'markers\')");
    }
    public DataSet GetMarkersSearchInfo()
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select id=[MARKER_ID],address=[ADDRESS],name=[MARKER_NAME] from [MARKERS] ");
    }
    public DataSet SelectAllMarkersTest()
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select id=[MARKER_ID],master=[MASTER_ID],MARKER_NAME,owner=[USER_ID],iniDate=[INITIALIZE_DATE],content=[DESCRIPTION],lat=[LAT],lng=[LNG],address=[ADDRESS] from [MARKERS]");
    }

    public int GetMasterId(string MarkerName)
    {
        int MasterId = -1;
        DataSet AllMarker = this.SelectAllMarker();
        for (int i = 0; i < AllMarker.Tables[0].Rows.Count; i++)
        {
            if (MarkerName == AllMarker.Tables[0].Rows[i][4].ToString())
            {
                MasterId = int.Parse(AllMarker.Tables[0].Rows[i][1].ToString());
                if (MasterId == -1)
                {
                    DataSet AllMaster = this.SelectAllMarker();
                    for (int j = 0; j < AllMaster.Tables[0].Rows.Count; j++)
                    {
                        if (MasterId < int.Parse(AllMaster.Tables[0].Rows[j][1].ToString()))
                        {
                            MasterId = int.Parse(AllMaster.Tables[0].Rows[j][1].ToString());
                        }
                    }
                    MasterId += 1;
                    Helper.OpenConnection();
                    Helper.ExcuteNonQuary("update [MARKERS]set [MASTER_ID]='" + MasterId + "' where [MARKER_NAME]='" + MarkerName + "'");
                }
                else
                {
                    return MasterId;
                }
            }
            else
            {
                MasterId = -1;
            }
        }
        return MasterId;
    }
    public void FlushMasterId(int MasterId)
    {
        Helper.OpenConnection();
        Helper.ExcuteNonQuary("update[MARKERS] set [MASTER_ID]='" + -1 + "'where [MASTER_ID]='" + MasterId + "'");
    }
    public DataSet GetMarkerInfoByMarkerName(string MarkerName)
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select * from [MARKERS] where [MARKER_NAME]='" + MarkerName + "'");
    }
    public DataSet GetMarkerByUserId(int UserId)
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select * from [MARKERS] where [USER_ID]='" + UserId + "' ");
    }
    public DataSet GetMasterByUserId(int UserId)
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select * from MARKERS where MASTER_ID=-1 and USER_ID='" + UserId + "'");
    }

    public int GetLastInsertedMarkerID()
    {
        DataSet allMarkers = SelectAllMarker();
        return Convert.ToInt32(allMarkers.Tables[0].Rows[allMarkers.Tables[0].Rows.Count - 1][0]);
    }

    public string AddMarker(MARKER toAdd)
    {
        Helper.OpenConnection();
        return Helper.ExcuteNonQuary("insert into [MARKERS] (USER_ID,MARKER_NAME,DESCRIPTION,LNG,LAT,ADDRESS,TYPE) values(" + toAdd.USER_ID + ",'" + toAdd.MARKER_NAME + "','" + toAdd.DESCRIPTION + "'," + toAdd.LNG + "," + toAdd.LAT + ",'" + toAdd.ADDRESS + "','" + toAdd.TYPE + "')");
    }
    public string AddMarkerWithOpeningTime(MARKER toAdd)
    {
        Helper.OpenConnection();
        return Helper.ExcuteNonQuary("insert into [MARKERS] (USER_ID,MARKER_NAME,DESCRIPTION,LNG,LAT,ADDRESS,TYPE,TIME_FROM,TIME_TO,DAYS_OPEN) values(" + toAdd.USER_ID + ",'" + toAdd.MARKER_NAME + "','" + toAdd.DESCRIPTION + "'," + toAdd.LNG + "," + toAdd.LAT + ",'" + toAdd.ADDRESS + "','" + toAdd.TYPE + "','" + toAdd.TIME_FROM + "','" + toAdd.TIME_TO + "','" + toAdd.DAYS_OPEN + "')");
    }
    public string AddBranch(MARKER toAdd)
    {
        Helper.OpenConnection();
        return Helper.ExcuteNonQuary("insert into [MARKERS] (USER_ID,MASTER_ID,MARKER_NAME,DESCRIPTION,LNG,LAT,ADDRESS,TYPE) values(" + toAdd.USER_ID + "," + toAdd.MASTER_ID + ",'" + toAdd.MARKER_NAME + "','" + toAdd.DESCRIPTION + "'," + toAdd.LNG + "," + toAdd.LAT + ",'@" + toAdd.ADDRESS + "','" + toAdd.TYPE + "')");
    }
    public string EditMarker(string description, int markerId)
    {
        Helper.OpenConnection();
        return Helper.ExcuteNonQuary("update [MARKERS] set [DESCRIPTION='" + description + "'] where [MARKER_ID]=" + markerId);
    }

    public string AddMarkerForEvent(MARKER toAdd)
    {
        Helper.OpenConnection();
        return Helper.ExcuteNonQuary("insert into [MARKERS] (USER_ID,MARKER_NAME,DESCRIPTION,LNG,LAT,ADDRESS,IS_EVENT,Type) values(" + toAdd.USER_ID + ",'" + toAdd.MARKER_NAME + "','" + toAdd.DESCRIPTION + "'," + toAdd.LNG + "," + toAdd.LAT + ",'@" + toAdd.ADDRESS + "','" + toAdd.IS_EVENT + "','" + toAdd.TYPE + "')");
    }
    public DataSet GetMarkerCanAddAdvertisment(int UserId)
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("   ");
    }
    public DataSet GetMarkerHaveAvilableAdvertisment(int UserID)
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select MARKERS.MARKER_NAME,MARKERS.LAT,MARKERS.LNG,ADVERTISMENTS.ADVERTISMENT_ID,ADVERTISMENTS.DESCRIPTION,ADVERTISMENTS.EXPIRE_DATE from ADVERTISMENTS  inner join MARKERS on MARKERS.MARKER_ID=ADVERTISMENTS.MARKER_ID where MARKERS.USER_ID='" + UserID + "' and ADVERTISMENTS.EXPIRE_DATE>'" + DateTime.Now.ToString("yyyy-MM-dd") + "'");
    }

    public DataSet SelectMarkerViaMarkerName(string markerName)
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select * from [MARKERS] where [MARKER_NAME] like '" + markerName + "'");
    }
    public DataSet GetMarkerByType(string Gener)
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select * from MARKERS where TYPE='" + Gener + "' and IS_EVENT=0");
    }
    public DataSet GetMarkerHaveAvilableEvent(int UserId)
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select MARKERS.MARKER_NAME,MARKERS.LAT,MARKERS.LNG,MARKERS.ADDRESS,ADVERTISMENTS.ADVERTISMENT_ID,ADVERTISMENTS.MARKER_ID,ADVERTISMENTS.DESCRIPTION,ADVERTISMENTS.EXPIRE_DATE from MARKERS right join ADVERTISMENTS on MARKERS.MARKER_ID=ADVERTISMENTS.MARKER_ID where USER_ID='" + UserId + "' and (MARKERS.IS_EVENT=1 or ADVERTISMENTS.ADVERTISMENT_TYPE_ID=1 ) and ADVERTISMENTS.EXPIRE_DATE>'" + DateTime.Now.ToString("yyyy-MM-dd") + "'");
    }
    public DataSet GetMarkerNotEventByUserId(int UserId)
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select * from [MARKERS] where [USER_ID]='" + UserId + "' and IS_EVENT=0 ");
    }
    public DataSet GetMarkerInfoByMarkerId(int MarkerId)
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select * from [MARKERS] where [MARKER_ID]='" + MarkerId + "'");
    }
    public string ChangeMainImage(string MarkerName, string Address, string ImagePath)
    {
        Helper.OpenConnection();
        return Helper.ExcuteNonQuary("Update [MARKERS] set [MAIN_IMAGE_PATH]='" + ImagePath + "' where [MARKER_NAME]='" + MarkerName + "' And [ADDRESS]='" + Address + "';");
    }
    public DataSet GetMarkerPosition(int markerID)
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("Select [LAT],[LNG] from [MARKERS] where MARKER_ID=" + markerID);
    }
    public string VoteUp(int markerId)
    {
        Helper.OpenConnection();
        return Helper.ExcuteNonQuary("update [MARKERS] set APPROVAL_VOTE = APPROVAL_VOTE + 1 where MARKER_ID = " + markerId);
    }
    public string VoteDown(int markerId)
    {
        Helper.OpenConnection();
        return Helper.ExcuteNonQuary("update [MARKERS] set APPROVAL_VOTE = APPROVAL_VOTE - 1 where MARKER_ID = " + markerId);
    }
    public DataSet GetMarkerVisit()
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select MARKER_NAME,VISITS_COUNTER from MARKERS");
    }
    public void BlockMarker(int Marker_Id)
    {
        Helper.OpenConnection();
        Helper.ExcuteNonQuary("update [MARKERS] set [IS_APPORVED]= 3 where [MARKER_ID]=" + Marker_Id);
    }
    public DataSet ReturnNewMarkerLastMonthForChart()
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select INITIALIZE_DATE,Count(*)[MARKER_ADDED] from [MARKERS]  where CURRENT_TIMESTAMP-INITIALIZE_DATE<=31GROUP BY INITIALIZE_DATE;");
    }
    public DataSet ReturnNewMarkerLast7ForChart()
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select INITIALIZE_DATE,Count(*)[MARKER_ADDED] from [MARKERS]  where CURRENT_TIMESTAMP-INITIALIZE_DATE<=7GROUP BY INITIALIZE_DATE;");
    }
    public void ApproveMark(int Marker_Id)
    {
        Helper.OpenConnection();
        Helper.ExcuteNonQuary("update [MARKERS] Set [IS_APPORVED] = 1 where [MARKER_ID] ='" + Marker_Id + "'");
    }
    public void WaitMarker(int Marker_Id)
    {
        Helper.OpenConnection();
        Helper.ExcuteNonQuary("update [MARKERS] set [IS_APPORVED]= 2 where [MARKER_ID]='" + Marker_Id + "'");
    }
    public void DeleteMarkById(int Marker_Id)
    {
        Helper.OpenConnection();
        Helper.ExcuteNonQuary("");
    }
    public DataSet ReturnNewMarkers()
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select * from MARKERS where CURRENT_TIMESTAMP-INITIALIZE_DATE<=7;");
    }
    public DataSet GetMarkerWaitingValid()
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select id=[MARKER_ID],master=[MASTER_ID],owner=[USER_ID],iniDate=[INITIALIZE_DATE],content=[DESCRIPTION],lat=[LAT],lng=[LNG] from [MARKERS] where [IS_APPORVED]= 2");
    }
    public DataSet GetAvalibaleMarkForBlock()
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select * From [MARKERS] where [IS_APPORVED]= 1 ");
    }
    public DataSet GetMarkerBlocked()
    {
        return Helper.ExcuteSelectQuery("select * From [MARKERS] where [IS_APPORVED]= 3");
    }
    public void RemoveMarkBlockById(int Marker_Id)
    {
        Helper.OpenConnection();
        Helper.ExcuteNonQuary("update [MARKERS] set [IS_APPORVED]= 1 where [MARKER_ID]=" + Marker_Id);
    }
    public DataSet GetMarkerNotValid()
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select id=[MARKER_ID],master=[MASTER_ID],owner=[USER_ID],iniDate=[INITIALIZE_DATE],content=[DESCRIPTION],lat=[LAT],lng=[LNG] from [MARKERS] where [IS_APPORVED]= 0");
    }
    public List<ImageList> getImagesPath(string markerName, string markerAddress, string path)
    {
        List<ImageList> toReturn = new List<ImageList>();
        try
        {

            DirectoryInfo di = new DirectoryInfo(path);
            string teldePath = @"~\photos\" + markerName + "-" + markerAddress;
            if (di.Exists)
            {
                foreach (FileInfo file in di.GetFiles())
                {

                    toReturn.Add(new ImageList { FilePath = path + "\\" + file.Name, fileName = file.Name, teldePath = teldePath + "\\" + file.Name });
                }
                return toReturn;
            }
        }
        catch { }
        return null;
    }
    public DataSet GetRateViaMarkerId(int MarkerId)
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select RATE,RATE_COUNT from MARKERS where MARKER_ID='" + MarkerId + "'");
    }
    public DataSet getMarkerAddress(int markerId)
    {
        Helper.OpenConnection();
        return Helper.ExcuteSelectQuery("select ADDRESS from MARKERS where MARKER_ID=" + markerId);
    }
    public string UpdateVisitCounter(int MarkerId)
    {
        Helper.OpenConnection();
        return Helper.ExcuteNonQuary("update MARKERS set VISITS_COUNTER=VISITS_COUNTER+1 where MARKER_ID='" + MarkerId + "'");
    }
    public string UpdateRate(MARKER mkRate)
    {
        Helper.OpenConnection();
        return Helper.ExcuteNonQuary("update MARKERS set RATE= (RATE + '" + mkRate.RATE + "') , RATE_COUNT=(RATE_COUNT+1) where MARKER_ID='" + mkRate.MARKER_ID + "'  ");
    }

}