CreateConVar("ttt2_spy_fake_buy", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_spy_confirm_as_traitor", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_spy_reveal_true_role", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_spy_jam_special_roles", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_spy_survival_bonus", "3", {FCVAR_ARCHIVE, FCVAR_NOTIFY})

if SERVER then
	hook.Add("TTT2SyncGlobals", "ttt2_spy_sync_convars", function()
		SetGlobalBool("ttt2_spy_fake_buy", GetConVar("ttt2_spy_fake_buy"):GetBool())
		SetGlobalBool("ttt2_spy_confirm_as_traitor", GetConVar("ttt2_spy_confirm_as_traitor"):GetBool())
		SetGlobalBool("ttt2_spy_reveal_true_role", GetConVar("ttt2_spy_reveal_true_role"):GetBool())
		SetGlobalBool("ttt2_spy_jam_special_roles", GetConVar("ttt2_spy_jam_special_roles"):GetBool())
		SetGlobalInt("ttt2_spy_survival_bonus", GetConVar("ttt2_spy_survival_bonus"):GetInt())
	end)

	cvars.AddChangeCallback("ttt2_spy_fake_buy", function(cv, old, new)
		SetGlobalBool("ttt2_spy_fake_buy", tobool(tonumber(new)))
	end)

	cvars.AddChangeCallback("ttt2_spy_confirm_as_traitor", function(cv, old, new)
		SetGlobalBool("ttt2_spy_confirm_as_traitor", tobool(tonumber(new)))
	end)

	cvars.AddChangeCallback("ttt2_spy_reveal_true_role", function(cv, old, new)
		SetGlobalBool("ttt2_spy_reveal_true_role", tobool(tonumber(new)))
	end)

	cvars.AddChangeCallback("ttt2_spy_jam_special_roles", function(cv, old, new)
		SetGlobalBool("ttt2_spy_jam_special_roles", tobool(tonumber(new)))
	end)

	cvars.AddChangeCallback("ttt2_spy_survival_bonus", function(cv, old, new)
		SetGlobalInt("ttt2_spy_survival_bonus", tonumber(new))
	end)
end
