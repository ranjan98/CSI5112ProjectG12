using aspnet.models;

namespace aspnet.services;
public class CustomerService {
    // Data placeholder
    private List<Customer> customer = new List<Customer> () {
        new Customer("1", "Ashish","Ottawa","url", true),
        new Customer("2", "Rajan","Kanata","url",true),
        new Customer("3",  "Donald","Florida","url", true)
    };

    public CustomerService() {
    }

    public async Task createCustomer(Customer newCustomer) {
        customer.Add(newCustomer);//changine in database
    }

    public async Task<List<Customer>> getCustomer() {
        return customer;//getting it from database
    }

    public async Task<Customer> getCustomer(string id) {
        return customer.Find(x => x.id == id);
    }
   
    public async Task<bool> updateCustomer(string Id,Customer updatedCustomer) {
        bool result = false;
        int index = customer.FindIndex(x => x.id == Id);
        if (index != -1) {
            updatedCustomer.id = Id;
            customer[index] = updatedCustomer;
            result = true;
        }
        return result;
    }

    public async Task<bool> deleteCustomer(string Id) {
        bool deleted = false;
        int index = customer.FindIndex(x => x.id == Id);
        if (index != -1) {
            customer.RemoveAt(index);
            deleted = true;
        }
        return deleted;
    }
}