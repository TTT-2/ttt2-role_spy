L = LANG.GetLanguageTableReference("english")

-- GENERAL ROLE LANGUAGE STRINGS
L[SPY.name] = "Spy"
L["info_popup_" .. SPY.name] = [[You are a spy! A spy plays in the innocent team but is shown to the traitos as their mate to confuse them.]]
L["body_found_" .. SPY.abbr] = "They were a spy!"
L["search_role_" .. SPY.abbr] = "This person was a spy!"
L["target_" .. SPY.name] = "Spy"
L["ttt2_desc_" .. SPY.name] = [[]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_teamchat_jammed_" .. SPY.name] = "You are not able to chat with your team until every Spy is dead!"
L["ttt2_teamvoice_jammed_" .. SPY.name] = "You are not able to use the team voice chat until every Spy is dead!"
L["ttt2_fakebuy_success_" .. SPY.name] = "You successfully faked an equipment purchase!"
