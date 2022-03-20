using aspnet.models;
using aspnet.services;
using Microsoft.AspNetCore.Mvc;

namespace aspnet.controllers;

[ApiController]
[Route("api/[controller]")] // this way we name the controller as Answers - route will be /api/Answers
public class AnswersController : ControllerBase
{
    private readonly AnswersService answersService;
    public AnswersController(AnswersService service)
    {
        this.answersService = service;
    }

    [HttpGet]
    public async Task<List<Answer>> Get()
    {
        return await answersService.getAnswer(); // returns the list of all answers
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<Answer>> Get(string Id)
    {
        var answer = await answersService.getAnswer(Id);
        if (answer is null)
        {
            return NotFound();
        }
        return answer; // returns answer with the provided id
    }

    [HttpPost]
    public async Task<ActionResult> Post(Answer newAnswer)
    {
        await answersService.createAnswer(newAnswer);
        return CreatedAtAction(nameof(Get), new { id = newAnswer.id }, newAnswer);
    }

    [HttpPut("{id}")]
    public async Task<ActionResult> Update(string Id, Answer updatedAnswer)
    {
        bool updated = await answersService.updateAnswer(Id, updatedAnswer);
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
        var answer = await answersService.getAnswer(Id);
        if (answer is null)
        {
            return NotFound();
        }
        await answersService.deleteAnswer(answer.id);
        return NoContent(); // returns 204 no content which means it was successfully deleted
    }
}