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
builder.Services.AddTransient<ProdService>();
builder.Services.AddTransient<CatService>();
builder.Services.AddTransient<UserService>();
builder.Services.AddTransient<QuestionsService>();
builder.Services.AddTransient<AnswersService>();
builder.Services.AddTransient<OrderService>();

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
