using aspnet.models;
using MongoDB.Driver;
using Microsoft.Extensions.Options;

namespace aspnet.services;
public class QuestionsService
{
    private readonly IMongoCollection<Question> quesCollection;
    public QuestionsService(IOptions<uomartDatabaseSettings> uomartDatabaseSettings)
    {
        var settings = MongoClientSettings.FromConnectionString("mongodb://csi5112group12:csi5112group12@cluster0-shard-00-00.vtqbg.mongodb.net:27017,cluster0-shard-00-01.vtqbg.mongodb.net:27017,cluster0-shard-00-02.vtqbg.mongodb.net:27017/myFirstDatabase?ssl=true&replicaSet=atlas-gv1oje-shard-0&authSource=admin&retryWrites=true&w=majority");
        settings.ServerApi = new ServerApi(ServerApiVersion.V1);
        var client = new MongoClient(settings);
        var database = client.GetDatabase("uomart");
        quesCollection = database.GetCollection<Question>("questions");
    }

    public async Task createQuestion(Question newQuestion)
    {
        newQuestion.id = null; // ID will be set by MongoDB
        await quesCollection.InsertOneAsync(newQuestion);
    }

    public async Task<List<Question>> getQuestion()
    {
        return await quesCollection.Find(_ => true).ToListAsync();
    }

    public async Task<Question> getQuestion(string Id)
    {
        return await quesCollection.Find<Question>(question => question.id == Id).FirstOrDefaultAsync();
    }

    public async Task<bool> updateQuestion(string Id, Question updatedQuestion)
    {

        ReplaceOneResult r = await quesCollection.ReplaceOneAsync(question => question.id == updatedQuestion.id, updatedQuestion);
        return r.IsModifiedCountAvailable && r.ModifiedCount == 1;
    }

    public async Task deleteQuestion(string Id)
    {

        await quesCollection.DeleteOneAsync(question => question.id == Id);
    }
}