using aspnet.models;
using aspnet.services;
using Microsoft.AspNetCore.Mvc;

namespace aspnet.controllers;

// [ApiController]
[Route("api/cat/[controller]")]
public class CatController : ControllerBase{
    private readonly CatService catService;
    public CatController(CatService service) {
        this.catService = service;
    }

    [HttpGet]
    public async Task<List<Category>> Get() {
        return await catService.getCat();
    } 

    [HttpGet("{cid}")]
    public async Task<ActionResult<Category>> Get(string Cid) {
        var cat = await catService.getCat(Cid);
        if (cat is null) {
            return NotFound();
        }
        return cat;
    }

    [HttpPost]
    public async Task<ActionResult> Post(Category newCat) {
        await catService.createCat(newCat);
        return CreatedAtAction(nameof(Get), new {id = newCat.cid}, newCat);
    }

    [HttpPut("{cid}")]
    public async Task<ActionResult> Update(string Cid, Category updatedCat) {
        bool updated = await catService.updateCat(Cid, updatedCat);
        if (!updated) {
            // this assumes that a failed update is always caused by the object 
            // not being found. This needs to be changed if the cause may be different
            return NotFound();
        } 
        return NoContent();
    }

    [HttpDelete("{cid}")]
    public async Task<ActionResult> Delete(string Cid) {
        var cat = await catService.getCat(Cid);
        if (cat is null) {
            return NotFound();
        }
        await catService.deleteCat(cat.cid);
        return NoContent();
    }
}
