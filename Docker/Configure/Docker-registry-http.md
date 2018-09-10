### Create on docker 

```
docker run -d -p 5000:5000 --name registry registry:2
```

### Create or modify /etc/docker/daemon.json

```
        {
        "insecure-registries":["myregistry.example.com:5000"] 
        }
 ```
        
### Restart docker daemon

```
    sudo service docker restart
```

## ERROR

>Error response from daemon: Get https://domanin:5000/v2/: http: server gave HTTP response to HTTPS client
