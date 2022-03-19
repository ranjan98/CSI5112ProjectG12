namespace aspnet.models;

public class Answer
{
    public string id { get; set; }
    public string reply { get; set; }
    public string uid { get; set; }
    public string datetime { get; set; }
    public string qid { get; set; }

    public Answer(string Id, string Reply, string Uid, string Datetime, string Qid)
    {
        this.id = Id;
        this.reply = Reply;
        this.uid = Uid;
        this.datetime = Datetime;
        this.qid = Qid;
    }
}


