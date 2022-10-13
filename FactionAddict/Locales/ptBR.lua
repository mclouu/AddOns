if GetLocale() == "ptBR" then
	if not FactionAddictLocalization then
		FactionAddictLocalization = {}
	end

-- Titles
FactionAddictLocalization["ADDON_TITLE"] = "Faction Addict"

-- tab labels at bottom of addon
FactionAddictLocalization["TAB1_LABEL"] = "Facções"
FactionAddictLocalization["TAB2_LABEL"] = "Friends"
FactionAddictLocalization["TAB3_LABEL"] = "Relatório"
FactionAddictLocalization["TAB4_LABEL"] = "Configuração"
FactionAddictLocalization["TAB5_LABEL"] = "Sobre"

-- Error Messages
FactionAddictLocalization["ERROR1"] = "Não há facções para mostrar!\n\nVerifique as configurações e o filtro de posições."
FactionAddictLocalization["ERROR2"] = "No friends to show!\n\nCheck config and Pct to Max filter."

-- Tooltips
FactionAddictLocalization["LAUNCHER_TT"] = "Abrir/Fechar o Faction Addict"
FactionAddictLocalization["CONFIG_TT_CF"] = "Mostrar Facções Clássicas do WoW."
FactionAddictLocalization["CONFIG_TT_BC"] = "Mostrar Facções do Burning Crusade."
FactionAddictLocalization["CONFIG_TT_WOTLK"] = "Mostrar Facções do Wrath of the Lich King."
FactionAddictLocalization["CONFIG_TT_CATA"] = "Mostrar Facções do Cataclysm."
FactionAddictLocalization["CONFIG_TT_MOP"] = "Mostrar Facções do Mists of Pandaria."
FactionAddictLocalization["CONFIG_TT_WOD"] = "Mostrar Facções do Warlords of Draenor."
FactionAddictLocalization["CONFIG_TT_LG"] = "Mostrar Facções do Legion."
FactionAddictLocalization["CONFIG_TT_BFA"] = "Show Battle for Azeroth factions."
FactionAddictLocalization["CONFIG_TT_SLANDS"] = "Show Shadowlands factions."
FactionAddictLocalization["CONFIG_TT_OrderPct"] = "Ordenar facções por porcentagem à exaltado."
FactionAddictLocalization["CONFIG_TT_OrderName"] = "Ordenar facções por nome."
FactionAddictLocalization["CONFIG_TT_AO"] = "Mostrar somente facções da Aliança."
FactionAddictLocalization["CONFIG_TT_HO"] = "Mostrar somente facções da Horda."
FactionAddictLocalization["CONFIG_TT_AUTOBAR"] = "Mudar automaticamente a barra de reputações para a última facção que ganhou reputação."
FactionAddictLocalization["CONFIG_TT_HIDEINACTIVE"] = "Ocultar facções que você marcou como Inativas nesse addon, senão facções Inativas serão movidas para o fm da lista com um fundo vermelho."
FactionAddictLocalization["CHECKBUTTON_TT_SETINACTIVE"] = "Move essa facção para o fim da lista de Facções. (Facções Inativas tem um fundo vermelho e também pode ser ocultadas nas Configurações.)"
FactionAddictLocalization["TAB1_TT"] = FactionAddictLocalization["TAB1_LABEL"]
FactionAddictLocalization["TAB2_TT"] = FactionAddictLocalization["TAB2_LABEL"]
FactionAddictLocalization["TAB3_TT"] = FactionAddictLocalization["TAB3_LABEL"]
FactionAddictLocalization["TAB4_TT"] = FactionAddictLocalization["TAB4_LABEL"]
FactionAddictLocalization["TAB5_TT"] = FactionAddictLocalization["TAB5_LABEL"]
FactionAddictLocalization["CONFIG_MENU_TT"] = "Filtro de Posicionamento com as Facções"
FactionAddictLocalization["CONFIG_FRIENDS_MENU_TT"] = "Friend Pct To Max Filter"
FactionAddictLocalization["ACHIEVEMENT_TT_TITLE"] = "Conquistas de Exaltado:"
FactionAddictLocalization["SEARCH_TOGGLE"] = "Mostra/Oculta Busca"

-- Tab1 - factions text
FactionAddictLocalization["TAB1_DESC_TXT"] = "Clique em uma facção para mais informações."
FactionAddictLocalization["KNOWN_TXT"] = "Conhecidas: "
FactionAddictLocalization["SHOWN_TXT"] = "Visíveis: "
FactionAddictLocalization["EXALTED_TXT"] = "Exaltado: "
FactionAddictLocalization["NEXT_ACHIEV_TXT"] = "Próxima Conquista: "
FactionAddictLocalization["ACHIEV_DATEFORMAT"] = "%Y-%b-%d" -- lua date format

-- Tab2 - friends text
FactionAddictLocalization["TAB2_DESC_TXT"] = "Click a friend for more info."

-- Tab3 - log text
FactionAddictLocalization["TAB3_DESC_TXT"] = "Relatório de Reputações"
FactionAddictLocalization["TAB3_LASTGAIN_TXT"] = "Último Ganho"
FactionAddictLocalization["TAB3_NOGAIN_TXT"] = "Nada nessa sessão"
FactionAddictLocalization["TAB3_SESSIONTOTAL_TXT"] = "Total da Sessão: "

-- Tab4 - config text
FactionAddictLocalization["TAB4_DESC_TXT"] = "Configuração"
FactionAddictLocalization["TAB4_DISPLAY_CONFIG_TXT"] = "Quais facções mostrar?"
FactionAddictLocalization["TAB4_DISPLAY_ORDER_TXT"] = "Ordenar Facções por"
FactionAddictLocalization["TAB4_DISPLAY_FILTER"] = "Filtro de Facções"
FactionAddictLocalization["TAB4_DISPLAY_OPTIONS"] = "Opções"
FactionAddictLocalization["TAB4_CONFIG_CF"] = "Facções Clássicas"
FactionAddictLocalization["TAB4_CONFIG_BC"] = "Facções do Burning Crusade"
FactionAddictLocalization["TAB4_CONFIG_WOTLK"] = "Facções do Wrath of the Lich King"
FactionAddictLocalization["TAB4_CONFIG_CATA"] = "Facções do Cataclysm"
FactionAddictLocalization["TAB4_CONFIG_MOP"] = "Facções do Mists of Pandaria"
FactionAddictLocalization["TAB4_CONFIG_WOD"] = "Facções do Warlords of Draenor"
FactionAddictLocalization["TAB4_CONFIG_LG"] = "Facções do Legion"
FactionAddictLocalization["TAB4_CONFIG_BFA"] = "Battle for Azeroth Factions"
FactionAddictLocalization["TAB4_CONFIG_SLANDS"] = "Shadowlands Factions"
FactionAddictLocalization["TAB4_CONFIG_ORDER_PCT"] = "% para Exaltado"
FactionAddictLocalization["TAB4_CONFIG_ORDER_NAME"] = "Nome da Facção"
FactionAddictLocalization["TAB4_CONFIG_ALLIANCE_ONLY"] = "Mostrar apenas facções da Aliança"
FactionAddictLocalization["TAB4_CONFIG_HORDE_ONLY"] = "Mostrar apenas facções da Horda"
FactionAddictLocalization["TAB4_CONFIG_AUTOBAR"] = "Mudar automaticamente a Barra de Reputação"
FactionAddictLocalization["TAB4_CONFIG_HIDEINACTIVE"] = "Ocultar Facções Inativas"

-- Tab5 - about text
FactionAddictLocalization["TAB5_DESC_TXT"] = "Sobre Faction Addict"
FactionAddictLocalization["VERSION_TXT"] = "versão: "
FactionAddictLocalization["ABOUT_TXT"] = "Faction Addict é um addon que ajuda o jogador a facilmente vizualizar e rastrear informações relacionadas às várias facções no jogo. Muito bom para aqueles trabalhando para ficar exaltado com diferentes facções. |n|nUse os comandos de console |cFFFF0000/fa|r ou |cFFFF0000/factionaddict|r para abrir e/ou fechar a janela. A interface padrão também pode ser aberta pelo botão no canto superior direito.|n|nFaça download das atualizações e deixe comentários em: |cFFFFFF00wowinterface.com|r e |cFFFFFF00wow.curse.com|r|n|nAutoria de: |cFFFFFF00gmz323 (Greg)|r"

-- Info Window
FactionAddictLocalization["LAUNCH_WATCH_PANEL_TXT"] = "Abrir Painel de Visualização"
FactionAddictLocalization["FACTION_URL_TXT"] = "pt.wowhead.com/faction="
FactionAddictLocalization["PCT_TO_EXALTED_TXT"] = "% para Exaltado: "
FactionAddictLocalization["PCT_TO_MAX_TXT"] = "Pct to Max: "
FactionAddictLocalization["PCT_TO_REWARD_TXT"] = "Pct to Next Reward: "
FactionAddictLocalization["CATEGORY_TXT"] = "Categoria: "

-- Info Window - Categories
FactionAddictLocalization["CATEGORY_ALLIANCE_TXT"] = "Aliança"
FactionAddictLocalization["CATEGORY_ALLIANCEFORCES_TXT"] = "Forças da Aliança"
FactionAddictLocalization["CATEGORY_ALLIANCEVANGUARD_TXT"] = "Vanguarda da Aliança"
FactionAddictLocalization["CATEGORY_CATACLYSM_TXT"] = "Cataclysm"
FactionAddictLocalization["CATEGORY_CLASSIC_TXT"] = "Clássico"
FactionAddictLocalization["CATEGORY_GUILD_TXT"] = "Guilda"
FactionAddictLocalization["CATEGORY_HORDE_TXT"] = "Horda"
FactionAddictLocalization["CATEGORY_HORDEEXP_TXT"] = "Expedição da Horda"
FactionAddictLocalization["CATEGORY_OTHER_TXT"] = "Outras"
FactionAddictLocalization["CATEGORY_SHATTRATH_TXT"] = "Shattrath"
FactionAddictLocalization["CATEGORY_SHOLAZAR_TXT"] = "Bacia Sholazar"
FactionAddictLocalization["CATEGORY_STEAMWHEEDLE_TXT"] = "Cartel Bondebico"
FactionAddictLocalization["CATEGORY_TBC_TXT"] = "The Burning Crusade"
FactionAddictLocalization["CATEGORY_WOTLK_TXT"] = "Wrath of the Lich King"
FactionAddictLocalization["CATEGORY_HORDEFORCES_TXT"] = "Forças da Horda"
FactionAddictLocalization["CATEGORY_MOP_TXT"] = "Mists of Pandaria"
FactionAddictLocalization["CATEGORY_WOD_TXT"] = "Warlords of Draenor"
FactionAddictLocalization["CATEGORY_BARRACKSBODYGUARDS_TXT"] = "Guarda-costas do Quartel"
FactionAddictLocalization["CATEGORY_LEGION_TXT"] = "Legion"
FactionAddictLocalization["CATEGORY_BFA_TXT"] = "Battle for Azeroth"
FactionAddictLocalization["CATEGORY_SLANDS_TXT"] = "Shadowlands"

-- Standing Filter (Tab1 - dropdown)
FactionAddictLocalization["STANDING_FILTER_TITLE_TXT"] =    "Filtro de Posicionamentos"
FactionAddictLocalization["STANDING_FILTER_LABEL_8_TXT"] =  "(42,000+)"
FactionAddictLocalization["STANDING_FILTER_LABEL_7_TXT"] =  "(21,000 to 42,000)"
FactionAddictLocalization["STANDING_FILTER_LABEL_6_TXT"] =  "(9,000 to 21,000)"
FactionAddictLocalization["STANDING_FILTER_LABEL_5_TXT"] =  "(3,000 to 9,000)"
FactionAddictLocalization["STANDING_FILTER_LABEL_4B_TXT"] = "(1 to 3,000)"
FactionAddictLocalization["STANDING_FILTER_LABEL_4A_TXT"] = "(=0)"
FactionAddictLocalization["STANDING_FILTER_LABEL_3_TXT"] =  "(-3,000 to 0)"
FactionAddictLocalization["STANDING_FILTER_LABEL_2_TXT"] =  "(-6,000 to -3,000)"
FactionAddictLocalization["STANDING_FILTER_LABEL_1_TXT"] =  "(-42,000 to -6,000)"

-- Friend Percent to Max Filter (Tab2 - dropdown)
FactionAddictLocalization["STANDING_FRIEND_FILTER_TITLE_TXT"] = "Pct to Max"
FactionAddictLocalization["STANDING_FILTER_LABEL_FRIENDMAX"] =  "Max (100%)"
FactionAddictLocalization["STANDING_FILTER_LABEL_FRIENDZERO"] =  "None (0%)"

-- Log date (Format: D = weekday, d = day, m = month, y = year)
FactionAddictLocalization["Monday"] = "Segunda-feira"
FactionAddictLocalization["Tuesday"] = "Terça-feira"
FactionAddictLocalization["Wednesday"] = "Quarta-feira"
FactionAddictLocalization["Thursday"] = "Quinta-feira"
FactionAddictLocalization["Friday"] = "Sexta-feira"
FactionAddictLocalization["Saturday"] = "Sábado"
FactionAddictLocalization["Sunday"] = "Domingo"
FactionAddictLocalization["DATE_FORMAT"] = "D, d/m/y"

-- Misc Strings
FactionAddictLocalization["MISC_PARAGON_TXT"] = "Paragon"
end;