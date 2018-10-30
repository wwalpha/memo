## Folder Link
`C:\Code\Project` Link to `\Workspace`
```
docker run -v /C/Code/Project:/Workspace -it golang:latest
```

## Port Publish
`-p`は`-it`の前に実行する必要がある
```
docker run -p 3000:3000 --rm -it golang:latest
```
