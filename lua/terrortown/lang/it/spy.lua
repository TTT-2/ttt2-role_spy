local L = LANG.GetLanguageTableReference("it")

-- GENERAL ROLE LANGUAGE STRINGS
L[SPY.name] = "Spia"
L["info_popup_" .. SPY.name] = [[Sei una Spia! Una Spia gioca con gli innocenti ma viene mostrato come traditore per i traditori per confonderli.]]
L["body_found_" .. SPY.abbr] = "Era una Spia!"
L["search_role_" .. SPY.abbr] = "Questa persona era una Spia!"
L["target_" .. SPY.name] = "Spia"
L["ttt2_desc_" .. SPY.name] = [[Una Spia è un normale innocente che viene mostrato come traditore, il suo obiettivo è quello di scoprire i traditori e ucciderli.
Può far finta di comprare da uno shop apposito.]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_teamchat_jammed_" .. SPY.name] = "Non puoi chattare con la tua squadra finché ci sono Spie in vita!"
L["ttt2_teamvoice_jammed_" .. SPY.name] = "Non puoi usare la chat vocale della squadra finché ci sono Spie in vita!"
L["ttt2_fakebuy_success_" .. SPY.name] = "Hai fatto finta di comprare un oggetto con successo!"

--L["tooltip_spy_alive_score"] = "Spy alive: {score}"
--L["spy_alive_score"] = "Spy alive:"
--L["title_event_spy_alive"] = "Spy survived"
--L["desc_event_spy_alive"] = "The Spy has survived the round and tricked the Traitors."

--L["label_spy_fake_buy"] = "Spies are only allowed to fake purchases"
--L["label_spy_confirm_as_traitor"] = "Spies will be confirmed as traitor"
--L["label_spy_reveal_true_role"] = "Spy's role will be revealed after every traitor dies"
--L["label_spy_jam_special_roles"] = "Special traitors will be displayed as normal traitors"
--L["label_spy_survival_bonus"] = "The bonus received for surviving a round"
