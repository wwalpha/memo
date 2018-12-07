```sh
$ cd /home/ec2-user
$ sudo yum -y install git fuse libcurl wget
$ wget https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz
$ tar -C /usr/local -xzf go1.11.2.linux-amd64.tar.gz
$ export GOROOT=/usr/local/go
$ export GOPATH=$HOME/go
$ export PATH=$PATH:$GOROOT/bin
$ go get github.com/kahing/goofys
$ go install github.com/kahing/goofys
$ $GOPATH/bin/goofys -o allow_other -f --uid=?? --gid=?? bucket folder
```
