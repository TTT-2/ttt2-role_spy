local L = LANG.GetLanguageTableReference("en")

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

L["label_spy_fake_buy"] = "Spies are only allowed to fake purchases"
L["label_spy_confirm_as_traitor"] = "Spies will be confirmed as traitor"
L["label_spy_reveal_true_role"] = "Spy's role will be revealed after every traitor dies"
L["label_spy_jam_special_roles"] = "Special traitors will be displayed as normal traitors"
L["label_spy_survival_bonus"] = "The bonus received for surviving a round"
