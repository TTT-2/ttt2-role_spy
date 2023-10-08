local L = LANG.GetLanguageTableReference("fr")

-- GENERAL ROLE LANGUAGE STRINGS
L[SPY.name] = "Espion"
L["info_popup_" .. SPY.name] = [[Vous êtes un Espion! Un Espion joue dans l'équipe des innocents mais est présenté aux traîtres comme leur compagnon pour les embrouiller.]]
L["body_found_" .. SPY.abbr] = "C'était un Espion!"
L["search_role_" .. SPY.abbr] = "Cette personne était un Espion!"
L["target_" .. SPY.name] = "Espion"
L["ttt2_desc_" .. SPY.name] = [[]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_teamchat_jammed_" .. SPY.name] = "Vous ne pouvez pas utiliser le chat de votre équipe tant que tous les Espions ne sont pas morts!"
L["ttt2_teamvoice_jammed_" .. SPY.name] = "Vous ne pouvez pas utiliser le chat vocal de votre équipe tant que tous les Espions ne sont pas morts!"
L["ttt2_fakebuy_success_" .. SPY.name] = "Vous avez réussi à faire un faux achat d'équipement!"

--L["tooltip_spy_alive_score"] = "Spy alive: {score}"
--L["spy_alive_score"] = "Spy alive:"
--L["title_event_spy_alive"] = "Spy survived"
--L["desc_event_spy_alive"] = "The Spy has survived the round and tricked the Traitors."

--L["label_spy_fake_buy"] = "Spies are only allowed to fake purchases"
--L["label_spy_confirm_as_traitor"] = "Spies will be confirmed as traitor"
--L["label_spy_reveal_true_role"] = "Spy's role will be revealed after every traitor dies"
--L["label_spy_jam_special_roles"] = "Special traitors will be displayed as normal traitors"
--L["label_spy_survival_bonus"] = "The bonus received for surviving a round"
