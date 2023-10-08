local L = LANG.GetLanguageTableReference("de")

-- GENERAL ROLE LANGUAGE STRINGS
L[SPY.name] = "Spion"
L["info_popup_" .. SPY.name] = [[Du bist ein Spion! Ein Spion spielt im Team der Unschuldigen, wird Verrätern aber als Kollege angezeigt um diese zu verwirren.]]
L["body_found_" .. SPY.abbr] = "Er war ein Spion!"
L["search_role_" .. SPY.abbr] = "Diese Person war ein Spion!"
L["target_" .. SPY.name] = "Spion"
L["ttt2_desc_" .. SPY.name] = [[]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_teamchat_jammed_" .. SPY.name] = "Du kannst nicht mit deinem Team schreiben solange nicht alle Spione tot sind!"
L["ttt2_teamvoice_jammed_" .. SPY.name] = "Du kannst nicht mit deinem Team reden solange nicht alle Spione tot sind!"
L["ttt2_fakebuy_success_" .. SPY.name] = "Du hast erfolgreich einen Ausrüstungskauf vorgetäuscht!"

L["tooltip_spy_alive_score"] = "Spion am Leben: {score}"
L["spy_alive_score"] = "Spion am Leben:"
L["title_event_spy_alive"] = "Spion hat überlebt"
L["desc_event_spy_alive"] = "Der Spion hat die Verräter ausgetrickst und die Runde überlebt."

--L["label_spy_fake_buy"] = "Spies are only allowed to fake purchases"
--L["label_spy_confirm_as_traitor"] = "Spies will be confirmed as traitor"
--L["label_spy_reveal_true_role"] = "Spy's role will be revealed after every traitor dies"
--L["label_spy_jam_special_roles"] = "Special traitors will be displayed as normal traitors"
--L["label_spy_survival_bonus"] = "The bonus received for surviving a round"
