namespace aspnet.models;

public class Question
{
    public string id { get; set; }
    public string title { get; set; }
    public string description { get; set; }
    public string uid { get; set; }
    public List<string> answers { get; set; }
    public string datetime { get; set; }

    public Question(string Id, string Title, string Description, string Uid, List<string> Answers, string Datetime)
    {
        this.id = Id;
        this.title = Title;
        this.description = Description;
        this.uid = Uid;
        this.answers = Answers;
        this.datetime = Datetime;
    }
}


