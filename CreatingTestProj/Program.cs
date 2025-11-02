using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Hosting;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// Serve default files like index.html
app.UseDefaultFiles();
app.UseStaticFiles();

// Listen on port 8080 (Railway expects this)
app.Urls.Add("http://0.0.0.0:8080");

app.Run();
