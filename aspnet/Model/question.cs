using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
namespace aspnet.models;
public class Question
{
    [BsonId][BsonRepresentation(BsonType.ObjectId)]  
    public string? id { get; set; }
    [BsonElement]
    public string title { get; set; }
    [BsonElement]
    public string description { get; set; }
    [BsonElement]
    public string uid { get; set; }
    [BsonElement]
    public List<string> answers { get; set; }
    [BsonElement]
    public string datetime { get; set; }

    public Question(string Id, string Title, string Description, string Uid, List<string> Answers, string Datetime)
    {
        this.id = Id;
        this.title = Title;
        this.description = Description;
        this.uid = Uid;
        this.answers = Answers;
        this.datetime = Datetime;
    }
}


