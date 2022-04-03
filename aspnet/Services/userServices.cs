using aspnet.models;
using MongoDB.Driver;  
using Microsoft.Extensions.Options; 

namespace aspnet.services;
public class UserService
{

    private readonly IMongoCollection<User> userCollection;
  
    public UserService(IOptions<uomartDatabaseSettings> uomartDatabaseSettings)
    {
        var settings = MongoClientSettings.FromConnectionString("mongodb://csi5112group12:csi5112group12@cluster0-shard-00-00.vtqbg.mongodb.net:27017,cluster0-shard-00-01.vtqbg.mongodb.net:27017,cluster0-shard-00-02.vtqbg.mongodb.net:27017/myFirstDatabase?ssl=true&replicaSet=atlas-gv1oje-shard-0&authSource=admin&retryWrites=true&w=majority");
        settings.ServerApi = new ServerApi(ServerApiVersion.V1);
        var client = new MongoClient(settings);
        var database = client.GetDatabase("uomart");
        userCollection = database.GetCollection<User>("user");

        var indexOptions = new CreateIndexOptions();
        var indexKeys = Builders<User>.IndexKeys.Ascending(user => user.uid);
        var indexModel = new CreateIndexModel<User>(indexKeys, indexOptions);
        userCollection.Indexes.CreateOneAsync(indexModel);
        
        var indexes = database.GetCollection<User>("user").Indexes.List().ToList();

        foreach (var index in indexes)
        {
            Console.WriteLine(index);
        }
    }

    public async Task createUser(User newUser)
    {
        newUser.uid = null; // ID will be set by MongoDB
        await userCollection.InsertOneAsync(newUser);
       
    }

    public async Task<List<User>> getUser()
    {
        return await userCollection.Find(_ => true).ToListAsync();
        
    }

    public async Task<User> getUser(string id)
    {
        return await userCollection.Find<User>(user => user.uid == id).FirstOrDefaultAsync();
        
    }
    public async Task<User> getUserFromEmail(string email)
    {
        return await userCollection.Find<User>(user => user.email == email).FirstOrDefaultAsync();
       
    }

    public async Task<bool> updateUser(string Id, User updatedUser){
        ReplaceOneResult r = await userCollection.ReplaceOneAsync(user => user.uid == updatedUser.uid, updatedUser);
        return r.IsModifiedCountAvailable && r.ModifiedCount == 1;
    }

    public async Task deleteUser(string Id) {
        await userCollection.DeleteOneAsync(user => user.uid == Id);
    }
}