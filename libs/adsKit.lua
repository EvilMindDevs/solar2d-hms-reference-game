local adsKit = require ("plugin.huaweiAdsKit")
local json = require("json")
local toast = require( "libs.toast" )

_adsKit = {} 

local function listener( event )
    if event.type == "create" then
        if not event.isError then 
            adsKit.load("Interstitial");
        else 
            toast.showToast("Ads Kit Error => " .. event.message, {duration = "long", gravity = "center"})
        end
    elseif event.type == "Interstitial" then
    	if not event.isError then 
        	if event.message == "Ad Loaded" then
            	adsKit.show("Interstitial")
        	end
        end 
    end
end


adsKit.init( listener )

function _adsKit.interstitial()
	adsKit.create("Interstitial", {AdId="testb4znbuh3n2"})
end

return _adsKit