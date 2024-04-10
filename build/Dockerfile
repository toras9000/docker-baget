FROM mcr.microsoft.com/dotnet/sdk:3.1-focal as builder

WORKDIR /work

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update
RUN apt-get install -y git nodejs

COPY ./assets/helper  ./helper
RUN dotnet publish ./helper          -c Release -o /work/helper

ARG BAGET_VER=xxxxxxxxxx
RUN git clone https://github.com/loic-sharma/BaGet.git --depth 1 -b "${BAGET_VER}"

COPY ./assets/patches ./patches
RUN ls -la /work/patches
RUN git -C ./BaGet apply -p1 /work/patches/*
RUN dotnet publish ./BaGet/src/BaGet -c Release -o /work/app


FROM mcr.microsoft.com/dotnet/aspnet:3.1

WORKDIR /app

RUN mkdir config

COPY --from=builder  /work/app            ./BaGet
COPY --from=builder  /work/helper         ./tool
COPY                 ./assets/startup.sh  .

EXPOSE 80

CMD ["bash", "/app/startup.sh"]
