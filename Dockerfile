# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj and restore dependencies
COPY CreatingTestProj/CreatingTestProj.csproj CreatingTestProj/
RUN dotnet restore "CreatingTestProj/CreatingTestProj.csproj"

# Copy everything and build
COPY . .
WORKDIR /src/CreatingTestProj
RUN dotnet publish -c Release -o /app/out

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .

# Expose port (Railway expects this)
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

# Run the app
ENTRYPOINT ["dotnet", "CreatingTestProj.dll"]
