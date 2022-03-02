using aspnet.models;

namespace aspnet.services;
public class ProdService {
    // Data placeholder
    private List<Product> prod = new List<Product> () {
        new Product("1", "Tommy -Tshirt", "1","Clothing","url","desc", true),
        new Product("2", "Note20", "2","Electronics","url","desc", true),
        new Product("3", "Lebron Soldier", "3","Shoes","url","desc", true)
    };

    public ProdService() {
    }

    public async Task createProd(Product newProd) {
        prod.Add(newProd);//changine in database
    }

    public async Task<List<Product>> getProd() {
        return prod;//getting it from database
    }

    public async Task<Product> getProd(string id) {
        return prod.Find(x => x.id == id);
    }
    public async Task<Product> getmProd(string mid) {
        return prod.Find(x => x.merchantid == mid);
    }//getting all products of merchant

    public async Task<bool> updateProd(string Id, Product updatedProd) {
        bool result = false;
        int index = prod.FindIndex(x => x.id == Id);
        if (index != -1) {
            updatedProd.id = Id;
            prod[index] = updatedProd;
            result = true;
        }
        return result;
    }

    public async Task<bool> deleteProd(string Id) {
        bool deleted = false;
        int index = prod.FindIndex(x => x.id == Id);
        if (index != -1) {
            prod.RemoveAt(index);
            deleted = true;
        }
        return deleted;
    }
}