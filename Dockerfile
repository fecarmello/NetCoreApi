#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

# FROM mcr.microsoft.com/dotnet/core/sdk AS base
# WORKDIR /app
# EXPOSE 8081
# EXPOSE 8082

# FROM mcr.microsoft.com/dotnet/core/sdk AS build
# WORKDIR /src
# COPY ["NetCoreApi/NetCoreApi.csproj", "NetCoreApi/"]
# RUN dotnet restore "NetCoreApi/NetCoreApi.csproj"
# COPY . .
# WORKDIR "/src/NetCoreApi"
# RUN dotnet build "NetCoreApi.csproj" -c Release -o /app

# FROM build AS publish
# RUN dotnet publish "NetCoreApi.csproj" -c Release -o /app

# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app .
# ENTRYPOINT ["dotnet", "NetCoreApi.dll"]

FROM mcr.microsoft.com/dotnet/core/sdk
WORKDIR /app
EXPOSE 80

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out
CMD ASPNETCORE_URLS=http://*:$PORT dotnet out/NetCoreApi.dll