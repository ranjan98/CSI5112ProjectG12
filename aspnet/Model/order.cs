using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
namespace aspnet.models;
public class Order
{
    [BsonId][BsonRepresentation(BsonType.ObjectId)] 
    public string? id { get; set; }
    [BsonElement]
    public string invoicenumber { get; set; }
    [BsonElement]
    public string userid { get; set; }
    [BsonElement]
    public double amount { get; set; }
    [BsonElement]
    public List<CartItem> items { get; set; }
    [BsonElement]
    public string datetime { get; set; }

    public Order(string Id, string Invoicenumber, string Userid, double Amount, List<CartItem> Items, string Datetime)
    {
        this.id = Id;
        this.invoicenumber = Invoicenumber;
        this.userid = Userid;
        this.amount = Amount;
        this.items = Items;
        this.datetime = Datetime;
    }
}


