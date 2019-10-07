if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_spy.vmt")

	util.AddNetworkString("TTT2SpyFakeMessage")
end

function ROLE:PreInitialize()
	self.color = Color(255, 127, 80, 255)
	self.dkcolor = Color(189, 61, 14, 255)
	self.bgcolor = Color(55, 176, 121, 255)

	self.abbr = "spy"
	self.surviveBonus = 0
	self.scoreKillsMultiplier = 1
	self.scoreTeamKillsMultiplier = -8
	self.unknownTeam = true

	self.defaultTeam = TEAM_INNOCENT
	self.defaultEquipment = SPECIAL_EQUIPMENT

	self.conVarData = {
		pct = 0.15, -- necessary: percentage of getting this role selected (per player)
		maximum = 2, -- maximum amount of roles in a round
		minPlayers = 7, -- minimum amount of players until this role is able to get selected
		credits = 1, -- the starting credits of a specific role
		togglable = true, -- option to toggle a role for a client if possible (F1 menu)
		shopFallback = SHOP_FALLBACK_TRAITOR
	}
end

function ROLE:Initialize()
	roles.SetBaseRole(self, ROLE_INNOCENT)

	if CLIENT then
		-- Role specific language elements
		LANG.AddToLanguage("English", SPY.name, "SPY")
		LANG.AddToLanguage("English", "info_popup_" .. SPY.name, [[You are a spy! A spy plays in the innocent team but is shown to the traitos as their mate to confuse them.]])
		LANG.AddToLanguage("English", "body_found_" .. SPY.abbr, "They were a spy!")
		LANG.AddToLanguage("English", "search_role_" .. SPY.abbr, "This person was a spy!")
		LANG.AddToLanguage("English", "target_" .. SPY.name, "Spy")
		LANG.AddToLanguage("English", "ttt2_desc_" .. SPY.name, [[]])

		LANG.AddToLanguage("Deutsch", SPY.name, "Spion")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. SPY.name, [[Du bist ein Spion! Ein Spion spielt im Team der Unschuldigen, wird Verrätern aber als Kollege angezeigt um diese zu verwirren.]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. SPY.abbr, "Er war ein Spion!")
		LANG.AddToLanguage("Deutsch", "search_role_" .. SPY.abbr, "Diese Person war ein Spion!")
		LANG.AddToLanguage("Deutsch", "target_" .. SPY.name, "Spion")
		LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. SPY.name, [[]])
	end
end)

CreateConVar("ttt2_spy_fake_buy", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_spy_confirm_as_traitor", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_spy_reveal_true_role", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})

hook.Add("TTTUlxDynamicRCVars", "TTTUlxDynamicSpyCVars", function(tbl)
	tbl[ROLE_SPY] = tbl[ROLE_SPY] or {}

	table.insert(tbl[ROLE_SPY], {cvar = "ttt2_spy_fake_buy", checkbox = true, desc = "Spies are only allowed to fake purchases (Def. 1)"})
	table.insert(tbl[ROLE_SPY], {cvar = "ttt2_spy_confirm_as_traitor", checkbox = true, desc = "Spies will be confirmed as traitor (Def. 1)"})
	table.insert(tbl[ROLE_SPY], {cvar = "ttt2_spy_reveal_true_role", checkbox = true, desc = "Spies role will be revealed after every traitors death (Def. 1)"})
end)

if CLIENT then
	net.Receive("TTT2SpyFakeMessage", function()
		MSTACK:AddColoredBgMessage("You succefully faked an equipment purchase.", LocalPlayer():GetRoleColor())
	end)
else
	hook.Add("TTT2SpecialRoleSyncing", "TTT2RoleSpyMod", function(ply, tbl)
		if ply and not ply:HasTeam(TEAM_TRAITOR) or ply:GetSubRoleData().unknownTeam or GetRoundState() == ROUND_POST then return end

		for spy in pairs(tbl) do
			if spy:IsTerror() and spy:Alive() and spy:GetSubRole() == ROLE_SPY then
				tbl[spy] = {ROLE_TRAITOR, TEAM_TRAITOR}
			end
		end
	end)

	--we need this hook to secure that dead spies/traitors doesn't get revealed if someone calls SendFullStateUpdate()
	hook.Add("TTT2SpecialRoleSyncing", "TTT2RoleDeadSpyMod", function(ply, tbl)
		if not GetConVar("ttt2_spy_confirm_as_traitor"):GetBool() or GetRoundState() == ROUND_POST then return end

		--check if traitors are dead and reveal
		if GetConVar("ttt2_spy_reveal_true_role"):GetBool() then
			local traitor_alive = 0

			for tr in pairs(tbl) do
				if tr:IsTerror() and tr:Alive() and (tr:GetBaseRole() == ROLE_TRAITOR or tr:GetSubRole() == ROLE_SPY) then
					traitor_alive = traitor_alive + 1
				end
			end

			if traitor_alive <= 0 then return end
		end

		for spy in pairs(tbl) do
			if not spy:Alive() and spy:GetSubRole() == ROLE_SPY then
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
		if not GetConVar("ttt2_spy_confirm_as_traitor"):GetBool() then return end

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
		if spy:GetSubRole() and spy:GetSubRole() == ROLE_SPY and GetConVar("ttt2_spy_fake_buy"):GetBool() then
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

	hook.Add("TTTCanSearchCorpse", "TTT2SpyChangeCorpseToTraitor", function(ply, corpse)
		if not GetConVar("ttt2_spy_confirm_as_traitor"):GetBool() then return end

		if corpse and corpse.was_role == ROLE_SPY and not corpse.reverted_spy then
			corpse.was_role = ROLE_TRAITOR
			corpse.role_color = GetRoleByIndex(ROLE_TRAITOR).color
			corpse.is_spy_corpse = true
		end

	end)

	hook.Add("TTT2ConfirmPlayer", "TTT2SpyChangeRoleToTraitor", function(confirmed, finder, corpse)
		if not GetConVar("ttt2_spy_confirm_as_traitor"):GetBool() then return end

		if IsValid(confirmed) and corpse and corpse.is_spy_corpse then
			confirmed:ConfirmPlayer(true)
			SendRoleListMessage(ROLE_TRAITOR, TEAM_TRAITOR, {confirmed:EntIndex()})
			SCORE:HandleBodyFound(finder, confirmed)

			return false
		end
	end)

	hook.Add("TTTBodyFound", "TTT2SpyGetRoleBackIfLastTraitor", function(_, confirmed, corpse)
		if not GetConVar("ttt2_spy_confirm_as_traitor"):GetBool() or not GetConVar("ttt2_spy_reveal_true_role"):GetBool() then return end

		if not confirmed:HasTeam(TEAM_TRAITOR) and confirmed:GetSubRole() ~= ROLE_SPY then
			return
		end

		local traitor_alive = 0
		for _, ply in ipairs(player.GetAll()) do
			if ply:IsTerror() and ply:Alive() and (ply:HasTeam(TEAM_TRAITOR) or ply:GetSubRole() == ROLE_SPY) then
				traitor_alive = traitor_alive + 1
			end
		end

		if traitor_alive <= 0 then
			for _, ply in ipairs(player.GetAll()) do
				if ply:GetSubRole() == ROLE_SPY and ply.server_ragdoll and ply:GetNWBool("body_found", false) then
					local spy_corpse = ply.server_ragdoll
					spy_corpse.was_role = ROLE_SPY
					spy_corpse.role_color = GetRoleByIndex(ROLE_SPY).color
					spy_corpse.is_spy_corpse = false
					spy_corpse.reverted_spy = true

					SendRoleListMessage(ROLE_SPY, TEAM_INNOCENT, {ply:EntIndex()})
				end
			end
		end
	end)
end
