require "conf"

local aes = require "resty.aes_new"
local str = require "resty.string"
local aes_128_cbc_with_iv = assert(aes:new(CRYPTO_KEY, nil, aes.cipher(128, "cbc"), {iv = CRYPTO_IV}))
-- AES 128 CBC with IV and no SALT

local _M = {}

function _M:encrypt(data)
    local encrypted = aes_128_cbc_with_iv:encrypt(data)
    return encrypted
end

--
function _M:decrypt(data)
    local decrypted = aes_128_cbc_with_iv:decrypt(data)
    return decrypted
end

return _M
