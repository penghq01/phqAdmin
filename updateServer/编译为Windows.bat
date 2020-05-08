SET GOARCH=amd64
SET GOOS=windows
go build -o phqUpdateServer.exe -ldflags "-H windowsgui" & pause