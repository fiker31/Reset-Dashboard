﻿using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
namespace DAL.Framework
{
    public class RoleUserAccountData : BaseData<EntRoleUserAccount>
    {
        #region Overrides
        public override List<EntRoleUserAccount> Select()
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                List<EntRoleUserAccount> RU = (from ru in db.EntRoleUserAccounts
                                               select ru).ToList();
                return RU;
            }
        }
        public override EntRoleUserAccount Select(long id)
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                var RU = (from ru in db.EntRoleUserAccounts
                          where ru.RoleUserAccountId == id
                          select ru);
                if (RU.Count() != 0)
                {
                    return RU.Single();
                }
                else
                {
                    return null;
                }
            }
        }
        public override EntRoleUserAccount Select(string id)
        {
            throw new NotImplementedException();
        }
        public override void Delete(DBDataContext db, long id, Binary version)
        {
            //Create Role UserAccount object
            EntRoleUserAccount RU = new EntRoleUserAccount();
            RU.RoleUserAccountId = id;
            RU.Version = version;
            db.EntRoleUserAccounts.Attach(RU);
            db.EntRoleUserAccounts.DeleteOnSubmit(RU);
            db.SubmitChanges();
        }
        public override void Delete(DBDataContext db, string id, Binary version)
        {
            throw new NotImplementedException();
        }
        #endregion Overrides
        #region Insert
        public long Insert(string connectionString, long roleId,
            long userAccountId, string userId)
        {
            using (DBDataContext db = new DBDataContext(connectionString))
            {
                return Insert(db, roleId, userAccountId, userId);
            }
        }
        public long Insert(DBDataContext db, long roleId,
            long userAccountId, string userId)
        {
            //Create a new Role User Account object
            EntRoleUserAccount RU = new EntRoleUserAccount
            {
                //RoleUserAccountId = roleUserAccountId,
                RoleId = roleId,
                UserAccountId = userAccountId,
                InsertUser = userId,
                InsertDate = DateTime.Now,
                UpdateUser = userId,
                UpdateDate = DateTime.Now
            };
            //save the record to the object model
            db.EntRoleUserAccounts.InsertOnSubmit(RU);
            //send changes to the database
            db.SubmitChanges();
            return RU.RoleUserAccountId;
        }
        #endregion Insert
        #region Update
        public bool Update(string connectionString, long id, long roleId, long userAccountId,
            string insertUserId, DateTime entryDate, string userId, Binary version)
        {
            using (DBDataContext db = new DBDataContext(connectionString))
            {
                return Update(db, id, roleId, userAccountId
                    , insertUserId, entryDate, userId, version);
            }
        }
        public bool Update(DBDataContext db, long id, long roleId, long userAccountId,
            string insertUserId, DateTime entryDate, string userId, Binary version)
        {
            //Create a new Role User Account object
            EntRoleUserAccount RU = new EntRoleUserAccount
            {
                RoleUserAccountId = id,
                RoleId = roleId,
                UserAccountId = userAccountId,
                InsertUser = insertUserId,
                InsertDate = entryDate,
                UpdateUser = userId,
                UpdateDate = DateTime.Now,
                Version = version
            };
            //save the record to the object model
            db.EntRoleUserAccounts.Attach(RU, true);
            //send changes to the database
            db.SubmitChanges();
            return true;
        }
        #endregion Update
        #region Custom Select
        public List<EntRoleUserAccount> SelectByRoleId(long roleId)
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                List<EntRoleUserAccount> RU = (from ru in db.EntRoleUserAccounts
                                               where ru.RoleId == roleId
                                               select ru).ToList();
                return RU;
            }
        }
        #endregion Custom Select
    }
}
