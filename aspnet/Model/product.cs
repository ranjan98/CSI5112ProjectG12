namespace aspnet.models;

public class Product
{
    public string id { get; set; }
    public string name { get; set; }
    public string merchantid { get; set; }
    public string category { get; set; }
    public string imageurl { get; set; }
    public string description { get; set; }
    public string price { get; set; }

    public Product(string Id, string Name, string Merchantid, string Category, string imageurl, string Description, string Price)
    {
        this.id = Id;
        this.name = Name;
        this.description = Description;
        this.price = Price;
        this.merchantid = Merchantid;
        this.imageurl = imageurl;
        this.category = Category;
    }
}


