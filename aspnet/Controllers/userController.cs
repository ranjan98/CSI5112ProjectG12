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

    // [HttpGet("{uid}")]
    // public async Task<ActionResult<User>> Get(string Id)
    // {
    //     var user = await userService.getUser(Id);
    //     if (user is null)
    //     {
    //         return NotFound();
    //     }
    //     return user;
    // }
    [HttpGet("{email}")]
    public async Task<ActionResult<User>> Get(string Email)
    {
        var user = await userService.getUserFromEmail(Email);
        if (user is null)
        {
            return NotFound();
        }
        return user;
    }

    // [HttpPost]
    // public async Task<ActionResult> Post(Product newProd) {
    //     await prodService.createProd(newProd);
    //     return CreatedAtAction(nameof(Get), new {id = newProd.id}, newProd);
    // }

    // [HttpPut("{uid}")]
    // public async Task<ActionResult> Update(string Id, Product updatedProd) {
    //     bool updated = await prodService.updateProd(Id, updatedProd);
    //     if (!updated) {
    //         // this assumes that a failed update is always caused by the object 
    //         // not being found. This needs to be changed if the cause may be different
    //         return NotFound();
    //     } 
    //     return NoContent();
    // }

    // [HttpDelete("{id}")]
    // public async Task<ActionResult> Delete(string Id) {
    //     var prod = await prodService.getProd(Id);
    //     if (prod is null) {
    //         return NotFound();
    //     }
    //     await prodService.deleteProd(prod.id);
    //     return NoContent();
    // }
}