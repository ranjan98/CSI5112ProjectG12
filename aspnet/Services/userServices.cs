using aspnet.models;
using MongoDB.Driver;  
using Microsoft.Extensions.Options; 

namespace aspnet.services;
public class UserService
{

    private readonly IMongoCollection<User> userCollection;
    // Data placeholder
    // private List<User> user = new List<User>() {
    //     new User("1", "Ranjan", "ranjan@uottawa.ca", "ranjan12345@", "customer"),
    //     new User("2", "Ashish", "ashish@uottawa.ca", "ashish123452", "customer"),
    //     new User("3", "Harish", "harish@uottawa.ca", "harish12345@", "customer"),
    //     new User("4", "John", "john@uottawa.ca", "john12345@", "merchant"),
    //     new User("5", "Hannah", "hannah@uottawa.ca", "hanna12345@", "merchant"),
    //     new User("6", "Peter", "peter@uottawa.ca", "peter12345@", "customer"),
    // };

    public UserService(IOptions<uomartDatabaseSettings> uomartDatabaseSettings)
    {
        var settings = MongoClientSettings.FromConnectionString(uomartDatabaseSettings.Value.ConnectionString);
        settings.ServerApi = new ServerApi(ServerApiVersion.V1);
        var client = new MongoClient(settings);
        var database = client.GetDatabase(uomartDatabaseSettings.Value.DatabaseName);
        userCollection = database.GetCollection<User>(uomartDatabaseSettings.Value.CollectionName);
    }

    public async Task createUser(User newUser)
    {
        newUser.uid = null; // ID will be set by MongoDB
        await userCollection.InsertOneAsync(newUser);
        //user.Add(newUser);//changine in database
    }

    public async Task<List<User>> getUser()
    {
        return await userCollection.Find(_ => true).ToListAsync();
        //return user;//getting it from database
    }

    public async Task<User> getUser(string id)
    {
        return await userCollection.Find<User>(user => user.uid == id).FirstOrDefaultAsync();
        //return user.Find(x => x.uid == id);
    }
    public async Task<User> getUserFromEmail(string email)
    {
        return await userCollection.Find<User>(user => user.email == email).FirstOrDefaultAsync();
        //return user.Find(x => x.email == email);
    }

    public async Task<bool> updateUser(string Id, User updatedUser){
        ReplaceOneResult r = await userCollection.ReplaceOneAsync(user => user.uid == updatedUser.uid, updatedUser);
        return r.IsModifiedCountAvailable && r.ModifiedCount == 1;
    }

    // public async Task<bool> updateUser(string Id, User updatedUser)
    // {
    //     bool result = false;
    //     int index = user.FindIndex(x => x.uid == Id);
    //     if (index != -1)
    //     {
    //         updatedUser.uid = Id;
    //         user[index] = updatedUser;
    //         result = true;
    //     }
    //     return result;
    // }

    // public async Task<bool> deleteUser(string Id)
    // {
    //     bool deleted = false;
    //     int index = user.FindIndex(x => x.uid == Id);
    //     if (index != -1)
    //     {
    //         user.RemoveAt(index);
    //         deleted = true;
    //     }
    //     return deleted;
    // }


    public async Task deleteUser(string Id) {
        await userCollection.DeleteOneAsync(user => user.uid == Id);
    }
}