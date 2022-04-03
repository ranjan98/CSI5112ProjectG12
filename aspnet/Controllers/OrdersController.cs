using aspnet.models;
using aspnet.services;
using Microsoft.AspNetCore.Mvc;

namespace aspnet.controllers;

[ApiController]
[Route("api/[controller]")] // this way we name the controller as Orders - route will be /api/Orders
public class OrdersController : ControllerBase
{
    private readonly OrderService orderService;
    public OrdersController(OrderService service)
    {
        this.orderService = service;
    }

    [HttpGet]
    public async Task<List<Order>> Get()
    {
        return await orderService.getOrder(); // returns the list of all orders
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<Order>> Get(string Id)
    {
        var order = await orderService.getOrder(Id);
        if (order is null)
        {
            return NotFound();
        }
        return order; // returns order with the provided id
    }

    [HttpGet("userorders/{userid}")]
    public async Task<ActionResult<List<Order>>> GetByUser(string Userid)
    {
        var order = await orderService.getOrderByUser(Userid);
        if (order is null)
        {
            return NotFound();
        }
        return order; // returns order with the provided id
    }

    [HttpPost]
    public async Task<ActionResult> Post(Order newOrder)
    {
        await orderService.createOrder(newOrder);
        return CreatedAtAction(nameof(Get), new { id = newOrder.id }, newOrder);
    }

    [HttpPut("{id}")]
    public async Task<ActionResult> Update(string Id, Order updatedOrder)
    {
        bool updated = await orderService.updateOrder(Id, updatedOrder);
        if (!updated)
        {
            // this assumes that a failed update is always caused by the object 
            // not being found. This needs to be changed if the cause may be different
            return NotFound();
        }
        return NoContent();  // returns 204 no content which means it was successfully modified using http put request
    }

    [HttpDelete("{id}")]
    public async Task<ActionResult> Delete(string Id)
    {
        var order = await orderService.getOrder(Id);
        if (order is null)
        {
            return NotFound();
        }
        await orderService.deleteOrder(order.id);
        return NoContent();  // returns 204 no content which means it was successfully deleted
    }
}