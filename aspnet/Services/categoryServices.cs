using aspnet.models;

namespace aspnet.services;

public class CatService
{
    // Data placeholder
    private List<Category> cat = new List<Category>() {
        new Category("1", "Clothing and Shoes", "https://m.media-amazon.com/images/I/410-L0vF3+L._AC_UL640_QL65_.jpg"),
        new Category("2", "Laptops and Mobiles", "https://m.media-amazon.com/images/I/71an9eiBxpL._AC_UL640_QL65_.jpg"),
        new Category("3", "Books and Stationary", "https://m.media-amazon.com/images/I/61-Pt+1b+xL._AC_UL640_QL65_.jpg"),
        new Category("4", "Electronics and Accessories", "https://m.media-amazon.com/images/I/71Hx8b6HGbL._AC_UL640_QL65_.jpg"),
        new Category("5", "Home and Kitchen", "https://m.media-amazon.com/images/I/61wHFNgOxSL._AC_UL640_QL65_.jpg"),
        new Category("6", "Beauty and Essentials", "https://m.media-amazon.com/images/I/81qII9PojkL._AC_UL640_QL65_.jpg"),

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