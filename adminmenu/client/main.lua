--[[
 ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~~=~=~=~=~=~=~=~~=~=~=~=~=~=~=~~=~=
    -- Johnksm, I create and release these thing for free so as to help someone who is not able to pay for an admin menu.
 ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~~=~=~=~=~=~=~=~~=~=~=~=~=~=~=~~=~=
]]








trase = {}

TriggerServerEvent('thor_adminmenu:server:getScreenshot')

SCResource = nil;
RegisterNetEvent("thor_adminmenu:client:getScreenshot")
AddEventHandler("thor_adminmenu:client:getScreenshot", function(screenshotEnabled, screenshotResource)
	SCResource = screenshotResource
end)

RegisterNetEvent("thor_adminmenu:client:gotoPlayer")
AddEventHandler("thor_adminmenu:client:gotoPlayer", function(target)
	TriggerServerEvent('thor_adminmenu:server:goto_player', target)
end)

RegisterNetEvent("thor_adminmenu:client:bringPlayer")
AddEventHandler("thor_adminmenu:client:bringPlayer", function(target)
	TriggerServerEvent('thor_adminmenu:server:bring_player', target)
end)

RegisterNetEvent("thor_adminmenu:client:freezePlayer")
AddEventHandler("thor_adminmenu:client:freezePlayer", function(target)
	frozen = not frozen
	TriggerServerEvent('thor_adminmenu:server:freeze_player', target)
	if frozen then
		TriggerServerEvent('thor_adminmenu:server:freeze_player_logs', target)
	end
end)


CreateThread(function()
	RegisterNetEvent("thor_adminmenu:client:screenshot")
	AddEventHandler("thor_adminmenu:client:screenshot", function(url)
		while (SCResource == nil) do Wait(4) end; 
		print(SCResource)
		local webhook = 'https://discord.com/api/webhooks/921644318614228992/gs4pkJn7YzxgN4gYi2htLkOx-5lfE8chG94E-reaqAMYB4Ou2mwIZW0cdddPIOqbax56'
		exports[SCResource]:requestScreenshotUpload(webhook, "files[]", function(data)
			local image = json.decode(data)
			TriggerServerEvent('thor_adminmenu:server:receiveScreenshot', image.attachments[1].proxy_url)
		end)
	end)
end)


AdminMenu = { }
AdminMenu.__index = AdminMenu

-- Deprecated
AdminMenu.debug = false
function AdminMenu.SetDebugEnabled(enabled)
end
function AdminMenu.IsDebugEnabled()
	return false
end
---

local menus = { }
local keys = { 
	down = 187, 
	down2 = 14, 
	up = 188, 
	up2 = 15, 
	left = 189, 
	right = 190, 
	select = 191, 
	back = 194 
}
local optionCount = 0

local currentKey = nil
local currentMenu = nil

local toolTipWidth = 0.153

local spriteWidth = 0.027
local spriteHeight = spriteWidth * GetAspectRatio()

local titleHeight = 0.101
local titleYOffset = 0.021
local titleFont = 1
local titleScale = 1.0

local buttonHeight = 0.038
local buttonFont = 0
local buttonScale = 0.365
local buttonTextXOffset = 0.005
local buttonTextYOffset = 0.005
local buttonSpriteXOffset = 0.002
local buttonSpriteYOffset = 0.005

local defaultStyle = {
	x = 0.375,
	y = 0.125,
	width = 0.23,
	maxOptionCountOnScreen = 15,
	titleColor = { 255, 255, 255, 255 },
	titleBackgroundColor = { 0, 0, 0, 200 },
	titleBackgroundSprite = nil,
	subTitleColor = { 255, 255, 255, 255 },
	textColor = { 255, 255, 255, 255 },
	subTextColor = { 189, 189, 189, 255 },
	focusTextColor = { 0, 0, 0, 255 },
	focusColor = { 245, 245, 245, 255 },
	backgroundColor = { 0, 0, 0, 160 },
	subTitleBackgroundColor = { 0, 0, 0, 200 },
	buttonPressedSound = { name = 'SELECT', set = 'HUD_FRONTEND_DEFAULT_SOUNDSET' }, --https://pastebin.com/0neZdsZ5
}

CreateThread(function()
	local runtime = CreateRuntimeTxd("AdminMenu")
	local image = CreateDui("PUT YOUR IMAGE LINK HERE", 400, 90)
	local dui = GetDuiHandle(image)
	local texture = CreateRuntimeTextureFromDuiHandle(runtime, "admin_menu", dui)
end)

local function setMenuProperty(id, property, value)
	if not id then
		return
	end

	local menu = menus[id]
	if menu then
		menu[property] = value
	end
end

local function setStyleProperty(id, property, value)
	if not id then
		return
	end

	local menu = menus[id]

	if menu then
		if not menu.overrideStyle then
			menu.overrideStyle = { }
		end

		menu.overrideStyle[property] = value
	end
end

local function getStyleProperty(property, menu)
	menu = menu or currentMenu

	if menu.overrideStyle then
		local value = menu.overrideStyle[property]
		if value then
			return value
		end
	end

	return menu.style and menu.style[property] or defaultStyle[property]
end

local function copyTable(t)
	if type(t) ~= 'table' then
		return t
	end

	local result = { }
	for k, v in pairs(t) do
		result[k] = copyTable(v)
	end

	return result
end

local function setMenuVisible(id, visible, holdCurrentOption)
	if currentMenu then
		if visible then
			if currentMenu.id == id then
				return
			end
		else
			if currentMenu.id ~= id then
				return
			end
		end
	end

	if visible then
		local menu = menus[id]

		if not currentMenu then
			menu.currentOption = 1
		else
			if not holdCurrentOption then
				menus[currentMenu.id].currentOption = 1
			end
		end

		currentMenu = menu
	else
		currentMenu = nil
	end
end

local function setTextParams(font, color, scale, center, shadow, alignRight, wrapFrom, wrapTo)
	SetTextFont(font)
	SetTextColour(color[1], color[2], color[3], color[4] or 255)
	SetTextScale(scale, scale)

	if shadow then
		SetTextDropShadow()
	end

	if center then
		SetTextCentre(true)
	elseif alignRight then
		SetTextRightJustify(true)
	end

	if not wrapFrom or not wrapTo then
		wrapFrom = wrapFrom or getStyleProperty('x')
		wrapTo = wrapTo or getStyleProperty('x') + getStyleProperty('width') - buttonTextXOffset
	end

	SetTextWrap(wrapFrom, wrapTo)
end

local function getLinesCount(text, x, y)
	BeginTextCommandLineCount('TWOSTRINGS')
	AddTextComponentString(tostring(text))
	return EndTextCommandGetLineCount(x, y)
end

local function drawText(text, x, y)
	BeginTextCommandDisplayText('TWOSTRINGS')
	AddTextComponentString(tostring(text))
	EndTextCommandDisplayText(x, y)
end

local function drawRect(x, y, width, height, color)
	DrawRect(x, y, width, height, color[1], color[2], color[3], color[4] or 255)
end

local function getCurrentIndex()
	if currentMenu.currentOption <= getStyleProperty('maxOptionCountOnScreen') and optionCount <= getStyleProperty('maxOptionCountOnScreen') then
		return optionCount
	elseif optionCount > currentMenu.currentOption - getStyleProperty('maxOptionCountOnScreen') and optionCount <= currentMenu.currentOption then
		return optionCount - (currentMenu.currentOption - getStyleProperty('maxOptionCountOnScreen'))
	end

	return nil
end

local function drawTitle()
	local x = getStyleProperty('x') + getStyleProperty('width') / 2
	local y = getStyleProperty('y') + titleHeight / 2

	if getStyleProperty('titleBackgroundSprite') then
		DrawSprite(getStyleProperty('titleBackgroundSprite').dict, getStyleProperty('titleBackgroundSprite').name, x, y, getStyleProperty('width'), titleHeight, 0., 255, 255, 255, 255)
	else
		drawRect(x, y, getStyleProperty('width'), titleHeight, getStyleProperty('titleBackgroundColor'))
	end

	if currentMenu.title then
		setTextParams(titleFont, getStyleProperty('titleColor'), titleScale, true)
		drawText(currentMenu.title, x, y - titleHeight / 2 + titleYOffset)
	end
end

local function drawSubTitle()
	local x = getStyleProperty('x') + getStyleProperty('width') / 2
	local y = getStyleProperty('y') + titleHeight + buttonHeight / 2

	drawRect(x, y, getStyleProperty('width'), buttonHeight, getStyleProperty('subTitleBackgroundColor'))

	setTextParams(buttonFont, getStyleProperty('subTitleColor'), buttonScale, false)
	drawText(currentMenu.subTitle, getStyleProperty('x') + buttonTextXOffset, y - buttonHeight / 2 + buttonTextYOffset)

	if optionCount > getStyleProperty('maxOptionCountOnScreen') then
		setTextParams(buttonFont, getStyleProperty('subTitleColor'), buttonScale, false, false, true)
		drawText(tostring(currentMenu.currentOption)..' / '..tostring(optionCount), getStyleProperty('x') + getStyleProperty('width'), y - buttonHeight / 2 + buttonTextYOffset)
	end
end

local function drawButton(text, subText)
	local currentIndex = getCurrentIndex()
	if not currentIndex then
		return
	end

	local backgroundColor = nil
	local textColor = nil
	local subTextColor = nil
	local shadow = false

	if currentMenu.currentOption == optionCount then
		backgroundColor = getStyleProperty('focusColor')
		textColor = getStyleProperty('focusTextColor')
		subTextColor = getStyleProperty('focusTextColor')
	else
		backgroundColor = getStyleProperty('backgroundColor')
		textColor = getStyleProperty('textColor')
		subTextColor = getStyleProperty('subTextColor')
		shadow = true
	end

	local x = getStyleProperty('x') + getStyleProperty('width') / 2
	local y = getStyleProperty('y') + titleHeight + buttonHeight + (buttonHeight * currentIndex) - buttonHeight / 2

	drawRect(x, y, getStyleProperty('width'), buttonHeight, backgroundColor)

	setTextParams(buttonFont, textColor, buttonScale, false, shadow)
	drawText(text, getStyleProperty('x') + buttonTextXOffset, y - (buttonHeight / 2) + buttonTextYOffset)

	if subText then
		setTextParams(buttonFont, subTextColor, buttonScale, false, shadow, true)
		drawText(subText, getStyleProperty('x') + buttonTextXOffset, y - buttonHeight / 2 + buttonTextYOffset)
	end
end

menus_list = { }

function AdminMenu.CreateMenu(id, title, subTitle, style)
	table.insert(menus_list, id)
	local menu = { }

	-- Members
	menu.id = id
	menu.previousMenu = nil
	menu.currentOption = 1
	menu.title = title
	menu.subTitle = subTitle and string.upper(subTitle) or 'INTERACTION MENU'

	-- Style
	if style then
		menu.style = style
	end

	menus[id] = menu
end

function AdminMenu.CreateSubMenu(id, parent, subTitle, style)
	local parentMenu = menus[parent]
	if not parentMenu then
		return
	end

	AdminMenu.CreateMenu(id, parentMenu.title, subTitle and string.upper(subTitle) or parentMenu.subTitle)

	local menu = menus[id]

	menu.previousMenu = parent

	if parentMenu.overrideStyle then
		menu.overrideStyle = copyTable(parentMenu.overrideStyle)
	end

	if style then
		menu.style = style
	elseif parentMenu.style then
		menu.style = copyTable(parentMenu.style)
	end
end

function AdminMenu.CurrentMenu()
	return currentMenu and currentMenu.id or nil
end

function AdminMenu.OpenMenu(id)
	if id and menus[id] then
		PlaySoundFrontend(-1, 'SELECT', 'HUD_FRONTEND_DEFAULT_SOUNDSET', true)
		setMenuVisible(id, true)
	end
end

function AdminMenu.IsMenuOpened(id)
	return currentMenu and currentMenu.id == id
end
AdminMenu.Begin = AdminMenu.IsMenuOpened

function AdminMenu.IsAnyMenuOpened()
	return currentMenu ~= nil
end

function AdminMenu.IsMenuAboutToBeClosed()
	return false
end

function AdminMenu.CloseMenu()
	if currentMenu then
		setMenuVisible(currentMenu.id, false)
		optionCount = 0
		currentKey = nil
		PlaySoundFrontend(-1, 'QUIT', 'HUD_FRONTEND_DEFAULT_SOUNDSET', true)
	end
end

function AdminMenu.ToolTip(text, width, flipHorizontal)
	if not currentMenu then
		return
	end

	local currentIndex = getCurrentIndex()
	if not currentIndex then
		return
	end

	width = width or toolTipWidth

	local x = nil
	if not flipHorizontal then
		x = getStyleProperty('x') + getStyleProperty('width') + width / 2 + buttonTextXOffset
	else
		x = getStyleProperty('x') - width / 2 - buttonTextXOffset
	end

	local textX = x - (width / 2) + buttonTextXOffset
	setTextParams(buttonFont, getStyleProperty('textColor'), buttonScale, false, true, false, textX, textX + width - (buttonTextYOffset * 2))
	local linesCount = getLinesCount(text, textX, getStyleProperty('y'))

	local height = GetTextScaleHeight(buttonScale, buttonFont) * (linesCount + 1) + buttonTextYOffset
	local y = getStyleProperty('y') + titleHeight + (buttonHeight * currentIndex) + height / 2

	drawRect(x, y, width, height, getStyleProperty('backgroundColor'))

	y = y - (height / 2) + buttonTextYOffset
	drawText(text, textX, y)
end

function AdminMenu.Button(text, subText)
	if not currentMenu then
		return
	end

	optionCount = optionCount + 1

	drawButton(text, subText)

	local pressed = false

	if currentMenu.currentOption == optionCount then
		if currentKey == keys.select then
			pressed = true
			PlaySoundFrontend(-1, getStyleProperty('buttonPressedSound').name, getStyleProperty('buttonPressedSound').set, true)
		elseif currentKey == keys.left or currentKey == keys.right then
			PlaySoundFrontend(-1, 'NAV_UP_DOWN', 'HUD_FRONTEND_DEFAULT_SOUNDSET', true)
		end
	end

	return pressed
end

function AdminMenu.SpriteButton(text, dict, name, r, g, b, a)
	if not currentMenu then
		return
	end

	local pressed = AdminMenu.Button(text)

	local currentIndex = getCurrentIndex()
	if not currentIndex then
		return
	end

	if not HasStreamedTextureDictLoaded(dict) then
		RequestStreamedTextureDict(dict)
	end
	DrawSprite(dict, name, getStyleProperty('x') + getStyleProperty('width') - spriteWidth / 2 - buttonSpriteXOffset, getStyleProperty('y') + titleHeight + buttonHeight + (buttonHeight * currentIndex) - spriteHeight / 2 + buttonSpriteYOffset, spriteWidth, spriteHeight, 0., r or 255, g or 255, b or 255, a or 255)

	return pressed
end

function AdminMenu.InputButton(text, windowTitleEntry, defaultText, maxLength, subText)
	if not currentMenu then
		return
	end

	local pressed = AdminMenu.Button(text, subText)
	local inputText = nil

	if pressed then
		DisplayOnscreenKeyboard(1, windowTitleEntry or 'FMMC_MPM_NA', '', defaultText or '', '', '', '', maxLength or 255)

		while true do
			DisableAllControlActions(0)

			local status = UpdateOnscreenKeyboard()
			if status == 2 then
				break
			elseif status == 1 then
				inputText = GetOnscreenKeyboardResult()
				break
			end

			Wait(0)
		end
	end

	return pressed, inputText
end

function AdminMenu.MenuButton(text, id, subText)
	if not currentMenu then
		return
	end

	local pressed = AdminMenu.Button(text, subText)

	if pressed then
		currentMenu.currentOption = optionCount
		setMenuVisible(currentMenu.id, false)
		setMenuVisible(id, true, true)
	end

	return pressed
end

function AdminMenu.CheckBox(text, checked, callback)
	if not currentMenu then
		return
	end

	local name = nil
	if currentMenu.currentOption == optionCount + 1 then
		name = checked and 'shop_box_tickb' or 'shop_box_blankb'
	else
		name = checked and 'shop_box_tick' or 'shop_box_blank'
	end

	local pressed = AdminMenu.SpriteButton(text, 'commonmenu', name)

	if pressed then
		checked = not checked
		if callback then callback(checked) end
	end

	return pressed
end

function AdminMenu.ComboBox(text, items, currentIndex, selectedIndex, callback)
	if not currentMenu then
		return
	end

	local itemsCount = #items
	local selectedItem = items[currentIndex]
	local isCurrent = currentMenu.currentOption == optionCount + 1
	selectedIndex = selectedIndex or currentIndex

	if itemsCount > 1 and isCurrent then
		selectedItem = '← '..tostring(selectedItem)..' →'
	end

	local pressed = AdminMenu.Button(text, selectedItem)

	if pressed then
		selectedIndex = currentIndex
	elseif isCurrent then
		if currentKey == keys.left then
			if currentIndex > 1 then currentIndex = currentIndex - 1 else currentIndex = itemsCount end
		elseif currentKey == keys.right then
			if currentIndex < itemsCount then currentIndex = currentIndex + 1 else currentIndex = 1 end
		end
	end

	if callback then callback(currentIndex, selectedIndex) end
	return pressed, currentIndex
end

function AdminMenu.Display()
	if currentMenu then
		DisableControlAction(0, keys.left, true)
		DisableControlAction(0, keys.up, true)
		DisableControlAction(0, keys.up2, true)
		DisableControlAction(0, keys.down, true)
		DisableControlAction(0, keys.down2, true)
		DisableControlAction(0, keys.right, true)
		DisableControlAction(0, keys.back, true)

		ClearAllHelpMessages()

		drawTitle()
		drawSubTitle()

		currentKey = nil

		if IsDisabledControlJustReleased(0, keys.down) then
			PlaySoundFrontend(-1, 'NAV_UP_DOWN', 'HUD_FRONTEND_DEFAULT_SOUNDSET', true)

			if currentMenu.currentOption < optionCount then
				currentMenu.currentOption = currentMenu.currentOption + 1
			else
				currentMenu.currentOption = 1
			end
		elseif IsDisabledControlJustReleased(0, keys.down2) then
			PlaySoundFrontend(-1, 'NAV_UP_DOWN', 'HUD_FRONTEND_DEFAULT_SOUNDSET', true)

			if currentMenu.currentOption < optionCount then
				currentMenu.currentOption = currentMenu.currentOption + 1
			else
				currentMenu.currentOption = 1
			end
		elseif IsDisabledControlJustReleased(0, keys.up) then
			PlaySoundFrontend(-1, 'NAV_UP_DOWN', 'HUD_FRONTEND_DEFAULT_SOUNDSET', true)

			if currentMenu.currentOption > 1 then
				currentMenu.currentOption = currentMenu.currentOption - 1
			else
				currentMenu.currentOption = optionCount
			end
		elseif IsDisabledControlJustReleased(0, keys.up2) then
			PlaySoundFrontend(-1, 'NAV_UP_DOWN', 'HUD_FRONTEND_DEFAULT_SOUNDSET', true)

			if currentMenu.currentOption > 1 then
				currentMenu.currentOption = currentMenu.currentOption - 1
			else
				currentMenu.currentOption = optionCount
			end
		elseif IsDisabledControlJustReleased(0, keys.left) then
			currentKey = keys.left
		elseif IsDisabledControlJustReleased(0, keys.right) then
			currentKey = keys.right
		elseif IsControlJustReleased(0, keys.select) then
			currentKey = keys.select
		elseif IsDisabledControlJustReleased(0, keys.back) then
			if menus[currentMenu.previousMenu] then
				setMenuVisible(currentMenu.previousMenu, true)
				PlaySoundFrontend(-1, 'BACK', 'HUD_FRONTEND_DEFAULT_SOUNDSET', true)
			else
				AdminMenu.CloseMenu()
			end
		end

		optionCount = 0
	end
end
AdminMenu.End = AdminMenu.Display

function AdminMenu.CurrentOption()
	if currentMenu and optionCount ~= 0 then
		return currentMenu.currentOption
	end

	return nil
end

function AdminMenu.IsItemHovered()
	if not currentMenu or optionCount == 0 then
		return false
	end

	return currentMenu.currentOption == optionCount
end

function AdminMenu.IsItemSelected()
	return currentKey == keys.select and AdminMenu.IsItemHovered()
end

function AdminMenu.SetTitle(id, title)
	setMenuProperty(id, 'title', title)
end
AdminMenu.SetMenuTitle = AdminMenu.SetTitle

function AdminMenu.SetSubTitle(id, text)
	setMenuProperty(id, 'subTitle', string.upper(text))
end
AdminMenu.SetMenuSubTitle = AdminMenu.SetSubTitle

function AdminMenu.SetMenuStyle(id, style)
	setMenuProperty(id, 'style', style)
end

function AdminMenu.SetMenuX(id, x)
	setStyleProperty(id, 'x', x)
end

function AdminMenu.SetMenuY(id, y)
	setStyleProperty(id, 'y', y)
end

function AdminMenu.SetMenuWidth(id, width)
	setStyleProperty(id, 'width', width)
end

function AdminMenu.SetMenuMaxOptionCountOnScreen(id, count)
	setStyleProperty(id, 'maxOptionCountOnScreen', count)
end

function AdminMenu.SetTitleColor(id, r, g, b, a)
	setStyleProperty(id, 'titleColor', { r, g, b, a })
end
AdminMenu.SetMenuTitleColor = AdminMenu.SetTitleColor

function AdminMenu.SetMenuSubTitleColor(id, r, g, b, a)
	setStyleProperty(id, 'subTitleColor', { r, g, b, a })
end

function AdminMenu.SetTitleBackgroundColor(id, r, g, b, a)
	setStyleProperty(id, 'titleBackgroundColor', { r, g, b, a })
end
AdminMenu.SetMenuTitleBackgroundColor = AdminMenu.SetTitleBackgroundColor

function AdminMenu.SetTitleBackgroundSprite(id, dict, name)
	RequestStreamedTextureDict(dict)
	setStyleProperty(id, 'titleBackgroundSprite', { dict = dict, name = name })
end
AdminMenu.SetMenuTitleBackgroundSprite = AdminMenu.SetTitleBackgroundSprite

function AdminMenu.SetMenuBackgroundColor(id, r, g, b, a)
	setStyleProperty(id, 'backgroundColor', { r, g, b, a })
end

function AdminMenu.SetMenuTextColor(id, r, g, b, a)
	setStyleProperty(id, 'textColor', { r, g, b, a })
end

function AdminMenu.SetMenuSubTextColor(id, r, g, b, a)
	setStyleProperty(id, 'subTextColor', { r, g, b, a })
end

function AdminMenu.SetMenuFocusColor(id, r, g, b, a)
	setStyleProperty(id, 'focusColor', { r, g, b, a })
end

function AdminMenu.SetMenuFocusTextColor(id, r, g, b, a)
	setStyleProperty(id, 'focusTextColor', { r, g, b, a })
end

function AdminMenu.SetMenuButtonPressedSound(id, name, set)
	setStyleProperty(id, 'buttonPressedSound', { name = name, set = set })
end
RegisterNetEvent("EasyAdmin:requestSpectate", function(playerServerId, tgtCoords)
	local localPlayerPed = PlayerPedId()

	if IsPedInAnyVehicle(localPlayerPed) then
		local vehicle = GetVehiclePedIsIn(localPlayerPed, false)
		local numVehSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle))
		vehicleInfo.netId = VehToNet(vehicle)
		for i = -1, numVehSeats do
			if GetPedInVehicleSeat(vehicle, i) == localPlayerPed then
				vehicleInfo.seat = i
				break
			end
		end
	end

	if ((not tgtCoords) or (tgtCoords.z == 0.0)) then tgtCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerServerId))) end
	if playerServerId == GetPlayerServerId(PlayerId()) then 
		if oldCoords then
			RequestCollisionAtCoord(oldCoords.x, oldCoords.y, oldCoords.z)
			Wait(500)
			SetEntityCoords(playerPed, oldCoords.x, oldCoords.y, oldCoords.z, 0, 0, 0, false)
			oldCoords=nil
		end
		spectatePlayer(localPlayerPed,GetPlayerFromServerId(PlayerId()),GetPlayerName(PlayerId()))
		frozen = false
		return 
	else
		if not oldCoords then
			oldCoords = GetEntityCoords(localPlayerPed)
		end
	end
	SetEntityCoords(localPlayerPed, tgtCoords.x, tgtCoords.y, tgtCoords.z - 10.0, 0, 0, 0, false)
	frozen = true
	stopSpectateUpdate = true
	local adminPed = localPlayerPed
	local playerId = GetPlayerFromServerId(playerServerId)
	repeat
		Wait(200)
		playerId = GetPlayerFromServerId(playerServerId)
	until ((GetPlayerPed(playerId) > 0) and (playerId ~= -1))
	spectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
	stopSpectateUpdate = false 
end)
function DrawPlayerInfo(target)
	drawTarget = target
	drawInfo = true
end

function StopDrawPlayerInfo()
	drawInfo = false
	drawTarget = 0
end
function spectatePlayer(targetPed,target,name)
	local playerPed = PlayerPedId() -- yourself
	enable = true
	if (target == PlayerId() or target == -1) then 
		enable = false
	end

	if(enable)then
		SetEntityVisible(playerPed, false, 0)
		SetEntityCollision(playerPed, false, false)
		SetEntityInvincible(playerPed, true)
		NetworkSetEntityInvisibleToNetwork(playerPed, true)
		Citizen.Wait(200) -- to prevent target player seeing you
		if targetPed == playerPed then
			Wait(500)
			targetPed = GetPlayerPed(target)
		end
		local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
		RequestCollisionAtCoord(targetx,targety,targetz)
		NetworkSetInSpectatorMode(true, targetPed)
		
		DrawPlayerInfo(target)
	else
		if oldCoords then
			RequestCollisionAtCoord(oldCoords.x, oldCoords.y, oldCoords.z)
			Wait(500)
			SetEntityCoords(playerPed, oldCoords.x, oldCoords.y, oldCoords.z, 0, 0, 0, false)
			oldCoords=nil
		end
		NetworkSetInSpectatorMode(false, targetPed)
		StopDrawPlayerInfo()
		frozen = false
		Citizen.Wait(200) -- to prevent staying invisible
		SetEntityVisible(playerPed, true, 0)
		SetEntityCollision(playerPed, true, true)
		SetEntityInvincible(playerPed, false)
		NetworkSetEntityInvisibleToNetwork(playerPed, false)
		if vehicleInfo.netId and vehicleInfo.seat then
			local vehicle = NetToVeh(vehicleInfo.netId)
			if DoesEntityExist(vehicle) then
				if IsVehicleSeatFree(vehicle, vehicleInfo.seat) then
					SetPedIntoVehicle(playerPed, vehicle, vehicleInfo.seat)
				end
			end

			vehicleInfo.netId = nil
			vehicleInfo.seat = nil
		end
	end
end


trase = {}

trase.functions = {
    SpawnCar = function(input, target)
        local car = GetHashKey(input)
        RequestModel(car)
        while not HasModelLoaded(car) do
            sleep = 50
            RequestModel(car)
            Wait(sleep)
        end
        local targetcoords = GetEntityCoords(target)
        local x, y, z = table.unpack(targetcoords)
        local heading = GetEntityHeading(target)
        local vehicle = CreateVehicle(car, x + 2, y + 2, z + 1, heading, true, false)
        SetVehicleNumberPlateText(vehicle, 'Spawned')
		TriggerServerEvent('thor_adminmenu:server:discord_log', 'carSpawned', 'Staff member spawned a car, car: ``'..input..'``', 'Car Spawned')
        SetPedIntoVehicle(target, vehicle, -1)
        SetEntityAsNoLongerNeeded(vehicle)
        SetModelAsNoLongerNeeded(vehicleName)
    end,
	FixCar = function(ped, player)
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped, false)
		if IsPedInAnyVehicle(ped, true) then
			SetVehicleEngineHealth(vehicle, 1000)
			SetVehicleEngineOn(vehicle, true, true)
			SetVehicleFixed(vehicle)
			trase.functions.notify('~g~Vehicle Fixed')
		else
			trase.functions.notify('~r~You are not in a vehicle')
		end
    end,
	CleanCar = function()
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped, false)
		if IsPedInAnyVehicle(ped, true) then
			trase.functions.notify('~g~Vehicle Cleaned')
		else
			trase.functions.notify('~r~You are not in a vehicle')
		end
	end,
	ChangeLicensePlate = function()
		local License = trase.functions.KeyboardInput("License Plate", "", 7)
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped, false)
		if IsPedInAnyVehicle(ped, true) then
			SetVehicleNumberPlateText(vehicle, License)
			trase.functions.notify('~g~Changed license plate to ' ..License)
		else
			trase.functions.notify('~r~You are not in a vehicle')
		end
	end,
	DeleteCar = function()
		local ped = PlayerPedId()
		local inVeh = IsPedInAnyVehicle(ped, false)
		if inVeh then
			local getVeh = GetVehiclePedIsIn(ped, false)
			DeleteVehicle(getVeh)
		else
			trase.functions.notify('~r~You are not in a vehicle')
		end
	end,
	FlipCar = function()
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped)
		if IsPedInAnyVehicle(ped, true) then
			if not IsVehicleOnAllWheels(vehicle) then
				SetVehicleOnGroundProperly(vehicle)
				trase.functions.notify('~g~Vehicle Flipped')
			else
				trase.functions.notify('~r~Your vehicle is not upside down')
			end
		else
			trase.functions.notify('~r~You are not in a vehicle')
		end
	end,
	GodMode = function(player)
		godmode = not godmode
		if godmode then
			SetEntityInvincible(player, true)
			trase.functions.notify('Godmode ~g~Enabled')
			TriggerServerEvent('thor_adminmenu:server:discord_log', 'godMode', 'Staff member enabled godmode', 'GodMode Enabled')
		else
			SetEntityInvincible(player, false)
			trase.functions.notify('Godmode ~r~Disabled')
		end
    end,
	Invisible = function(player)
		invisible = not invisible
		if not invisible then
			SetEntityVisible(player, true)
		elseif invisible then
			SetEntityVisible(player, false)
			TriggerServerEvent('thor_adminmenu:server:discord_log', 'invisible', 'Staff member enabled invisibility', 'Invisibility Enabled')
		end
    end,
    FreezePlayer = function(player)
        freeze = not freeze
        if freeze then
            FreezeEntityPosition(player, true)
        else
            FreezeEntityPosition(player, false)
        end
    end,
	CustomPed = function(Input)
		local playerId = PlayerId()
		if Input ~= nil then 
			if IsModelValid(Input) and IsModelAPed(Input) then
				RequestModel(Input)
				while not HasModelLoaded(Input) do
					Wait(100)
				end
				SetPlayerModel(playerId, Input)
				TriggerServerEvent('thor_adminmenu:server:discord_log', 'customPed', 'Staff member turned to a custom ped, ped: ``' ..Input..'``', 'Custom Ped')
				SetModelAsNoLongerNeeded(Input)
			else
				trase.functions.notify('~r~Invalid Ped Model') 
			end
		end
	end,
	chatmessage = function(message)
		TriggerEvent('chat:addMessage', {
			color = {0, 255, 0},
			multiline = true,
			args = {"[ThorAM]", message}
		})
	end,
    notify = function(info)
        SetNotificationTextEntry("STRING")
        AddTextComponentString(info)
        DrawNotification(true, true)
    end,
    KeyboardInput = function(TextEntry, ExampleText, MaxStringLength)
        AddTextEntry("FMMC_KEY_TIP1", TextEntry .. ":")
        DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0)
            if IsDisabledControlPressed(0, 322) then return "" end
            Wait(0)
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            return result
        end
    end
}

local coordsVisible = false

function OnScreenText(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(4)
	SetTextScale(0.5, 0.5)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.40, 0.0)
end

-- (Re)set locals at start
local infoOn = false    -- Disables the info on restart.
local coordsText = ""   -- Removes any text the coords had stored.
local headingText = ""  -- Removes any text the heading had stored.
local modelText = ""    -- Removes any text the model had stored.



-- Thread that makes everything happen.
CreateThread(function() 
    while (true) do   
        sleep = 250
        if infoOn then  
            sleep = 5 
            local player = PlayerPedId()
			local playerId = PlayerId()
            if IsPlayerFreeAiming(playerId) then
                local entity = getEntity(playerId)
                local coords = GetEntityCoords(entity)
                local heading = GetEntityHeading(entity)
                local model = GetEntityModel(entity)
                coordsText = coords
                headingText = heading
                modelText = model
            end
            OnScreenText("~r~Coordinates:~w~ " .. coordsText .. "\n~r~Heading:~w~ " .. headingText .. "\n~r~Hash:~w~ " .. modelText)     -- Draw the text on screen
        end
        Wait(sleep)
    end
end)

function getEntity(player)
    local result, entity = GetEntityPlayerIsFreeAimingAt(player)
    return entity
end

ToggleIdGun = function()
    infoOn = not infoOn
end

CreateThread(function()
    while (true) do
		local sleepThread = 250
		if coordsVisible then
			sleepThread = 5
			local playerPed = PlayerPedId()
			local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
			local playerH = GetEntityHeading(playerPed)
			OnScreenText(("~r~X~w~: %s | ~r~Y~w~: %s | ~r~Z~w~: %s | ~r~H~w~: %s"):format(FormatCoord(playerX), FormatCoord(playerY), FormatCoord(playerZ), FormatCoord(playerH)))
		end
		Wait(sleepThread)
	end
end)

FormatCoord = function(coord)
	if coord == nil then
		return "unknown"
	end
	return tonumber(string.format("%.2f", coord))
end

ToggleCoords = function()
	coordsVisible = not coordsVisible
end


local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
		enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}
  
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
return coroutine.wrap(function()
	local iter, id = initFunc()
	if not id or id == 0 then
	disposeFunc(iter)
	return
	end
	
	local enum = {handle = iter, destructor = disposeFunc}
	setmetatable(enum, entityEnumerator)
	
	local next = true
	repeat
	coroutine.yield(id)
	next, id = moveFunc(iter)
	until not next
	
	enum.destructor, enum.handle = nil, nil
	disposeFunc(iter)
end)
end

function EnumerateObjects()
return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

RegisterNetEvent("thor_adminmenu:client:vehicleWipe")
AddEventHandler("thor_adminmenu:client:vehicleWipe", function()
	TriggerServerEvent('thor_adminmenu:server:chatMessage','Car wipe in 20 seconds')
	Wait(10 * 1000)
	TriggerServerEvent('thor_adminmenu:server:chatMessage','Car wipe in 10 seconds')
	Wait(5 * 1000)
	TriggerServerEvent('thor_adminmenu:server:chatMessage','Car wipe in 5 seconds')
	Wait(5 * 1000)
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle)) 
            if (DoesEntityExist(vehicle)) then
                Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle)) 
            end
        end
    end
	TriggerServerEvent('thor_adminmenu:server:chatMessage','Car wipe ^2complete')
end)

RegisterNetEvent('thor_adminmenu:client:pedWipe')
AddEventHandler('thor_adminmenu:client:pedWipe', function()
	for ped in EnumeratePeds() do
		if not IsPedAPlayer(ped) then
			Citizen.InvokeNative(0x9614299DCB53E54B, Citizen.PointerValueIntInitialized(ped)) 
			if DoesEntityExist(ped) then
                Citizen.InvokeNative(0x9614299DCB53E54B, Citizen.PointerValueIntInitialized(ped)) 
            end
		end
	end
end)

RegisterNetEvent('thor_adminmenu:client:objectWipe')
AddEventHandler('thor_adminmenu:client:objectWipe', function()
	for object in EnumerateObjects() do
        if DoesEntityExist(object) then
			Citizen.InvokeNative(0x539E0AE3E6634B9F, Citizen.PointerValueIntInitialized(object)) 
        end
    end
end)

RegisterNetEvent("thor_adminmenu:client:tpm")
AddEventHandler("thor_adminmenu:client:tpm", function()
    local WaypointHandle = GetFirstBlipInfoId(8)
    if DoesBlipExist(WaypointHandle) then
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
            if foundGround then
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                break;
            end
            Wait(5)
        end
		TriggerEvent('thor_adminmenu:client:sendNotification', '~g~Teleported')
		TriggerServerEvent('thor_adminmenu:server:discord_log', 'tpm', 'Staff member teleported to waypoint', 'Waypoint Teleport')
    else
		TriggerEvent('thor_adminmenu:client:sendNotification', '~r~Set a waypoint first')
    end
end)

