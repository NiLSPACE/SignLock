function Initialize( Plugin )
	PLUGIN = Plugin
	Plugin:SetName( "SignLock" )
	Plugin:SetVersion( 1 )
       
	PluginManager = cRoot:Get():GetPluginManager()
	PluginManager:AddHook(Plugin, cPluginManager.HOOK_PLAYER_USING_BLOCK);
	PluginManager:AddHook(Plugin, cPluginManager.HOOK_PLAYER_BREAKING_BLOCK);
	PluginManager:AddHook(Plugin, cPluginManager.HOOK_UPDATING_SIGN);
	return true
end

function OnPlayerUsingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType)
	World = Player:GetWorld()
	Block = World:GetBlock( BlockX, BlockY, BlockZ )
	if Block == 23 or Block == 54 or Block == 64 or Block == 61 or Block == 62 or Block == 96 then
		if World:GetBlock( BlockX + 1, BlockY, BlockZ ) == 68 then
			Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX + 1, BlockY, BlockZ, "", "", "", "" )
		elseif World:GetBlock( BlockX - 1, BlockY, BlockZ ) == 68 then
			Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX - 1, BlockY, BlockZ, "", "", "", "" )
		elseif World:GetBlock( BlockX, BlockY, BlockZ + 1 ) == 68 then 
			Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX, BlockY, BlockZ + 1, "", "", "", "" )
		elseif World:GetBlock( BlockX, BlockY, BlockZ - 1 ) == 68 then 
			Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX, BlockY, BlockZ - 1, "", "", "", "" )
		end
		if Read == true then
			if Line1 == "[SL]" or Line1 == "[SignLock]" then
				if Line2 ~= Player:GetName() then
					if Line3 ~= Player:GetName() then
						if Line4 ~= Player:GetName() then
							if Player:HasPermission("SignLock.Bypass") == false then
								Player:SendMessage( cChatColor.Rose .. "You do not have permission to open this" )
								return true
							end
						end
					end
				end
			end
		end
	end
end

function OnPlayerBreakingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType)
	World = Player:GetWorld()
	Block = World:GetBlock( BlockX, BlockY, BlockZ )
	if Block == 23 or Block == 54 or Block == 64 or Block == 61 or Block == 62 or Block == 96 then
		if World:GetBlock( BlockX + 1, BlockY, BlockZ ) == 68 then
			Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX + 1, BlockY, BlockZ, "", "", "", "" )
		elseif World:GetBlock( BlockX - 1, BlockY, BlockZ ) == 68 then
			Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX - 1, BlockY, BlockZ, "", "", "", "" )
		elseif World:GetBlock( BlockX, BlockY, BlockZ + 1 ) == 68 then 
			Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX, BlockY, BlockZ + 1, "", "", "", "" )
		elseif World:GetBlock( BlockX, BlockY, BlockZ - 1 ) == 68 then 
			Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX, BlockY, BlockZ - 1, "", "", "", "" )
		end
		if Read == true then
			if Line1 == "[SL]" or Line1 == "[SignLock]" then
				if Line2 ~= Player:GetName() then
					if Line3 ~= Player:GetName() then
						if Line4 ~= Player:GetName() then
							if Player:HasPermission("SignLock.Bypass") == false then
								Player:SendMessage( cChatColor.Rose .. "You do not have permission to destroy this" )
								return true
							end
						end
					end
				end
			end
		end
	end
end

function OnUpdatingSign(World, BlockX, BlockY, BlockZ, Line1, Line2, Line3, Line4, Player)
	if Line1 == "[SL]" or Line1 == "[SignLock]" then
		if Line2 == "" then
			if Line3 == "" then
				if Line4 == "" then
					return false, Line1, Player:GetName(), Line3, Line4
				end
			end
		end
	end
end