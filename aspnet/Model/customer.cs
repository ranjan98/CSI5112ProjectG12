namespace aspnet.models;

public class Customer
{
    public string id { get; set; }
    public string name { get; set; }
    public string address { get; set; }

    public string imageurl { get; set; }
    public bool isComplete { get; set; }

    public Customer(string Id, string Name, string address, string imageurl, bool IsComplete)
    {
        this.id = Id;
        this.name = Name;
        this.isComplete = IsComplete;
        this.address = address;
        this.imageurl = imageurl;
    }
}
 
