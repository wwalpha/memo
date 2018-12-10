```sh
$ cd /home/ec2-user
$ sudo yum -y install git fuse libcurl wget
$ wget https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz
$ tar -C /usr/local -xzf go1.11.2.linux-amd64.tar.gz
$ echo "export GOROOT=/usr/local/go" >> ~/.bashrc
$ echo "export GOPATH=$HOME/go" >> ~/.bashrc
$ echo "export PATH=$PATH:$GOROOT/bin" >> ~/.bashrc
$ source ~/.bashrc
$ go get github.com/kahing/goofys
$ go install github.com/kahing/goofys
$ $GOPATH/bin/goofys -o allow_other -f --uid=?? --gid=?? bucket folder
```
