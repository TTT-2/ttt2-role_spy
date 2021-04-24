local L = LANG.GetLanguageTableReference("english")

-- GENERAL ROLE LANGUAGE STRINGS
L[SPY.name] = "Spy"
L["info_popup_" .. SPY.name] = [[You are a Spy! A Spy plays in the innocent team but is shown to the traitors as their mate to confuse them.]]
L["body_found_" .. SPY.abbr] = "They were a Spy!"
L["search_role_" .. SPY.abbr] = "This person was a Spy!"
L["target_" .. SPY.name] = "Spy"
L["ttt2_desc_" .. SPY.name] = [[]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_teamchat_jammed_" .. SPY.name] = "You cannot use the team text chat until every Spy is dead!"
L["ttt2_teamvoice_jammed_" .. SPY.name] = "You cannot use the team voice chat until every Spy is dead!"
L["ttt2_fakebuy_success_" .. SPY.name] = "You successfully made a fake equipment purchase!"

L["tooltip_spy_alive_score"] = "Spy alive: {score}"
L["spy_alive_score"] = "Spy alive:"
L["title_event_spy_alive"] = "Spy survived"
L["desc_event_spy_alive"] = "The Spy has survived the round and tricked the Traitors."
