function LoadSettings(Path)
	SettingsIni = cIniFile()
	SettingsIni:ReadFile(Path)
	ShowAdminBreach = SettingsIni:GetValueSetB( "General", "ShowAdminBreach", false )
	SettingsIni:WriteFile(Path)
	
	if ShowAdminBreach == nil then
		return true
	end
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

function CheckBlock( SideBlock )
	if SideBlock == 23 or SideBlock == 54 or SideBlock == 64 or SideBlock == 61 or SideBlock == 62 or SideBlock == 96 then
		return true
	end
end

function CheckProtect( BlockX, BlockY, BlockZ, World )
	if World:GetBlock( BlockX + 1, BlockY, BlockZ ) == 68 then
		if World:GetBlockMeta( BlockX + 1, BlockY, BlockZ ) == 4 then
			Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX + 1, BlockY, BlockZ, "", "", "", "" )
			if Line1 == "[SL]" or Line1 == "[SignLock]" then
				return true
			end
		end
	elseif World:GetBlock( BlockX - 1, BlockY, BlockZ ) == 68 then
		if World:GetBlockMeta( BlockX - 1, BlockY, BlockZ ) == 5 then
			Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX - 1, BlockY, BlockZ, "", "", "", "" )
			if Line1 == "[SL]" or Line1 == "[SignLock]" then
				return true
			end
		end
	elseif World:GetBlock( BlockX, BlockY, BlockZ + 1 ) == 68 then
		if World:GetBlockMeta( BlockX, BlockY, BlockZ + 1 ) == 3 then
			Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX, BlockY, BlockZ + 1, "", "", "", "" )
			if Line1 == "[SL]" or Line1 == "[SignLock]" then
				return true
			end
		end
	elseif World:GetBlock( BlockX, BlockY, BlockZ - 1 ) == 68 then
		if World:GetBlockMeta( BlockX, BlockY, BlockZ - 1 ) == 2 then
			Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX, BlockY, BlockZ - 1, "", "", "", "" )
			if Line1 == "[SL]" or Line1 == "[SignLock]" then
				return true
			end
		end
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
			if World:GetBlockMeta( BlockX, BlockY, BlockZ + 1 ) == 3 then
				Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX, BlockY, BlockZ + 1, "", "", "", "" )
			else
				return false
			end
		elseif World:GetBlock( BlockX, BlockY, BlockZ - 1 ) == 68 then
			if World:GetBlockMeta( BlockX, BlockY, BlockZ - 1 ) == 2 then
				Read, Line1, Line2, Line3, Line4 = World:GetSignLines( BlockX, BlockY, BlockZ - 1, "", "", "", "" )
			else
				return false
			end
		else
			return false
		end
		if Read == true then
			if Line1 == "[SL]" or Line1 == "[SignLock]" then
				if Line2 ~= Player:GetName() then
					if Line3 ~= Player:GetName() then
						if Line4 ~= Player:GetName() then
							if Player:HasPermission("SignLock.Bypass") == false then
								return true
							else
								return nil
							end
						end
					end
				end
			end
			Read, Line1, Line2, Line3, Line4 = nil
		end
	end
end