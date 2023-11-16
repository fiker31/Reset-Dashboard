﻿using DAL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Linq;
using System.Linq;
namespace DAL.Framework
{
    public class UserAccountData : BaseData<EntUserAccount>
    {
        #region Overrides
        public override List<EntUserAccount> Select()
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                List<EntUserAccount> UA = (from ua in db.EntUserAccounts
                                           select ua).ToList();
                return UA;
            }
        }
        public override EntUserAccount Select(long id)
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                var UA = (from ua in db.EntUserAccounts
                          where ua.UserAccountId == id
                          select ua);
                if (UA.Count() != 0)
                {
                    return UA.Single();
                }
                else
                {
                    return null;
                }
            }
        }
        public override EntUserAccount Select(string userAccountName)
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                var UA = (from ua in db.EntUserAccounts
                          where ua.UserAccountName == userAccountName
                          select ua);
                if (UA.Count() != 0)
                {
                    return UA.Single();
                }
                else
                {
                    return null;
                }
            }
        }
        public override void Delete(DBDataContext db, long id, Binary version)
        {
            //Create User Account object
            EntUserAccount UA = new EntUserAccount();
            UA.UserAccountId = id;
            UA.Version = version;
            db.EntUserAccounts.Attach(UA);
            db.EntUserAccounts.DeleteOnSubmit(UA);
            db.SubmitChanges();
        }
        public override void Delete(DBDataContext db, string id, Binary version)
        {
            throw new NotImplementedException();
        }
        #endregion Overrides
        #region Insert
        public long Insert(string connectionString, string userAccountName, string firstName,
            string lastName, string phone, bool isActive, string userPassword, string branchCode, bool IsMerchant, string userId)
        {
            using (DBDataContext db = new DBDataContext(connectionString))
            {
                return Insert(db, userAccountName, firstName,
                        lastName, phone, isActive, userPassword, branchCode, IsMerchant, userId);
            }
        }
        public long Insert(DBDataContext db, string userAccountName, string firstName,
            string lastName, string phone, bool isActive, string userPassword, string branchCode, bool IsMerchant, string userId)
        {
            //Create a new User Account object
            EntUserAccount UA = new EntUserAccount
            {
                UserAccountName = userAccountName,
                FirstName = firstName,
                LastName = lastName,
                Phone = phone,
                Status = isActive,
                UserPassword = userPassword,
                Shortcode = branchCode,
                IsNewPassword = true,
                PWDChangeDate = DateTime.Now,
                IsLocked = false,
                PAsswordAttemptNo = 0,
                InsertUser = userId,
                InsertDate = DateTime.Now,
                UpdateUser = userId,
                UpdateDate = DateTime.Now
            };
            //save the record to the object model
            db.EntUserAccounts.InsertOnSubmit(UA);
            //send changes to the database
            db.SubmitChanges();
            if (IsMerchant)
            {
                MerchantAppSimulation m = new MerchantAppSimulation
                {
                    MerchantShortCode = branchCode,
                    Phone = phone,
                    MerchantName = firstName + " " + lastName,
                    InsertUser = userId,
                    InsertDate = DateTime.Now,
                    UpdateUser = userId,
                    UpdateDate = DateTime.Now
                };
                //save the record to the object model
                db.MerchantAppSimulations.InsertOnSubmit(m);
                //send changes to the database
                 

                db.SubmitChanges();
            }

            if (IsMerchant)
            {

                string RoleId = ConfigurationManager.AppSettings["RoleId"].ToString();


                EntRoleUserAccount u = new EntRoleUserAccount
                {
                    RoleId = Convert.ToInt64(RoleId),
                    UserAccountId = UA.UserAccountId,
                    InsertUser = userId,
                    InsertDate = DateTime.Now,
                    UpdateUser = userId,
                    UpdateDate = DateTime.Now
                };
                //save the record to the object model
                db.EntRoleUserAccounts.InsertOnSubmit(u);
                //send changes to the database
                db.SubmitChanges();


            }

            return UA.UserAccountId;
        }
        #endregion Insert
        #region Update
        public bool Update(string connectionString, long id, string userAccountName, string firstName,
            string lastName, string email, bool isActive, string userPassword, string branchCode, bool isNewPassord, DateTime passwordChangeDate,
            byte passwordAttempt, bool isLocked, string insertUserId, DateTime entryDate, string userId, bool IsMerchant, Binary version)
        {
            using (DBDataContext db = new DBDataContext(connectionString))
            {
                return Update(db, id, userAccountName, firstName, lastName, email, isActive, userPassword, branchCode, isNewPassord, passwordChangeDate,
                    passwordAttempt, isLocked, IsMerchant, insertUserId, entryDate, userId, version);
            }
        }
        public bool Update(DBDataContext db, long id, string userAccountName, string firstName,
            string lastName, string phone, bool isActive, string userPassword, string branchCode, bool isNewPassord, DateTime passwordChangeDate,
            byte passwordAttempt, bool isLocked, bool IsMerchant, string insertUserId, DateTime entryDate, string userId, Binary version)
        {
            //Create a new User Account object
            EntUserAccount UA = new EntUserAccount
            {
                UserAccountId = id,
                UserAccountName = userAccountName,
                FirstName = firstName,
                LastName = lastName,
                Phone = phone,
                Status = isActive,
                UserPassword = userPassword,
                Shortcode = branchCode,
                IsNewPassword = isNewPassord,
                PWDChangeDate = passwordChangeDate,
                IsLocked = isLocked,
                PAsswordAttemptNo = passwordAttempt,
                InsertUser = insertUserId,
                InsertDate = entryDate,
                UpdateUser = userId,
                UpdateDate = DateTime.Now,
                Version = version
            };
            //save the record to the object model
            db.EntUserAccounts.Attach(UA, true);
            //send changes to the database
            db.SubmitChanges();

            return true;
        }
        #endregion Update
        #region Static Methods
        public static long GetUserIdByUserName(string useraccountname)
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                var TD = (from ua in db.EntUserAccounts
                          where ua.UserAccountName == useraccountname
                          select ua.UserAccountId);
                if (TD.Count() != 0)
                {
                    return TD.Single();
                }
                else
                {
                    return 0;
                }
            }
        }
        #endregion Static Methods
        #region Utility Methods
        /// <summary>
        /// Checks to see that window account name is unique.
        /// </summary>        
        /// <returns>Returns true if the windows account name is already in database</returns>
        public bool IsDuplicateUserAccountName(DBDataContext db, long userAccountId, string userAccountName)
        {
            return IsDuplicate(db, "EntUserAccount", "UserAccountName", "UserAccountId", userAccountName, userAccountId);
        }
        public bool IsDuplicateEmail(DBDataContext db, int userAccountId, string email)
        {
            return IsDuplicate(db, "EntUserAccount", "phone", "UserAccountId", email, userAccountId);
        }
        public List<EntUserAccount> Select(string userAccountName, string firstName, string lastName)
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                List<EntUserAccount> UA = (from ua in db.EntUserAccounts
                                           where (ua.UserAccountName.StartsWith(userAccountName))
                                           && (firstName.ToString() != "" ? ua.FirstName.StartsWith(firstName) : true)
                                           && (lastName.ToString() != "" ? ua.LastName.StartsWith(lastName) : true)
                                           select ua).ToList();
                return UA;
            }
        }
        public EntUserAccount SelectUserByUserId(long UserAccountId)
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                EntUserAccount UA = (from ua in db.EntUserAccounts
                                     where ua.UserAccountId == UserAccountId
                                     select ua).FirstOrDefault();
                return UA;
            }
        }
        public EntUserAccount SelectUserByUserAccountName(string UserAccountName)
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                EntUserAccount UA = (from ua in db.EntUserAccounts
                                     where ua.UserAccountName == UserAccountName
                                     select ua).FirstOrDefault();
                return UA;
            }
        }
        public List<EntUserAccount> SelectAllUser()
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                List<EntUserAccount> UA = (from ua in db.EntUserAccounts
                                           select ua).ToList();
                return UA ?? null;
            }
        }
        #endregion Utility Methods
    }
}
