using aspnet.models;
using aspnet.services;
using Microsoft.AspNetCore.Mvc;

namespace aspnet.controllers;

// [ApiController]
[Route("api/user/[controller]")]
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
    public async Task<ActionResult<User>> Get(string Id)
    {
        var user = await userService.getUser(Id);
        if (user is null)
        {
            return NotFound();
        }
        return user;
    }
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
}