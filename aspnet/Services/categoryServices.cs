using aspnet.models;

namespace aspnet.services;

public class CatService
{
    // Data placeholder
    private List<Category> cat = new List<Category>() {
        new Category("1", "Clothing", "url"),
        new Category("2", "Electronics", "url"),
        new Category("3", "Shoes", "url")
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

    async Task<bool> updateCat(string Cid, Category updatedCat)
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

    async Task<bool> deleteCat(string Cid)
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