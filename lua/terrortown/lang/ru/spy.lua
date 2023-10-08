local L = LANG.GetLanguageTableReference("ru")

-- GENERAL ROLE LANGUAGE STRINGS
L[SPY.name] = "Шпион"
L["info_popup_" .. SPY.name] = [[Вы шпион! Шпион играет за команду невиновных, но отображается у предателей как их товарищ, чтобы запутать их.]]
L["body_found_" .. SPY.abbr] = "Он был шпионом!"
L["search_role_" .. SPY.abbr] = "Этот человек был шпионом!"
L["target_" .. SPY.name] = "Шпион"
L["ttt2_desc_" .. SPY.name] = [[]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_teamchat_jammed_" .. SPY.name] = "Текстовый командный чат недоступен до тех пор, пока не умрут все шпионы!"
L["ttt2_teamvoice_jammed_" .. SPY.name] = "Голосовой командный чат недоступен до тех пор, пока не умрут все шпионы!"
L["ttt2_fakebuy_success_" .. SPY.name] = "Вы совершили поддельную покупку снаряжения!"

--L["tooltip_spy_alive_score"] = "Spy alive: {score}"
--L["spy_alive_score"] = "Spy alive:"
--L["title_event_spy_alive"] = "Spy survived"
--L["desc_event_spy_alive"] = "The Spy has survived the round and tricked the Traitors."

--L["label_spy_fake_buy"] = "Spies are only allowed to fake purchases"
--L["label_spy_confirm_as_traitor"] = "Spies will be confirmed as traitor"
--L["label_spy_reveal_true_role"] = "Spy's role will be revealed after every traitor dies"
--L["label_spy_jam_special_roles"] = "Special traitors will be displayed as normal traitors"
--L["label_spy_survival_bonus"] = "The bonus received for surviving a round"
