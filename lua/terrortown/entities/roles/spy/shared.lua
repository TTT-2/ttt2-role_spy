if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_spy.vmt")

	util.AddNetworkString("TTT2SpyFakeMessage")
end

ROLE.color = Color(255, 127, 80, 255) -- ...
ROLE.dkcolor = Color(189, 61, 14, 255) -- ...
ROLE.bgcolor = Color(55, 176, 121, 255) -- ...
ROLE.abbr = "spy" -- abbreviation
ROLE.defaultTeam = TEAM_INNOCENT -- the team name: roles with same team name are working together
ROLE.defaultEquipment = SPECIAL_EQUIPMENT -- here you can set up your own default equipment
ROLE.surviveBonus = 0 -- bonus multiplier for every survive while another player was killed
ROLE.scoreKillsMultiplier = 1 -- multiplier for kill of player of another team
ROLE.scoreTeamKillsMultiplier = -8 -- multiplier for teamkill
ROLE.unknownTeam = true -- player don't know their teammates

ROLE.conVarData = {
	pct = 0.15, -- necessary: percentage of getting this role selected (per player)
	maximum = 2, -- maximum amount of roles in a round
	minPlayers = 7, -- minimum amount of players until this role is able to get selected
	credits = 1, -- the starting credits of a specific role
	togglable = true, -- option to toggle a role for a client if possible (F1 menu)
	shopFallback = SHOP_FALLBACK_TRAITOR
}

-- now link this subrole with its baserole
hook.Add("TTT2BaseRoleInit", "TTT2ConBRIWithSpy", function()
	SPY:SetBaseRole(ROLE_INNOCENT)
end)

if CLIENT then
	hook.Add("TTT2FinishedLoading", "SpyInitT", function()
		-- setup here is not necessary but if you want to access the role data, you need to start here
		-- setup basic translation !
		LANG.AddToLanguage("English", SPY.name, "SPY")
		LANG.AddToLanguage("English", "info_popup_" .. SPY.name, [[You are a SPY! Try to survive and protect your mates if possible!]])
		LANG.AddToLanguage("English", "body_found_" .. SPY.abbr, "This was a SPY...")
		LANG.AddToLanguage("English", "search_role_" .. SPY.abbr, "This person was a SPY!")
		LANG.AddToLanguage("English", "target_" .. SPY.name, "SPY")
		LANG.AddToLanguage("English", "ttt2_desc_" .. SPY.name, [[The SPY is a better innocent, because he is able to access his own ([C]) shop. Try to protect the innocents!]])

		---------------------------------

		-- maybe this language as well...
		LANG.AddToLanguage("Deutsch", SPY.name, "Spion")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. SPY.name, [[Du bist ein Spion! Versuche zu überleben und beschütze dein Team, wenn es möglich sein sollte!]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. SPY.abbr, "Er war ein Spion...")
		LANG.AddToLanguage("Deutsch", "search_role_" .. SPY.abbr, "Diese Person war ein Spion!")
		LANG.AddToLanguage("Deutsch", "target_" .. SPY.name, "Spion")
		LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. SPY.name, [[Der Spion ist ein besserer Unschuldiger (oder sogar ein besserer Detektiv), denn er hat seinen eigenen ([C]) Shop. Versuche, die Unschuldigen zu beschützen!]])
	end)

	net.Receive("TTT2SpyFakeMessage", function()
		MSTACK:AddColoredBgMessage("You succefully faked an equipment purchase.", LocalPlayer():GetRoleColor())
	end)
else
	hook.Add("TTT2SpecialRoleSyncing", "TTT2RoleSpyMod", function(ply, tbl)
		if ply and not ply:HasTeam(TEAM_TRAITOR) or GetRoundState() == ROUND_POST then return end

		for spy in pairs(tbl) do
			if spy:IsTerror() and spy:Alive() and spy:GetSubRole() == ROLE_SPY then
				tbl[spy] = {ROLE_TRAITOR, TEAM_TRAITOR}
			end
		end
	end)

	hook.Add("TTT2ModifyRadarRole", "TTT2ModifyRadarRole4Spy", function(ply, target)
		if ply:HasTeam(TEAM_TRAITOR) and target:GetSubRole() == ROLE_SPY then
			return ROLE_TRAITOR
		end
	end)

	hook.Add("TTT2TellTraitors", "TTT2SpyModifyStartingTraitors", function(traitornames)
		if traitornames then
			for _, spy in ipairs(player.GetAll()) do
				if spy:IsTerror() and spy:Alive() and spy:GetSubRole() == ROLE_SPY then
					traitornames[#traitornames + 1] = spy:Nick()
				end
			end
		end
	end)

	hook.Add("TTT2AvoidTeamChat", "TTT2SpyJamTraitorChat", function(sender, tm, msg)
		if tm == TEAM_TRAITOR then
			for _, spy in ipairs(player.GetAll()) do
				if spy:IsTerror() and spy:Alive() and spy:GetSubRole() == ROLE_SPY then
					sender:ChatPrint("You are not able to chat until every Spy is dead!")

					return false
				end
			end
		end
	end)

	hook.Add("TTT2AvoidTeamVoiceChat", "TTT2SpyJamTraitorVoice", function(speaker, listener)
		if IsValid(speaker) and speaker:HasTeam(TEAM_TRAITOR) then
			for _, spy in ipairs(player.GetAll()) do
				if spy:IsTerror() and spy:Alive() and spy:GetSubRole() == ROLE_SPY then
					speaker:ChatPrint("You are not able to use the voice chat until every Spy is dead!")

					return false
				end
			end
		end
	end)

	hook.Add("TTTCanOrderEquipment", "TTT2SpyCanOrderEquipment", function(spy, id)
		if spy:GetSubRole() and spy:GetSubRole() == ROLE_SPY then
			if util.NetworkStringToID("TEBN_ItemBought") ~= 0 then
				local is_item = items.IsItem(id)
				
				local traitors = {}

				for _, ply in pairs(player.GetAll()) do
					if IsValid(ply) and ply:IsActive() and ply:IsTraitor() then
						table.insert(traitors, ply)
					end
				end

				net.Start("TEBN_ItemBought")
				net.WriteEntity(spy)
				net.WriteString(id)
				net.WriteBool(is_item)
				net.Send(traitors)
			end

			net.Start("TTT2SpyFakeMessage")
			net.Send(spy)

			return false
		end
	end)
end
