using aspnet.models;
using aspnet.services;
using Microsoft.AspNetCore.Mvc;

namespace aspnet.controllers;

[ApiController]
[Route("api/[controller]")] // this way we name the controller as Questions - route will be /api/Questions
public class QuestionsController : ControllerBase
{
    private readonly QuestionsService questionsService;
    public QuestionsController(QuestionsService service)
    {
        this.questionsService = service;
    }

    [HttpGet]
    public async Task<List<Question>> Get()
    {
        return await questionsService.getQuestion(); // returns the list of Questions
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<Question>> Get(string Id)
    {
        var question = await questionsService.getQuestion(Id);
        if (question is null)
        {
            return NotFound();
        }
        return question; // returns Question with the provided id
    }

    [HttpPost]
    public async Task<ActionResult> Post(Question newQuestion)
    {
        await questionsService.createQuestion(newQuestion);
        return CreatedAtAction(nameof(Get), new { id = newQuestion.id }, newQuestion);
    }

    [HttpPut("{id}")]
    public async Task<ActionResult> Update(string Id, Question updatedQuestion)
    {
        bool updated = await questionsService.updateQuestion(Id, updatedQuestion);
        if (!updated)
        {
            // this assumes that a failed update is always caused by the object 
            // not being found. This needs to be changed if the cause may be different
            return NotFound();
        }
        return NoContent(); // returns 204 no content which means it was successfully modified using http put request
    }

    [HttpDelete("{id}")]
    public async Task<ActionResult> Delete(string Id)
    {
        var question = await questionsService.getQuestion(Id);
        if (question is null)
        {
            return NotFound();
        }
        await questionsService.deleteQuestion(question.id);
        return NoContent(); // returns 204 no content which means it was successfully deleted
    }
}