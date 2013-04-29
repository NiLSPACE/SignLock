function Initialize( Plugin )
	PLUGIN = Plugin
	Plugin:SetName( "SignLock" )
	Plugin:SetVersion( 1.1 )
       
	PluginManager = cRoot:Get():GetPluginManager()
	PluginManager:AddHook(Plugin, cPluginManager.HOOK_PLAYER_USING_BLOCK);
	PluginManager:AddHook(Plugin, cPluginManager.HOOK_PLAYER_BREAKING_BLOCK);
	PluginManager:AddHook(Plugin, cPluginManager.HOOK_UPDATING_SIGN);
	return true
end

function CheckBlock( SideBlock )
	if SideBlock == 23 or SideBlock == 54 or SideBlock == 64 or SideBlock == 61 or SideBlock == 62 or SideBlock == 96 then
		return true
	end
end

function CheckProtect( Block )
	
end

function SetSide( BlockX, BlockY, BlockZ, Side, World )
		if Side == "+X" then
			World:SetBlock(BlockX, BlockY, BlockZ, 68, 4)
		end
		if Side == "-X" then
			World:SetBlock(BlockX, BlockY, BlockZ, 68, 5)
		end
		if Side == "+Z" then
			World:SetBlock(BlockX, BlockY, BlockZ, 68, 2)
		end
		if Side == "-Z" then
			World:SetBlock(BlockX, BlockY, BlockZ, 68, 3)
		end
end

function OnPlayerUsingItem(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType)
	if CheckUsingBlockItem(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType) == true then
		return true
	end
end

function OnPlayerUsingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType)
	if CheckUsingBlockItem(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType) == true then
		Player:SendMessage( cChatColor.Rose .. "You do not have permission to open this" )
		return true
	end
end

function OnPlayerBreakingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType)
	Block = Player:GetWorld():GetBlock(BlockX, BlockY, BlockZ)
	if Block == 68 then	
		World = Player:GetWorld()
		Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX , BlockY, BlockZ, "", "", "", "" )
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
	if CheckUsingBlockItem(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType) == true then
		Player:SendMessage( cChatColor.Rose .. "You do not have permission to destroy this" )
		return true
	end
end

function CheckUsingBlockItem(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType)
	World = Player:GetWorld()
	Block = World:GetBlock( BlockX, BlockY, BlockZ )
	if Block == 23 or Block == 54 or Block == 64 or Block == 61 or Block == 62 or Block == 96 then
		if World:GetBlock( BlockX + 1, BlockY, BlockZ ) == 68 then
			if World:GetBlockMeta( BlockX + 1, BlockY, BlockZ ) == 5 then
				Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX + 1, BlockY, BlockZ, "", "", "", "" )
			else
				return false
			end
		elseif World:GetBlock( BlockX - 1, BlockY, BlockZ ) == 68 then
			if World:GetBlockMeta( BlockX - 1, BlockY, BlockZ ) == 4 then
				Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX - 1, BlockY, BlockZ, "", "", "", "" )
			else
				return false
			end
		elseif World:GetBlock( BlockX, BlockY, BlockZ + 1 ) == 68 then 
			if World:GetBlockMeta( BlockX, BlockY, BlockZ + 1 ) == 2 then
				Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX, BlockY, BlockZ + 1, "", "", "", "" )
			else
				return false
			end
		elseif World:GetBlock( BlockX, BlockY, BlockZ - 1 ) == 68 then 
			if World:GetBlockMeta( BlockX, BlockY, BlockZ - 1 ) == 3 then
				Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX, BlockY, BlockZ - 1, "", "", "", "" )
			else
				return false
			end
		end
		if Read == true then
			if Line1 == "[SL]" or Line1 == "[SignLock]" then
				if Line2 ~= Player:GetName() then
					if Line3 ~= Player:GetName() then
						if Line4 ~= Player:GetName() then
							if Player:HasPermission("SignLock.Bypass") == false then
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
		if Player:HasPermission("SignLock.Create") ~= true then
			return true
		end
		if CheckBlock(World:GetBlock( BlockX + 1, BlockY, BlockZ )) == true then
			SetSide( BlockX, BlockY, BlockZ, "+X", World )
		end
		if CheckBlock(World:GetBlock( BlockX - 1, BlockY, BlockZ )) == true then
			SetSide( BlockX, BlockY, BlockZ, "-X", World )
		end
		if CheckBlock(World:GetBlock( BlockX, BlockY, BlockZ + 1 )) == true then
			SetSide( BlockX, BlockY, BlockZ, "+Z", World )
		end
		if CheckBlock(World:GetBlock( BlockX, BlockY, BlockZ - 1 )) == true then
			SetSide( BlockX, BlockY, BlockZ, "-Z", World )
		end
		if Line2 == "" and Line3 == "" and Line4 == "" then
			return false, Line1, Player:GetName(), Line3, Line4
		end
	end
end