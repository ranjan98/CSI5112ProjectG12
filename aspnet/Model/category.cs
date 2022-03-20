namespace aspnet.models;

public class Category
{
    public string cid { get; set; }
    public string cName { get; set; }
    public string imgUrl { get; set; }

    public Category(string Cid, string CName, string ImgUrl)
    {
        this.cid = Cid;
        this.cName = CName;
        this.imgUrl = ImgUrl;
    }
}