// using aspnet.models;
// using aspnet.services;
// using Microsoft.AspNetCore.Mvc;

// namespace aspnet.controllers;

// // [ApiController]
// [Route("api/merchant/[controller]")]
// public class MerchantController : ControllerBase{
//     private readonly MerchantService merchantService;
//     public MerchantController(MerchantService service) {
//         this.merchantService = service;
//     }

//     [HttpGet]
//     public async Task<List<Merchant>> Get() {
//         return await merchantService.getMerchant();
//     } 

//     [HttpGet("{id}")]
//     public async Task<ActionResult<Merchant>> Get(string Id) {
//         var merchant = await merchantService.getMerchant(Id);
//         if (merchant is null) {
//             return NotFound();
//         }
//         return merchant;
//     }


//     [HttpPost]
//     public async Task<ActionResult> Post(Merchant newMerchant) {
//         await merchantService.createMerchant(newMerchant);
//         return CreatedAtAction(nameof(Get), new {id = newMerchant.id}, newMerchant);
//     }

//     [HttpPut("{id}")]
//     public async Task<ActionResult> Update(string Id, Merchant updatedMerchant) {
//         bool updated = await merchantService.updateMerchant(Id, updatedMerchant);
//         if (!updated) {
//             // this assumes that a failed update is always caused by the object 
//             // not being found. This needs to be changed if the cause may be different
//             return NotFound();
//         } 
//         return NoContent();
//     }

//     [HttpDelete("{id}")]
//     public async Task<ActionResult> Delete(string Id) {
//         var merchant = await merchantService.getMerchant(Id);
//         if (merchant is null) {
//             return NotFound();
//         }
//         await merchantService.deleteMerchant(merchant.id);
//         return NoContent();
//     }
// }