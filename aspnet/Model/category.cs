using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
namespace aspnet.models;
public class Category
{
    [BsonId][BsonRepresentation(BsonType.ObjectId)] 
    public string? cid { get; set; }
    [BsonElement]
    public string cName { get; set; }
    [BsonElement]
    public string imgUrl { get; set; }

    public Category(string Cid, string CName, string ImgUrl)
    {
        this.cid = Cid;
        this.cName = CName;
        this.imgUrl = ImgUrl;
    }
}