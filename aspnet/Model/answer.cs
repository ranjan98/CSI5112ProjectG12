using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
namespace aspnet.models;


public class Answer
{
    [BsonId][BsonRepresentation(BsonType.ObjectId)]  
    public string? id { get; set; }
    [BsonElement]
    public string reply { get; set; }
    [BsonElement]
    public string uid { get; set; }
    [BsonElement]
    public string datetime { get; set; }
    [BsonElement]
    public string qid { get; set; }

    public Answer(string Id, string Reply, string Uid, string Datetime, string Qid)
    {
        this.id = Id;
        this.reply = Reply;
        this.uid = Uid;
        this.datetime = Datetime;
        this.qid = Qid;
    }
}


