if GetLocale() == "esES" then
	if not FactionAddictLocalization then
		FactionAddictLocalization = {}
	end

-- Titles
FactionAddictLocalization["ADDON_TITLE"] = "Faction Addict"

-- tab labels at bottom of addon
FactionAddictLocalization["TAB1_LABEL"] = "Facciones"
FactionAddictLocalization["TAB2_LABEL"] = "Friends"
FactionAddictLocalization["TAB3_LABEL"] = "Registro"
FactionAddictLocalization["TAB4_LABEL"] = "Configuración"
FactionAddictLocalization["TAB5_LABEL"] = "Acerca de"

-- Error Messages
FactionAddictLocalization["ERROR1"] = "¡No hay facciones para mostrar!\n\nComprueba la configuración y el filtro de prestigio."
FactionAddictLocalization["ERROR2"] = "No friends to show!\n\nCheck config and Pct to Max filter."

-- Tooltips
FactionAddictLocalization["LAUNCHER_TT"] = "Abrir/Cerrar Faction Addict"
FactionAddictLocalization["CONFIG_TT_CF"] = "Mostrar facciones Clásicas."
FactionAddictLocalization["CONFIG_TT_BC"] = "Mostrar facciones de Burning Crusade."
FactionAddictLocalization["CONFIG_TT_WOTLK"] = "Mostrar facciones de Wrath of the Lich King."
FactionAddictLocalization["CONFIG_TT_CATA"] = "Mostrar facciones de Cataclysm."
FactionAddictLocalization["CONFIG_TT_MOP"] = "Mostrar facciones de Mists of Pandaria."
FactionAddictLocalization["CONFIG_TT_WOD"] = "Mostrar facciones de Warlords of Draenor."
FactionAddictLocalization["CONFIG_TT_LG"] = "Mostrar facciones de Legion."
FactionAddictLocalization["CONFIG_TT_BFA"] = "Show Battle for Azeroth factions."
FactionAddictLocalization["CONFIG_TT_SLANDS"] = "Show Shadowlands factions."
FactionAddictLocalization["CONFIG_TT_OrderPct"] = "Ordenar facciones por porcentaje a exaltado."
FactionAddictLocalization["CONFIG_TT_OrderName"] = "Ordenar facciones por nombre"
FactionAddictLocalization["CONFIG_TT_AO"] = "Mostrar sólo facciones Alianza."
FactionAddictLocalization["CONFIG_TT_HO"] = "Mostrar sólo facciones Horda."
FactionAddictLocalization["CONFIG_TT_AUTOBAR"] = "Cambia automáticamente la barra de reputación a la última facción con la que has ganado puntos."
FactionAddictLocalization["CONFIG_TT_HIDEINACTIVE"] = "Las facciones marcadas como Inactivas no aparecen en la lista. De lo contrario pasarán a estar al final y con un fondo rojo."
FactionAddictLocalization["CHECKBUTTON_TT_SETINACTIVE"] = "Mueve esta facción al final de la lista de facciones. (Las facciones inactivas tienen un fondo rojo aunque pueden estar ocultas según la Configuración elegida)"
FactionAddictLocalization["TAB1_TT"] = FactionAddictLocalization["TAB1_LABEL"]
FactionAddictLocalization["TAB2_TT"] = FactionAddictLocalization["TAB2_LABEL"]
FactionAddictLocalization["TAB3_TT"] = FactionAddictLocalization["TAB3_LABEL"]
FactionAddictLocalization["TAB4_TT"] = FactionAddictLocalization["TAB4_LABEL"]
FactionAddictLocalization["TAB5_TT"] = FactionAddictLocalization["TAB5_LABEL"]
FactionAddictLocalization["CONFIG_MENU_TT"] = "Filtro de Prestigio"
FactionAddictLocalization["CONFIG_FRIENDS_MENU_TT"] = "Friend Pct To Max Filter"
FactionAddictLocalization["ACHIEVEMENT_TT_TITLE"] = "Logros de Exaltado:"
FactionAddictLocalization["SEARCH_TOGGLE"] = "Mostrar/Ocultar búsqueda"

-- Tab1 - factions text
FactionAddictLocalization["TAB1_DESC_TXT"] = "Pulsa una facción para más info."
FactionAddictLocalization["KNOWN_TXT"] = "Conocidas: "
FactionAddictLocalization["SHOWN_TXT"] = "Lista: "
FactionAddictLocalization["EXALTED_TXT"] = "Exaltadas: "
FactionAddictLocalization["NEXT_ACHIEV_TXT"] = "Siguiente logro: "
FactionAddictLocalization["ACHIEV_DATEFORMAT"] = "%Y-%b-%d" -- lua date format

-- Tab2 - friends text
FactionAddictLocalization["TAB2_DESC_TXT"] = "Click a friend for more info."

-- Tab3 - log text
FactionAddictLocalization["TAB3_DESC_TXT"] = "Registro de reputación"
FactionAddictLocalization["TAB3_LASTGAIN_TXT"] = "Última ganacia"
FactionAddictLocalization["TAB3_NOGAIN_TXT"] = "Ninguna en esta sesión"
FactionAddictLocalization["TAB3_SESSIONTOTAL_TXT"] = "Total de la sesión: "

-- Tab4 - config text
FactionAddictLocalization["TAB4_DESC_TXT"] = "Configuración"
FactionAddictLocalization["TAB4_DISPLAY_CONFIG_TXT"] = "¿Qué facciones se muestran?"
FactionAddictLocalization["TAB4_DISPLAY_ORDER_TXT"] = "Ordenar facciones por:"
FactionAddictLocalization["TAB4_DISPLAY_FILTER"] = "Filtro de Facción"
FactionAddictLocalization["TAB4_DISPLAY_OPTIONS"] = "Opciones"
FactionAddictLocalization["TAB4_CONFIG_CF"] = "Facciones Clásicas"
FactionAddictLocalization["TAB4_CONFIG_BC"] = "Facciones de Burning Crusade"
FactionAddictLocalization["TAB4_CONFIG_WOTLK"] = "Facciones de Wrath of the Lich King"
FactionAddictLocalization["TAB4_CONFIG_CATA"] = "Facciones de Cataclysm "
FactionAddictLocalization["TAB4_CONFIG_MOP"] = "Facciones de Mists of Pandaria"
FactionAddictLocalization["TAB4_CONFIG_WOD"] = "Facciones de Warlords of Draenor"
FactionAddictLocalization["TAB4_CONFIG_LG"] = "Facciones de Legion"
FactionAddictLocalization["TAB4_CONFIG_BFA"] = "Battle for Azeroth Factions"
FactionAddictLocalization["TAB4_CONFIG_SLANDS"] = "Shadowlands Factions"
FactionAddictLocalization["TAB4_CONFIG_ORDER_PCT"] = "% a Exaltado"
FactionAddictLocalization["TAB4_CONFIG_ORDER_NAME"] = "Nombre de facción"
FactionAddictLocalization["TAB4_CONFIG_ALLIANCE_ONLY"] = "Mostrar sólo facciones Alianza"
FactionAddictLocalization["TAB4_CONFIG_HORDE_ONLY"] = "Mostrar sólo facciones Horda"
FactionAddictLocalization["TAB4_CONFIG_AUTOBAR"] = "Cambiar automáticamente la barra de reputación"
FactionAddictLocalization["TAB4_CONFIG_HIDEINACTIVE"] = "Ocultar facciones inactivas"

-- Tab5 - about text
FactionAddictLocalization["TAB5_DESC_TXT"] = "Acerca de Faction Addict"
FactionAddictLocalization["VERSION_TXT"] = "versión: "
FactionAddictLocalization["ABOUT_TXT"] = "Faction Addict es un addon que ayuda a los jugadores a ver y seguir fácilmente la información relacionada con las diferentes facciones del juego. Imprescindible para aquellos cuyo objetivo es llegar ser exaltado con todas ellas. |n|nUsa los comandos |cFFFF0000/fa|r o |cFFFF0000/factionaddict|r para abrir y cerrar la ventana. La ventana por defecto de reputación también tiene un botón para abrirla en la esquina superior derecha.|n|nDescargate actualizaciones y deja comentarios en: |cFFFFFF00wowinterface.com|r y |cFFFFFF00wow.curse.com|r|n|nAddon por: |cFFFFFF00gmz323 (Greg)|r"

-- Info Window
FactionAddictLocalization["LAUNCH_WATCH_PANEL_TXT"] = "Launch Watch Panel"
FactionAddictLocalization["FACTION_URL_TXT"] = "www.es.wowhead.com/faction="
FactionAddictLocalization["PCT_TO_EXALTED_TXT"] = "% para Exaltado: "
FactionAddictLocalization["PCT_TO_MAX_TXT"] = "Pct to Max: "
FactionAddictLocalization["PCT_TO_REWARD_TXT"] = "Pct to Next Reward: "
FactionAddictLocalization["CATEGORY_TXT"] = "Categoría: "

-- Info Window - Categories
FactionAddictLocalization["CATEGORY_ALLIANCE_TXT"] = "Alianza"
FactionAddictLocalization["CATEGORY_ALLIANCEFORCES_TXT"] = "Fuerzas de la Alianza"
FactionAddictLocalization["CATEGORY_ALLIANCEVANGUARD_TXT"] = "Vanguardia de la Alliance"
FactionAddictLocalization["CATEGORY_CATACLYSM_TXT"] = "Cataclysm"
FactionAddictLocalization["CATEGORY_CLASSIC_TXT"] = "Clásicas"
FactionAddictLocalization["CATEGORY_GUILD_TXT"] = "Hermandad"
FactionAddictLocalization["CATEGORY_HORDE_TXT"] = "Horda"
FactionAddictLocalization["CATEGORY_HORDEEXP_TXT"] = "Expedición de la Horda"
FactionAddictLocalization["CATEGORY_OTHER_TXT"] = "Otro"
FactionAddictLocalization["CATEGORY_SHATTRATH_TXT"] = "Ciudad de Shattrath"
FactionAddictLocalization["CATEGORY_SHOLAZAR_TXT"] = "Cuenca de Sholazar"
FactionAddictLocalization["CATEGORY_STEAMWHEEDLE_TXT"] = "Cártel Bonvapor"
FactionAddictLocalization["CATEGORY_TBC_TXT"] = "The Burning Crusade"
FactionAddictLocalization["CATEGORY_WOTLK_TXT"] = "Wrath of the Lich King"
FactionAddictLocalization["CATEGORY_HORDEFORCES_TXT"] = "Fuerzas de la Horda"
FactionAddictLocalization["CATEGORY_MOP_TXT"] = "Mists of Pandaria"
FactionAddictLocalization["CATEGORY_WOD_TXT"] = "Warlords of Draenor"
FactionAddictLocalization["CATEGORY_BARRACKSBODYGUARDS_TXT"] = "Guardaespaldas del cuartel"
FactionAddictLocalization["CATEGORY_LEGION_TXT"] = "Legion"
FactionAddictLocalization["CATEGORY_BFA_TXT"] = "Battle for Azeroth"
FactionAddictLocalization["CATEGORY_SLANDS_TXT"] = "Shadowlands"

-- Standing Filter (Tab1 - dropdown)
FactionAddictLocalization["STANDING_FILTER_TITLE_TXT"] =    "Filtro de Prestigio"
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
FactionAddictLocalization["Monday"] = "Lunes"
FactionAddictLocalization["Tuesday"] = "Martes"
FactionAddictLocalization["Wednesday"] = "Miércoles"
FactionAddictLocalization["Thursday"] = "Jueves"
FactionAddictLocalization["Friday"] = "Viernes"
FactionAddictLocalization["Saturday"] = "Sábado"
FactionAddictLocalization["Sunday"] = "Domingo"
FactionAddictLocalization["DATE_FORMAT"] = "D, d/m/y"

-- Misc Strings
FactionAddictLocalization["MISC_PARAGON_TXT"] = "Paragon"
end;