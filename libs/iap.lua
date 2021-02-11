local huaweiIAP = require ("plugin.huaweiIAP")
local json = require("json")
local toast = require( "libs.toast" )

local publicKey = "MIIBojANBgkqhkiG9w0BAQEFAAOCAY8AMIIBigKCAYEAun7pFTYMCQB8OEiEPR5R2K20BK5InaUUUQuU38T/PkBfzo9RMc2fIEMU+oN4akPLNZKEBDxkEfCg3gN2piNP3zbLQ/9Zw7taYmLBHAQI35T0MvAb0ZPkd8F7VvobLJyAxiVvDn7/e9eJQD/Vf9dH5q+Tpmv7r21bHPmUAjmu2/PtFT0N7DK3LjCpQ/jbDkKb70CNvTE/pBMJ0cTjpwsY6U3kSXqiB+eXCpcGp6f+bJ/alGMO0qgOvAIH1vN7Xz6RXbZ0qLkV+NLfKYeODvyx9vTsVspobQTvfBNjztixPEMvPmJHAC3hSqt6xeKIuLhjkrPdKKKXJaGD4fQYTXlQT+OXEQmrT0sOCP2M7lmTUVWXqRpQUfMo9WfEE0499qUBdbWZmC1tjEukizxMvPw9sYcVbivcnCwOX3ww+X9PR1W5RxF8bo4o2z8uzZlKV5HjZoxS6VwRMTJcoIjUYTPyGPases/WFBMSYHpHc4GokxQy4MyesdnsSY3dj5vvx59PAgMBAAE="

_huaweiIAP = {}
_huaweiIAP.remove_ads = "remove_ads"
_huaweiIAP.isRemoveAds = false

local function listener(event)
    if event.type == "createPurchaseIntent" then
	    if not event.isError then
	        toast.showToast("Purchase Successful", {duration = "long", gravity = "center"})
	        huaweiIAP.obtainOwnedPurchases(1)
	    else
	        toast.showToast(event.message, {duration = "long", gravity = "center"})
	    end
	elseif event.type == "obtainOwnedPurchases" then
	    if not event.isError then
	        for el in pairs(json.decode(event.data)) do 	        	
	        	if _huaweiIAP.remove_ads == json.decode(json.decode(event.data)[el].inAppPurchaseData).productId then
	        		_huaweiIAP.isRemoveAds = true;
	        	end 
	        end
	    else
	        toast.showToast(event.message, {duration = "long", gravity = "center"})
	    end
	end
end


huaweiIAP.init(listener) 

-- huaweiIAP.isEnvReady()
-- huaweiIAP.isSandboxActivated()

function _huaweiIAP.Purchase(productType, productId)
	huaweiIAP.createPurchaseIntent(productType , productId)
end

huaweiIAP.obtainOwnedPurchases(1)

function _huaweiIAP.ObtainOwnedPurchases()
	huaweiIAP.obtainOwnedPurchases(1)
end


return _huaweiIAP