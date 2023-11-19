FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 7265
ENV ASPNETCORE_URLS=http://+:7265


FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY . .

COPY eStomatolog/Images /app/images

FROM build AS publish
RUN dotnet publish "eStomatolog/eStomatolog.csproj" -c Release -o /app
FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "eStomatolog.dll"]