# 1️⃣ Build stage - use SDK image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the csproj and restore dependencies first (for better caching)
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and publish
COPY . .
RUN dotnet publish -c Release -o /app/publish

# 2️⃣ Runtime stage - smaller image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy the published output from build stage
COPY --from=build /app/publish .

# Expose port Railway expects
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

# Start the app
ENTRYPOINT ["dotnet", "CreatingTestProj.dll"]
