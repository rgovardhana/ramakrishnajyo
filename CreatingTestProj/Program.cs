using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Hosting;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// Serve default files (like index.html)
app.UseDefaultFiles();

// Serve all static files from wwwroot
app.UseStaticFiles();

app.Run();
