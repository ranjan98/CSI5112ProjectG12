using aspnet.models;

namespace aspnet.services;
public class OrderService
{
    // Data placeholder
    private List<Order> order = new List<Order>() {
        new Order("1", "1647391064239", "1", 269.94, items, "2022-03-15 08:37:44"),
    };

    private static List<CartItem> items = new List<CartItem>(){
        new CartItem("1", "p1", 29.99, 2, "Tommy Red T-Shirt"),
        new CartItem("2", "p2", 59.99, 1, "Trousers")
    };

    public OrderService()
    {
    }

    public async Task createOrder(Order newOrder)
    {
        order.Add(newOrder);//changine in database
    }

    public async Task<List<Order>> getOrder()
    {
        return order;//getting it from database
    }

    public async Task<Order> getOrder(string Id)
    {
        return order.Find(x => x.id == Id);
    }

    public async Task<bool> updateOrder(string Id, Order updatedOrder)
    {
        bool result = false;
        int index = order.FindIndex(x => x.id == Id);
        if (index != -1)
        {
            updatedOrder.id = Id;
            order[index] = updatedOrder;
            result = true;
        }
        return result;
    }

    public async Task<bool> deleteOrder(string Id)
    {
        bool deleted = false;
        int index = order.FindIndex(x => x.id == Id);
        if (index != -1)
        {
            order.RemoveAt(index);
            deleted = true;
        }
        return deleted;
    }
}