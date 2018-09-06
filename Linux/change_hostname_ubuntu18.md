# Change hostname Ubuntu 18

## Check current hostname

```
$ sudo hostnamectl set-hostname newname
```

-----

### Change ```/etc/hosts``` file

```
127.0.0.1   localhost
127.0.0.1   newname

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

-----

### Edit the ```cloud.cfg``` file

If the ```cloud-init``` package is installed you also need to edit the ```cloud.cfg file```. This package is usually installed by default in the images provided by the cloud providers such as AWS and it is used to handle the initialization of the cloud instances.

```
$ ls -l /etc/cloud/cloud.cfg
```
If you see the following output it means that the package is not installed and no further action is required.

```
Output:
ls: cannot access '/etc/cloud/cloud.cfg': No such file or directory
```

If the package is installed the output will look like the following:

```
Output
-rw-r--r-- 1 root root 3169 Apr 27 09:30 /etc/cloud/cloud.cfg
```

and you’ll need to open the ```/etc/cloud/cloud.cfg``` and change the ```preserve_hostname``` value from ```false``` to ```true```:

```
# This will cause the set+update hostname module to not operate (if true)
preserve_hostname: true
```
-----

### Verify the change

```
$ hostnamectl
```

### Result

```
   Static hostname: newname
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 6f17445f53074505a008c9abd8ed64a5
           Boot ID: 1c769ab73b924a188c5caeaf8c72e0f4
    Virtualization: kvm
  Operating System: Ubuntu 18.04 LTS
            Kernel: Linux 4.15.0-22-generic
      Architecture: x86-64
```