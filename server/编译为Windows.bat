SET GOARCH=amd64
SET GOOS=windows
go build -o phqAdminServer.exe -ldflags "-H windowsgui" & pause