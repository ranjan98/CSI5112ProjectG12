using aspnet.models;
using MongoDB.Driver;
using Microsoft.Extensions.Options;

namespace aspnet.services;
public class AnswersService
{
    private readonly IMongoCollection<Answer> answerCollection;
    // Data placeholder
    // private List<Answer> answer = new List<Answer>() {
    //     new Answer("1", "No, it does not have a thermostat", "1", "2022-03-15 08:37:44", "1"),
    //     new Answer("2", "Using thermostat can easily turn this off at night", "1", "2022-03-15 08:37:44", "1"),
    //     new Answer("3", "Just buy this, you won't regret it", "1", "2022-04-15 08:37:44", "1")
    // };

    public AnswersService(IOptions<uomartDatabaseSettings> uomartDatabaseSettings)
    {
        var settings = MongoClientSettings.FromConnectionString("mongodb://csi5112group12:csi5112group12@cluster0-shard-00-00.vtqbg.mongodb.net:27017,cluster0-shard-00-01.vtqbg.mongodb.net:27017,cluster0-shard-00-02.vtqbg.mongodb.net:27017/myFirstDatabase?ssl=true&replicaSet=atlas-gv1oje-shard-0&authSource=admin&retryWrites=true&w=majority");
        settings.ServerApi = new ServerApi(ServerApiVersion.V1);
        var client = new MongoClient(settings);
        var database = client.GetDatabase("uomart");
        answerCollection = database.GetCollection<Answer>("answers");
    }

    public async Task createAnswer(Answer newAnswer)
    {
        newAnswer.id = null; // ID will be set by MongoDB
        await answerCollection.InsertOneAsync(newAnswer);
        //answer.Add(newAnswer);//changing in database
    }

    public async Task<List<Answer>> getAnswer()
    {
        return await answerCollection.Find(_ => true).ToListAsync();
        //return answer;//getting it from database
    }

    public async Task<Answer> getAnswer(string Id)
    {
        return await answerCollection.Find<Answer>(answer => answer.id == Id).FirstOrDefaultAsync();
        //return answer.Find(x => x.id == Id);
    }

    public async Task<bool> updateAnswer(string Id, Answer updatedAnswer)
    {
        // bool result = false;
        // int index = answer.FindIndex(x => x.id == Id);
        // if (index != -1)
        // {
        //     updatedAnswer.id = Id;
        //     answer[index] = updatedAnswer;
        //     result = true;
        // }
        // return result;
        ReplaceOneResult r = await answerCollection.ReplaceOneAsync(answer => answer.id == updatedAnswer.id, updatedAnswer);
        return r.IsModifiedCountAvailable && r.ModifiedCount == 1;
    }

    public async Task deleteAnswer(string Id)
    {
        // bool deleted = false;
        // int index = answer.FindIndex(x => x.id == Id);
        // if (index != -1)
        // {
        //     answer.RemoveAt(index);
        //     deleted = true;
        // }
        // return deleted;

        await answerCollection.DeleteOneAsync(answer => answer.id == Id);
    }
}