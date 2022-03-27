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

    //  public OrderService()
    // {
    // }

    public OrderService(IOptions<uomartDatabaseSettings> uomartDatabaseSettings)
    {
        var settings = MongoClientSettings.FromConnectionString(uomartDatabaseSettings.Value.ConnectionString);
        settings.ServerApi = new ServerApi(ServerApiVersion.V1);
        var client = new MongoClient(settings);
        var database = client.GetDatabase(uomartDatabaseSettings.Value.DatabaseName);
        orderCollection = database.GetCollection<Order>(uomartDatabaseSettings.Value.CollectionName);
    }


    public async Task createOrder(Order newOrder)
    {
        newOrder.id = null; // ID will be set by MongoDB
        await orderCollection.InsertOneAsync(newOrder);
        //changine in database
    }

    // public async Task<List<Order>> getOrder()
    // {
    //     return order;//getting it from database
    // }

    public async Task<List<Order>> getOrder()
    {
        return await orderCollection.Find(_ => true).ToListAsync();
        //getting it from database
    }

    // public async Task<Order> getOrder(string Id)
    // {
    //     return order.Find(x => x.id == Id);
    // }

    public async Task<Order> getOrder(string id)
    {
        return await orderCollection.Find<Order>(order => order.uid == id).FirstOrDefaultAsync();
        
    }

    // public async Task<bool> updateOrder(string Id, Order updatedOrder)
    // {
    //     bool result = false;
    //     int index = order.FindIndex(x => x.id == Id);
    //     if (index != -1)
    //     {
    //         updatedOrder.id = Id;
    //         order[index] = updatedOrder;
    //         result = true;
    //     }
    //     return result;
    // }

    public async Task<bool> updateOrder(string Id, Order updatedOrder){
        ReplaceOneResult r = await orderCollection.ReplaceOneAsync(order => order.uid == updatedOrder.uid, updatedOrder);
        return r.IsModifiedCountAvailable && r.ModifiedCount == 1;
    }

    // public async Task<bool> deleteOrder(string Id)
    // {
    //     bool deleted = false;
    //     int index = order.FindIndex(x => x.id == Id);
    //     if (index != -1)
    //     {
    //         order.RemoveAt(index);
    //         deleted = true;
    //     }
    //     return deleted;
    // }

    public async Task deleteOrder(string Id) {
        await orderCollection.DeleteOneAsync(order => order.uid == Id);
    }
}