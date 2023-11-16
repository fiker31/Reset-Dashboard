using BLL.Framework;
using System;
using System.Collections.Generic;
using DAL;
using DAL.Framework;
namespace BLL
{
    #region CustomerRegistrationBO
    [Serializable()]
    public class CustomerRegistrationBO: BaseEO
    {
        public CustomerRegistrationBO()
        {
        }
        #region Properties
        public Guid CustomerRegistrationID { get; set; }
        public string PhoneNumber { get; set; }
        public string FullName { get; set; }
        public DateTime RegistrationDate { get; set; }
        public string Status { get; set; }
        public string DeviceID { get; set; }
        public string OTP { get; set; }
        public DateTime OTPGenratedDate { get; set; }
        public DateTime OTPExpireDate { get; set; }
        public DateTime OTPConfimationDate { get; set; }
        public string Password { get; set; }
        public string AppKey { get; set; }
        public DateTime AppKeyExpireDate { get; set; }
        public Guid AppVersionID { get; set; }
        public decimal Balance { get; set; }


        #endregion Properties
        #region Overrides
        public override bool Load(long CustomerRegistrationID)
        {
            //Get the entity object from the DAL.
            throw new NotImplementedException();

        }
      
        public override bool Load(string CustomerRegistrationID)
        {
            //Get the entity object from the DAL.
            CustomerRegistration td = new CustomerRegistrationData().Select(CustomerRegistrationID);
            if (td != null)
            {
                MapEntityToProperties(td);
                return true;
            }
            else
            {
                return false;
            }
        }
        protected override void MapEntityToCustomProperties(IBaseEntity entity)
        {
			CustomerRegistration td = (CustomerRegistration)entity;
			CustomerRegistrationID = td.CustomerRegistrationID;
            PhoneNumber = td.PhoneNumber;
            FullName = td.FullName;
            RegistrationDate = (DateTime)td.RegistrationDate;
            Status = td.Status;
            DeviceID = td.DeviceID;
            OTP = td.OTP;
            OTPGenratedDate = (DateTime)td.OTPGenratedDate;
            OTPExpireDate = (DateTime)td.OTPExpireDate;
            OTPConfimationDate = (DateTime)td.OTPConfimationDate;
            Password = td.Password;
            AppKey = td.AppKey;
            AppKeyExpireDate = (DateTime)td.AppKeyExpireDate;
            AppVersionID = (Guid)td.AppVersionID;
            Balance =(Decimal) td.Balance;


	}
	public override bool Save(DBDataContext db, ref EntValidationErrors validationErrors, string userAccountId)
        {
            if (DBAction == DBActionEnum.Insert || DBAction == DBActionEnum.Update)
            {
                //Validate the object
                Validate(db, ref validationErrors);
                //Check if there were any validation errors
                if (validationErrors.Count == 0)
                {
                    if (DBAction == DBActionEnum.Insert)
                    {
						//Add
						CustomerRegistrationID = new CustomerRegistrationData().Insert(db, PhoneNumber, FullName, RegistrationDate, DeviceID, OTP, OTPGenratedDate, OTPExpireDate, OTPConfimationDate, Status, Password, AppKey, AppKeyExpireDate, AppVersionID, Balance, userAccountId);
                    }
                    else
                    {
                        //Update
                        if (!new CustomerRegistrationData().Update(db, CustomerRegistrationID, PhoneNumber, FullName, RegistrationDate, DeviceID, OTP, OTPGenratedDate, OTPExpireDate, OTPConfimationDate, Status, Password, AppKey, AppKeyExpireDate, AppVersionID, Balance, InsertUserId, userAccountId, EntryDate, Version))
                        {
                            UpdateFailed(ref validationErrors);
                            return false;
                        }
                    }
                    return true;
                }
                else
                {
                    //Didn't pass validation.
                    return false;
                }
            }
            else
            {
                throw new Exception("DBAction not Save.");
            }
        }
        protected override void Validate(DBDataContext db, ref EntValidationErrors validationErrors)
        {
            if (Status.Trim().Length <= 0 || Status.Trim().Length <= 0)
            {
                validationErrors.Add("Status is required.");
            }

            else if (DBAction == DBActionEnum.Insert && new CustomerRegistrationData().IsDuplicateEntry(PhoneNumber))
            {
                validationErrors.Add("Customers with this Phone was registered.");
            }
        }
        protected override void DeleteForReal(DBDataContext db)
        {
            new CustomerRegistrationData().Delete(db, CustomerRegistrationID, Version);
        }
        protected override void ValidateDelete(DBDataContext db, ref EntValidationErrors validationErrors)
        {
        }
        public override void Init()
        {
        }
        protected override string GetDisplayText()
        {
            return PhoneNumber;
        }

        internal void MapEntityToProperties(CustomerRegistration td)
        {
			CustomerRegistrationID = td.CustomerRegistrationID;
			PhoneNumber = td.PhoneNumber;
			FullName = td.FullName;
			RegistrationDate = (DateTime)td.RegistrationDate;
			Status = td.Status;
			DeviceID = td.DeviceID;
			OTP = td.OTP;
			OTPGenratedDate = (DateTime)td.OTPGenratedDate;
			OTPExpireDate = (DateTime)td.OTPExpireDate;
			OTPConfimationDate = (DateTime)td.OTPConfimationDate;
			Password = td.Password;
			AppKey = td.AppKey;
			AppKeyExpireDate = (DateTime)td.AppKeyExpireDate;
			AppVersionID = (Guid)td.AppVersionID;
			Balance = (Decimal)td.Balance;
		}
		#endregion Overrides
	}
	#endregion CustomerRegistrationBO 
	#region CustomerRegistrationBOList
	[Serializable()]
    public class CustomerRegistrationBOList : BaseEOList<CustomerRegistrationBO>
    {
        #region Overrides
        public override void Load()
        {
            LoadFromList(new CustomerRegistrationData().Select());
        }
        #endregion Overrides
        #region Private Methods
        private void LoadFromList(List<CustomerRegistration> CustomerRegistrations)
        {
            foreach (CustomerRegistration CustomerRegistration in CustomerRegistrations)
            {
				CustomerRegistrationBO templateHeadBo = new CustomerRegistrationBO();
                templateHeadBo.MapEntityToProperties(CustomerRegistration);
                this.Add(templateHeadBo);
            }
        }
        #endregion Private Methods
        #region Public Methods
        // This method is used for loading search results
        // It can be extended by adding or changing the parameter lists
        // Its corrosponding DAL class is the Select method in Other methods region
        public void LoadByPhoneNumber(string PhoneNumber)
        {
            LoadFromList(new CustomerRegistrationData().SelectByPhoneNumber(PhoneNumber));
        }
        #endregion Public Methods
    }
	#endregion CustomerRegistrationBOList
}
