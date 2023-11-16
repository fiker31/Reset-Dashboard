using DAL.Framework;
using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Net;

namespace DAL
{
	public class CustomerRegistrationData : BaseData<CustomerRegistration>
    {
        #region Overrides
        public override List<CustomerRegistration> Select()
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                List<CustomerRegistration> TD = (from td in db.CustomerRegistrations
												  select td ).ToList();
                return TD;

              //  List<CustomerRegistration> customerRegistrations= db.CustomerRegistrations.Select(c=>c.PhoneNumber, c.Status,c.FullName,c.RegistrationDate).ToList();
            }
        }

        public override CustomerRegistration Select(string id)
        {

            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                var TD = (from td in db.CustomerRegistrations
						  where td.CustomerRegistrationID.ToString() == id
						  select td);
                if (TD.Count() != 0)
                {
                    return TD.Single();
                }
                else
                {
                    return null;
                }
            }
        }
        public override CustomerRegistration Select(long id)
        {
            throw new NotImplementedException();
        }
        public void Delete(DBDataContext db, Guid id, Binary version)
        {
			CustomerRegistration TD = new CustomerRegistration();
            TD.CustomerRegistrationID = id;
            TD.Version = version;
            db.CustomerRegistrations.Attach(TD);
            db.CustomerRegistrations.DeleteOnSubmit(TD);
            db.SubmitChanges();
        }
        public override void Delete(DBDataContext db, string id, Binary version)
        {
            throw new NotImplementedException();
        }
        public override void Delete(DBDataContext db, long id, Binary version)
        {
            throw new NotImplementedException();
        }
        #endregion Overrides
        #region Insert
        public Guid Insert(string connectionString, string PhoneNumber, string FullName, DateTime RegistrationDate, string DeviceID, string OTP,DateTime OTPGenratedDate,DateTime OTPExpireDate,DateTime OTPConfimationDate, string Status,string Password,string AppKey,DateTime AppKeyExpireDate,Guid AppVersionID,Decimal Balance, string insertUserId)
        {
            using (DBDataContext db = new DBDataContext(connectionString))
            {
                return Insert(db,  PhoneNumber,  FullName,  RegistrationDate,  DeviceID,  OTP,  OTPGenratedDate,  OTPExpireDate,  OTPConfimationDate,  Status,  Password,  AppKey,  AppKeyExpireDate,  AppVersionID,  Balance, insertUserId);
            }
        }
        public Guid Insert(DBDataContext db, string PhoneNumber, string FullName, DateTime RegistrationDate, string DeviceID, string OTP, DateTime OTPGenratedDate, DateTime OTPExpireDate, DateTime OTPConfimationDate, string Status, string Password, string AppKey, DateTime AppKeyExpireDate, Guid AppVersionID, Decimal Balance, string insertUserId)
        {
			//Create a new object 
			CustomerRegistration TD = new CustomerRegistration
			{
				PhoneNumber= PhoneNumber,
                FullName= FullName, 
                RegistrationDate= RegistrationDate,
				DeviceID= DeviceID,
                OTP= OTP,
                OTPGenratedDate= OTPGenratedDate,
                OTPExpireDate=OTPExpireDate,
                OTPConfimationDate=OTPConfimationDate,
                Status=Status, 
                Password= Password, 
                AppKey= AppKey, 
                AppKeyExpireDate= AppKeyExpireDate,
                AppVersionID=AppVersionID,
                Balance= Balance,
				InsertUser = insertUserId,
                UpdateUser = insertUserId,
                UpdateDate = DateTime.Now,
                InsertDate = DateTime.Now,
            };
            //save the record to the object model
            db.CustomerRegistrations.InsertOnSubmit(TD);
            //send changes to the database
            db.SubmitChanges();
            return (TD.CustomerRegistrationID);
        }
        #endregion Insert
        #region Update
        public bool Update(string connectionString, Guid CustomerRegistrationID, string PhoneNumber, string FullName, DateTime RegistrationDate, string DeviceID, string OTP, DateTime OTPGenratedDate, DateTime OTPExpireDate, DateTime OTPConfimationDate, string Status, string Password, string AppKey, DateTime AppKeyExpireDate, Guid AppVersionID, Decimal Balance, string insertUserId, string updateUserId, DateTime entryDate, Binary version)
        {
            using (DBDataContext db = new DBDataContext(connectionString))
            {
                return Update(db, CustomerRegistrationID,  PhoneNumber,  FullName,  RegistrationDate,  DeviceID,  OTP,  OTPGenratedDate,  OTPExpireDate,  OTPConfimationDate,  Status,  Password,  AppKey,  AppKeyExpireDate,  AppVersionID,  Balance, insertUserId, updateUserId, entryDate, version);
            }
        }
        public bool Update(DBDataContext db, Guid CustomerRegistrationID, string PhoneNumber, string FullName, DateTime RegistrationDate, string DeviceID, string OTP, DateTime OTPGenratedDate, DateTime OTPExpireDate, DateTime OTPConfimationDate, string Status, string Password, string AppKey, DateTime AppKeyExpireDate, Guid AppVersionID, Decimal Balance, string insertUserId, string updateUserId, DateTime entryDate, Binary version)
        {
			//Create a new object 
			CustomerRegistration TD = new CustomerRegistration
			{
				CustomerRegistrationID = CustomerRegistrationID,
				PhoneNumber = PhoneNumber,
				FullName = FullName,
				RegistrationDate = RegistrationDate,
				DeviceID = DeviceID,
				OTP = OTP,
				OTPGenratedDate = OTPGenratedDate,
				OTPExpireDate = OTPExpireDate,
				OTPConfimationDate = OTPConfimationDate,
				Status = Status,
				Password = Password,
				AppKey = AppKey,
				AppKeyExpireDate = AppKeyExpireDate,
				AppVersionID = AppVersionID,
				Balance = Balance,
				InsertUser = insertUserId,
                UpdateUser = updateUserId,
                UpdateDate = DateTime.Now,
                InsertDate = entryDate,
                Version = version,
            };
            //save the record to the object model
            db.CustomerRegistrations.Attach(TD, true);
            //send changes to the database
            db.SubmitChanges();
            return true;
        }
        #endregion Update
        #region Other Methods
        public List<CustomerRegistration> SelectByPhoneNumber(string PhoneNumber)
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                List<CustomerRegistration> TD = (from td in db.CustomerRegistrations
												 where td.PhoneNumber == PhoneNumber
												  select td).ToList();
                return TD;
            }
        }
        public bool IsDuplicateEntry(string PhoneNumber)
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                int result = (from td in db.CustomerRegistrations
							  where td.PhoneNumber == PhoneNumber
							  select td).Count();
                return (result > 0);
            }
        }
        #endregion Other Methods
    }
}
