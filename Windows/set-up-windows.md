# WSL Configure

```shell
$ notepad $env:USERPROFILE\.wslconfig
```


```
[wsl2]
guiApplications=false

# Limits VM memory to use no more than 3 GB, this can be set as whole numbers using GB or MB
memory=3GB 

# Sets the VM to use two virtual processors
processors=2

# Sets amount of swap storage space to 6GB, default is 25% of available RAM
swap=6GB
```
