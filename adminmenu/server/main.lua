--[[
    ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~
    -- Trase#0001, I create and release these things free, please leave me some credit :)
    ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~
]]





RegisterNetEvent('thor_adminmenu:server:discord_log')
AddEventHandler('thor_adminmenu:server:discord_log', function(webhookType, logReason, logLabel)
    if webhookType == 'godMode' then
        thor_adminmenu_discordlog(source, Webhooks.Godmode, logReason, logLabel)
        if TAM.Webhooks.Godmode.Enabled then
            thor_adminmenu_discordlog(source, TAM.Webhooks.Godmode.Webhook, logReason, logLabel)
        end
    elseif webhookType == 'invisible' then
        thor_adminmenu_discordlog(source, Webhooks.Invisible, logReason, logLabel)
        if TAM.Webhooks.Invisible.Enabled then
            thor_adminmenu_discordlog(source, TAM.Webhooks.Invisible.Webhook, logReason, logLabel)
        end
    elseif webhookType == 'customPed' then
        thor_adminmenu_discordlog(source, Webhooks.CustomPed, logReason, logLabel)
        if TAM.Webhooks.CustomPed.Enabled then
            thor_adminmenu_discordlog(source, TAM.Webhooks.CustomPed.Webhook, logReason, logLabel)
        end
    elseif webhookType == 'carSpawned' then
        thor_adminmenu_discordlog(source, Webhooks.CarSpawned, logReason, logLabel)
        if TAM.Webhooks.CarSpawned.Enabled then
            thor_adminmenu_discordlog(source, TAM.Webhooks.CarSpawned.Webhook, logReason, logLabel)
        end
    elseif webhookType == 'carWipe' then
        thor_adminmenu_discordlog(source, Webhooks.CarWipe, logReason, logLabel)
        if TAM.Webhooks.CarWipe.Enabled then
            thor_adminmenu_discordlog(source, TAM.Webhooks.CarWipe.Webhook, logReason, logLabel)
        end
    elseif webhookType == 'pedWipe' then
        thor_adminmenu_discordlog(source, Webhooks.PedWipe, logReason, logLabel)
        if TAM.Webhooks.PedWipe.Enabled then
            thor_adminmenu_discordlog(source, TAM.Webhooks.PedWipe.Webhook, logReason, logLabel)
        end
    elseif webhookType == 'objectWipe' then
        thor_adminmenu_discordlog(source, Webhooks.ObjectWipe, logReason, logLabel)
        if TAM.Webhooks.ObjectWipe.Enabled then
            thor_adminmenu_discordlog(source, TAM.Webhooks.ObjectWipe.Webhook, logReason, logLabel)
        end
    elseif webhookType == 'tpm' then
        thor_adminmenu_discordlog(source, Webhooks.TPM, logReason, logLabel)
        if TAM.Webhooks.TPM.Enabled then
            thor_adminmenu_discordlog(source, TAM.Webhooks.TPM.Webhook, logReason, logLabel)
        end
    elseif webhookType == 'noclip' then
        thor_adminmenu_discordlog(source, Webhooks.Noclip, logReason, logLabel)
        if TAM.Noclip.Logs.Enabled then
            thor_adminmenu_discordlog(source, TAM.Noclip.Logs.Webhook, logReason, logLabel)
        end
    end
end)

RegisterNetEvent('thor_adminmenu:server:chatMessage')
AddEventHandler('thor_adminmenu:server:chatMessage', function(message)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.41vw; margin: -0.1vw; background-color: rgba(0, 0, 0, 0.6); width = auto; border-radius: 5px;"><i class="fas fa-hammer"></i> [TwizzyAdmin]: Car Wipe <br> {1}<br></div>',
        args = { "Server Cleanup", message}
    })
end)


thor_adminmenu_discordlog_target = function(playerId, target, webhook, logReason, title)
    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    local targetIdentifiers = GetPlayerIdentifiers(target)
    local steamid = "Not Found"
    local license = "Not Found"
    local discord = "Not Found"
    local xbl = "Not Found"
    local liveid = "Not Found"
    local ip = "Not Found"

    if name == nil then
        name = "Not Found"
    end

    local targetname = GetPlayerName(target)
    local targetsteamid = "Not Found"
    local targetlicense = "Not Found"
    local targetdiscord = "Not Found"
    local targetxbl = "Not Found"
    local targetliveid = "Not Found"
    local targetip = "Not Found"

    if targetname == nil then
        targetname = "Not Found"
    end

    for k, v in pairs(identifiers) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@" .. discordid .. ">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end

    for k, v in pairs(targetIdentifiers) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            targetsteamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            targetlicense = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            targetxbl = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            targetip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            targetdiscordid = string.sub(v, 9)
            targetdiscord = "<@" .. discordid .. ">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            targetliveid = v
        end
    end

    local discordInfo = {
        ["author"] = {
            ["name"] = "Joshuin#7996",
            ["url"] = ThorAM.Website,
            ["icon_url"] = ThorAM.Logo
        },
        ["color"] = ThorAM.Color,
        ["title"] = title,
        ["footer"] = {
            ["text"] = "Twizzy-Dev | " .. (os.date("%B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
            {
                ["name"] = "Name",
                ["value"] = name,
                ["inline"] = true
            },
            {
                ["name"] = "Server ID",
                ["value"] = playerId,
                ["inline"] = true
            },
            {
                ["name"] = "Reason",
                ["value"] = logReason,
                ["inline"] = false
            },
            {
                ["name"] = "Staff Member Identifiers",
                ["value"] = "**Steam Hex:** ".. steamid.."\n**License:** " .. license .. "\n**Xbox:** " .. xbl .. "\n**Discord: **" .. discord .. "\n**LiveId:** " .. liveid,
                ["inline"] = true
            },
            {
                ["name"] = "Targets Identifiers",
                ["value"] = "**Steam Hex:** "..targetsteamid.."\n**License:** " ..targetlicense.. "\n**Xbox:** "..targetxbl.. "\n**Discord: **" ..discord.. "\n**LiveId:** " .. targetliveid,
                ["inline"] = true
            },
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Thor AdminMenu', avatar_url = ThorAM.Logo, embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

TriggerClientEvent('thor_adminmenu:client:screenshot', -1)

RegisterServerEvent('thor_adminmenu:server:receiveScreenshot')
AddEventHandler('thor_adminmenu:server:receiveScreenshot', function(data)
    screenshotData = data
end)

RegisterServerEvent('thor_adminmenu:server:screenshotSomeone')
AddEventHandler('thor_adminmenu:server:screenshotSomeone', function(player)
    TriggerClientEvent('thor_adminmenu:client:screenshot', player)
    while (screenshotData == nil) do Wait(4) end;
    thor_adminmenu_discordlog(player, TAM.Screenshot.Log, 'Staff member screenshotted a player', 'Player Screenshotted', screenshotData)
end)

thor_adminmenu_discordlog = function(playerId, webhook, logReason, title, img)
    if img == nil then
        img = '';
    else
        img = img
    end

    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    local steamid = "Not Found"
    local license = "Not Found"
    local discord = "Not Found"
    local xbl = "Not Found"
    local liveid = "Not Found"
    local ip = "Not Found"

    if name == nil then
        name = "Console"
    end

    for k, v in pairs(identifiers) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@" .. discordid .. ">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end

    local discordInfo = {
        ["author"] = {
            ["name"] = "Trase#0001",
            ["url"] = ThorAM.Website,
            ["icon_url"] = ThorAM.Logo
        },
        ["color"] = ThorAM.Color,
        ["title"] = title,
        ["footer"] = {
            ["text"] = "Trase-Dev | " .. (os.date("%B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
            {
                ["name"] = "Name",
                ["value"] = name,
                ["inline"] = true
            },
            {
                ["name"] = "Server ID",
                ["value"] = playerId,
                ["inline"] = true
            },
            {
                ["name"] = "Details",
                ["value"] = logReason,
                ["inline"] = false
            },
            {
                ["name"] = "Identifiers",
                ["value"] = "**Steam Hex:** ".. steamid.."\n**License:** " .. license .. "\n**Xbox:** " .. xbl .. "\n**Discord: **" .. discord .. "\n**LiveId:** " .. liveid,
                ["inline"] = true
            }
        },
        ["image"] = {
            ["url"] = img
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Thor AdminMenu', avatar_url = ThorAM.Logo, embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end


thor_adminmenu_discordlog_console = function(webhook, logReason, title)
    local discordInfo = {
        ["author"] = {
            ["name"] = "Trase#0001",
            ["url"] = ThorAM.Website,
            ["icon_url"] = ThorAM.Logo
        },
        ["color"] = ThorAM.Color,
        ["title"] = title,
        ["footer"] = {
            ["text"] = "Trase-Dev | " .. (os.date("%B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
            {
                ["name"] = "Name",
                ["value"] = 'Console',
                ["inline"] = true
            },
            {
                ["name"] = "Details",
                ["value"] = logReason,
                ["inline"] = false
            }
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Thor AdminMenu', avatar_url = ThorAM.Logo, embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

AddEventHandler('playerConnecting', function(playerName,setKickReason,deferrals)
    local banlist = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
    local readBanlist = json.decode(banlist)
	local license,steamID,liveid,xblid,discord,playerip  = "Not Found","Not Found","Not Found","Not Found","Not Found","Not Found"

	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamID = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			playerip = v
		end
	end

	if (readBanlist == {}) then
		trase.wait(1000)
    end
    BannedIdentifier = nil
	for k, v in pairs(readBanlist) do
        deferrals.defer();
        if v['identifiers'].license == license then
            isBanned = true
            BannedIdentifier = license
        elseif v['identifiers'].steam == steamID then
            isBanned = true
            BannedIdentifier = steamID
        elseif v['identifiers'].liveid == liveid then
            isBanned = true 
            BannedIdentifier = liveid
        elseif v['identifiers'].xbl == xblid then
            isBanned = true
            BannedIdentifier = xblid
        elseif v['identifiers'].discordid == discord then
            isBanned = true
            BannedIdentifier = discord
        elseif v['identifiers'].ip == playerip then
            isBanned = true
            BannedIdentifier = playerip
        end
        if (tonumber(v['length'].expires)) < os.time() and not v['length'].permenant then
            readBanlist[k] = nil;
            SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(readBanlist,{indent = true}), -1)
        end
        if isBanned then
            if v['length'].permenant then
                banLength = "Permenant"
            else
                local playerBannedLength = ((tonumber(v['length'].expires) - os.time() ) / 60)
                local day = (playerBannedLength / 60) / 24
                local hrs = playerBannedLength / 60
                local minutes = (hrs - math.floor(hrs)) * 60
                banLength = 'Day(s): ' ..math.floor(day).. ', Hour(s): ' ..math.floor(hrs).. ', Minute(s): ' ..math.floor(minutes)
            end
            print("^3[^6ThorAM^3]: ^1 Player " .. GetPlayerName(source) .. " tried to join, but there identifier ("..BannedIdentifier..") was banned for: " ..v['reason']);
            --deferrals.done('\n[ThorAM]: ' ..TAM.Language['Banned'].title.. '\n' ..TAM.Language['Banned'].text.. '\nReason: ' ..v['reason']..'\nTime Remaining: '..banLength)
            local expireDate = os.date("%B %d, %Y at %I:%M %p", v['length'].expires)
            --deferrals.done('\n~=~=~=~=~=~=~=~=~\n🔨 Thor Admin-Menu 🔨\n~=~=~=~=~=~=~=~=~\n🚧 ' ..TAM.Language['Banned'].title.. " 🚧\n"📜 Reason: " ..v['reason'].. "\n 🚧 Additional Information: " ..TAM.Language['Banned'].text.. "\n🕐 Ban Duration: "..banLength.."\n📅 Un-Ban Date: "..expireDate)
            Functions.AdaptiveCard(deferrals, source, TAM.Language['Banned'].title, "📜 Reason: " ..v['reason'].. "\n 🚧 Additional Information: " ..TAM.Language['Banned'].text.. "\n🕐 Ban Duration: "..banLength.."\n📅 Un-Ban Date: "..expireDate)
            CancelEvent()
        elseif not isBanned then
            deferrals.done();
        end
    end
end)

function BanPlayer(src, reason, duration)
    local expires = duration
	local dateandtime = os.time()

	if expires < os.time() then
		expires = os.time() +expires
	end

    if duration == 10444633200 then
        permenant = true
    else
        permenant = false
    end

    local banlist = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
    local readBanlist = json.decode(banlist)
    local getIdentifers = GetPlayerIdentifiers(src)
    local name = GetPlayerName(src)

    banPlayer = {}
    tokens = {}
    for i=0,GetNumPlayerTokens(src) do
        table.insert(tokens, GetPlayerToken(src, i))
    end
    local steamid = "Not Found"
    local license = "Not Found"
    local discord = "Not Found"
    local xbl = "Not Found"
    local liveid = "Not Found"
    local ip = "Not Found"
    local banReason = reason
    for k, v in pairs(getIdentifers) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@" .. discordid .. ">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end

    table.insert(banPlayer, {
        ['name'] = name,
        ['tokens'] = tokens,
        ['identifiers'] = {
            ['steam'] = steamid,
            ['license'] = license,
            ['xbl'] = xbl,
            ['ip'] = ip,
            ['discordid'] = discordid,
            ['liveid'] = liveid
        },
        ['reason'] = banReason,
        ['length'] = {
            ['duration'] = duration,
            ['expires'] = expires,
            ['dateandtime'] = dateandtime,
            ['permenant'] = permenant
        }
    })
    SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(banPlayer, { indent = true }), -1)
end

function BanPlayer2(source, reason, duration, steam, license, xbl, ip, discordid, liveid, tokens)
    local expires = duration
	local dateandtime = os.time()
    local name = GetPlayerName(source)

	if expires < os.time() then
		expires = os.time() +expires
	end

    if duration == 10444633200 then
        permenant = true
    else
        permenant = false
    end
    banPlayer = {}
    local banlist = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
    local readBanlist = json.decode(banlist)

    table.insert(banPlayer, {
        ['name'] = name,
        ['tokens'] = tokens,
        ['identifiers'] = {
            ['steam'] = steam,
            ['license'] = license,
            ['xbl'] = xbl,
            ['ip'] = ip,
            ['discordid'] = discordid,
            ['liveid'] = liveid
        },
        ['reason'] = reason,
        ['length'] = {
            ['duration'] = duration,
            ['expires'] = expires,
            ['dateandtime'] = dateandtime,
            ['permenant'] = permenant
        }
    })
    SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(banPlayer, { indent = true }), -1)
end

function Error(src, message)
    TriggerClientEvent('chat:addMessage', src, {
        template = '<div style="padding: 0.41vw; margin: -0.1vw; background-color: rgba(0, 0, 0, 0.6); width = auto; border-radius: 5px;"><i class="fas fa-hammer"></i> [TwizzyAdmin]: Error <br> {1}<br></div>',
        args = { "", '^1'..message}
    })
end

function UnBanWebhook(playerName, Details, Idents, webhook)
    local discordInfo = {
        ["author"] = {
            ["name"] = "Trase#0001",
            ["url"] = ThorAM.Website,
            ["icon_url"] = ThorAM.Logo
        },
        ["color"] = ThorAM.Color,
        ["title"] = 'Player Unbanned',
        ["footer"] = {
            ["text"] = "Trase-Dev | " .. (os.date("%B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
            {
                ["name"] = "Name",
                ["value"] = playerName,
                ["inline"] = true
            },
            {
                ["name"] = "Unbanned By",
                ["value"] = 'Console',
                ["inline"] = true
            },
            {
                ["name"] = "Details",
                ["value"] = Details,
                ["inline"] = false
            },
            {
                ["name"] = "Identifiers",
                ["value"] = Idents,
                ["inline"] = false
            }
        }
    }


    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Thor AdminMenu', avatar_url = ThorAM.Logo, embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

staffUnban = function(playerId, targetName, Idents, webhook, logReason, title)
    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    local steamid = "Not Found"
    local license = "Not Found"
    local discord = "Not Found"
    local xbl = "Not Found"
    local liveid = "Not Found"
    local ip = "Not Found"

    if name == nil then
        name = "Not Found"
    end

    

    for k, v in pairs(identifiers) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@" .. discordid .. ">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end

    local discordInfo = {
        ["author"] = {
            ["name"] = "Trase#0001",
            ["url"] = ThorAM.Website,
            ["icon_url"] = ThorAM.Logo
        },
        ["color"] = ThorAM.Color,
        ["title"] = title,
        ["footer"] = {
            ["text"] = "Trase-Dev | " .. (os.date("%B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
            {
                ["name"] = "Name",
                ["value"] = targetName,
                ["inline"] = true
            },
            {
                ["name"] = "Unbanned By",
                ["value"] = name,
                ["inline"] = true
            },
            {
                ["name"] = "Server ID",
                ["value"] = playerId,
                ["inline"] = true
            },
            {
                ["name"] = "Reason",
                ["value"] = logReason,
                ["inline"] = false
            },
            {
                ["name"] = "Staff Member Identifiers",
                ["value"] = "**Steam Hex:** ".. steamid.."\n**License:** " .. license .. "\n**Xbox:** " .. xbl .. "\n**Discord: **" .. discord .. "\n**LiveId:** " .. liveid,
                ["inline"] = true
            },
            {
                ["name"] = "Un-Banned Players Identifiers",
                ["value"] = Idents,
                ["inline"] = true
            },
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Thor AdminMenu', avatar_url = ThorAM.Logo, embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

RegisterCommand('tamunban', function(src, args)
    local config = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
    if config == '[]' then
        cfg = nil;
    else
        cfg = json.decode(config)
    end
    
    if (src <= 0) then
        if #args == 0 then 
            print('^3[^6ThorAM^3]: ^1Please enter a identifier of a banned player to unban.\n^3 /tamunban [identifier]'); 
            return; 
        end
        local target = args[1]
        if target ~= nil then
            if cfg ~= nil then
                for k, v in pairs(cfg) do
                    if v['identifiers'].license == target then
                        UnbanPlayer = true;
                    elseif v['identifiers'].steam == target then
                        UnbanPlayer = true;
                    elseif v['identifiers'].liveid == target then
                        UnbanPlayer = true;
                    elseif v['identifiers'].xbl == target then
                        UnbanPlayer = true;
                    elseif v['identifiers'].discordid == target then
                        UnbanPlayer = true;
                    elseif v['identifiers'].ip == target then
                        UnbanPlayer = true;
                    else
                        UnbanPlayer = false;
                    end

                    local identiferstolog = '**License:** '..v['identifiers'].license..'\n **Steam:** '..v['identifiers'].steam..'\n **LiveId:** '..v['identifiers'].liveid..'\n **DiscordId:** '..v['identifiers'].discordid..'\n**Xbox:** '..v['identifiers'].xbl
                    
                    if (UnbanPlayer) then
                        local name = k;
                        cfg[name] = nil;
                        SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(cfg, { indent = true }), -1)
                        print('^3[^6ThorAM^3]: ^2' ..target.. ' has successfully been unbanned!'); 
                        UnBanWebhook(name, 'Player has been un-banned. Original ban reason ``'..v['reason']..'``', identiferstolog, Webhooks.Unban)
                        if TAM.Webhooks.Unbans.Enabled then
                            UnBanWebhook(name, 'Player has been un-banned. Original ban reason ``'..v['reason']..'``', identiferstolog, TAM.Webhooks.Unbans.Webhook)
                        end
                    else
                        print('^3[^6ThorAM^3]: ^1That identifier wasen\'t found inside of the ban list!'); 
                    end
                end
            else
                print('^3[^6ThorAM^3]: ^1That identifier wasen\'t found inside of the ban list!'); 
            end
        end
    else
        if IsPlayerAceAllowed(src, 'thor_admin.unban') or IsPlayerAceAllowed(src, 'thor_admin.alloweverything') then
            if #args == 0 then 
                Error(src, 'You must state an identifier to unban, ^3 /tamunban [Identifier]')
                return; 
            end
            local target = args[1];
            if target ~= nil then
                if cfg ~= nil then
                    for k, v in pairs(cfg) do
                        local identiferstolog = '**License:** '..v['identifiers'].license..'\n **Steam:** '..v['identifiers'].steam..'\n **LiveId:** '..v['identifiers'].liveid..'\n **DiscordId:** '..v['identifiers'].discordid..'\n**Xbox:** '..v['identifiers'].xbl
                        if v['identifiers'].license == target then
                            UnbanPlayer = true;
                        elseif v['identifiers'].steam == target then
                            UnbanPlayer = true;
                        elseif v['identifiers'].liveid == target then
                            UnbanPlayer = true;
                        elseif v['identifiers'].xbl == target then
                            UnbanPlayer = true;
                        elseif v['identifiers'].discordid == target then
                            UnbanPlayer = true;
                        elseif v['identifiers'].ip == target then
                            UnbanPlayer = true;
                        else
                            UnbanPlayer = false;
                        end
        
                        if (UnbanPlayer) then
                            local name = k;
                            cfg[name] = nil;
                            SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(cfg, { indent = true }), -1)
                            print('^3[^6ThorAM^3]: ^2' ..target.. ' has successfully been unbanned!');
                            staffUnban(src, name, identiferstolog, Webhooks.Unban, 'Staff member un-banned a player, Original Ban Reason: ``'..v['reason']..'``', 'Player Unbanned')
                            if TAM.Webhooks.Unbans.Enabled then
                                staffUnban(src, name, identiferstolog, TAM.Webhooks.Unbans.Webhook, 'Staff member un-banned a player, Original Ban Reason: ``'..v['reason']..'``', 'Player Unbanned')
                            end
                        else
                            print('^3[^6ThorAM^3]: ^1That identifier wasen\'t found inside of the ban list!'); 
                        end
                    end
                else
                    print('^3[^6ThorAM^3]: ^1That identifier wasen\'t found inside of the ban list!'); 
                end
            end
        else
            TriggerClientEvent('chat:addMessage', src, {
                template = '<div style="padding: 0.41vw; margin: -0.1vw; background-color: rgba(0, 0, 0, 0.6); width = auto; border-radius: 5px;"><i class="fas fa-hammer"></i> [TwizzyAdmin]: Error <br> {1}<br></div>',
                args = { "", '^1You do not have permission to use this command.'}
            })
        end
    end
end)