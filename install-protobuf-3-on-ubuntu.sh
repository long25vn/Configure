### Make sure you grab the latest version
curl -OL 	https://github.com/google/protobuf/releases/download/v3.5.1/protoc-3.5.1-linux-x86_64.zip

#Unzip
unzip protoc-3.5.1-linux-x86_64.zip -d protoc3

#Move protoc to /usr/local/bin/
sudo mv protoc3/bin/* /usr/local/bin/

#Move protoc3/include to /usr/local/include/
sudo mv protoc3/include/* /usr/local/include/

#Logout
sudo pkill -u username
