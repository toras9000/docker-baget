FROM mcr.microsoft.com/dotnet/core/aspnet:2.2

ARG BAGET_VER=v0.2.0-preview1

WORKDIR /app

RUN apt-get update \
 && apt-get install -y unzip \
 && curl -sOL https://github.com/loic-sharma/BaGet/releases/download/${BAGET_VER}/BaGet.zip \
 && unzip BaGet.zip \
 && rm -f BaGet.zip \
 && mkdir -p database \
 && sed -i -E "s/^(\\s+)\"ConnectionString\": \"Data Source=baget\.db\"(\\s*)\$/\\1\"ConnectionString\": \"Data Source=database\\/baget.db\"\\2/1" appsettings.json \
 && apt-get purge -y unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY ./assets/startup.sh /app/startup.sh

EXPOSE 80

CMD ["bash", "/app/startup.sh"]
