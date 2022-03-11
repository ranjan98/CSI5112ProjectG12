# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app/aspnet

# Copy csproj and restore as distinct layers
COPY ./aspnet/*.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY ./aspnet ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app/aspnet
COPY --from=build-env /app/aspnet/out .
ENTRYPOINT ["dotnet", "aspnet.dll"]
