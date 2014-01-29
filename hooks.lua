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
						else
							if ShowAdminBreach == true then
								cRoot:Get():BroadcastChat( cChatColor.Rose .. "Player " .. Player:GetName() .. " destroyed a SignLock sign owned by somebody else" )
							end
						end
					end
				end
			end
		end
		Read, Line1, Line2, Line3, Line4 = nil
	end
	if CheckUsingBlockItem(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType) == true then
		Player:SendMessage( cChatColor.Rose .. "You do not have permission to destroy this" )
		return true
	elseif CheckUsingBlockItem(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType) == nil then
		if BlockType == 68 then
			cRoot:Get():BroadcastChat( cChatColor.Rose .. "Player " .. Player:GetName() .. " destroyed a block owned by somebody else" )
		end
	end
end

function OnUpdatingSign(World, BlockX, BlockY, BlockZ, Line1, Line2, Line3, Line4, Player)
	if Line1 == "[SL]" or Line1 == "[SignLock]" then
		if not Player:HasPermission("SignLock.Create") then
			return true
		end
		if CheckBlock(World:GetBlock( BlockX + 1, BlockY, BlockZ )) then
			if CheckProtect( BlockX + 1, BlockY, BlockZ, World ) then
				Player:SendMessage( cChatColor.Green .. "This block is already protected" )
				return false, "[?]", "Already", "Protected"
			end
			SetSide( BlockX, BlockY, BlockZ, "+X", World )
		end
		if CheckBlock(World:GetBlock( BlockX - 1, BlockY, BlockZ )) then
			if CheckProtect( BlockX - 1, BlockY, BlockZ, World ) then
				Player:SendMessage( cChatColor.Green .. "This block is already protected" )
				return false, "[?]", "Already", "Protected"
			end
			SetSide( BlockX, BlockY, BlockZ, "-X", World )
		end
		if CheckBlock(World:GetBlock( BlockX, BlockY, BlockZ + 1 )) then
			if CheckProtect( BlockX, BlockY, BlockZ + 1, World ) then
				Player:SendMessage( cChatColor.Green .. "This block is already protected" )
				return false, "[?]", "Already", "Protected"
			end
			SetSide( BlockX, BlockY, BlockZ, "+Z", World )
		end
		if CheckBlock(World:GetBlock( BlockX, BlockY, BlockZ - 1 )) then
			if CheckProtect( BlockX, BlockY, BlockZ - 1, World ) then
				Player:SendMessage( cChatColor.Green .. "This block is already protected" )
				return false, "[?]", "Already", "Protected"
			end
			SetSide( BlockX, BlockY, BlockZ, "-Z", World )
		end
		Player:SendMessage( cChatColor.Green .. "You successfully protected you're block" )
		if Line2 == "" and Line3 == "" and Line4 == "" then
			return false, Line1, Player:GetName(), Line3, Line4
		end		
	end
end