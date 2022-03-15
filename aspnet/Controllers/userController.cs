using aspnet.models;
using aspnet.services;
using Microsoft.AspNetCore.Mvc;

namespace aspnet.controllers;

[ApiController]
[Route("api/[controller]")]
public class UserController : ControllerBase
{
    private readonly UserService userService;
    public UserController(UserService service)
    {
        this.userService = service;
    }

    [HttpGet]
    public async Task<List<User>> Get()
    {
        return await userService.getUser();
    }

    // commenting this as, instead of using id, using email to get the user 
    [HttpGet("{uid}")]
    public async Task<ActionResult<User>> Get(string Uid)
    {
        var user = await userService.getUser(Uid);
        if (user is null)
        {
            return NotFound();
        }
        return user;
    }

    // commenting this for now as we are fetching the user from uid
    // [HttpGet("{email}")]
    // public async Task<ActionResult<User>> Get(string Email)
    // {
    //     var user = await userService.getUserFromEmail(Email);
    //     if (user is null)
    //     {
    //         return NotFound();
    //     }
    //     return user;
    // }

    [HttpPost]
    public async Task<ActionResult> Post(User newUser)
    {
        await userService.createUser(newUser);
        return CreatedAtAction(nameof(Get), new { uid = newUser.uid }, newUser);
    }

    [HttpPut("{uid}")]
    public async Task<ActionResult> Update(string Uid, User updatedUser)
    {
        bool updated = await userService.updateUser(Uid, updatedUser);
        if (!updated)
        {
            // this assumes that a failed update is always caused by the object 
            // not being found. This needs to be changed if the cause may be different
            return NotFound();
        }
        return NoContent();
    }

    [HttpDelete("{uid}")]
    public async Task<ActionResult> Delete(string Uid)
    {
        var user = await userService.getUser(Uid);
        if (user is null)
        {
            return NotFound();
        }
        await userService.deleteUser(user.uid);
        return NoContent();
    }
}