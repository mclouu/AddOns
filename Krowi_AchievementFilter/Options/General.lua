-- [[ Namespaces ]] --
local _, addon = ...;
local options = addon.Options;
options.General = {};
local general = options.General;
local widthMultiplier = addon.Options.WidthMultiplier;

local popupDialog = LibStub("Krowi_PopopDialog-1.0");

function general.AddKeybindingOptions()
    local w = 1;
    for i, binding in next, addon.Bindings do
        addon.Options.InjectOptionsTableAdd({
            order = i + 0.1, type = "description", width = w * widthMultiplier,
            name = binding.Text
        }, "Binding" .. i .. "Name", "args", "General", "args", "KeyBinding", "args", "Keybindings");
        local command = binding.Name;
        addon.Options.InjectOptionsTableAdd({
            order = i + 0.2, type = "keybinding", width = w * widthMultiplier,
            name = "",
            desc = "",
            get = function() return GetBindingKey(command); end,
            set = function(_, value)
                local key = GetBindingKey(command);
                if key then
                    SetBinding(key);
                end
                SetBinding(value, command, 1);
                SaveBindings(GetCurrentBindingSet());
                end
        }, "Binding" .. i .. "Key1", "args", "General", "args", "KeyBinding", "args", "Keybindings");
        addon.Options.InjectOptionsTableAdd({
            order = i + 0.3, type = "keybinding", width = w * widthMultiplier,
            name = "",
            desc = "",
            get = function() return select(2, GetBindingKey(command)); end,
            set = function(_, value)
                local _, key = GetBindingKey(command);
                if key then
                    SetBinding(key);
                end
                SetBinding(value, command, 2);
                SaveBindings(GetCurrentBindingSet());
                end
        }, "Binding" .. i .. "Key2", "args", "General", "args", "KeyBinding", "args", "Keybindings");
    end
end

local function OpenTutorialsMenu()
    local menu = LibStub("Krowi_Menu-1.0");
    local pages = addon.Tutorials.FeaturesTutorial.Pages;

    menu:Clear(); -- Reset menu

    menu:AddFull({Text = addon.L["View Tutorial"], IsTitle = true});
    for i, _ in next, pages do
        menu:AddFull({
            Text = (pages[i].IsViewed and "" or "|T132049:0|t") .. string.format(addon.Colors.White, addon.Colors.RemoveColor(pages[i].SubTitle)),
            Func = function()
                if addon.IsWrathClassic or addon.IsShadowlandsRetail then
                    InterfaceOptionsFrame:Hide();
                else
                    SettingsPanel:Close();
                end
                addon.Diagnostics.Debug("Showing tutorial for " .. tostring(i));
                addon.Tutorials.FeaturesTutorial:ShowTutorial(i);
            end
        });
    end

    menu:Open();
end

local function SetShowHideMinimapIcon()
    addon.Options.db.ShowMinimapIcon = not addon.Options.db.ShowMinimapIcon;
    if addon.Options.db.ShowMinimapIcon then
        addon.Icon:Show("Krowi_AchievementFilterLDB");
    else
        addon.Icon:Hide("Krowi_AchievementFilterLDB");
    end
    options.Debug(addon.L["Show minimap icon"], addon.Options.db.ShowMinimapIcon);
end

local function SetShowHideWorldmapIcon()
    addon.Options.db.ShowWorldmapIcon = not addon.Options.db.ShowWorldmapIcon;
    addon.GUI.WorldMapButton:Refresh();
    addon.WorldMapButtons.SetPoints();
    options.Debug(addon.L["Show worldmap icon"], addon.Options.db.ShowWorldmapIcon);
end

local screenshotModeFrame;
local function HandleScreenshotMode()
    if addon.IsWrathClassic or addon.IsShadowlandsRetail then
        InterfaceOptionsFrame:Hide();
    else
        SettingsPanel:Close();
    end
    if screenshotModeFrame == nil then
        screenshotModeFrame = CreateFrame("Frame", nil, UIParent);
        if screenshotModeFrame == nil then
            error("Screenshot frame failed to be created.");
            return;
        end
        screenshotModeFrame:SetAllPoints();
        screenshotModeFrame:SetPoint("CENTER");
        screenshotModeFrame:SetSize(64, 64);

        screenshotModeFrame.tex = screenshotModeFrame:CreateTexture();
        screenshotModeFrame.tex:SetAllPoints();
        screenshotModeFrame.tex:SetTexture("Interface/AddOns/Krowi_AchievementFilter/Media/Black");
        screenshotModeFrame.tex:SetTexCoord(0, 0.390625, 0, 0.78125);
    elseif screenshotModeFrame:IsShown() then
        screenshotModeFrame:Hide();
    else
        screenshotModeFrame:Show();
    end
end

local function ExportCriteria()
    local criteriaCache = {};
    for _, id in next, addon.Data.AchievementIds do
        local numCriteria = GetAchievementNumCriteria(id);
        if numCriteria > 0 then
            for i = 1, numCriteria do
                local criteriaString, criteriaType, _, _, _, _, flags, assetId, _, criteriaId, _ = GetAchievementCriteriaInfo(id, i);
                tinsert(criteriaCache, {
                    AchievementId = id,
                    CriteriaIndex = i,
                    CriteriaString = criteriaString,
                    CriteriaType = criteriaType,
                    Flags = flags,
                    AssetId = assetId,
                    CriteriaId = criteriaId
                });
            end
        end
        -- if #criteriaCache > 100 then
        --     DebugTable = criteriaCache;
        --     return;
        -- end
    end
    DebugTable = criteriaCache;
end

-- local function ExportAchievements()
--     local achievementsCache = {};
--     local gapSize, i = 0, 1;
--     while gapSize < 500 do
--         local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy, isStatistic, exists = addon.GetAchievementInfo(i);

--         if id then
--             tinsert(achievementsCache, {
--                 Id = id,
--                 Name = name,
--                 Description = description,
--                 RewardText = rewardText,
--                 Points = points,
--                 -- CategoryAgtId = nil,
--                 Flags = flags,
--                 -- UiOrder = nil,
--                 IconFileId = icon
--             });
--         end
--         if id and exists then
--             gapSize = 0;
--         else
--             gapSize = gapSize + 1;
--         end
--         i = i + 1;
--     end
--     DebugTable = achievementsCache;
-- end

options.OptionsTable.args["General"] = {
    type = "group",
    childGroups = "tab",
    name = addon.L["General"],
    args = {
        Info = {
            order = 1, type = "group",
            name = addon.L["Info"],
            args = {
                General = {
                    order = 1, type = "group",
                    name = addon.L["General"],
                    inline = true,
                    args = {
                        Version = {
                            order = 1.1, type = "description", width = 1 * widthMultiplier,
                            name = string.format(addon.Colors.Yellow, addon.L["Version"] .. ": ") .. addon.MetaData.Version,
                            fontSize = "medium",
                        },
                        Build = {
                            order = 1.2, type = "description", width = 1 * widthMultiplier,
                            name = string.format(addon.Colors.Yellow, addon.L["Build"] .. ": ") .. addon.MetaData.Build,
                            fontSize = "medium",
                        },
                        Tutorial = {
                            order = 1.3, type = "execute", width = 1 * widthMultiplier,
                            name = function() return (addon.Tutorials.FeaturesTutorial:HasUnviewedPages() and "|T132049:0|t" or "") .. addon.L["Tutorial"]; end,
                            desc = addon.L["Tutorial Desc"],
                            func = OpenTutorialsMenu
                        },
                        Author = {
                            order = 2.1, type = "description", width = 2 * widthMultiplier,
                            name = string.format(addon.Colors.Yellow, addon.L["Author"] .. ": ") .. addon.MetaData.Author,
                            fontSize = "medium",
                        },
                        Discord = {
                            order = 2.3, type = "execute", width = 1 * widthMultiplier,
                            name = addon.L["Discord"],
                            desc = addon.Util.ReplaceVars
                            {
                                addon.L["Discord Desc"],
                                serverName = addon.MetaData.DiscordServerName
                            },
                            func = function()
                                popupDialog.ShowExternalLink(addon.MetaData.DiscordInviteLink);
                            end
                        }
                    }
                },
                Sources = {
                    order = 2, type = "group",
                    name = addon.L["Sources"],
                    inline = true,
                    args = {
                        CurseForge = {
                            order = 1.1, type = "execute", width = 1 * widthMultiplier,
                            name = addon.L["CurseForge"],
                            desc = addon.Util.ReplaceVars
                            {
                                addon.L["CurseForge Desc"],
                                addonName = addon.MetaData.Title,
                                curseForge = addon.L["CurseForge"]
                            },
                            func = function()
                                popupDialog.ShowExternalLink(addon.MetaData.CurseForge);
                            end
                        },
                        Wago = {
                            order = 1.2, type = "execute", width = 1 * widthMultiplier,
                            name = addon.L["Wago"],
                            desc = addon.Util.ReplaceVars
                            {
                                addon.L["Wago Desc"],
                                addonName = addon.MetaData.Title,
                                wago = addon.L["Wago"]
                            },
                            func = function()
                                popupDialog.ShowExternalLink(addon.MetaData.Wago);
                            end
                        },
                        WoWInterface = {
                            order = 1.3, type = "execute", width = 1 * widthMultiplier,
                            name = addon.L["WoWInterface"],
                            desc = addon.Util.ReplaceVars
                            {
                                addon.L["WoWInterface Desc"],
                                addonName = addon.MetaData.Title,
                                woWInterface = addon.L["WoWInterface"]
                            },
                            func = function()
                                popupDialog.ShowExternalLink(addon.MetaData.WoWInterface);
                            end
                        }
                    }
                }
            }
        },
        Icon = {
            order = 2, type = "group",
            name = addon.L["Icon"],
            args = {
                Minimap = {
                    order = 1, type = "group",
                    name = addon.L["Minimap"],
                    inline = true,
                    args = {
                        ShowMinimapIcon = {
                            order = 1, type = "toggle", width = 1 * widthMultiplier,
                            name = addon.L["Show minimap icon"],
                            desc = addon.L["Show minimap icon Desc"],
                            get = function() return addon.Options.db.ShowMinimapIcon; end,
                            set = SetShowHideMinimapIcon
                        }
                    }
                },
                Worldmap = {
                    order = 1, type = "group",
                    name = addon.L["World Map"],
                    inline = true,
                    args = {
                        ShowMinimapIcon = {
                            order = 1, type = "toggle", width = 1 * widthMultiplier,
                            name = addon.L["Show world map icon"],
                            desc = addon.L["Show world map icon Desc"],
                            get = function() return addon.Options.db.ShowWorldmapIcon; end,
                            set = SetShowHideWorldmapIcon
                        }
                    }
                }
            }
        },
        KeyBinding = {
            order = 3, type = "group",
            name = addon.L["Key Binding"],
            args = {
                ResetView = {
                    order = 1, type = "group",
                    name = addon.L["Reset view"],
                    inline = true,
                    args = {
                        ResetViewOnOpen = {
                            order = 1.1, type = "toggle", width = 1.5 * widthMultiplier,
                            name = addon.L["Reset view on open"],
                            desc = addon.L["Reset view on open Desc"],
                            get = function() return addon.Options.db.ResetViewOnOpen; end,
                            set = function()
                                addon.Options.db.ResetViewOnOpen = not addon.Options.db.ResetViewOnOpen;
                                addon.Options.db.ToggleWindow = false;
                                options.Debug(addon.L["Reset view on open"], addon.Options.db.ResetViewOnOpen);
                            end
                        },
                        ToggleWindow = {
                            order = 1.1, type = "toggle", width = 1.5 * widthMultiplier,
                            name = addon.L["Toggle window once opened"],
                            desc = addon.L["Toggle window once opened Desc"],
                            get = function() return addon.Options.db.ToggleWindow; end,
                            set = function()
                                addon.Options.db.ToggleWindow = not addon.Options.db.ToggleWindow;
                                options.Debug(addon.L["Toggle window once opened"], addon.Options.db.ToggleWindow);
                            end,
                            disabled = function() return addon.Options.db.ResetViewOnOpen; end
                        }
                    }
                },
                MicroButton = {
                    order = 2, type = "group",
                    name = addon.L["Micro Button"],
                    inline = true,
                    args = {
                        RebindMicroButton = {
                            order = 1.1, type = "select", width = 2 * widthMultiplier,
                            name = addon.L["Rebind Micro Button"],
                            desc = addon.L["Rebind Micro Button Desc"],
                            values = function() return addon.GUI.TabsOrderGetActiveKeys(); end,
                            get = function()
                                return addon.Options.db.MicroButtonTab;
                            end,
                            set = function (_, value)
                                addon.Options.db.MicroButtonTab = value;
                                addon.ChangeAchievementMicroButtonOnClick();
                                options.Debug(addon.L["Rebind Micro Button"], addon.Options.db.MicroButtonTab);
                            end
                        },
                        SetKeybind = {
                            order = 1.2, type = "execute", width = 1 * widthMultiplier,
                            name = addon.L["Set Keybind"],
                            desc = addon.Util.ReplaceVars
                            {
                                addon.L["Set Keybind Desc"],
                                keyBindings = addon.L["Key Bindings"]
                            },
                            func = function()
                                local tab = SavedData.Tabs[addon.Options.db.MicroButtonTab];
                                if tab.BindingName then
                                    SetBinding("Y", tab.BindingName);
                                    SaveBindings(GetCurrentBindingSet());
                                end
                            end
                        }
                    }
                },
                Keybindings = {
                    order = 3, type = "group",
                    name = addon.L["Keybindings"],
                    inline = true,
                    args = {

                    }
                },
                Modifiers = {
                    order = 4, type = "group",
                    name = addon.L["Modifiers"],
                    inline = true,
                    args = {
                        LinkToChat = {
                            order = 1.1, type = "select", width = 1 * widthMultiplier,
                            name = addon.L["Paste to Chat"],
                            values = addon.Modifiers,
                            get = function() return addon.Options.db.Achievements.Modifiers.PasteToChat; end,
                            set = function (_, value)
                                if addon.Options.db.Achievements.Modifiers.PasteToChat == value then return; end;
                                addon.Options.db.Achievements.Modifiers.PasteToChat = value;
                                options.Debug(addon.L["Paste to Chat"], addon.Options.db.Achievements.Modifiers.PasteToChat);
                            end
                        },
                        ToggleTracking = {
                            order = 1.2, type = "select", width = 1 * widthMultiplier,
                            name = addon.L["Toggle Tracking"],
                            values = addon.Modifiers,
                            get = function() return addon.Options.db.Achievements.Modifiers.ToggleTracking; end,
                            set = function (_, value)
                                if addon.Options.db.Achievements.Modifiers.ToggleTracking == value then return; end;
                                addon.Options.db.Achievements.Modifiers.ToggleTracking = value;
                                options.Debug(addon.L["Toggle Tracking"], addon.Options.db.Achievements.Modifiers.ToggleTracking);
                            end
                        },
                        WatchList = {
                            order = 2.1, type = "select", width = 1 * widthMultiplier,
                            name = addon.L["Add to / Remove from Watch List"]:ReplaceVars
                            {
                                watchList = addon.L["Watch List"]
                            },
                            values = addon.Modifiers,
                            get = function() return addon.Options.db.Achievements.Modifiers.ToggleWatchList; end,
                            set = function (_, value)
                                if addon.Options.db.Achievements.Modifiers.ToggleWatchList == value then return; end;
                                addon.Options.db.Achievements.Modifiers.ToggleWatchList = value;
                                options.Debug(addon.L["Add to/Remove from Watch List"], addon.Options.db.Achievements.Modifiers.ToggleWatchList);
                            end
                        },
                        Excluded = {
                            order = 2.1, type = "select", width = 1 * widthMultiplier,
                            name = addon.L["Include"] .. " / " .. addon.L["Exclude"],
                            values = addon.Modifiers,
                            get = function() return addon.Options.db.Achievements.Modifiers.ToggleExcluded; end,
                            set = function (_, value)
                                if addon.Options.db.Achievements.Modifiers.ToggleExcluded == value then return; end;
                                addon.Options.db.Achievements.Modifiers.ToggleExcluded = value;
                                options.Debug(addon.L["Include"] .. " / " .. addon.L["Exclude"], addon.Options.db.Achievements.Modifiers.ToggleExcluded);
                            end
                        }
                    }
                }
            }
        },
        Search = {
            order = 5, type = "group",
            name = addon.L["Search"],
            args = {
                SearchField = {
                    order = 1, type = "group",
                    name = addon.L["Search field"],
                    inline = true,
                    args = {
                        ClearOnRightClick = {
                            order = 1.1, type = "toggle", width = 1.5 * widthMultiplier,
                            name = addon.L["Clear search field on Right Click"],
                            desc = addon.L["Clear search field on Right Click Desc"],
                            get = function() return addon.Options.db.SearchBox.ClearOnRightClick; end,
                            set = function()
                                addon.Options.db.SearchBox.ClearOnRightClick = not addon.Options.db.SearchBox.ClearOnRightClick;
                                options.Debug(addon.L["Clear search field on Right Click"], addon.Options.db.SearchBox.ClearOnRightClick);
                            end
                        },
                        ExcludeExcluded = {
                            order = 1.2, type = "toggle", width = 1.5 * widthMultiplier,
                            name = addon.L["Exclude Excluded achievements"],
                            desc = addon.L["Exclude Excluded achievements Desc"],
                            get = function() return addon.Options.db.SearchBox.ExcludeExcluded; end,
                            set = function()
                                addon.Options.db.SearchBox.ExcludeExcluded = not addon.Options.db.SearchBox.ExcludeExcluded;
                                options.Debug(addon.L["Exclude Excluded achievements"], addon.Options.db.SearchBox.ExcludeExcluded);
                            end
                        },
                        OnlySearchFiltered = {
                            order = 2.1, type = "toggle", width = 1.5 * widthMultiplier,
                            name = addon.L["Only search filtered achievements"],
                            desc = addon.L["Only search filtered achievements Desc"],
                            get = function() return addon.Options.db.SearchBox.OnlySearchFiltered; end,
                            set = function()
                                addon.Options.db.SearchBox.OnlySearchFiltered = not addon.Options.db.SearchBox.OnlySearchFiltered;
                                options.Debug(addon.L["Only search filtered achievements"], addon.Options.db.SearchBox.OnlySearchFiltered);
                            end
                        },
                        Blank22 = {order = 2.2, type = "description", width = 1.5 * widthMultiplier, name = ""},
                        MinimumCharactersToSearch = {
                            order = 3.1, type = "range", width = 1.5 * widthMultiplier,
                            name = addon.L["Minimum characters to search"],
                            desc = addon.L["Minimum characters to search Desc"],
                            min = 1, max = 10, step = 1,
                            get = function() return addon.Options.db.SearchBox.MinimumCharactersToSearch; end,
                            set = function(_, value)
                                if addon.Options.db.SearchBox.MinimumCharactersToSearch == value then return; end
                                addon.Options.db.SearchBox.MinimumCharactersToSearch = value;
                                options.Debug(addon.L["Minimum characters to search"], addon.Options.db.SearchBox.MinimumCharactersToSearch);
                            end
                        }
                    }
                },
                SearchPreview = {
                    order = 2, type = "group",
                    name = addon.L["Search preview"],
                    inline = true,
                    args = {
                        NumberOfSearchPreviews = {
                            order = 1.1, type = "range", width = 1.5 * widthMultiplier,
                            name = addon.L["Number of search previews"],
                            desc = addon.ReplaceVarsWithReloadReq(addon.L["Number of search previews Desc"]),
                            min = 1, max = 1000, step = 1, -- max is set by options.MaxNumberOfSearchPreviews after loading has finished
                            get = function() return addon.Options.db.SearchBox.NumberOfSearchPreviews; end,
                            set = function(_, value)
                                if addon.Options.db.SearchBox.NumberOfSearchPreviews == value then return; end
                                addon.Options.db.SearchBox.NumberOfSearchPreviews = value;
                                options.Debug(addon.L["Number of search previews"], addon.Options.db.SearchBox.NumberOfSearchPreviews);
                            end
                        },
                        Blank12 = {order = 1.2, type = "description", width = 1.5 * widthMultiplier, name = ""},
                        ShowAllResultsInCategory = {
                            order = 2.1, type = "toggle", width = 1.5 * widthMultiplier,
                            name = addon.L["Show All Results in Category"],
                            desc = addon.L["Show All Results in Category Desc"],
                            get = function() return addon.Options.db.SearchBox.ShowAllResultsInCategory; end,
                            set = function()
                                addon.Options.db.SearchBox.ShowAllResultsInCategory = not addon.Options.db.SearchBox.ShowAllResultsInCategory;
                                options.Debug(addon.L["Show All Results in Category"], addon.Options.db.SearchBox.ShowAllResultsInCategory);
                            end
                        },
                    }
                }
            }
        },
        Filters = {
            order = 6, type = "group",
            name = addon.L["Filters"],
            args = {
                ResetFilters = {
                    order = 1, type = "group",
                    name = addon.L["Reset filters"],
                    inline = true,
                    args = {
                        ResetFactionFilter = {
                            order = 1.1, type = "toggle", width = 1 * widthMultiplier,
                            name = addon.L["Reset Faction Filters"],
                            desc = addon.Util.ReplaceVars
                            {
                                addon.L["Reset Faction Filters Desc"],
                                neutral = addon.L["Neutral"],
                                alliance = addon.L["Alliance"],
                                horde = addon.L["Horde"]
                            },
                            get = function() return addon.Options.db.Filters.ResetFactionFilters; end,
                            set = function()
                                addon.Options.db.Filters.ResetFactionFilters = not addon.Options.db.Filters.ResetFactionFilters;
                                options.Debug(addon.L["Reset Faction Filters"], addon.Options.db.Filters.ResetFactionFilters);
                            end
                        }
                    }
                }
            }
        },
        Debug = {
            order = 7, type = "group",
            name = addon.L["Debug"],
            args = {
                Description = {
                    order = 1, type = "description", width = "full",
                    name = addon.L["Debug Desc"],
                    fontSize = "medium"
                },
                EnableDebugInfo = {
                    order = 2.1, type = "toggle", width = 1 * widthMultiplier,
                    name = addon.L["Enable debug info"],
                    desc = addon.L["Enable debug info Desc"],
                    get = function() return addon.Options.db.EnableDebugInfo; end,
                    set = function()
                        addon.Options.db.EnableDebugInfo = not addon.Options.db.EnableDebugInfo;
                        options.Debug(addon.L["Enable debug info"], addon.Options.db.EnableDebugInfo);
                    end
                },
                Blank12 = {order = 2.2, type = "description", width = 1 * widthMultiplier, name = ""},
                ScreenshotMode = {
                    order = 2.3, type = "execute",
                    name = addon.L["Screenshot Mode"],
                    desc = addon.L["Screenshot Mode Desc"],
                    func = HandleScreenshotMode
                },
                EnableTraceInfo = {
                    order = 3.1, type = "toggle", width = 1 * widthMultiplier,
                    name = addon.L["Enable trace info"],
                    desc = addon.L["Enable trace info Desc"],
                    get = function() return addon.Options.db.EnableTraceInfo; end,
                    set = function()
                        addon.Options.db.EnableTraceInfo = not addon.Options.db.EnableTraceInfo;
                        options.Debug(addon.L["Enable trace info"], addon.Options.db.EnableTraceInfo);
                    end
                },
                Blank32 = {order = 3.2, type = "description", width = 1 * widthMultiplier, name = ""},
                ExportCriteria = {
                    order = 3.3, type = "execute",
                    name = addon.L["Export Criteria"],
                    desc = addon.L["Export Criteria Desc"],
                    func = ExportCriteria
                },
                ShowPlaceholdersFilter = {
                    order = 4.1, type = "toggle", width = 1 * widthMultiplier,
                    name = addon.L["Show placeholders filter"],
                    desc = addon.L["Show placeholders filter Desc"],
                    get = function() return addon.Options.db.ShowPlaceholdersFilter; end,
                    set = function()
                        addon.Options.db.ShowPlaceholdersFilter = not addon.Options.db.ShowPlaceholdersFilter;
                        options.Debug(addon.L["Show placeholders filter"], addon.Options.db.ShowPlaceholdersFilter);
                    end
                },
                Blank42 = {order = 4.2, type = "description", width = 2 * widthMultiplier, name = ""},
                -- ExportAchievements = {
                --     order = 4.3, type = "execute",
                --     name = addon.L["Export Achievements"],
                --     desc = addon.L["Export Achievements Desc"],
                --     func = ExportAchievements
                -- },
            }
        }
    }
};