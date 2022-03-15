// using aspnet.models;
// using aspnet.services;
// using Microsoft.AspNetCore.Mvc;

// namespace aspnet.controllers;

// // [ApiController]
// [Route("api/customer/[controller]")]
// public class CustomerController : ControllerBase{
//     private readonly CustomerService customerService;
//     public CustomerController(CustomerService service) {
//         this.customerService = service;
//     }

//     [HttpGet]
//     public async Task<List<Customer>> Get() {
//         return await customerService.getCustomer();
//     } 

//     [HttpGet("{id}")]
//     public async Task<ActionResult<Customer>> Get(string Id) {
//         var customer = await customerService.getCustomer(Id);
//         if (customer is null) {
//             return NotFound();
//         }
//         return customer;
//     }

//     // [HttpGet("{merchantid}")]
//     // public async Task<ActionResult<Customer>> Get(string Id) {
//     //     var customer = await customerService.getmCustomer(Id);
//     //     if (customer is null) {
//     //         return NotFound();
//     //     }
//     //     return customer;
//     // }

//     [HttpPost]
//     public async Task<ActionResult> Post(Customer newCustomer) {
//         await customerService.createCustomer(newCustomer);
//         return CreatedAtAction(nameof(Get), new {id = newCustomer.id}, newCustomer);
//     }

//     [HttpPut("{id}")]
//     public async Task<ActionResult> Update(string Id, Customer updatedCustomer) {
//         bool updated = await customerService.updateCustomer(Id, updatedCustomer);
//         if (!updated) {
//             // this assumes that a failed update is always caused by the object 
//             // not being found. This needs to be changed if the cause may be different
//             return NotFound();
//         } 
//         return NoContent();
//     }

//     [HttpDelete("{id}")]
//     public async Task<ActionResult> Delete(string Id) {
//         var customer = await customerService.getCustomer(Id);
//         if (customer is null) {
//             return NotFound();
//         }
//         await customerService.deleteCustomer(customer.id);
//         return NoContent();
//     }
// }