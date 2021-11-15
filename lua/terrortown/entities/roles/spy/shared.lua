if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_spy.vmt")
end

function ROLE:PreInitialize()
	self.color = Color(255, 127, 80, 255)

	self.abbr = "spy"
	self.score.killsMultiplier = 2
	self.score.teamKillsMultiplier = -8
	self.unknownTeam = true

	self.defaultTeam = TEAM_INNOCENT
	self.defaultEquipment = SPECIAL_EQUIPMENT

	self.conVarData = {
		pct = 0.15,
		maximum = 2,
		minPlayers = 7,
		credits = 1,
		togglable = true,
		shopFallback = SHOP_FALLBACK_TRAITOR
	}
end

function ROLE:Initialize()
	roles.SetBaseRole(self, ROLE_INNOCENT)
end

hook.Add("TTTUlxDynamicRCVars", "TTTUlxDynamicSpyCVars", function(tbl)
	tbl[ROLE_SPY] = tbl[ROLE_SPY] or {}

	table.insert(tbl[ROLE_SPY], {
		cvar = "ttt2_spy_fake_buy",
		checkbox = true,
		desc = "Spies are only allowed to fake purchases (Def. 1)"}
	)

	table.insert(tbl[ROLE_SPY], {
		cvar = "ttt2_spy_confirm_as_traitor",
		checkbox = true,
		desc = "Spies will be confirmed as traitor (Def. 1)"
	})

	table.insert(tbl[ROLE_SPY], {
		cvar = "ttt2_spy_reveal_true_role",
		checkbox = true,
		desc = "Spies role will be revealed after every traitors death (Def. 1)"
	})

	table.insert(tbl[ROLE_SPY], {
		cvar = "ttt2_spy_jam_special_roles",
		checkbox = true,
		desc = "Spies role will jam special traitor roles, special roles will be displayed as normal traitors (Def. 1)"
	})

	table.insert(tbl[ROLE_SPY], {
		cvar = "ttt2_spy_survival_bonus",
		slider = true,
		min = 0,
		max = 10,
		decimal = 0,
		desc = "The bonus received for surviving a round (Def. 3)"
	})
end)

if SERVER then
	local ttt2_spy_fake_buy = CreateConVar("ttt2_spy_fake_buy", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
	local ttt2_spy_confirm_as_traitor = CreateConVar("ttt2_spy_confirm_as_traitor", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
	local ttt2_spy_reveal_true_role = CreateConVar("ttt2_spy_reveal_true_role", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
	local ttt2_spy_jam_special_roles = CreateConVar("ttt2_spy_jam_special_roles", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
	CreateConVar("ttt2_spy_survival_bonus", "3", {FCVAR_ARCHIVE, FCVAR_NOTIFY})

	-- TODO combine next two hooks
	hook.Add("TTT2SpecialRoleSyncing", "TTT2RoleSpyMod", function(ply, tbl)
		if ply and ply:GetTeam() ~= TEAM_TRAITOR or ply:GetSubRoleData().unknownTeam or GetRoundState() == ROUND_POST then return end

		local spySelected = false

		for spy in pairs(tbl) do
			if spy:IsTerror() and spy:Alive() and spy:GetSubRole() == ROLE_SPY then
				tbl[spy] = {ROLE_TRAITOR, TEAM_TRAITOR}

				spySelected = true
			end
		end

		if not spySelected or not ttt2_spy_jam_special_roles:GetBool() then return end

		for traitor in pairs(tbl) do
			if traitor == ply then continue end

			if traitor:IsTerror() and traitor:Alive() and traitor:GetBaseRole() == ROLE_TRAITOR then
				tbl[traitor] = {ROLE_TRAITOR, TEAM_TRAITOR}
			end
		end
	end)

	-- we need this hook to secure that dead spies/traitors doesn't get revealed if someone calls SendFullStateUpdate()
	hook.Add("TTT2SpecialRoleSyncing", "TTT2RoleDeadSpyMod", function(ply, tbl)
		if not ttt2_spy_confirm_as_traitor:GetBool() or GetRoundState() == ROUND_POST then return end

		--check if traitors are dead and reveal
		if ttt2_spy_reveal_true_role:GetBool() then
			local traitor_alive = false

			for tr in pairs(tbl) do
				if tr:IsTerror() and tr:Alive() and (tr:GetBaseRole() == ROLE_TRAITOR or tr:GetSubRole() == ROLE_SPY) then
					traitor_alive = true

					break
				end
			end

			if not traitor_alive then return end
		end

		local spySelected = false

		for spy in pairs(tbl) do
			if not spy:Alive() and spy:GetSubRole() == ROLE_SPY then
				tbl[spy] = {ROLE_TRAITOR, TEAM_TRAITOR}

				spySelected = true
			end
		end

		if not spySelected or not ttt2_spy_jam_special_roles:GetBool() then return end

		for traitor in pairs(tbl) do
			if traitor == ply then continue end

			if not traitor:Alive() and traitor:GetBaseRole() == ROLE_TRAITOR then
				tbl[traitor] = {ROLE_TRAITOR, TEAM_TRAITOR}
			end
		end
	end)

	hook.Add("TTT2OverrideDisabledSync", "TTT2ModifyTraitorRoles4Spy", function(ply, target)
		if not ttt2_spy_confirm_as_traitor:GetBool() or not ttt2_spy_jam_special_roles:GetBool() or GetRoundState() == ROUND_POST then return end

		local plys = player.GetAll()
		local spySelected = false

		for i = 1, #plys do
			if plys[i]:GetSubRole() == ROLE_SPY then
				spySelected = true

				break
			end
		end

		if not spySelected then return end

		if ply:GetTeam() == TEAM_TRAITOR and target:GetBaseRole() == ROLE_TRAITOR then
			return true
		end
	end)

	hook.Add("TTTCOverrideTeamSync", "TTTCModifyTeamSync4Spy", function(ply, tbl)
		if ply:GetSubRole() ~= ROLE_SPY or GetRoundState() ~= ROUND_ACTIVE then return end

		local plys = player.GetAll()

		for i = 1, #plys do
			local v = plys[i]
			if v:GetTeam() ~= TEAM_TRAITOR or v:GetSubRoleData().unknownTeam then continue end

			table.insert(tbl, v)
		end
	end)

	hook.Add("TTT2ModifyRadarRole", "TTT2ModifyRadarRole4Spy", function(ply, target)
		if ply:GetTeam() == TEAM_TRAITOR and target:GetSubRole() == ROLE_SPY then
			return ROLE_TRAITOR, TEAM_TRAITOR
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
					LANG.Msg(sender, "ttt2_teamchat_jammed_" .. SPY.name, nil, MSG_CHAT_WARN)

					return false
				end
			end
		end
	end)

	hook.Add("TTT2CanUseVoiceChat", "TTT2SpyJamTraitorVoice", function(speaker, isTeamVoice)

		-- only jam traitor team voice
		if not isTeamVoice or not IsValid(speaker) or speaker:GetTeam() ~= TEAM_TRAITOR then return end

		-- ToDo prevent team voice overlay from showing on the speaking players screen
		for _, spy in ipairs(player.GetAll()) do
			if spy:IsTerror() and spy:Alive() and spy:GetSubRole() == ROLE_SPY then
				LANG.Msg(speaker, "ttt2_teamvoice_jammed_" .. SPY.name , nil, MSG_CHAT_WARN)

				return false
			end
		end
	end)

	hook.Add("TTTCanOrderEquipment", "TTT2SpyCanOrderEquipment", function(spy, id)
		if spy:GetSubRole() and spy:GetSubRole() == ROLE_SPY and ttt2_spy_fake_buy:GetBool() then
			if util.NetworkStringToID("TEBN_ItemBought") ~= 0 then
				local is_item = items.IsItem(id)

				local traitors = {}

				for _, ply in ipairs(player.GetAll()) do
					if ply:IsActive() and ply:IsTraitor() then
						traitors[#traitors + 1] = ply
					end
				end

				net.Start("TEBN_ItemBought")
				net.WriteEntity(spy)
				net.WriteString(id)
				net.WriteBool(is_item)
				net.Send(traitors)
			end

			LANG.Msg(spy, "ttt2_fakebuy_success_" .. SPY.name, nil, MSG_MSTACK_ROLE)

			return false
		end
	end)

	hook.Add("TTTCanSearchCorpse", "TTT2SpyChangeCorpseToTraitor", function(ply, corpse)
		local plys = player.GetAll()
		local spySelected = false

		for i = 1, #plys do
			if plys[i]:GetSubRole() == ROLE_SPY then
				spySelected = true

				break
			end
		end

		if not spySelected then return end

		if not ttt2_spy_confirm_as_traitor:GetBool() then return end

		if corpse and (corpse.was_role == ROLE_SPY or ttt2_spy_jam_special_roles:GetBool() and roles.GetByIndex(corpse.was_role):GetBaseRole() == ROLE_TRAITOR) and not corpse.reverted_spy then
			corpse.was_role = ROLE_TRAITOR
			corpse.was_team = TEAM_TRAITOR
			corpse.role_color = TRAITOR.color
			corpse.is_spy_corpse = true
		end
	end)

	hook.Add("TTT2ConfirmPlayer", "TTT2SpyChangeRoleToTraitor", function(confirmed, finder, corpse)
		if not ttt2_spy_confirm_as_traitor:GetBool() then return end

		if IsValid(confirmed) and corpse and corpse.is_spy_corpse then
			confirmed:ConfirmPlayer(true)
			SendRoleListMessage(ROLE_TRAITOR, TEAM_TRAITOR, {confirmed:EntIndex()})
			events.Trigger(EVENT_BODYFOUND, finder, corpse)

			return false
		end
	end)

	hook.Add("TTTBodyFound", "TTT2SpyGetRoleBackIfLastTraitor", function(_, confirmed, corpse)
		if not ttt2_spy_confirm_as_traitor:GetBool() or not ttt2_spy_reveal_true_role:GetBool() then return end

		if IsValid(confirmed) and confirmed:GetTeam() ~= TEAM_TRAITOR and confirmed:GetSubRole() ~= ROLE_SPY then return end

		for _, ply in ipairs(player.GetAll()) do
			if ply:IsTerror() and ply:Alive() and (ply:GetTeam() == TEAM_TRAITOR or ply:GetSubRole() == ROLE_SPY) then
				return
			end
		end

		for _, ply in ipairs(player.GetAll()) do
			local ply_corpse = ply.server_ragdoll

			if not ply_corpse or not ply:GetNWBool("body_found", false) then continue end

			if ply:GetSubRole() == ROLE_SPY or ttt2_spy_jam_special_roles:GetBool() and ply:GetBaseRole() == ROLE_TRAITOR then
				local subrole = ply:GetSubRole()
				local team = ply:GetTeam()
				local srd = ply:GetSubRoleData()

				ply_corpse.was_role = subrole
				ply_corpse.was_team = team
				ply_corpse.role_color = srd.color
				ply_corpse.is_spy_corpse = false
				ply_corpse.reverted_spy = true

				SendRoleListMessage(subrole, team, {ply:EntIndex()})
			end
		end
	end)

	hook.Add("TTT2CanBeHitmanTarget", "TTT2SpyNoHitmanTarget", function(hitman, ply)
		if ply:GetSubRole() == ROLE_SPY then
			return false
		end
	end)
end
