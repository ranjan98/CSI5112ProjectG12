using aspnet.models;
using aspnet.services;
using Microsoft.AspNetCore.Mvc;

namespace aspnet.controllers;

[ApiController]
[Route("api/[controller]")]
public class ProdController : ControllerBase
{
    private readonly ProdService prodService;
    public ProdController(ProdService service)
    {
        this.prodService = service;
    }

    [HttpGet]
    public async Task<List<Product>> Get()
    {
        return await prodService.getProd();
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<Product>> Get(string Id)
    {
        var prod = await prodService.getProd(Id);
        if (prod is null)
        {
            return NotFound();
        }
        return prod;
    }

    // [HttpGet("{merchantid}")]
    // public async Task<ActionResult<Product>> Get(string Id) {
    //     var prod = await prodService.getmProd(Id);
    //     if (prod is null) {
    //         return NotFound();
    //     }
    //     return prod;
    // }

    [HttpPost]
    public async Task<ActionResult> Post(Product newProd)
    {
        await prodService.createProd(newProd);
        return CreatedAtAction(nameof(Get), new { id = newProd.id }, newProd);
    }

    [HttpPut("{id}")]
    public async Task<ActionResult> Update(string Id, Product updatedProd)
    {
        bool updated = await prodService.updateProd(Id, updatedProd);
        if (!updated)
        {
            // this assumes that a failed update is always caused by the object 
            // not being found. This needs to be changed if the cause may be different
            return NotFound();
        }
        return NoContent();
    }

    [HttpDelete("{id}")]
    public async Task<ActionResult> Delete(string Id)
    {
        var prod = await prodService.getProd(Id);
        if (prod is null)
        {
            return NotFound();
        }
        await prodService.deleteProd(prod.id);
        return NoContent();
    }
}