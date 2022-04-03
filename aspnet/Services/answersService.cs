using aspnet.models;
using MongoDB.Driver;  
using Microsoft.Extensions.Options; 

namespace aspnet.services;
public class AnswersService
{
    private readonly IMongoCollection<Answer> answerCollection;

    public AnswersService(IOptions<uomartDatabaseSettings> uomartDatabaseSettings)
    {
        var settings = MongoClientSettings.FromConnectionString("mongodb://csi5112group12:csi5112group12@cluster0-shard-00-00.vtqbg.mongodb.net:27017,cluster0-shard-00-01.vtqbg.mongodb.net:27017,cluster0-shard-00-02.vtqbg.mongodb.net:27017/myFirstDatabase?ssl=true&replicaSet=atlas-gv1oje-shard-0&authSource=admin&retryWrites=true&w=majority");
        settings.ServerApi = new ServerApi(ServerApiVersion.V1);
        var client = new MongoClient(settings);
        var database = client.GetDatabase("uomart");
        answerCollection = database.GetCollection<Answer>("answers");

        var indexOptions = new CreateIndexOptions();
        var indexKeys = Builders<Answer>.IndexKeys.Ascending(answers => answers.qid);
        var indexModel = new CreateIndexModel<Answer>(indexKeys, indexOptions);
        answerCollection.Indexes.CreateOneAsync(indexModel);
        
        var indexes = database.GetCollection<Answer>("answers").Indexes.List().ToList();

        foreach (var index in indexes)
        {
            Console.WriteLine(index);
        }
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


    public async Task<List<Answer>> getAnswerByQuestionId(string Qid)
    {
        return await answerCollection.Find(answer => answer.qid == Qid).ToListAsync();
        //return answer.Find(x => x.id == Id);
    }

    public async Task<bool> updateAnswer(string Id, Answer updatedAnswer)
    {
        ReplaceOneResult r = await answerCollection.ReplaceOneAsync(answer => answer.id == updatedAnswer.id, updatedAnswer);
        return r.IsModifiedCountAvailable && r.ModifiedCount == 1;
    }

    public async Task deleteAnswer(string Id)
    {
        await answerCollection.DeleteOneAsync(answer => answer.id == Id);
    }
}