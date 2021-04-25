local L = LANG.GetLanguageTableReference("es")

-- GENERAL ROLE LANGUAGE STRINGS
L[SPY.name] = "Espía"
L["info_popup_" .. SPY.name] = [[¡Eres un Espía! Juegas para los inocentes, sin embargo los traidores te verán como parte de su equipo.]]
L["body_found_" .. SPY.abbr] = "¡Era un Espía!"
L["search_role_" .. SPY.abbr] = "Esta persona era un Espía."
L["target_" .. SPY.name] = "Espía"
L["ttt2_desc_" .. SPY.name] = [[Podrás hacerte pasar como un malvado traidor. Además, podrás hacer uso de una 
tienda falsa para confundir a tus compañeros. Además, tu presencia hará que los traidores no puedan usar un chat de equipo (escrito y por voz).]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_teamchat_jammed_" .. SPY.name] = "¡No puedes hablar por el chat de equipo hasta que el Espía esté muerto!"
L["ttt2_teamvoice_jammed_" .. SPY.name] = "¡No puedes usar el chat de voz hasta que el Espía esté muerto!"
L["ttt2_fakebuy_success_" .. SPY.name] = "¡Has hecho una compra falsa con éxito!"

--L["tooltip_spy_alive_score"] = "Spy alive: {score}"
--L["spy_alive_score"] = "Spy alive:"
--L["title_event_spy_alive"] = "Spy survived"
--L["desc_event_spy_alive"] = "The Spy has survived the round and tricked the Traitors."
