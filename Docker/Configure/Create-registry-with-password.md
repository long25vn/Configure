
## Create

##### Created a folder registry from in which I wanted to work:

```
$ mkdir registry
```

```
$ cd registry/
```

##### Create my folder in which I wil store my credentials

```
$ mkdir auth
```

##### Now I will create a htpasswd file with the help of a docker container. This htpasswd file will contain my credentials and my encrypted passwd.

```
$ docker run --entrypoint htpasswd registry:2 -Bbn myuser mypassword > auth/htpasswd
```

##### To verify

```
$ cat auth/htpasswd
myuser:$2y$05$8IpPEG94/u.gX4Hn9zDU3.6vru2rHJSehPEZfD1yyxHu.ABc2QhSa
```

Credentials are fine. Now I have to add my credentials to my registry. Here for I will mount my auth directory inside my container:

```
docker run -d -p 5000:5000 --restart=always --name registry_private  -v `pwd`/auth:/auth  -e "REGISTRY_AUTH=htpasswd"  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm"  -e "REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd"  registry:2
```

## TEST:

```
$ docker push localhost:5000/busybox
The push refers to a repository [localhost:5000/busybox]
8ac8bfaff55a: Image push failed
unauthorized: authentication required
authenticate
```

```
$ docker login localhost:5000
Username (): myuser
Password:
Login Succeeded
Retry the push
```

```
$ docker push localhost:5000/busybox
The push refers to a repository [localhost:5000/busybox]
8ac8bfaff55a: Pushed
latest: digest: sha256:1359608115b94599e5641638bac5aef1ddfaa79bb96057ebf41ebc8d33acf8a7 size: 527
```

##### Credentials are saved in ~/.docker/config.json:


`cat ~/.docker/config.json`

```
{
    "auths": {
        "localhost:5000": {
            "auth": "bXl1c2VyOm15cGFzc3dvcmQ="
        }
    }
```    
