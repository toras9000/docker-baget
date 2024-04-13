# BaGet Docker Image

This is a docker image of the lightweight NuGet and symbol server [BaGet](https://github.com/loic-sharma/BaGet)\.

## Tags

- [0.3.0-preview1](https://github.com/toras9000/docker-baget/tree/v0.3.0-preview1/build)
    - Build using original source.

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
BaGet supports some database providers.  
See the official [configuration documentation](https://github.com/loic-sharma/BaGet/blob/main/docs/configuration.md#database-configuration)\.


- `INIT_DB_CONN_STR`  
Replaces the database connection string in the configuration file.   
The connection string is the one used by the .NET database provider.

### Usage examples

The following is an example of a simple docker-compose.yml for Sqlite.

```
services:
  app:
    image: toras9000/baget-mp:0.3.0-preview1
    restart: unless-stopped
    ports:
      - "8030:80"
    volumes:
      - ./volumes/baget/app/config:/app/config
      - ./volumes/baget/app/database:/app/database
      - ./volumes/baget/app/packages:/app/BaGet/packages
      - ./volumes/baget/app/symbols:/app/BaGet/symbols
    environment:
      - INIT_DB_TYPE=Sqlite
      - INIT_DB_CONN_STR=Data Source=/app/database/baget.db
```
