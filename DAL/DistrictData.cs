using DAL.Framework;
using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
namespace DAL
{
    public class DistrictData : BaseData<District>
    {
        #region Overrides
        public override List<District> Select()
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                List<District> TD = (from td in db.Districts
                                     select td).ToList();
                return TD;
            }
        }
        public override District Select(long id)
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                var TD = (from td in db.Districts
                          where td.ID == id
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
        public override District Select(string id)
        {
            throw new NotImplementedException();
        }
        public override void Delete(DBDataContext db, long id, Binary version)
        {
            District TD = new District();
            TD.ID = id;
            TD.Version = version;
            db.Districts.Attach(TD);
            db.Districts.DeleteOnSubmit(TD);
            db.SubmitChanges();
        }
        public override void Delete(DBDataContext db, string id, Binary version)
        {
            throw new NotImplementedException();
        }
        #endregion Overrides
        #region Insert
        public long Insert(string connectionString, string name, string addrerss, string contact, string insertUserId)
        {
            using (DBDataContext db = new DBDataContext(connectionString))
            {
                return Insert(db, name, addrerss, contact, insertUserId);
            }
        }
        public long Insert(DBDataContext db, string name, string addrerss, string contact, string insertUserId)
        {
            //Create a new object 
            District TD = new District
            {
                Name = name,
                Address = addrerss,
                Contact = contact,
                InsertUser = insertUserId,
                UpdateUser = insertUserId,
                UpdateDate = DateTime.Now,
                InsertDate = DateTime.Now,
            };
            //save the record to the object model
            db.Districts.InsertOnSubmit(TD);
            //send changes to the database
            db.SubmitChanges();
            return (TD.ID);
        }
        #endregion Insert
        #region Update
        public bool Update(string connectionString, long Id, string name, string addrerss, string contact, string insertUserId, string updateUserId, DateTime entryDate, Binary version)
        {
            using (DBDataContext db = new DBDataContext(connectionString))
            {
                return Update(db, Id, name, addrerss, contact, insertUserId, updateUserId, entryDate, version);
            }
        }
        public bool Update(DBDataContext db, long Id, string name, string addrerss, string contact, string insertUserId, string updateUserId, DateTime entryDate, Binary version)
        {
            //Create a new object 
            District TD = new District
            {
                ID = Id,
                Name = name,
                Address = addrerss,
                Contact = contact,
                InsertUser = insertUserId,
                UpdateUser = updateUserId,
                UpdateDate = DateTime.Now,
                InsertDate = entryDate,
                Version = version,
            };
            //save the record to the object model
            db.Districts.Attach(TD, true);
            //send changes to the database
            db.SubmitChanges();
            return true;
        }
        #endregion Update
        #region Other Methods
        public List<District> SelectByDistrictName(string name)
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                List<District> TD = (from td in db.Districts
                                     where td.Name.StartsWith(name)
                                     select td).ToList();
                return TD;
            }
        }
        public bool IsDuplicateEntry(string name)
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                int result = (from td in db.Districts
                              where td.Name == name
                              select td).Count();
                return (result > 0);
            }
        }
        #endregion Other Methods
    }
}