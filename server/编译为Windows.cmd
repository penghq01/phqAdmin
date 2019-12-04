SET GOARCH=amd64
SET GOOS=windows
go build -ldflags "-H windowsgui"

pause