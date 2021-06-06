# BaGet Docker Image

[This](https://hub.docker.com/r/toras9000/baget) is a docker image of the lightweight NuGet and symbol server [BaGet](https://github.com/loic-sharma/BaGet).  

## Tags

- latest ([Dockerfile](https://github.com/toras9000/docker-baget/blob/master/build/Dockerfile))

- 0.3.0-preview1
- 0.2.0-preview1

## Usage
If you run for trial.  
The container provides services on port 80.  

```
$ docker run -d -p 8000:80 toras9000/baget
```

## Data location
Assume that the following locations in the container are persisted:

- `/app/packages`  
Storage directory for package files.

- `/app/symbols`  
Storage directory for symbol files.

- `/app/database`  
Storage directory for SQLite database files used by default.  
This does not apply if the database settings are changed.  

- `/app/config`  
Storage directory for configuration file 'appsettings.json'.  
If there is a configuration file in this directory, it is copied to the application directory.  
If not, copy the application configuration file here.  

An example of persistence is as follows:
```
$ docker run -d \
             -p 8000:80 \
             -v /opt/baget/packages:/app/packages \
             -v /opt/baget/symbols:/app/symbols \
             -v /opt/baget/database:/app/database \
             -v /opt/baget/congig:/app/config \
             toras9000/baget
```
