using aspnet.models;
using MongoDB.Driver;  
using Microsoft.Extensions.Options; 

namespace aspnet.services;
public class QuestionsService
{
    private readonly IMongoCollection<Question> quesCollection;
    // Data placeholder
    // private List<Question> question = new List<Question>() {
    //     new Question("1", "Features in Portable Heater", "Does it comes with a thermostat to check the temperature? Or is there anyway it can automatically turn off during night?", "1", answersList, "2022-03-15 08:37:44"),
    // };

    // private static List<string> answersList = new List<string>(){
    //     "1", "2", "3"
    // };
    public QuestionsService(IOptions<uomartDatabaseSettings> uomartDatabaseSettings)
    {
        var settings = MongoClientSettings.FromConnectionString(uomartDatabaseSettings.Value.ConnectionString);
        settings.ServerApi = new ServerApi(ServerApiVersion.V1);
        var client = new MongoClient(settings);
        var database = client.GetDatabase(uomartDatabaseSettings.Value.DatabaseName);
        quesCollection = database.GetCollection<Question>("questions");
    }

    public async Task createQuestion(Question newQuestion)
    {
        newQuestion.id = null; // ID will be set by MongoDB
        await quesCollection.InsertOneAsync(newQuestion);
        //question.Add(newQuestion);//changing in database
    }

    public async Task<List<Question>> getQuestion()
    {
        return await quesCollection.Find(_ => true).ToListAsync();
        //return question;//getting it from database
    }

    public async Task<Question> getQuestion(string Id)
    {
        return await quesCollection.Find<Question>(question => question.id == Id).FirstOrDefaultAsync();
        //return question.Find(x => x.id == Id);
    }

    public async Task<bool> updateQuestion(string Id, Question updatedQuestion)
    {
        // bool result = false;
        // int index = question.FindIndex(x => x.id == Id);
        // if (index != -1)
        // {
        //     updatedQuestion.id = Id;
        //     question[index] = updatedQuestion;
        //     result = true;
        // }
        // return result;

        ReplaceOneResult r = await quesCollection.ReplaceOneAsync(question => question.id == updatedQuestion.id, updatedQuestion);
        return r.IsModifiedCountAvailable && r.ModifiedCount == 1;
    }

    public async Task deleteQuestion(string Id)
    {
        // bool deleted = false;
        // int index = question.FindIndex(x => x.id == Id);
        // if (index != -1)
        // {
        //     question.RemoveAt(index);
        //     deleted = true;
        // }
        // return deleted;

        await quesCollection.DeleteOneAsync(question => question.id == Id);
    }
}