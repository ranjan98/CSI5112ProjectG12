using aspnet.models;

namespace aspnet.services;

public class CatService
{
    // Data placeholder
    private List<Category> cat = new List<Category>() {
        new Category("1", "Clothing and Shoes", "assets/categories/1.png"),
        new Category("2", "Laptops and Mobiles", "assets/categories/2.png"),
        new Category("3", "Books and Stationary", "assets/categories/3.png"),
        new Category("4", "Electronics and Accessories", "assets/categories/4.png"),
        new Category("5", "Home and Kitchen", "assets/categories/5.jpg"),
        new Category("6", "Beauty and Essentials", "assets/categories/6.png"),

    };

    public CatService()
    {
    }

    public async Task createCat(Category newCat)
    {
        cat.Add(newCat);//changing in database
    }

    public async Task<List<Category>> getCat()
    {
        return cat;//getting it from database
    }

    public async Task<Category> getCat(string cid)
    {
        return cat.Find(x => x.cid == cid);
    }


    // public async Task<Category> getmCat(string mid)
    // {
    //     return cat.Find(x => x.cmerchantid == mid);
    // }//getting all categories of merchant

    public async Task<bool> updateCat(string Cid, Category updatedCat)
    {
        bool result = false;
        int index = cat.FindIndex(x => x.cid == Cid);
        if (index != -1)
        {
            updatedCat.cid = Cid;
            cat[index] = updatedCat;
            result = true;
        }
        return result;
    }

    public async Task<bool> deleteCat(string Cid)
    {
        bool deleted = false;
        int index = cat.FindIndex(x => x.cid == Cid);
        if (index != -1)
        {
            cat.RemoveAt(index);
            deleted = true;
        }
        return deleted;
    }
}