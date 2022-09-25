# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:6:0-focal AS build
WORKDIR /source
COPY . .
RUN dotnet restore "./Messenger.Server/Messenger.Server.csproj" --disable-parallel
RUN dotnet publish "./Messenger.Server/Messenger.Server.csproj" --c release -o /app --no-restore

# Serve Stage
FROM mcr.microsoft.com/dotnet/sdk:6:0-focal AS build
WORKDIR /app
COPY --from=build /app ./	

EXPOSE 5000

ENTRYPOINT ["dotnet", "Messenger.Server.dll"]