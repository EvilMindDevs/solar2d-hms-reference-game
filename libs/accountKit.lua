local accountKit = require ("plugin.huaweiAccountKit")
local json = require("json")
local toast = require( "libs.toast" )

local _accountKit = {}

_accountKit.login = false;
_accountKit.error = false;
_accountKit.text = ""
_accountKit.data = {}

local function listener( event )
    if event.type == "signIn" then
        if not event.isError then 
            _accountKit.data = json.decode( event.data )
            _accountKit.text = event.message
            _accountKit.error = false
            _accountKit.login = true
            toast.showToast("Welcome ".._accountKit.data.getDisplayName, {duration = "long", gravity = "bottom"})
        else 
            _accountKit.data = {}
            _accountKit.text = event.message
            _accountKit.error = true
            _accountKit.login = false
            toast.showToast("Login failed " .. event.message, {duration = "long", gravity = "bottom"})
        end
    end
end

accountKit.init(listener) 

accountKit.signIn("DEFAULT_AUTH_REQUEST_PARAM_GAME", {"setAuthorizationCode", "setAccessToken"})

return _accountKit