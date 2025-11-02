# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj and restore
COPY ["CreatingTestProj.csproj", "./"]
RUN dotnet restore "CreatingTestProj.csproj"

# Copy the rest of the source and build
COPY . .
RUN dotnet publish "CreatingTestProj.csproj" -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Expose port for Railway
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "CreatingTestProj.dll"]
