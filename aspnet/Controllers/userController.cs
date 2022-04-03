using aspnet.models;
using aspnet.services;
using Microsoft.AspNetCore.Mvc;

namespace aspnet.controllers;

[ApiController]
[Route("api/[controller]")] // this way we name the controller as User for Users - route will be /api/User
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
        return await userService.getUser(); // returns the list of Users
    }

    [HttpGet("{uid}")]
    public async Task<ActionResult<User>> Get(string Uid)
    {
        var user = await userService.getUser(Uid);
        if (user is null)
        {
            return NotFound();
        }
        return user;  // returns the user with the provided id
    }

   
    [HttpGet("byemail/{email}")]
    public async Task<ActionResult<User>> GetByEmail(string Email)
    {
        var user = await userService.getUserFromEmail(Email);
        if (user is null)
        {
            return NotFound();
        }
        return user;
    }

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
        return NoContent(); // returns 204 no content which means it was successfully modified using http put request
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
        return NoContent(); // returns 204 no content which means it was successfully deleted
    }
}