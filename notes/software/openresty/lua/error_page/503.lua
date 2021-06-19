local err_msg = "Service " .. ngx.var.app_name .. "  not found!"
local crlf = "\n"
local cjson = require "cjson"

local RESULT = {}
RESULT["OPT_STATUS"] = "HTTP_SERVICE_UNAVAILABLE"
RESULT["DESCRIPTION"] = err_msg
RESULT["OPT_STATUS_CH"] = err_msg
RESULT["OPT_STATUS_EN"] = err_msg

ngx.status = ngx.HTTP_SERVICE_UNAVAILABLE
ngx.header["content-type"] = "application/json"
ngx.print(cjson.encode(RESULT))
