local err_msg = "Timeout for reading a response from " .. ngx.var.app_name
if ngx.var.upstream_response_time then
     err_msg = err_msg .. " (" .. ngx.var.upstream_response_time .. "s)"
end
local crlf = "\n"
local cjson = require "cjson"
local file_size = "2M"

local RESULT = {}
RESULT["OPT_STATUS"] = "FILE_SIZE_EXCEED_LIMIT"
RESULT["DESCRIPTION"] = "文件大小超出限制：" .. file_size
RESULT["OPT_STATUS_CH"] = "文件大小超出限制：" .. file_size
RESULT["OPT_STATUS_EN"] = "File size exceed limit"

ngx.status = ngx.HTTP_BAD_REQUEST
ngx.header["content-type"] = "application/json"
ngx.print(cjson.encode(RESULT))
