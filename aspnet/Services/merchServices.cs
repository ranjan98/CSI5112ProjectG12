// using aspnet.models;

// namespace aspnet.services;
// public class MerchantService {
//     // Data placeholder
//     private List<Merchant> merchant = new List<Merchant> () {
//         new Merchant("1", "Tommy Hilfigure","New York","Clothing","url","desc", true),
//         new Merchant("2", "Samsung","Seoul","Electronics","url","desc", true),
//         new Merchant("3",  "Nike","Florida","Shoes","url","desc", true)
//     };

//     public MerchantService() {
//     }

//     public async Task createMerchant(Merchant newMerchant) {
//         merchant.Add(newMerchant);//changine in database
//     }

//     public async Task<List<Merchant>> getMerchant() {
//         return merchant;//getting it from database
//     }

//     public async Task<Merchant> getMerchant(string id) {
//         return merchant.Find(x => x.id == id);
//     }

//     public async Task<bool> updateMerchant(string Id,Merchant updatedMerchant) {
//         bool result = false;
//         int index = merchant.FindIndex(x => x.id == Id);
//         if (index != -1) {
//             updatedMerchant.id = Id;
//             merchant[index] = updatedMerchant;
//             result = true;
//         }
//         return result;
//     }

//     public async Task<bool> deleteMerchant(string Id) {
//         bool deleted = false;
//         int index = merchant.FindIndex(x => x.id == Id);
//         if (index != -1) {
//             merchant.RemoveAt(index);
//             deleted = true;
//         }
//         return deleted;
//     }
// }