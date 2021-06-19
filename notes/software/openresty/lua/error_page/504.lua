local err_msg = "Timeout for reading a response from " .. ngx.var.app_name
if ngx.var.upstream_response_time then
     err_msg = err_msg .. " (" .. ngx.var.upstream_response_time .. "s)"
end
local crlf = "\n"
local cjson = require "cjson"

local RESULT = {}
RESULT["OPT_STATUS"] = "HTTP_GATEWAY_TIMEOUT"
RESULT["DESCRIPTION"] = err_msg
RESULT["OPT_STATUS_CH"] = err_msg
RESULT["OPT_STATUS_EN"] = err_msg

ngx.status = ngx.HTTP_GATEWAY_TIMEOUT
ngx.header["content-type"] = "application/json"
ngx.print(cjson.encode(RESULT))
