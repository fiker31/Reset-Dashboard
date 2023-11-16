using DAL.Framework;
using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
namespace DAL
{
    public class MerchantData : BaseData<MerchantAppSimulation>
    {
        #region Overrides
        public override List<MerchantAppSimulation> Select()
        {
            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                List<MerchantAppSimulation> TD = (from td in db.MerchantAppSimulations
                                                  select td).ToList();
                return TD;
            }
        }

        public override MerchantAppSimulation Select(string id)
        {

            using (DBDataContext db = new DBDataContext(DBHelper.GetCreditDBConnectionString()))
            {
                var TD = (from td in db.MerchantAppSimulations
                          where td.Id.ToString() == id
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
        public override MerchantAppSimulation Select(long id)
        {
            throw new NotImplementedException();
        }
        public override void Delete(DBDataContext db, long id, Binary version)
        {
            MerchantAppSimulation TD = new MerchantAppSimulation();
            TD.Id = id;
            TD.Version = version;
            db.MerchantAppSimulations.Attach(TD);
            db.MerchantAppSimulations.DeleteOnSubmit(TD);
            db.SubmitChanges();
        }
        public override void Delete(DBDataContext db, string id, Binary version)
        {
            throw new NotImplementedException();
        }

        #endregion Overrides
        #region Insert
        public long Insert(string connectionString, string Shortcode, string Phone, string MerchantName, string insertUserId)
        {
            using (DBDataContext db = new DBDataContext(connectionString))
            {
                return Insert(db, Shortcode, Phone, MerchantName, insertUserId);
            }
        }
        public long Insert(DBDataContext db, string Shortcode, string Phone, string MerchantName, string insertUserId)
        {
            //Create a new object 
            MerchantAppSimulation TD = new MerchantAppSimulation
            {
                MerchantShortCode = Shortcode,
                Phone = Phone,
                MerchantName = MerchantName,
                InsertUser = insertUserId,
                UpdateUser = insertUserId,
                UpdateDate = DateTime.Now,
                InsertDate = DateTime.Now,

            };
            //save the record to the object model
            db.MerchantAppSimulations.InsertOnSubmit(TD);
            //send changes to the database
            db.SubmitChanges();
            return (TD.Id);
        }
        #endregion Insert
        #region Update
        public bool Update(string connectionString, long Id, string Shortcode, string Phone, string MerchantName, string insertUserId, string updateUserId, DateTime entryDate, Binary version)
        {
            using (DBDataContext db = new DBDataContext(connectionString))
            {
                return Update(db, Id, Shortcode, Phone, MerchantName, insertUserId, updateUserId, entryDate, version);
            }
        }
        public bool Update(DBDataContext db, long Id, string Shortcode, string Phone, string MerchantName, string insertUserId, string updateUserId, DateTime entryDate, Binary version)
        {
            //Create a new object 
            MerchantAppSimulation TD = new MerchantAppSimulation
            {
                Id = Id,
                MerchantShortCode = Shortcode,
                Phone = Phone,
                MerchantName = MerchantName,
                InsertUser = insertUserId,
                UpdateUser = updateUserId,
                UpdateDate = DateTime.Now,
                InsertDate = entryDate,
                Version = version,
            };
            //save the record to the object model
            db.MerchantAppSimulations.Attach(TD, true);
            //send changes to the database
            db.SubmitChanges();
            return true;
        }
        #endregion Update
    }
}
