using aspnet.models;
using MongoDB.Driver;  
using Microsoft.Extensions.Options; 

namespace aspnet.services;
public class CatService
{
     private readonly IMongoCollection<Category> categoryCollection;

    public CatService(IOptions<uomartDatabaseSettings> uomartDatabaseSettings)
    {
        var settings = MongoClientSettings.FromConnectionString("mongodb://csi5112group12:csi5112group12@cluster0-shard-00-00.vtqbg.mongodb.net:27017,cluster0-shard-00-01.vtqbg.mongodb.net:27017,cluster0-shard-00-02.vtqbg.mongodb.net:27017/myFirstDatabase?ssl=true&replicaSet=atlas-gv1oje-shard-0&authSource=admin&retryWrites=true&w=majority");
        settings.ServerApi = new ServerApi(ServerApiVersion.V1);
        var client = new MongoClient(settings);
        var database = client.GetDatabase("uomart");
        categoryCollection = database.GetCollection<Category>("categories");

    }

    public async Task createCat(Category newCat)
    {
        newCat.cid = null; // ID will be set by MongoDB
        await categoryCollection.InsertOneAsync(newCat);
    }

    public async Task<List<Category>> getCat()
    {
        return await categoryCollection.Find(_ => true).ToListAsync();
     
    }

    public async Task<Category> getCat(string cid)
    {
        return await categoryCollection.Find<Category>(category => category.cid == cid).FirstOrDefaultAsync();
        
    }

    public async Task<bool> updateCat(string Cid, Category updatedCat)
    {
        ReplaceOneResult r = await categoryCollection.ReplaceOneAsync(category => category.cid == updatedCat.cid, updatedCat);
        return r.IsModifiedCountAvailable && r.ModifiedCount == 1;
    }

    public async Task deleteCat(string Cid)
    {
        await categoryCollection.DeleteOneAsync(category => category.cid == Cid);
    }
}