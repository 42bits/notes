local err_msg = ngx.var.app_name .. " failed!"
local crlf = "\n"
local cjson = require "cjson"

local RESULT = {}
RESULT["OPT_STATUS"] = "HTTP_BAD_GATEWAY"
RESULT["DESCRIPTION"] = err_msg
RESULT["OPT_STATUS_CH"] = err_msg
RESULT["OPT_STATUS_EN"] = err_msg

ngx.status = ngx.HTTP_BAD_GATEWAY
ngx.header["content-type"] = "application/json"
ngx.print(cjson.encode(RESULT))
