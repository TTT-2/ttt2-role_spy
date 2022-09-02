local L = LANG.GetLanguageTableReference("zh_hans")

-- GENERAL ROLE LANGUAGE STRINGS
L[SPY.name] = "间谍"
L["info_popup_" .. SPY.name] = [[你是个间谍!一名间谍在无辜的队伍中扮演角色,但被显示为叛徒的伙伴,以迷惑他们.]]
L["body_found_" .. SPY.abbr] = "他们是间谍!"
L["search_role_" .. SPY.abbr] = "这个人是间谍!"
L["target_" .. SPY.name] = "间谍"
L["ttt2_desc_" .. SPY.name] = [[]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_teamchat_jammed_" .. SPY.name] = "在所有间谍死亡之前,您不能使用团队文本聊天!"
L["ttt2_teamvoice_jammed_" .. SPY.name] = "在所有间谍死亡之前,您不能使用团队语音聊天!"
L["ttt2_fakebuy_success_" .. SPY.name] = "你成功地购买了假设备!"

L["tooltip_spy_alive_score"] = "活着的间谍: {score}"
L["spy_alive_score"] = "活着的间谍:"
L["title_event_spy_alive"] = "间谍幸存了下来"
L["desc_event_spy_alive"] = "间谍躲过了这一轮,欺骗了叛徒."
