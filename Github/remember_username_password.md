Save Username and Password in Git Credentials Storage
Run the following command to enable credentials storage in your Git repository:

```$ git config credential.helper store```

To enable credentials storage globally, run:

```$ git config --global credential.helper store```

When credentials storage is enabled, the first time you pull or push from the remote Git repository, you will be asked for a username and password, and they will be saved in ~/.git-credentials file.

During the next communications with the remote Git repository you won’t have to provide the username and password.

Each credential in ~/.git-credentials file is stored on its own line as a URL like:

```https://<USERNAME>:<PASSWORD>@github.com```
