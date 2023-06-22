# escape=`
ARG TAG=ltsc2022
FROM mcr.microsoft.com/dotnet/sdk:7.0-nanoserver-$TAG AS build
WORKDIR /source

# copy everything
COPY . .
RUN dotnet restore

RUN dotnet publish -c Release -o /app

# final stage/image
#FROM mcr.microsoft.com/dotnet/runtime:7.0-nanoserver-$TAG
FROM mcr.microsoft.com/dotnet/runtime:7.0-nanoserver-$TAG
WORKDIR /app
COPY --from=build /app .

# copy dll
COPY --from=build /source/Klukule.HogwartsLegacy.SavefileParser/oo2core_9_win64.dll .

EXPOSE 80/tcp

ENTRYPOINT ["Klukule.HogwartsLegacy.SavefileParser.exe"]
