
### Create a new user account using the adduser command. Don’t forget to replace username with the user name that you want to create:
```
adduser username
```

You will be prompted to set and confirm the new user password. Make sure that the password for the new account is as strong as possible.

```
Adding user `username' ...
Adding new group `username' (1001) ...
Adding new user `username' (1001) with group `username' ...
Creating home directory `/home/username' ...
Copying files from `/etc/skel' ...
New password:
Retype new password:
passwd: password updated successfully
```

Once you set the password the command will create a home directory for the user, copy several configuration files in the home directory and prompts you to set the new user’s information. If you want to leave all of this information blank just press ENTER to accept the defaults.

```
Changing the user information for username
Enter the new value, or press ENTER for the default
    Full Name []:
    Room Number []:
    Work Phone []:
    Home Phone []:
    Other []:
Is the information correct? [Y/n]
```

### Add the new user to the sudo group

By default on Ubuntu systems, members of the group sudo are granted with sudo access. To add the user you created to the sudo group use the usermod command:
```
usermod -aG sudo username
```
