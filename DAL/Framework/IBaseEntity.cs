using System;
using System.Data.Linq;
namespace DAL.Framework
{
    public interface IBaseEntity
    {
        DateTime InsertDate { get; set; }
        string InsertUser { get; set; }
        DateTime UpdateDate { get; set; }
        string UpdateUser { get; set; }
        Binary Version { get; set; }
    }
}
