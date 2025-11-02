# Use the .NET 8 SDK image to build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy and restore
COPY CreatingTestProj/*.csproj ./CreatingTestProj/
RUN dotnet restore "CreatingTestProj/CreatingTestProj.csproj"

# Copy everything and build
COPY . .
WORKDIR /src/CreatingTestProj
RUN dotnet publish -c Release -o /app

# Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app ./
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
ENTRYPOINT ["dotnet", "CreatingTestProj.dll"]
