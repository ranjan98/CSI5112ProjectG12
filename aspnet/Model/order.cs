namespace aspnet.models;

public class Order
{
    public string id { get; set; }
    public string invoicenumber { get; set; }
    public string userid { get; set; }
    public double amount { get; set; }

    public List<CartItem> items { get; set; }
    public string datetime { get; set; }

    public Order(string Id, string Invoicenumber, string Userid, double Amount, List<CartItem> Items, string Datetime)
    {
        this.id = Id;
        this.invoicenumber = Invoicenumber;
        this.userid = Userid;
        this.amount = Amount;
        this.items = Items;
        this.datetime = Datetime;
    }
}


