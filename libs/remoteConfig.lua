local remoteConfig = require ("plugin.huaweiRemoteConfig")
local json = require("json")
local toast = require( "libs.toast" )

local _remoteConfig = {}

local function listener(event)
	if event.type == "fetch" then
        print(event.message)
    end
end

remoteConfig.init(listener)

remoteConfig.clearAll()

local defaultValues = {
    removeAdProductId = "remove_ads",
    removeAdProductType = 1,
}

remoteConfig.applyDefault(defaultValues)

-- Used to pull the values from cloud.
--remoteConfig.fetch()

function _remoteConfig.getMergedAll()
	return json.decode(remoteConfig.getMergedAll())
end

return _remoteConfig