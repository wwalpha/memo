## Folder Link
`C:\Code\Project` Link to `\Workspace`
```
docker run -v /C/Code/Project:/Workspace -it golang:latest
```

## Port Publish
dockerの3000 portをlocalの 4000 portにforwardする
Access: http://localhost:4000
`-p`は`-it`の前に実行する必要がある

```
docker run -p 3000:4000 --rm -it golang:latest
```
