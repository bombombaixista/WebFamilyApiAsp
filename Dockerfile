# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia tudo para dentro do container
COPY . .

# Publica a aplicação em modo Release
RUN dotnet publish -c Release -o /app

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copia os artefatos da etapa de build
COPY --from=build /app .

# Expõe a porta (Railway define via variável PORT)
ENV ASPNETCORE_URLS=http://0.0.0.0:${PORT}

# Comando de entrada
ENTRYPOINT ["dotnet", "MinhaApi.dll"]
