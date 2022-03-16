namespace aspnet.models;

public class CartItem
{
    public string id { get; set; }
    public double price { get; set; }
    public int quantity { get; set; }
    public string title { get; set; }

    public CartItem(string Id, double Price, int Quantity, string Title)
    {
        this.id = Id;
        this.price = Price;
        this.quantity = Quantity;
        this.title = Title;
    }
}