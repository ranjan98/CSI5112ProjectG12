using aspnet.models;

namespace aspnet.services;
public class AnswersService
{
    // Data placeholder
    private List<Answer> answer = new List<Answer>() {
        new Answer("1", "No, it does not have a thermostat", "1", "2022-03-15 08:37:44", "1"),
        new Answer("2", "Using thermostat can easily turn this off at night", "1", "2022-03-15 08:37:44", "1"),
        new Answer("3", "Just buy this, you won't regret it", "1", "2022-04-15 08:37:44", "1")
    };

    public AnswersService()
    {
    }

    public async Task createAnswer(Answer newAnswer)
    {
        answer.Add(newAnswer);//changing in database
    }

    public async Task<List<Answer>> getAnswer()
    {
        return answer;//getting it from database
    }

    public async Task<Answer> getAnswer(string Id)
    {
        return answer.Find(x => x.id == Id);
    }

    public async Task<bool> updateAnswer(string Id, Answer updatedAnswer)
    {
        bool result = false;
        int index = answer.FindIndex(x => x.id == Id);
        if (index != -1)
        {
            updatedAnswer.id = Id;
            answer[index] = updatedAnswer;
            result = true;
        }
        return result;
    }

    public async Task<bool> deleteAnswer(string Id)
    {
        bool deleted = false;
        int index = answer.FindIndex(x => x.id == Id);
        if (index != -1)
        {
            answer.RemoveAt(index);
            deleted = true;
        }
        return deleted;
    }
}