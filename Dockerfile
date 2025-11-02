# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the csproj file from the correct subfolder
COPY ["CreatingTestProj/CreatingTestProj.csproj", "CreatingTestProj/"]
RUN dotnet restore "CreatingTestProj/CreatingTestProj.csproj"

# Copy everything and build
COPY . .
WORKDIR /src/CreatingTestProj
RUN dotnet publish "CreatingTestProj.csproj" -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Expose port for Railway
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "CreatingTestProj.dll"]
