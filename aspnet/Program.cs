using aspnet.services;
using aspnet.models;

var builder = WebApplication.CreateBuilder(args);

// Add CORS
var MyAllowSpecificOrigins = "_myAllowSpecificOrigins";

builder.Services.AddCors(options =>
{
    options.AddPolicy(name: MyAllowSpecificOrigins,
                      builder =>
                      {
                          builder.AllowAnyHeader().AllowAnyMethod().AllowAnyOrigin();
                      });
});

// Add services to the container.

builder.Services.AddControllers()
    .AddJsonOptions(
        options => options.JsonSerializerOptions.PropertyNamingPolicy = null);

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddSingleton<ProdService>();
builder.Services.AddSingleton<CatService>();
builder.Services.AddSingleton<UserService>();
builder.Services.AddSingleton<QuestionsService>();
builder.Services.AddSingleton<AnswersService>();
builder.Services.AddSingleton<OrderService>();

builder.Services.Configure<uomartDatabaseSettings>(
    builder.Configuration.GetSection(nameof(uomartDatabaseSettings))
);

// Adding services for Direct Injection

var options = builder.Configuration.GetSection(nameof(uomartDatabaseSettings)).Get<uomartDatabaseSettings>();
builder.Services.AddSingleton<uomartDatabaseSettings>(options);

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseRouting();

// useCors must be after use routing and before use authorization
app.UseCors(MyAllowSpecificOrigins);

app.UseAuthorization();

app.MapControllers();

app.Run();
