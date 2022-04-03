using aspnet.models;
using MongoDB.Driver;  
using Microsoft.Extensions.Options; 

namespace aspnet.services;
public class ProdService
{
    private readonly IMongoCollection<Product> prodCollection;

    public ProdService(IOptions<uomartDatabaseSettings> uomartDatabaseSettings)
    {
        var settings = MongoClientSettings.FromConnectionString("mongodb://csi5112group12:csi5112group12@cluster0-shard-00-00.vtqbg.mongodb.net:27017,cluster0-shard-00-01.vtqbg.mongodb.net:27017,cluster0-shard-00-02.vtqbg.mongodb.net:27017/myFirstDatabase?ssl=true&replicaSet=atlas-gv1oje-shard-0&authSource=admin&retryWrites=true&w=majority");
        settings.ServerApi = new ServerApi(ServerApiVersion.V1);
        var client = new MongoClient(settings);
        var database = client.GetDatabase("uomart");
        prodCollection = database.GetCollection<Product>("products");

        var indexOptions = new CreateIndexOptions();
        var indexKeys = Builders<Product>.IndexKeys.Ascending(products => products.category);
        var indexModel = new CreateIndexModel<Product>(indexKeys, indexOptions);
        prodCollection.Indexes.CreateOneAsync(indexModel);
        
        var indexes = database.GetCollection<Product>("products").Indexes.List().ToList();

        foreach (var index in indexes)
        {
            Console.WriteLine(index);
        }
    }

    public async Task createProd(Product newProd)
    {
        newProd.id = null; // ID will be set by MongoDB
        await prodCollection.InsertOneAsync(newProd);
        
    }

    public async Task<List<Product>> getProd()
    {
        return await prodCollection.Find(_ => true).ToListAsync();
        
    }

    public async Task<Product> getProd(string id)
    {
        return await prodCollection.Find<Product>(product => product.id == id).FirstOrDefaultAsync();
        
    }

    public async Task<List<Product>> getProdByCategory(string cid)
    {
        return await prodCollection.Find(product => product.category == cid).ToListAsync();
    }
    public async Task<bool> updateProd(string Id, Product updatedProd)
    {
        ReplaceOneResult r = await prodCollection.ReplaceOneAsync(user => user.id == updatedProd.id, updatedProd);
        return r.IsModifiedCountAvailable && r.ModifiedCount == 1;

    }

    public async Task deleteProd(string Id)
    {
        await prodCollection.DeleteOneAsync(product => product.id == Id);
    }
}