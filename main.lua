function Initialize( Plugin )
	PLUGIN = Plugin
	Plugin:SetName( "SignLock" )
	Plugin:SetVersion( 1.2 )
       
	PluginManager = cRoot:Get():GetPluginManager()
	PluginManager:AddHook(Plugin, cPluginManager.HOOK_PLAYER_USING_BLOCK);
	PluginManager:AddHook(Plugin, cPluginManager.HOOK_PLAYER_BREAKING_BLOCK);
	PluginManager:AddHook(Plugin, cPluginManager.HOOK_UPDATING_SIGN);
	
	if LoadSettings() == true then
		LOGWARN( "Error while loading settings" )
	end
	print(ShowAdminBreach)
	LOG("Initialized " .. PLUGIN:GetName() .. " v" .. PLUGIN:GetVersion())
	return true
end

function OnDisable()
	LOG( PLUGIN:GetName() .. " v" .. PLUGIN:GetVersion() .. " is shutting down..." )
end