FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /App

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /App
COPY --from=build-env /App/out .
# don't forget dll
COPY --from=build-env /App/Klukule.HogwartsLegacy.SavefileParser/oo2core_9_win64.dll .

EXPOSE 80/tcp

ENTRYPOINT ["dotnet", "Klukule.HogwartsLegacy.SavefileParser.dll"]
