using aspnet.models;

namespace aspnet.services;
public class UserService
{
    // Data placeholder
    private List<User> user = new List<User>() {
        new User("1", "Ranjan", "ranjan@uottawa.ca", "ranjan12345@", "customer"),
        new User("2", "Ashish", "ashish@uottawa.ca", "ashish123452", "customer"),
        new User("3", "Harish", "harish@uottawa.ca", "harish12345@", "merchant"),
        new User("4", "John", "john@uottawa.ca", "john12345@", "merchant"),
    };

    public UserService()
    {
    }

    public async Task createUser(User newUser)
    {
        user.Add(newUser);//changine in database
    }

    public async Task<List<User>> getUser()
    {
        return user;//getting it from database
    }

    public async Task<User> getUser(string id)
    {
        return user.Find(x => x.uid == id);
    }
    public async Task<User> getUserFromEmail(string email)
    {
        return user.Find(x => x.email == email);
    }
    // public async Task<Product> getmProd(string mid) {
    //     return prod.Find(x => x.merchantid == mid);
    // }//getting all products of merchant

    // public async Task<bool> updateProd(string Id, Product updatedProd) {
    //     bool result = false;
    //     int index = prod.FindIndex(x => x.id == Id);
    //     if (index != -1) {
    //         updatedProd.id = Id;
    //         prod[index] = updatedProd;
    //         result = true;
    //     }
    //     return result;
    // }

    // public async Task<bool> deleteProd(string Id) {
    //     bool deleted = false;
    //     int index = prod.FindIndex(x => x.id == Id);
    //     if (index != -1) {
    //         prod.RemoveAt(index);
    //         deleted = true;
    //     }
    //     return deleted;
    // }
}