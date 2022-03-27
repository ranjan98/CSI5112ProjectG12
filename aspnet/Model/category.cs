using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace aspnet.models;

public class Category
{
    [BsonId][BsonRepresentation(BsonType.ObjectId)] 
    public string cid { get; set; }

    [BsonElement]
    public string? uid { get; set; }

    [BsonElement]
    public string cName { get; set; }

    [BsonElement]
    public string imgUrl { get; set; }

    public Category(string Cid, string Uid, string CName, string ImgUrl)
    {
        this.cid = Cid;
        this.uid = Uid;
        this.cName = CName;
        this.imgUrl = ImgUrl;
    }
}