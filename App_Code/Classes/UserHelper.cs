using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for UserHelper
/// </summary>
public class UserHelper
{
    Helper MyHelper = new Helper();
    public DataSet SelectAllUsers()
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteSelectQuery("select * from [USERS]");
    }
    public bool CheckUserNameAndPassWord(string UserName, string Password)
    {
        MyHelper.OpenConnection();
        DataSet Ds = MyHelper.ExcuteSelectQuery("select USERNAME,PASSWORD from [USERS] where USERNAME='" + UserName + "'and PASSWORD='" + Password + "' ");
        if (Ds.Tables[0].Rows.Count > 0)
            return true;
        return false;
    }
    public bool CheckPasswordByUserId(int UserId, string Password)
    {
        MyHelper.OpenConnection();
        DataSet CheckPassword = MyHelper.ExcuteSelectQuery("select PASSWORD from [users] where USER_ID='" + UserId + "' ");
        if (CheckPassword.Tables[0].Rows[0][0].ToString() == Password)
            return true;
        else return false;
    }
    public string[] GetEmailAndRoleTypeAndUserId(string UserName)
    {
        MyHelper.OpenConnection();
        DataSet ds = MyHelper.ExcuteSelectQuery("select USER_ID,EMAIL,ROLE_ID from [USERS] where USERNAME='" + UserName + "'");
        string[] EmailAndRole = new string[3];
        int roleId = (int)ds.Tables[0].Rows[0][2];
        EmailAndRole[0] = ds.Tables[0].Rows[0][0].ToString();
        EmailAndRole[1] = ds.Tables[0].Rows[0][1].ToString();
        MyHelper.OpenConnection();
        DataSet ds1 = MyHelper.ExcuteSelectQuery("select DESCRIPTION from ROLES where ROLE_ID='" + roleId + "'");
        EmailAndRole[2] = ds1.Tables[0].Rows[0][0].ToString();
        return EmailAndRole;
    }
    public string[] GetEmailAndRoleType(string UserName)
    {
        MyHelper.OpenConnection();
        DataSet ds = this.SelectAllUsers();
        string[] EmailAndRole = new string[2];
        int roleId=0;
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            if (UserName == ds.Tables[0].Rows[i][4].ToString())
            {
                EmailAndRole[0] = ds.Tables[0].Rows[i][5].ToString();
                roleId =(int)ds.Tables[0].Rows[i][1];
            }
        }
        MyHelper.OpenConnection();
        DataSet ds1 = MyHelper.ExcuteSelectQuery("select DESCRIPTION from ROLES where ROLE_ID='" + roleId + "'");
        EmailAndRole[1] = ds1.Tables[0].Rows[0][0].ToString();
        return EmailAndRole;
    }
    public DataSet GetUserInfoByUsername(string UserName)
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteSelectQuery("select * from [USERS] where USERNAME='" + UserName + "'");
    }
    public String CheckUserNameAndEmail(string UserName, string Email)
    {
        string Result = "";
        bool foundUserName = false;
        bool foundEmail = false;
        MyHelper.OpenConnection();
        DataSet CheckEmail = MyHelper.ExcuteSelectQuery("select * from [USERS] where EMAIL='" + Email + "'");
        MyHelper.OpenConnection();
        DataSet CheckUserName = MyHelper.ExcuteSelectQuery("select * from [USERS] where USERNAME='" + UserName + "'");
        if (CheckEmail.Tables[0].Rows.Count > 0)
            foundEmail = true;
        if (CheckUserName.Tables[0].Rows.Count > 0)
            foundUserName = true;
        if (foundUserName == true && foundEmail == true)
            Result = "UserName And Email is Already Exists..";
        else if (foundUserName == false && foundEmail == true)
            Result = "Email is Already Exists..";

        else if (foundUserName == true && foundEmail == false)
            Result = "UserName is Already Exists..";
        else
            Result = "Done";
        return Result;
    }
    public bool CheckPhoneNumberByUsername(string PhoneNumber)
    {
        bool Found= false;
        DataSet ds = SelectAllUsers();
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            if (PhoneNumber == ds.Tables[0].Rows[i][9].ToString())
                Found = true;
        return Found;
    }
    public bool CheckPhoneNumberIfFound(string PhoneNumber)
    {
        bool Found = false;
        DataSet checkPhone = MyHelper.ExcuteSelectQuery("select * from [USERS] where CELLPHONE='" + PhoneNumber + "'");
        if (checkPhone.Tables[0].Rows.Count > 0)
            Found = true;
        return Found;
    }
    public string AddNewUser(USER MyUser)
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteNonQuary("insert into [USERS] (ROLE_ID,FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PASSWORD,ACCOUNT_TYPE_ID,CELLPHONE,GENDER) values('" + MyUser.ROLE_ID + "','" + MyUser.FIRST_NAME + "','" + MyUser.LAST_NAME + "','" + MyUser.USERNAME + "','" + MyUser.EMAIL + "','" + MyUser.PASSWORD + "','" + MyUser.ACCOUNT_TYPE_ID + "','" + MyUser.CELLPHONE + "','" + MyUser.GENDER + "')");
    }
    public string EditPersonalInfo(USER myUser)
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteNonQuary("update [USERS] set FIRST_NAME='" + myUser.FIRST_NAME + "',LAST_NAME='" + myUser.LAST_NAME + "' where USER_ID='" + myUser.USER_ID + "' ");
    }
    public string EditEmail(USER myUser)
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteNonQuary("update [USERS] set EMAIL='" + myUser.EMAIL + "' where USER_ID='" + myUser.USER_ID + "' ");
    }
    public string EditCellPhone(USER myUser)
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteNonQuary("update [USERS] set CELLPHONE='" + myUser.CELLPHONE + "' where USER_ID='" + myUser.USER_ID + "' ");
    }
    public string EditPassword(USER myUser)
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteNonQuary("update [USERS] set PASSWORD='" + myUser.PASSWORD + "' where USER_ID='" + myUser.USER_ID + "' ");
    }
    public DataSet GetAllAdmin()
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteSelectQuery("select * from USERS where ROLE_ID in (1,4,5) and USER_BLOCK=1;");
    }
    public void SetUserBlockById(int UserId)
    {
        MyHelper.OpenConnection();
        MyHelper.ExcuteNonQuary("update USERS set USER_BLOCK = 0 where USER_ID =" + UserId);
    }
    public DataSet GetAllUserForBlock()
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteSelectQuery("select * from USERS where ROLE_ID=2 and USER_BLOCK=1;");
    }
    public DataSet GetAllAdminBlocked()
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteSelectQuery("select * from USERS where ROLE_ID in (1,4,5) and USER_BLOCK=0;");
    }
    public void RemoveAdminBlockById(int AdminBlockId)
    {
        MyHelper.OpenConnection();
        MyHelper.ExcuteNonQuary("update USERS set USER_BLOCK=1 where USER_ID=" + AdminBlockId);
    }
    public DataSet GetAllUserBlocked()
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteSelectQuery("select * from USERS where ROLE_ID=2 and USER_BLOCK=0;");
    }
    public DataSet GetAdminActiveName()
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteSelectQuery("select USERNAME from USERS  where ROLE_ID in (1,4,5) and USER_BLOCK=1");
    }
    public void DeleteAdminVyId(int ID)
    {
        MyHelper.OpenConnection();
        MyHelper.ExcuteNonQuary("Delete from dbo.USERS where USER_ID=" + ID);
    }
    public DataSet GetNewUsersLast7()
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteSelectQuery("select USERNAME,EMAIL,INITIALIZE_DATE from USERS where  CURRENT_TIMESTAMP-INITIALIZE_DATE<=8 and ROLE_ID in(2); ");
    }
    public DataSet GetNewUsersLast30()
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteSelectQuery("select USERNAME,EMAIL,INITIALIZE_DATE from USERS where  CURRENT_TIMESTAMP-INITIALIZE_DATE<=31 and ROLE_ID =2;");
    }
    public DataSet SelectAllUser()
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteSelectQuery("select USERNAME,EMAIL,INITIALIZE_DATE from USERS where  ROLE_ID =2;");
    }
    public string RemoveAdminById(int AdminID)
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteNonQuary("delete from USERS where USER_ID=" + AdminID);
    }
    public void EditAdminRoleByUSERNAME(string UserName, int RoleId)
    {
        MyHelper.OpenConnection();
        MyHelper.ExcuteNonQuary("update USERS set[ROLE_ID]=" + RoleId + " where USERNAME='" + UserName + "'");
    }
    public string EditAdminGender(USER user, int AdminId)
    {
        MyHelper.OpenConnection();
        return MyHelper.ExcuteNonQuary("update USERS Set [GENDER] ='" + user.GENDER + "'  where USER_ID='" + AdminId + "'");
    }
}