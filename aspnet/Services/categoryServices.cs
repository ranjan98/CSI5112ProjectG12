using aspnet.models;
using MongoDB.Driver;  
using Microsoft.Extensions.Options; 

namespace aspnet.services;
public class CatService
{
     private readonly IMongoCollection<Category> categoryCollection;
    // Data placeholder
    // private List<Category> cat = new List<Category>() {
    //     new Category("1", "Clothing and Shoes", "https://m.media-amazon.com/images/I/410-L0vF3+L._AC_UL640_QL65_.jpg"),
    //     new Category("2", "Laptops and Mobiles", "https://m.media-amazon.com/images/I/71an9eiBxpL._AC_UL640_QL65_.jpg"),
    //     new Category("3", "Books and Stationary", "https://m.media-amazon.com/images/I/61-Pt+1b+xL._AC_UL640_QL65_.jpg"),
    //     new Category("4", "Electronics and Accessories", "https://m.media-amazon.com/images/I/71Hx8b6HGbL._AC_UL640_QL65_.jpg"),
    //     new Category("5", "Home and Kitchen", "https://m.media-amazon.com/images/I/61wHFNgOxSL._AC_UL640_QL65_.jpg"),
    //     new Category("6", "Beauty and Essentials", "https://m.media-amazon.com/images/I/81qII9PojkL._AC_UL640_QL65_.jpg"),

    // };

    public CatService(IOptions<uomartDatabaseSettings> uomartDatabaseSettings)
    {
        var settings = MongoClientSettings.FromConnectionString(uomartDatabaseSettings.Value.ConnectionString);
        settings.ServerApi = new ServerApi(ServerApiVersion.V1);
        var client = new MongoClient(settings);
        var database = client.GetDatabase(uomartDatabaseSettings.Value.DatabaseName);
        categoryCollection = database.GetCollection<Category>("categories");
    }

    public async Task createCat(Category newCat)
    {
        newCat.cid = null; // ID will be set by MongoDB
        await categoryCollection.InsertOneAsync(newCat);
        //cat.Add(newCat);//changing in database
    }

    public async Task<List<Category>> getCat()
    {
        return await categoryCollection.Find(_ => true).ToListAsync();
        //return cat;//getting it from database
    }

    public async Task<Category> getCat(string cid)
    {
        return await categoryCollection.Find<Category>(category => category.cid == cid).FirstOrDefaultAsync();
        //return cat.Find(x => x.cid == cid);
    }

    public async Task<bool> updateCat(string Cid, Category updatedCat)
    {
        // bool result = false;
        // int index = cat.FindIndex(x => x.cid == Cid);
        // if (index != -1)
        // {
        //     updatedCat.cid = Cid;
        //     cat[index] = updatedCat;
        //     result = true;
        // }
        // return result;
        ReplaceOneResult r = await categoryCollection.ReplaceOneAsync(category => category.cid == updatedCat.cid, updatedCat);
        return r.IsModifiedCountAvailable && r.ModifiedCount == 1;
    }

    public async Task deleteCat(string Cid)
    {
        // bool deleted = false;
        // int index = cat.FindIndex(x => x.cid == Cid);
        // if (index != -1)
        // {
        //     cat.RemoveAt(index);
        //     deleted = true;
        // }
        // return deleted;

        await categoryCollection.DeleteOneAsync(category => category.cid == Cid);
    }
}