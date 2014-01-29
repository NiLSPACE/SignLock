function Initialize( Plugin )
	PLUGIN = Plugin
	Plugin:SetName( "SignLock" )
	Plugin:SetVersion( 1.2 )
       
	PluginManager = cRoot:Get():GetPluginManager()
	PluginManager:AddHook(cPluginManager.HOOK_PLAYER_USING_BLOCK, OnPlayerUsingBlock);
	PluginManager:AddHook(cPluginManager.HOOK_PLAYER_BREAKING_BLOCK, OnPlayerBreakingBlock);
	PluginManager:AddHook(cPluginManager.HOOK_UPDATING_SIGN, OnUpdatingSign);
	
	if LoadSettings(PLUGIN:GetLocalDirectory() .. "/Config.ini") == true then
		LOGWARN( "Error while loading settings" )
	end
	LOG("Initialized " .. PLUGIN:GetName() .. " v" .. PLUGIN:GetVersion())
	return true
end

function OnDisable()
	LOG( PLUGIN:GetName() .. " v" .. PLUGIN:GetVersion() .. " is shutting down..." )
end