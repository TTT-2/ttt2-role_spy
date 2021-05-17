EVENT.base = "base_event"

if SERVER then
	AddCSLuaFile()
	resource.AddFile("materials/vgui/ttt/vskin/events/spy_alive.vmt")
end

if CLIENT then
	EVENT.icon = Material("vgui/ttt/vskin/events/spy_alive")
	EVENT.title = "title_event_spy_alive"

	function EVENT:GetText()
		return {
			{
				string = "desc_event_spy_alive"
			}
		}
	end
end

if SERVER then
	function EVENT:Trigger()
		local plys = player.GetAll()
		local eventPlys = {}

		for i = 1, #plys do
			local ply = plys[i]

			if not ply:IsTerror() or not ply:Alive() or ply:GetSubRole() ~= ROLE_SPY then continue end

			self:AddAffectedPlayers(
				{ply:SteamID64()},
				{ply:Nick()}
			)

			eventPlys[#eventPlys + 1] = {
				nick = ply:Nick(),
				sid64 = ply:SteamID64()
			}
		end

		return self:Add({plys = eventPlys})
	end

	function EVENT:CalculateScore()
		local plys = self.event.plys

		for i = 1, #plys do
			local ply = plys[i]

			self:SetPlayerScore(ply.sid64, {
				score = GetConVar("ttt2_spy_survival_bonus"):GetInt()
			})
		end
	end
end

function EVENT:Serialize()
	return "One or more Spies have survived the round."
end

-- trigger this event once the round ended but before the events are synced
hook.Add("TTT2AddedEvent", "trigger_spy_survival_event", function(type)
	if type ~= EVENT_FINISH then return end

	local plys = util.GetAlivePlayers()
	for i = 1, #plys do
		if plys[1]:GetSubRole() == ROLE_SPY then
			events.Trigger(EVENT_SPY_ALIVE)
			return
		end
	end

end)
