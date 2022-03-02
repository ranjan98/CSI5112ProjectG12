namespace aspnet.models;
public class Merchant {
    public string id { get; set; }
    public string name { get; set; }
    public string address { get; set; }
    public string category {get;set;}
    public string imageurl {get;set;}
    public string description { get; set; }
    public bool isComplete { get; set; }

    public Merchant(string Id, string Name, string address, string Category, string imageurl, string Description,  bool IsComplete) {
        this.id = Id;
        this.name = Name;
        this.description = Description;
        this.isComplete = IsComplete;
        this.address = address;
        this.imageurl = imageurl;
        this.category = Category;
    }
}
