namespace aspnet.models;

public class CartItem
{
    public string id { get; set; }
    public string productid { get; set; }
    public double price { get; set; }
    public int quantity { get; set; }
    public string title { get; set; }

    public CartItem(string Id, string Productid, double Price, int Quantity, string Title)
    {
        this.id = Id;
        this.productid = Productid;
        this.price = Price;
        this.quantity = Quantity;
        this.title = Title;
    }
}