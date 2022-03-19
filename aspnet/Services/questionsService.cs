using aspnet.models;

namespace aspnet.services;
public class QuestionsService
{
    // Data placeholder
    private List<Question> question = new List<Question>() {
        new Question("1", "Features in Portable Heater", "Does it comes with a thermostat to check the temperature? Or is there anyway it can automatically turn off during night?", "1", answersList, "2022-03-15 08:37:44"),
    };

    private static List<string> answersList = new List<string>(){
        "1", "2", "3"
    };
    public QuestionsService()
    {
    }

    public async Task createQuestion(Question newQuestion)
    {
        question.Add(newQuestion);//changing in database
    }

    public async Task<List<Question>> getQuestion()
    {
        return question;//getting it from database
    }

    public async Task<Question> getQuestion(string Id)
    {
        return question.Find(x => x.id == Id);
    }

    public async Task<bool> updateQuestion(string Id, Question updatedQuestion)
    {
        bool result = false;
        int index = question.FindIndex(x => x.id == Id);
        if (index != -1)
        {
            updatedQuestion.id = Id;
            question[index] = updatedQuestion;
            result = true;
        }
        return result;
    }

    public async Task<bool> deleteQuestion(string Id)
    {
        bool deleted = false;
        int index = question.FindIndex(x => x.id == Id);
        if (index != -1)
        {
            question.RemoveAt(index);
            deleted = true;
        }
        return deleted;
    }
}