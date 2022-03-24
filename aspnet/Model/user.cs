using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
namespace aspnet.models;


public class User
    {

    [BsonId][BsonRepresentation(BsonType.ObjectId)]  
    public string? id { get; set; }
    
    [BsonElement]
    public string? uid { get; set; }

    [BsonElement(elementName: "username")]
    public string name { get; set; }
    [BsonElement]
    public string email { get; set; }
    [BsonElement]
    public string password { get; set; }
    [BsonElement]
    public string role { get; set; }
    
    public User(string Id, string Uid, string Name, string Email, string Password, string Role)
    {
        this.id = id;
        this.uid = Uid;
        this.name = Name;
        this.email = Email;
        this.password = Password;
        this.role = Role;
    }
}

