using aspnet.models;
using MongoDB.Driver;  
using Microsoft.Extensions.Options; 

namespace aspnet.services;
public class OrderService
{
    private readonly IMongoCollection<Order> orderCollection;
    // Data placeholder
    // private List<Order> order = new List<Order>() {
    //     new Order("1", "1647391064239", "1", 269.94, items, "2022-03-15 08:37:44"),
    // };

    // private static List<CartItem> items = new List<CartItem>(){
    //     new CartItem("p1", 29.99, 2, "Tommy Red T-Shirt"),
    //     new CartItem("p2", 59.99, 1, "Trousers")
    // };

    public OrderService(IOptions<uomartDatabaseSettings> uomartDatabaseSettings)
    {
        var settings = MongoClientSettings.FromConnectionString("mongodb://csi5112group12:csi5112group12@cluster0-shard-00-00.vtqbg.mongodb.net:27017,cluster0-shard-00-01.vtqbg.mongodb.net:27017,cluster0-shard-00-02.vtqbg.mongodb.net:27017/myFirstDatabase?ssl=true&replicaSet=atlas-gv1oje-shard-0&authSource=admin&retryWrites=true&w=majority");
        settings.ServerApi = new ServerApi(ServerApiVersion.V1);
        var client = new MongoClient(settings);
        var database = client.GetDatabase("uomart");
        orderCollection = database.GetCollection<Order>("orders");

        var indexOptions = new CreateIndexOptions();
        var indexKeys = Builders<Order>.IndexKeys.Ascending(orders => orders.userid);
        var indexModel = new CreateIndexModel<Order>(indexKeys, indexOptions);
        orderCollection.Indexes.CreateOneAsync(indexModel);
        
        var indexes = database.GetCollection<Order>("orders").Indexes.List().ToList();

        foreach (var index in indexes)
        {
            Console.WriteLine(index);
        }
    }


    public async Task createOrder(Order newOrder)
    {
        newOrder.id = null; // ID will be set by MongoDB
        await orderCollection.InsertOneAsync(newOrder);
        //order.Add(newOrder);//changine in database
    }

    public async Task<List<Order>> getOrder()
    {
        return await orderCollection.Find(_ => true).ToListAsync();
        //return order;//getting it from database
    }

    public async Task<Order> getOrder(string Id)
    {
        return await orderCollection.Find<Order>(order => order.id == Id).FirstOrDefaultAsync();
        //return order.Find(x => x.id == Id);
    }


    public async Task<List<Order>> getOrderByUser(string userid)
    {
        return await orderCollection.Find(order => order.userid == userid).ToListAsync();
        //return order.Find(x => x.id == Id);
    }

    public async Task<bool> updateOrder(string Id, Order updatedOrder)
    {

        ReplaceOneResult r = await orderCollection.ReplaceOneAsync(order => order.id == updatedOrder.id, updatedOrder);
        return r.IsModifiedCountAvailable && r.ModifiedCount == 1;
    }

    public async Task deleteOrder(string Id)
    {
      
        await orderCollection.DeleteOneAsync(order => order.id == Id);
    }
}