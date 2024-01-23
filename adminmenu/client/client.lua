--[[
    ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~
    -- Trase#0001, I create and release these things free, please leave me some credit :)
    ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~
]]






RegisterNetEvent('thor_adminmenu:client:sendNotification')
AddEventHandler('thor_adminmenu:client:sendNotification', function(info)
    trase.functions.notify(info)
end)

local selectedPlayer = nil;
RegisterNetEvent('thor_adminmenu:client:spectatePlayer')
AddEventHandler('thor_adminmenu:client:spectatePlayer', function(target)
    spectating = not spectating
	if spectating then
		RequestCollisionAtCoord(GetEntityCoords(target))
		NetworkSetInSpectatorMode(true, target)
	else
		RequestCollisionAtCoord(GetEntityCoords(target))
		NetworkSetInSpectatorMode(false, target)
	end
end)


local function GetCamDirection()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()
    
    local x = -math.sin(heading * math.pi / 180.0)
    local y = math.cos(heading * math.pi / 180.0)
    local z = math.sin(pitch * math.pi / 180.0)
    
    local len = math.sqrt(x * x + y * y + z * z)
    if len ~= 0 then
        x = x / len
        y = y / len
        z = z / len
    end
    
    return x, y, z
end

canOpenMenu = nil
canSelfOptions = nil
canGodmode = nil
canFullHealth = nil
canFullArmor = nil
canSpawnWeapon = nil
canSpawnVehicle = nil
canInvisible = nil
canNoclip = nil
canCustomPed = nil
canPlayerOptions = nil
canFreeze = nil
canSpectate = nil
canSlap = nil
canHeal = nil
canGotoPlayer = nil
canBringPlayer = nil
canGiveCar = nil
canGiveWeapon = nil
canteleportCoords = nil
candisplayCoords = nil
canIdGun = nil
canDeveloperTools = nil
canKick = nil
canBan = nil
canVehicleoptions = nil
canSpawnvehicle = nil
canFixVehicle = nil
canCleanVehicle = nil
canDeleteVehicle = nil
canFlipVehicle = nil
canESXRevive = nil
canESXGiveItem = nil
canESXAddMoney = nil
canESXAddBank = nil
canESXAddDirty = nil
canESXSetJob = nil 
canCarWipe = nil;
canPedWipe = nil;
canObjectWipe = nil;
canViewMoney, canSetGroup, canReviveAll = nil, nil, nil;
canTPM = nil;
canScreenshot = nil;
canForceskin = nil;
enabledCmds = nil;
canCustomizeLicensePlate = nil;
noclip = nil;
local currentMenuX = 1
local selectedMenuX = 1
local currentMenuY = 4
local selectedMenuY = 4
noclipSpeed = nil;
local menuX = { 0.375, 0.10, 0.30, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.75 }
local menuY = { 0.125, 0.10, 0.30, 0.1, 0.2, 0.3, 0.4, 0.5 } 
local currGroupIndex = 1
local selGroupIndex = 1
canClearChat = nil;
TriggerServerEvent('thor_adminmenu:server:getPermissions')
TriggerServerEvent('thor_adminmenu:server:getConfig')

RegisterNetEvent('thor_adminmenu:client:getPermissions')
AddEventHandler('thor_adminmenu:client:getPermissions', function(hasOpenMenu, hasSelfOptions, hasGodmode, hasFullHealth, hasFullArmor, hasSpawnWeapon, hasSpawnVehicle, hasInvisible, hasNoclip, hasCustomPed, hasPlayerOptions,  hasFreeze, hasSpectate, hasSlap, hasHeal, hasGotoPlayer, hasBringPlayer, hasGiveWeapons, hasteleportCoords, hasdisplayCoords, hasIdGun, hadDeveloperTools, hasKick, hasBan, hasVehicleoptions, hasSpawnvehicle, hasFixVehicle, hasCleanVehicle, hasDeleteVehicle, hasFlipVehicle, hasESXRevive, hasESXGiveItem, hasESXAddMoney, hasESXAddBank, hasESXAddDirty, hasESXSetJob, hasCarWipe, hasPedWipe, hasObjectWipe, hasViewMoney, hasSetGroup, hasReviveAll, hasTPM, hasScreenshot, hasForceskin, hasCustomLicensePlate, hasClearChat)
    canOpenMenu = hasOpenMenu
    canSelfOptions = hasSelfOptions
    canGodmode = hasGodmode
    canFullHealth = hasFullHealth
    canFullArmor = hasFullArmor
    canSpawnWeapon = hasSpawnWeapon
    canSpawnVehicle = hasSpawnVehicle
    canInvisible = hasInvisible
    canNoclip = hasNoclip
    canCustomPed = hasCustomPed
    canPlayerOptions = hasPlayerOptions
    canFreeze = hasFreeze
    canSpectate = hasSpectate
    canSlap = hasSlap
    canHeal = hasHeal
    canGotoPlayer = hasGotoPlayer
    canBringPlayer = hasBringPlayer
    canGiveWeapon = hasGiveWeapons
    canGiveCar = hasGiveCar
    canteleportCoords = hasteleportCoords
    candisplayCoords = hasdisplayCoords
    canIdGun = hasIdGun
    canDeveloperTools = hadDeveloperTools
    canKick = hasKick
    canBan = hasBan
    canVehicleoptions = hasVehicleoptions
    canSpawnvehicle = hasSpawnvehicle
    canFixVehicle = hasFixVehicle
    canCleanVehicle = hasCleanVehicle
    canDeleteVehicle = hasDeleteVehicle
    canFlipVehicle = hasFlipVehicle
    canESXRevive = hasESXRevive
    canESXGiveItem = hasESXGiveItem
    canESXAddMoney = hasESXAddMoney
    canESXAddBank = hasESXAddBank
    canESXAddDirty = hasESXAddDirty
    canESXSetJob = hasESXSetJob
    canCarWipe = hasCarWipe
    canPedWipe = hasPedWipe
    canObjectWipe = hasObjectWipe
    canViewMoney, canSetGroup, canReviveAll = hasViewMoney, hasSetGroup, hasReviveAll
    canTPM = hasTPM
    enabledCmds = commandsEnabled
    canScreenshot = hasScreenshot
    canForceskin = hasForceskin
    canCustomizeLicensePlate = hasCustomLicensePlate
    canClearChat = hasClearChat
end)

local function DrawPlayerInfo(player)
	drawTarget = player
	drawingSpectatingText = true
end

RegisterNetEvent('trase:client:spectatePlayer')
AddEventHandler('trase:client:spectatePlayer', function(targetPed)
    local playerPed = PlayerPedId() -- yourself
	enable = true
	if targetPed == playerPed then enable = false end;

	if(enable)then
        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
		RequestCollisionAtCoord(targetx,targety,targetz)
		NetworkSetInSpectatorMode(true, targetPed)
	else
        NetworkSetInSpectatorMode(false, targetPed)
	end
end)

noclipSpeed = nil;
playerMaxHealth = nil;
playerMaxArmor = nil;
isESXEnabled = nil;
ESXMainEvent = nil;
ESXJobEvent = nil;
ESXReviveEvent = nil;
adminmenu_openCommand = nil;
OpenCommand = nil;
adminmenu_enabledkey = nil;
adminmenu_openkey = nil;
isReplyCommand = nil;
isReportCommand = nil;
replyCommand = nil;
reportCommand = nil;
screenshotAreEnabled = nil;
clearchatEvent = nil;
RegisterNetEvent('thor_adminmenu:client:getConfig')
AddEventHandler('thor_adminmenu:client:getConfig', function(menuKeyEnabled, openKey, openCommand, openCommandCmd, maxHealth, maxArmor, enabledESX, ESXMainEvent, ESXJobEvent, ESXReviveEvent, replyCommandEnabled, reportCommandEnabled, commandReply, commandReport, nclipSpeed, screenshotEnabled, chatclearEvent)
    adminmenu_enabledkey = menuKeyEnabled
    adminmenu_openkey = openKey
    adminmenu_openCommand = openCommand
    OpenCommand = openCommandCmd
    playerMaxHealth = maxHealth
    playerMaxArmor = maxArmor
    isESXEnabled = enabledESX
    isESXMainEvent = ESXMainEvent
    isESXJobEvent = ESXJobEvent
    isESXReviveEvent = ESXReviveEvent
    isReplyCommand = replyCommandEnabled
    isReportCommand = reportCommandEnabled
    replyCommand = commandReply
    reportCommand = commandReport
    noclipSpeed = nclipSpeed
    screenshotAreEnabled = screenshotEnabled
    clearchatEvent = chatclearEvent
end)

CreateThread(function()
    while isReplyCommand == nil or isReportCommand == nil or replyCommand == nil or reportCommand == nil or enabledCmds == nil do 
        Wait(4)
    end;

    if isReplyCommand then
        TriggerEvent('chat:addSuggestion', '/' ..replyCommand, 'Reply to a user\'s report', {
            { name="ID", help="ID of the player you would like to reply to" },
            { name="Message", help="The message you would like to reply with"}
        })
    end

    if isReportCommand then
        TriggerEvent('chat:addSuggestion', '/' ..reportCommand, 'Create a report', {
            { name="Reason", help="The reason you would like to create a report"}
        })
    end
end)


readPlayers = {}
RegisterNetEvent("thor_adminmenu:client:getPlayers", function(readPlayers)
	playerList = readPlayers
end)
disconnectionPlayers = {}
RegisterNetEvent("thor_adminmenu:client:getDisconnectedPlayers", function(disconnectionPlayers)
	discPlayers = disconnectionPlayers
end)
BanLength = {"1 Hour", "3 Hours", "6 Hours", "12 Hours", "1 Day", "2 Days", "3 Days", "1 Week", "2 Weeks", "1 Month", "Permanent"}
PlayerGroups = {"user", "mod", "admin", "superadmin"}
PermLevels = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
local currBanIndex = 1
local selBanIndex = 1
local spectatedPlayer = nil 
CreateThread(function()
    while canOpenMenu == nil or canPlayerOptions == nil or adminmenu_openkey == nil do
        Wait(4)
    end

    AdminMenu.CreateMenu('mainMenu', '', 'Welcome, Player')
	AdminMenu.SetTitleBackgroundSprite('mainMenu', 'AdminMenu', 'admin_menu')
    
    AdminMenu.CreateSubMenu('self_options', 'mainMenu', 'Self Options')
    AdminMenu.CreateSubMenu('player_options', 'mainMenu', 'Active Players')
    AdminMenu.CreateSubMenu('developer_tools', 'mainMenu', 'Developer Tools')
    AdminMenu.CreateSubMenu('disconnected_players', 'mainMenu', 'Disconnected Players')
    AdminMenu.CreateSubMenu('vehicle_options', 'mainMenu', 'Vehicle Options')

    AdminMenu.CreateSubMenu('manage_player', 'player_options', 'Player Options')
    AdminMenu.CreateSubMenu('ban_player', 'player_options', 'Ban Player')
    AdminMenu.CreateSubMenu('kick_player', 'player_options', 'Kick Player')
    AdminMenu.CreateSubMenu('disconnected_players_manage', 'disconnected_players', 'Manage Disconnected Player')
    AdminMenu.CreateSubMenu('offline_ban', 'disconnected_players_manage', 'Offline Ban Player')
    AdminMenu.CreateSubMenu('menu_options', 'mainMenu', 'Menu Options')

    -- [ESX] --
    AdminMenu.CreateSubMenu('esx_self_options', 'self_options', 'ESX Self Options')
    AdminMenu.CreateSubMenu('esx_player_options', 'self_options', 'ESX Player Options')

    while (true) do
        ped = PlayerPedId()
        if AdminMenu.IsMenuOpened('mainMenu') then
            if canSelfOptions then
                if AdminMenu.MenuButton('Self Options', 'self_options', '→') then end
                if AdminMenu.IsItemHovered() then
                    AdminMenu.ToolTip('View all ~y~Self Options')
                end
            end
            if canPlayerOptions then
                if AdminMenu.MenuButton('Player Options', 'player_options', '→') then end
                if AdminMenu.IsItemHovered() then
                    AdminMenu.ToolTip('View all ~b~Online Players~s~')
                end
                if AdminMenu.MenuButton('Disconnected Players', 'disconnected_players', '→') then end
                if AdminMenu.IsItemHovered() then
                    AdminMenu.ToolTip('View all ~r~Disconnected Players~s~')
                end
            end
            if canVehicleoptions then
                if AdminMenu.MenuButton('Vehicle Options', 'vehicle_options', '→') then end
                if AdminMenu.IsItemHovered() then
                    AdminMenu.ToolTip('View all ~g~Vehicle Options~s~')
                end
            end
            if canDeveloperTools then
                if AdminMenu.MenuButton('Developer Tools', 'developer_tools', '→') then end
                if AdminMenu.IsItemHovered() then
                    AdminMenu.ToolTip('View all ~p~Developer Tools~s~')
                end
            end
            if AdminMenu.MenuButton('Menu Options', 'menu_options', '→') then end
            if AdminMenu.IsItemHovered() then
                AdminMenu.ToolTip('View options to do to the ~u~AdminMenu~s~')
            end
        elseif AdminMenu.IsMenuOpened('self_options') then
            if isESXEnabled then
                if AdminMenu.Button('~y~[ESX]~s~ Options', '→') then
                    AdminMenu.OpenMenu('esx_self_options')
                end
            end
            if canFullHealth then
                if AdminMenu.Button('Full Health') then
                    SetEntityHealth(ped, playerMaxHealth)
                end
            end
            if canFullArmor then
                if AdminMenu.Button('Full Armor') then
                    SetPedArmour(ped, playerMaxArmor)
                end
            end
            if canSpawnWeapon then
                if AdminMenu.Button('Spawn Weapon', '→') then
                    local Input = trase.functions.KeyboardInput("Model", "WEAPON_", 100)
                    local AmmoInput = trase.functions.KeyboardInput("Ammo", "999", 100)
                    local hasWeapon = HasPedGotWeapon(ped, Input, false)
                    if hasWeapon then
                        trase.functions.notify('~r~You already own a ' ..Input)
                    else
                        TriggerServerEvent('thor_adminmenu:server:add_weapon', Input, AmmoInput)
                        trase.functions.notify('~g~Spawned ~b~' ..Input.. ' with ' ..AmmoInput.. ' ammo.')
                    end
                end
            end
            if canSpawnVehicle then
                if AdminMenu.Button('Spawn Vehicle', '→') then
                    local Input = trase.functions.KeyboardInput("Model", "", 100)
                    local inVeh = IsPedInAnyVehicle(ped, true)
                    if inVeh then
                        trase.functions.Notify('~r~You are already inside of a vehicle')
                    else
                        trase.functions.SpawnCar(Input, ped)
                    end
                end
            end
            if canCustomPed then
                if AdminMenu.Button('Custom Ped', '→') then
                    local Input = trase.functions.KeyboardInput("Model", "", 100)
                    trase.functions.CustomPed(Input)
                end
            end
            if canGodmode then
                if AdminMenu.CheckBox('Godmode', godmode) then
                    local ped = PlayerPedId()
                    trase.functions.GodMode(ped)
                end
            end
            if canInvisible then
                if AdminMenu.CheckBox('Invisible', invisible) then
                    trase.functions.Invisible(ped)
                end
            end
            if canNoclip then
                if AdminMenu.CheckBox('Noclip', noclip) then
                    noclip = not noclip
                    if noclip then
                        SetEntityAlpha(PlayerPedId(), 155, false)
                        TriggerServerEvent('thor_adminmenu:server:discord_log', 'noclip', 'Staff member enabled noclip', 'Noclip Enabled')
                    else
                        SetEntityRotation(GetVehiclePedIsIn(PlayerPedId(), 0), GetGameplayCamRot(2), 2, 1)
                        SetEntityVisible(GetVehiclePedIsIn(PlayerPedId(), 0), true, false)
                        SetEntityAlpha(PlayerPedId(), 255, false)
                    end
                end
            end
            if AdminMenu.Button('Back', '←') then
                AdminMenu.OpenMenu('mainMenu')
            end
        elseif AdminMenu.IsMenuOpened('player_options') then
            if canReviveAll and isESXEnabled then
                if AdminMenu.Button('Revive ~o~ALL', '~y~ESX') then
                    TriggerServerEvent('thor_adminmenu:server:revive_all')
                end
            end
            for k, v in pairs(playerList) do
                targetName = v.name
                targetId = v.id
                if AdminMenu.MenuButton(targetName.. ' (' ..targetId..')', 'manage_player', '→') then
                    selectedPlayer = targetId
                    selectedPed = GetPlayerPed(selectedPlayer)
                end
            end
        elseif AdminMenu.IsMenuOpened('manage_player') then
            if isESXEnabled then
                if AdminMenu.Button('~y~[ESX]~s~ Options', '→') then
                    AdminMenu.OpenMenu('esx_player_options')
                end
            end
            if canKick then
                if AdminMenu.Button('Kick Player', '→') then
                    AdminMenu.OpenMenu('kick_player')
                end
            end
            if screenshotAreEnabled then
                if canScreenshot then
                    if AdminMenu.Button('Screenshot Player', '~r~Don\'t Spam') then
                        TriggerServerEvent('thor_adminmenu:server:screenshotSomeone', selectedPlayer)
                    end
                end
            end
            if canBan then
                if AdminMenu.Button('Ban Player', '→') then
                    AdminMenu.OpenMenu('ban_player')
                end
            end
            if canFreeze then 
                if AdminMenu.CheckBox('Freeze', frozen) then
                    frozen = not frozen
                    TriggerServerEvent('thor_adminmenu:server:freeze_player', selectedPlayer)
                    if frozen then
                        TriggerServerEvent('thor_adminmenu:server:freeze_player_logs', selectedPlayer)
                    end
                end
            end
            if canSpectate then
                if AdminMenu.CheckBox('Spectate', spectated) then
                    spectated = not spectated
                    TriggerServerEvent('thor_adminmenu:server:spectatePlayer', selectedPlayer)
                end
            end
            if canSlap then
                if AdminMenu.Button('Slap') then
                    TriggerServerEvent('thor_adminmenu:server:set_health', selectedPlayer, 0)
                end
            end
            if canHeal then
                if AdminMenu.Button('Heal') then
                    local health = GetEntityHealth(selectedPlayer)
                    if health == playerMaxHealth then
                        trase.functions.notify('~r~Player is already full health')
                    else
                        TriggerServerEvent('thor_adminmenu:server:set_health', selectedPlayer, playerMaxHealth)
                        TriggerServerEvent('thor_adminmenu:server:set_armor', selectedPlayer, playerMaxArmor)
                        trase.functions.notify('~g~Healed Player')
                    end
                end
            end
            if canGotoPlayer then
                if AdminMenu.Button('Goto') then
                    TriggerServerEvent('thor_adminmenu:server:goto_player', selectedPlayer)
                    trase.functions.notify('~g~Teleported')
                end
            end
            if canBringPlayer then
                if AdminMenu.Button('Bring') then
                    local targetName = GetPlayerName(selectedPlayer)
                    TriggerServerEvent('thor_adminmenu:server:bring_player', selectedPlayer)
                    trase.functions.notify('~g~Brought Player')
                end
            end
            if canGiveWeapon then
                if AdminMenu.Button('Spawn Weapon', '→') then
                    local targetName = GetPlayerName(selectedPlayer)
                    local Input = trase.functions.KeyboardInput("Model", "WEAPON_", 100)
                    local AmmoInput = trase.functions.KeyboardInput("Ammo", "100", 100)
                    local hasWeapon = HasPedGotWeapon(targetPed, Input, false)
                    if hasWeapon then
                        trase.functions.notify('~r~Player already has that weapon')
                    else
                        TriggerServerEvent('thor_adminmenu:server:add_weapon_target', selectedPlayer, Input, AmmoInput)
                        trase.functions.notify('~g~Gave the player a ' ..Input.. ' with ' ..AmmoInput.. ' bullets')
                    end
                end
            end
            if AdminMenu.Button('Back', '←') then
                AdminMenu.OpenMenu('mainMenu')
            end
        elseif AdminMenu.IsMenuOpened('developer_tools') then
            if candisplayCoords then
                if AdminMenu.CheckBox('Display Coords', displayingCoords) then
                    displayingCoords = not displayingCoords
                    ToggleCoords()
                end
            end
            if candisplayCoords then
                if AdminMenu.Button('Copy Coords To Clipboard') then
                    local coords = GetEntityCoords(PlayerPedId())
                    SendNUIMessage({
                        coords = "vector3("..string.format("%.2f", coords.x)..", "..string.format("%.2f", coords.y)..", "..string.format("%.2f", coords.z)..")"
                    })
                end
            end
            if canIdGun then
                if AdminMenu.CheckBox('ID Gun', displayingIdGun) then
                    displayingIdGun = not displayingIdGun
                    ToggleIdGun()
                end   
            end
            if canTPM then
                if AdminMenu.Button('Teleport To Waypoint') then
                    TriggerEvent('thor_adminmenu:client:tpm')
                end
            end
            if canCarWipe then
                if AdminMenu.Button('~b~Car~s~ Wipe') then
                    TriggerEvent('thor_adminmenu:client:vehicleWipe')
                    TriggerServerEvent('thor_adminmenu:server:discord_log', 'carWipe', 'Staff member did a car wipe', 'Car Wipe')
                end
            end
            if canPedWipe then
                if AdminMenu.Button('~y~Ped~s~ Wipe', 'Instant') then
                    TriggerEvent('thor_adminmenu:client:pedWipe')
                    TriggerServerEvent('thor_adminmenu:server:discord_log', 'pedWipe', 'Staff member did a ped wipe', 'Ped Wipe')
                end
            end
            if canObjectWipe then
                if AdminMenu.Button('~o~Object~s~ Wipe', 'Instant') then
                    TriggerEvent('thor_adminmenu:client:objectWipe')
                    TriggerServerEvent('thor_adminmenu:server:discord_log', 'objectWipe', 'Staff member did a object wipe', 'Object Wipe')
                end   
            end
            if canClearChat then 
                if AdminMenu.Button('~b~Clear~s~ Chat', 'Everyone') then
                    TriggerEvent(clearchatEvent)
                end   
            end
        elseif AdminMenu.IsMenuOpened('kick_player') then
            if AdminMenu.Button('Reason:', KickReason) then
                local Reason = trase.functions.KeyboardInput("Kick Reason", "", 100)
                KickReason = Reason
                if KickReason == nil then
                    KickReason = 'No reason specified'
                else
                    KickReason = Reason
                end
            end
            if AdminMenu.Button('~g~[Confirm]') then
                TriggerServerEvent('thor_adminmenu:server:kick_player', selectedPlayer, KickReason)
            end
        elseif AdminMenu.IsMenuOpened('ban_player') then
            if AdminMenu.Button('Reason:', BanReason) then
                local result = trase.functions.KeyboardInput("Ban Reason", "", 100)
                BanReason = result
                if BanReason == "" then
                    BanReason = "No Reason Specified."
                end
            elseif AdminMenu.ComboBox("Ban Length", BanLength, currBanIndex, selBanIndex, function(currentIndex, selectedIndex)
                currBanIndex = currentIndex
                selBanIndex = currentIndex
                duration = BanLength[currentIndex]
                if duration == "1 Hour" then
                    duration = 3600
                    durationLabel = '1 Hour'
                elseif duration == "3 Hours" then
                    duration = 10800
                    durationLabel = '3 Hours'
                elseif duration == "6 Hours" then
                    duration = 21600
                    durationLabel = '6 Hours'
                elseif duration == "12 Hours" then
                    duration = 43200
                    durationLabel = '12 Hours'
                elseif duration == "1 Day" then
                    duration = 86400
                    durationLabel = '1 Day'
                elseif duration == "2 Days" then
                    duration = 172800
                    durationLabel = '2 Days'
                elseif duration == "3 Days" then
                    duration = 259200
                    durationLabel = '3 Days'
                elseif duration == "1 Week" then
                    duration = 518400
                    durationLabel = '1 Week'
                elseif duration == "2 Weeks" then
                    duration = 1123200
                    durationLabel = '2 Weeks'
                elseif duration == "1 Month" then
                    duration = 2678400
                    durationLabel = '1 Month'
                elseif duration == "Permanent" then
                    duration = 10444633200
                    durationLabel = 'Permanent'
                end
            end) then 
            elseif AdminMenu.Button('Confirm') then
                if BanReason == nil then
                    BanReason = "No Reason Specified."
                end
                local duration = duration
                local durationLabel = durationLabel
                TriggerServerEvent('thor_adminmenu:server:ban_player', selectedPlayer, BanReason, duration, durationLabel)
                AdminMenu.OpenMenu('mainMenu')
            end
        elseif AdminMenu.IsMenuOpened('disconnected_players') then
            for k, v in pairs(discPlayers) do
                targetName = v.name
                targetId = v.id
                if AdminMenu.Button(v.name, '→') then 
                    selectedPlayer = targetId
                    selectedPed = GetPlayerPed(selectedPlayer)
                    Playersteam = v.steam
                    Playerlicense = v.license
                    Playerxbl = v.xbl
                    Playerip = v.ip 
                    Playerdiscord = v.discordid
                    Playerliveid = v.live
                    Playertokens = v.tokens
                    PlayerLeaveReason = v.reason
                    AdminMenu.OpenMenu('disconnected_players_manage')
                end
            end
        elseif AdminMenu.IsMenuOpened('disconnected_players_manage') then
            if AdminMenu.Button('Offline Ban') then 
                AdminMenu.OpenMenu('offline_ban')
            end
            if AdminMenu.Button('View Leave Reason') then 
                trase.functions.notify('~r~Disconnection Reason:~y~\n'..PlayerLeaveReason)
            end
        elseif AdminMenu.IsMenuOpened('offline_ban') then
            if AdminMenu.Button('Reason:', OfflineBanReason) then
                local result = trase.functions.KeyboardInput("Ban Reason", "", 100)
                OfflineBanReason = result
                if OfflineBanReason == "" then
                    OfflineBanReason = "No Reason Specified."
                end
            elseif AdminMenu.ComboBox("Ban Length", BanLength, currBanIndex, selBanIndex, function(currentIndex, selectedIndex)
                currBanIndex = currentIndex
                selBanIndex = currentIndex
                duration = BanLength[currentIndex]
                if duration == "1 Hour" then
                    duration = 3600
                elseif duration == "3 Hours" then
                    duration = 10800
                elseif duration == "6 Hours" then
                    duration = 21600
                elseif duration == "12 Hours" then
                    duration = 43200
                elseif duration == "1 Day" then
                    duration = 86400
                elseif duration == "2 Days" then
                    duration = 172800
                elseif duration == "3 Days" then
                    duration = 259200
                elseif duration == "1 Week" then
                    duration = 518400
                elseif duration == "2 Weeks" then
                        duration = 1123200
                elseif duration == "1 Month" then
                    duration = 2678400
                elseif duration == "Permanent" then
                    duration = 10444633200
                end
            end) then 
            elseif AdminMenu.Button('Confirm') then
                if OfflineBanReason == nil then
                    OfflineBanReason = "No Reason Specified."
                end
                local duration = duration
                TriggerServerEvent('thor_adminmenu:server:offline_ban_player', selectedPlayer, OfflineBanReason, duration, Playersteam, Playerlicense, Playerxbl, Playerip, Playerdiscordid, Playerliveid, Playertokens)
                AdminMenu.OpenMenu('mainMenu')
            end
        elseif AdminMenu.IsMenuOpened('vehicle_options') then
            if canSpawnvehicle then
                if AdminMenu.Button('Spawn Vehicle', '→') then
                    local Input = trase.functions.KeyboardInput("Model", "", 100)
                    local inVeh = IsPedInAnyVehicle(ped, true)
                    if inVeh then
                        trase.functions.Notify('~r~You are already inside of a vehicle')
                    else
                        trase.functions.SpawnCar(Input, ped)
                    end
                end
            end
            if canFixVehicle then
                if AdminMenu.Button('Fix Vehicle') then
                    trase.functions.FixCar()
                end
            end
            if canCleanVehicle then
                if AdminMenu.Button('Clean Vehicle') then
                    trase.functions.CleanCar()
                end
            end
            if canCustomizeLicensePlate then
                if AdminMenu.Button('Change License Plate') then
                    trase.functions.ChangeLicensePlate()
                end
            end
            if canFlipVehicle then
                if AdminMenu.Button('Flip Vehicle') then
                    trase.functions.FlipCar()
                end
            end
        elseif AdminMenu.IsMenuOpened('menu_options') then
            if AdminMenu.ComboBox('Menu X', menuX, currentMenuX, selectedMenuX, 
                function(currentIndex, selectedIndex)
                    currentMenuX = currentIndex
                    selectedMenuX = selectedIndex
                    for i = 1, #menus_list do
                        AdminMenu.SetMenuX(menus_list[i], menuX[currentMenuX])
                    end
                    if AdminMenu.IsItemHovered() then
                        AdminMenu.ToolTip('Change the menu\'s ~b~X Screen Position~s~')
                    end
                end) 
                then
            elseif AdminMenu.ComboBox('Menu Y', menuY, currentMenuY, selectedMenuY, 
                function(currentIndex, selectedIndex)
                    currentMenuY = currentIndex
                    selectedMenuY = selectedIndex
                    for i = 1, #menus_list do
                        AdminMenu.SetMenuY(menus_list[i], menuY[currentMenuY])
                    end
                    if AdminMenu.IsItemHovered() then
                        AdminMenu.ToolTip('Change the menu\'s ~b~X Screen Position~s~')
                    end
                end)
                then
            elseif AdminMenu.Button('Back') then
                AdminMenu.OpenMenu('mainMenu')
            end
        elseif AdminMenu.IsMenuOpened('esx_self_options') then
            if canESXRevive then
                if AdminMenu.Button('Revive', '~y~ESX') then
                    TriggerServerEvent('thor_adminmenu:server:revive_self')
                end
            end
            if canESXGiveItem then
                if AdminMenu.Button('Give Item', '~y~ESX') then
                    local Item = trase.functions.KeyboardInput("Item", "", 100)
                    local Amount = trase.functions.KeyboardInput("Amount", "", 100)
                    TriggerServerEvent('thor_adminmenu:server:esx_give_item', Item, Amount)
                end
            end
            if canForceskin then
                if AdminMenu.Button('Open Skin Menu', '~y~ESX') then
                    TriggerServerEvent('thor_adminmenu:server:skin_menu', 'self')
                    AdminMenu.CloseMenu()
                end
            end
            if canESXAddMoney then
                if AdminMenu.Button('Add Money', '~y~ESX') then
                    local Amount = trase.functions.KeyboardInput("Amount", "", 100)
                    TriggerServerEvent('thor_adminmenu:server:esx_add_money', Amount)
                end
            end
            if canESXAddBank then
                if AdminMenu.Button('Add Money ~b~Bank', '~y~ESX') then
                    local Amount = trase.functions.KeyboardInput("Amount", "", 100)
                    TriggerServerEvent('thor_adminmenu:server:esx_add_bank', Amount)
                end
            end
            if canESXAddDirty then
                if AdminMenu.Button('Add Money ~r~Dirty', '~y~ESX') then
                    local Amount = trase.functions.KeyboardInput("Amount", "", 100)
                    TriggerServerEvent('thor_adminmenu:server:esx_add_dirty', Amount)
                end
            end
            if canESXSetJob then
                if AdminMenu.Button('Set Job', '~y~ESX') then
                    local Job = trase.functions.KeyboardInput("Job", "", 100)
                    local JobGrade = trase.functions.KeyboardInput("Job Grade", "", 100)
                    TriggerServerEvent('thor_adminmenu:server:esx_set_job', Job, JobGrade)
                end
            end
        elseif AdminMenu.IsMenuOpened('esx_player_options') then
            if canESXRevive then
                if AdminMenu.Button('Revive', '~y~ESX') then
                    TriggerServerEvent('thor_adminmenu:server:esx_revive_player', selectedPlayer)
                end
            end
            if canESXGiveItem then
                if AdminMenu.Button('Give Item', '~y~ESX') then
                    local Item = trase.functions.KeyboardInput("Item", "", 100)
                    local Amount = trase.functions.KeyboardInput("Amount", "", 100)
                    TriggerServerEvent('thor_adminmenu:server:esx_give_item_player', selectedPlayer, Item, Amount)
                end
            end
            if canForceskin then
                if AdminMenu.Button('Give Skin Menu', '~y~ESX') then
                    TriggerServerEvent('thor_adminmenu:server:skin_menu', selectedPlayer)
                end
            end
            if canESXAddMoney then
                if AdminMenu.Button('Add Money', '~y~ESX') then
                    local Amount = trase.functions.KeyboardInput("Amount", "", 100)
                    TriggerServerEvent('thor_adminmenu:server:esx_add_money_player', selectedPlayer, Amount)
                end
            end
            if canESXAddBank then
                if AdminMenu.Button('Add Money ~b~Bank', '~y~ESX') then
                    local Amount = trase.functions.KeyboardInput("Amount", "", 100)
                    TriggerServerEvent('thor_adminmenu:server:esx_add_bank_player', selectedPlayer, Amount)
                end
            end
            if canViewMoney then
                if AdminMenu.Button('~p~View~s~ Money', '~y~ESX') then
                    TriggerServerEvent('thor_adminmenu:server:esx_getPlayerMoney', selectedPlayer)
                end
            end
            if canESXAddDirty then
                if AdminMenu.Button('Add Money ~r~Dirty', '~y~ESX') then
                    local Amount = trase.functions.KeyboardInput("Amount", "", 100)
                    TriggerServerEvent('thor_adminmenu:server:esx_add_dirty_player', selectedPlayer, Amount)
                end
            end
            if canESXSetJob then
                if AdminMenu.Button('Set Job', '~y~ESX') then
                    local Job = trase.functions.KeyboardInput("Job", "", 100)
                    local JobGrade = trase.functions.KeyboardInput("Job Grade", "", 100)
                    TriggerServerEvent('thor_adminmenu:server:esx_set_job_player', selectedPlayer, Job, JobGrade)
                end
            end
            if canSetGroup then
                if AdminMenu.ComboBox("Group", PlayerGroups, currGroupIndex, selGroupIndex, function(currentIndex, selectedIndex)
					currGroupIndex = currentIndex
					selGroupIndex = currentIndex
					chosengroup = PlayerGroups[currentIndex]
				end) then 

                elseif AdminMenu.Button('~g~Confirm Group Set') then
					local player = GetPlayerServerId(selectedPlayer)
					local group = chosengroup
					
					TriggerServerEvent('trase:server:setgroup', selectedPlayer, group)
					AdminMenu.OpenMenu('esx_self_options')
				end
            end
        end
        AdminMenu.Display()

        while noclipSpeed == nil do
            Wait(4)
        end

        if noclip then
            local NoclipSpeed = noclipSpeed
            local isInVehicle = IsPedInAnyVehicle(PlayerPedId(), 0)
            local k = nil
            local x, y, z = nil
            
            if not isInVehicle then
                k = PlayerPedId()
                x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), 2))
            else
                k = GetVehiclePedIsIn(PlayerPedId(), 0)
                x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), 1))
            end
            
            if isInVehicle and GetSeatPedIsIn(PlayerPedId()) ~= -1 then RequestControlOnce(k) end
            
            local dx, dy, dz = GetCamDirection()
            
            
            SetEntityVelocity(k, 0.0001, 0.0001, 0.0001)
            
            if IsDisabledControlPressed(0, 32) then -- MOVE FORWARD
                x = x + NoclipSpeed * dx
                y = y + NoclipSpeed * dy
                z = z + NoclipSpeed * dz
            end
            
            if IsDisabledControlPressed(0, 269) then -- MOVE BACK
                x = x - NoclipSpeed * dx
                y = y - NoclipSpeed * dy
                z = z - NoclipSpeed * dz
            end
            
            if IsDisabledControlPressed(0, 22) then -- MOVE UP
                z = z + NoclipSpeed
            end
            
            if IsDisabledControlPressed(0, 36) then -- MOVE DOWN
                z = z - NoclipSpeed
            end
            
            SetEntityCoordsNoOffset(k, x, y, z, true, true, true)
        end
        Wait(0)
    end
end)

RegisterNetEvent("thor_adminmenu:client:Freeze_Player", function()
    local playerPed = PlayerPedId()
    trase.functions.FreezePlayer(playerPed)
end)

RegisterNetEvent("thor_adminmenu:client:set_health", function(amount)
    local playerPed = PlayerPedId()
    SetEntityHealth(playerPed, amount)
end)

RegisterNetEvent("thor_adminmenu:client:set_armor", function(amount)
    local playerPed = PlayerPedId()
    SetPedArmour(playerPed, amount)
end)

RegisterNetEvent("thor_adminmenu:client:create_vehicle")
AddEventHandler("thor_adminmenu:client:create_vehicle", function(car, target)
    trase.functions.SpawnCar(car, target)
end)

function OpenAdminMenu()
	if AdminMenu.IsAnyMenuOpened() then return end

    TriggerServerEvent('thor_adminmenu:server:getPlayers')
	AdminMenu.OpenMenu('mainMenu')
    AdminMenu.SetSubTitle('mainMenu', 'Twizzy AdminMenu')
end

CreateThread(function()
    while adminmenu_enabledkey == nil or adminmenu_openCommand == nil do
        Wait(4)
    end
    
    if adminmenu_openCommand then
        RegisterCommand(OpenCommand, function()
            if canOpenMenu then
                OpenAdminMenu()
            end
        end)
    end
    
    if adminmenu_enabledkey then
        CreateThread(function()
            while (true) do
                local pressed = IsControlJustPressed(0, adminmenu_openkey)
                if pressed and canOpenMenu then
                    OpenAdminMenu()
                end
                Wait(4)
            end
        end)
    end
end)