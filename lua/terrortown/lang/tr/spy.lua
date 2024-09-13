local L = LANG.GetLanguageTableReference("tr")

-- GENERAL ROLE LANGUAGE STRINGS
L[SPY.name] = "Casus"
L["info_popup_" .. SPY.name] = [[Casussun! Casus masum takımında oynar ama hainleri kandırmak için müttefikleri olarak görünürler.]]
L["body_found_" .. SPY.abbr] = "Onlar bir Casustu!"
L["search_role_" .. SPY.abbr] = "Bu kişi bir Casustu!"
L["target_" .. SPY.name] = "Casus"
L["ttt2_desc_" .. SPY.name] = [[]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_teamchat_jammed_" .. SPY.name] = "Tüm Casuslar ölene kadar metin takım sohbeti kullanamazsın!"
L["ttt2_teamvoice_jammed_" .. SPY.name] = "Tüm Casuslar ölene kadar sesli takım sohbeti kullanamazsın!"
L["ttt2_fakebuy_success_" .. SPY.name] = "Sahte ekipman satın alımını başarıyla gerçekleştirdin!"

L["tooltip_spy_alive_score"] = "Canlı Casus: {score}"
L["spy_alive_score"] = "Canlı Casus:"
L["title_event_spy_alive"] = "Casus hayatta kaldı"
L["desc_event_spy_alive"] = "Casus raundu kazandı ve hainleri kandırmayı başardı."

L["label_spy_fake_buy"] = "Sadece Casuslar sahte satın alım gerçekleştirebilir"
L["label_spy_confirm_as_traitor"] = "Casuslar hain olarak onaylanacak"
L["label_spy_reveal_true_role"] = "Casusun rolü tüm hainler öldükten sonra ortaya çıkacak"
L["label_spy_jam_special_roles"] = "Özel hainler normal hainler olarak gösterilecektir"
L["label_spy_survival_bonus"] = "Rauntta hayatta kaldığınız için alınan bonus"
