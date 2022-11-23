# BaGet Docker Image

This is a docker image of the lightweight NuGet and symbol server [BaGet](https://github.com/loic-sharma/BaGet)\.  
This image is built for multiple platforms using buildx. 

## Quick trial 
If you run for trial.  
The container provides services on port 80.  

```
$ docker run -it -p 8000:80 toras9000/baget-mp
```

## Data location
Assume that the following locations in the container are persisted:

- `/app/BaGet/packages`  
Storage directory for package files.

- `/app/BaGet/symbols`  
Storage directory for symbol files.

- `/app/config`  
Storage directory for configuration file 'appsettings.json'.  
If there is a configuration file in this directory, it is copied to the application directory.  
If not, copy the application configuration file here.  

## Enviroment variables

If appsettings.json does not exist in the config directory, it will be regarded as the first execution and the configuration file will be initialized. 
At that time, use the following environment variables. 
These only make sense when initialization is performed. 

- `INIT_DB_TYPE`  
Replaces the database type value in the configuration file.   


- `INIT_DB_CONN_STR`  
Replaces the database connection string in the configuration file.   
The connection string is the one used by the .NET database provider. 

### Usage examples

An example of persistence is as follows:
```
$ docker run -d \
             -p 8000:80 \
             -v /opt/baget/packages:/app/BaGet/packages \
             -v /opt/baget/symbols:/app/BaGet/symbols \
             -v /opt/baget/congig:/app/config \
             -v /opt/baget/database:/app/database \
             -e INIT_DB_TYPE=Sqlite \
             -e INIT_DB_CONN_STR=Data Source=/app/database/baget.db \
             toras9000/baget-mp
```

BaGet also supports other database providers.  
See the official [configuration documentation](https://github.com/loic-sharma/BaGet/blob/main/docs/configuration.md#database-configuration)\.   
Below is an example of docker-compose.yml for Postgres.   

```
version: '3'
services:
  db:
    image: postgres:13
    restart: unless-stopped
    volumes:
      - ./volumes/baget/db:/var/lib/postgresql/data
    environment:
      - POSTGRES_USER=baget_user
      - POSTGRES_PASSWORD=baget_secret
      - POSTGRES_DB=baget_store

  app:
    image: toras9000/baget-mp
    restart: unless-stopped
    links:
      - db:db-container
    ports:
      - "8030:80"
    volumes:
      - ./volumes/baget/app/packages:/app/BaGet/packages
      - ./volumes/baget/app/symbols:/app/BaGet/symbols
      - ./volumes/baget/app/config:/app/config
    environment:
      - INIT_DB_TYPE=PostgreSql
      - INIT_DB_CONN_STR=Host=db-container;User ID=baget_user;Password=baget_secret;Port=5432;Database=baget_store;
```