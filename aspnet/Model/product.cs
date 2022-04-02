using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
namespace aspnet.models;


public class Product
{
    [BsonId][BsonRepresentation(BsonType.ObjectId)]  
    public string? id { get; set; }
    [BsonElement]
    public string name { get; set; }
    [BsonElement]
    public string merchantid { get; set; }
    [BsonElement]
    public string category { get; set; }
    [BsonElement]
    public string imageurl { get; set; }
    [BsonElement]
    public string description { get; set; }
    [BsonElement]
    public string price { get; set; }

    public Product(string Id, string Name, string Merchantid, string Category, string imageurl, string Description, string Price)
    {
        this.id = Id;
        this.name = Name;
        this.description = Description;
        this.price = Price;
        this.merchantid = Merchantid;
        this.imageurl = imageurl;
        this.category = Category;
    }
}


