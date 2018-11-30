### 分析一个url 的信息
```
curl -o /dev/null -w  %{time_namelookup}::%{time_connect}::%{time_starttransfer}::%{time_total}::%{speed_download}"\n" -H "Content-Type: application/json;Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vY29udHJvbGxlcjo4MDgwL2FwaS9sb2dpbiIsImlhdCI6MTUzNDQ3MjU2OSwiZXhwIjoxNTM0NTU4OTY5LCJuYmYiOjE1MzQ0NzI1NjksImp0aSI6IlZ3enozNXFiYVpwb0hTRVMiLCJzdWIiOjF9.ddO9zAFwYWFDHsL3A4WGVfN5KxnNX9c8YAWLYcsg290" -X POST  --data '{method: "get", url: "/v1/vgateways/", apitype: "app", data: {}}' "https://112.35.22.8:4443/api/call"
```
