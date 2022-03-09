namespace aspnet.models;

public class User
{
    public string uid { get; set; }
    public string name { get; set; }
    public string email { get; set; }
    public string password { get; set; }
    public string role { get; set; }
    public User(string Uid, string Name, string Email, string Password, string Role)
    {
        this.uid = Uid;
        this.name = Name;
        this.email = Email;
        this.password = Password;
        this.role = Role;
    }
}

