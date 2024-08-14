script_name('FoXer')
script_author('Votati')
script_version('v0.8')

-- require('lib.moonloader')
-- require('lib.sampfuncs')

local sampEvent = require('lib.samp.events')
local sampRaknet = require('lib.samp.raknet')

local dinero = 0
local bancoId = 0
local depositando = false
local transfiriendo = false
local evadiendo = false
local dinfo = false
local borrarveh = false
local desmadre = false
local vehTotal = 0

local dialogs = {
	D_AYUDA = 0
}

local vehicles = {}
for i = 1, 2000 do
	vehicles[i] = 0
end

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	print("cargado correctamente.")

	sampRegisterChatCommand('af', cmd_af)
	sampRegisterChatCommand('nombre', cmd_nombre)
	-- sampRegisterChatCommand('depositar', cmd_depositar)
	-- sampRegisterChatCommand('transferir', cmd_transferir)
	sampRegisterChatCommand('evadir', cmd_evadir)
	sampRegisterChatCommand('borrarv', cmd_borrarv)
	sampRegisterChatCommand('dinfo', cmd_dinfo)
	-- sampRegisterChatCommand('desmadre', cmd_desmadre)
	sampRegisterChatCommand('spawn', cmd_spawn)
	sampRegisterChatCommand('registro', function()
		sampSendDialogResponse(0, 1, 0, 'admin123')
	end)

	wait(-1)
end

function sampEvent.onShowDialog(dialogId, style, title, button1, button2, text)
	if depositando == true then
		if dialogId == 8 then
			sampSendDialogResponse(8, 1, 1, "Depositar")
		end
		if dialogId == 10 then
			sampSendDialogResponse(10, 1, 0, dinero)
		end
	end

	if transfiriendo == true then
		if dialogId == 8 then
			sampSendDialogResponse(8, 1, 2, "Transferir")
		end
		if dialogId == 11 then
			sampSendDialogResponse(11, 1, 0, bancoId)
		end
		if dialogId == 12 then
			sampSendDialogResponse(12, 1, 0, dinero)
		end
	end

	if evadiendo == true then
		if dialogId == 3 then
			return false
		end
	end

	if dinfo == true then
		return { dialogId, style, title .. " | ID: " .. dialogId, button1, button2, text }
	end
end

--[[function sampEvent.onSendDialogResponse(dialogId, button, listboxId, input)
	sampAddChatMessage("{FCFC74}=== EVENTO: {FF5555}onSendDialogResponse {FCFC74}===", -1)
	sampAddChatMessage(string.format("{FCFC74}dialogId: {FFAF55}%d", dialogId), -1)
	sampAddChatMessage(string.format("{FCFC74}button: {FFAF55}%d", button), -1)
	sampAddChatMessage(string.format("{FCFC74}listboxId: {FFAF55}%d", listboxId), -1)
	sampAddChatMessage(string.format("{FCFC74}input: {FFAF55}%s", input), -1)
end]]

function sampEvent.onShowTextDraw(textdrawId, textdraw)
	if evadiendo == true then
		if textdrawId == 2 or textdrawId == 0 then
			return false
		end
	end
end

function sampEvent.onInterpolateCamera(setPos, fromPos, destPos, time, mode)
	if evadiendo == true then
		return false
	end
end

function sampEvent.onTogglePlayerSpectating(state)
	if evadiendo == true then
		return false
	end
end

function sampEvent.onSendClientJoin(version, mod, nickname, challengeResponse, joinAuthKey, clientVer, challengeResponse2)
	return { version, mod, nickname, challengeResponse, joinAuthKey, "0.3.7-R4", challengeResponse2 }
end

--[[function sampEvent.onSendVehicleDamaged(vehicleid, panelDmg, doorDmg, light, tires)
	sampAddChatMessage("{FCFC74}=== EVENTO: {FF5555}onSendVehicleDamaged {FCFC74}===", -1)
	sampAddChatMessage(string.format("{FCFC74}vehicleid: {FFAF55}%d", vehicleid), -1)
	sampAddChatMessage(string.format("{FCFC74}panelDmg: {FFAF55}%d", panelDmg), -1)
	sampAddChatMessage(string.format("{FCFC74}doorDmg: {FFAF55}%d", doorDmg), -1)
	sampAddChatMessage(string.format("{FCFC74}light: {FFAF55}%d", light), -1)
	sampAddChatMessage(string.format("{FCFC74}tires: {FFAF55}%d", tires), -1)
end]]

function sampEvent.onVehicleStreamIn(vehicleid, forplayerid)
	if borrarveh == true then
		sampSendVehicleDestroyed(vehicleid)
	end
	vehicles[vehicleid] = vehicleid
	vehTotal = vehTotal + 1
end

function sampEvent.onVehicleStreamOut(vehicleid)
	vehicles[vehicleid] = 0
	vehTotal = vehTotal - 1
end

function sampEvent.onPlayerQuit(playerid, reason)
	if desmadre == true then
		nickname = sampGetPlayerNickname(playerid)
		sampSendChat(string.format("/delete %s", nickname))
	end
end

-- function sampEvent.onSendEnterVehicle(vehicleid, passenger)
-- 	lua_thread.create(putBelt)
-- end

function GetMaxElementArray(array)
	local max = 0
	for i = 1, 2000 do
		if array[i] > max then
			max = array[i]
		end
	end
	return max
end

function GetMinElementArray(array)
	local min = 2000
	for i = 1, 2000 do
		if array[i] < min and array[i] ~= 0 then
			min = array[i]
		end
	end
	return min
end

function cmd_dinfo()
	if dinfo == true then
		dinfo = false
		sampAddChatMessage("{FCFC74}Información de los diálogos: {FF5555}Desactivado", -1)
	else
		dinfo = true
		sampAddChatMessage("{FCFC74}Información de los diálogos: {76FF55}Activado", -1)
	end
end

function cmd_borrarv(id)
	if #id == 0 then
		local cont = 0
		for i = GetMinElementArray(vehicles), GetMaxElementArray(vehicles) do
			if select(1, sampGetCarHandleBySampVehicleId(vehicles[i])) == true then
				sampSendVehicleDestroyed(vehicles[i])
				cont = cont + 1
			end
		end
		if cont == 0 then
			sampAddChatMessage("{FF5555}<!> No se encontró ningún vehículo para eliminar.", -1)
		else
			sampAddChatMessage(string.format("{FCFC74}Eliminaste {FF5555}%d {FCFC74}vehículos.", cont), -1)
		end
		return
	elseif type(tonumber(id)) == "number" then
		if tonumber(id) > 0 and tonumber(id) <= 2000 then
			sampSendVehicleDestroyed(id)
			sampAddChatMessage(string.format("{FCFC74}Vehículo ID {FF5555}%d {FCFC74}fue eliminado.", id), -1)
			return
		else
			sampAddChatMessage("{FF5555}<!> La ID debe ser entre 1 - 2000.", -1)
		end
	elseif id == "on" then
		borrarveh = true
		sampAddChatMessage("{FCFC74}Modo borrar vehículos: {76FF55}Activado", -1)
		return
	elseif id == "off" then
		borrarveh = false
		sampAddChatMessage("{FCFC74}Modo borrar vehículos: {FF5555}Desactivado", -1)
		return
	else
		sampAddChatMessage("{FF5555}<!> Uso correcto: {FFAF55}/borrarv | /borrarv <ID> | /borrarv <on/off>", -1)
	end
end

function cmd_evadir()
	if evadiendo == true then
		evadiendo = false
		sampAddChatMessage("{FCFC74}Modo evadir: {FF5555}Desactivado", -1)
	else
		evadiendo = true
		sampAddChatMessage("{FCFC74}Modo evadir: {76FF55}Activado", -1)
	end
end

function cmd_transferir(args)
	local id, money = string.match(args, '(%d+)%s*(%d+)')
	if #args == 0 then
		return sampAddChatMessage("{FF5555}<!> Uso correcto: {FFAF55}/transferir <ID> <Cantidad>", -1)
	else
		if args == tostring(0) then
			transfiriendo = false
			sampAddChatMessage("{FCFC74}Modo transferir: {FF5555}Desactivado", -1)
		else
			transfiriendo = true
			dinero = money
			bancoId = id
			sampAddChatMessage("{FCFC74}Modo transferir: {76FF55}Activado", -1)
			sampAddChatMessage(string.format("{FCFC74}Cuenta bancaria: {6AFFCD}%s", id), -1)
			sampAddChatMessage(string.format("{FCFC74}Dinero: {53C33A}$%s", money), -1)
		end
	end
end

function cmd_depositar(money)
	if #money == 0 then
		return sampAddChatMessage("{FF5555}<!> Uso correcto: {FFAF55}/depositar <Cantidad>", -1)
	else
		if money == tostring(0) then
			depositando = false
			sampAddChatMessage("{FCFC74}Modo depositar: {FF5555}Desactivado", -1)
		else
			depositando = true
			dinero = money
			sampAddChatMessage("{FCFC74}Modo depositar: {76FF55}Activado", -1)
			sampAddChatMessage(string.format("{FCFC74}Dinero: {53C33A}$%d", money), -1)
		end
	end
end

function cmd_nombre(name)
	if #name == 0 then
		return sampAddChatMessage("{FF5555}<!> Uso correcto: {FFAF55}/nombre <Nombre>", -1)
	else
		--[[for i = 0, sampGetMaxPlayerId(false) do
			if sampGetPlayerNickname(i) == name then
				sampAddChatMessage("{FF5555}<!> El jugador ya está conectado.", -1)
				return
			end
		end]]
		sampSetLocalPlayerName(name)
		sampSetGamestate(4)
		sampSetGamestate(1)
	end
end

function GiveGift(id)
	playerid = select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
	ping = sampGetPlayerPing(playerid)
	sampSendChat(string.format("/givecash %d 3000000", id))
	wait(ping * 10)
	sampSendChat(string.format("/pm %d Has ganado el sorteo secreto! No le digas a nadie ;)", id))
end

function cmd_r(id)
	if #id == 0 then
		return sampAddChatMessage("{FF5555}<!> Uso correcto: {FFAF55}/r <ID>", -1)
	else
		lua_thread.create(GiveGift, id)
	end
end

function cmd_desmadre()
	if desmadre == true then
		desmadre = false
		sampAddChatMessage("{FCFC74}Modo desmadre: {FF5555}Desactivado", -1)
	else
		desmadre = true
		sampAddChatMessage("{FCFC74}Modo desmadre: {76FF55}Activado", -1)
	end
end

function cmd_spawn()
	sampSpawnPlayer()
	sampAddChatMessage("{FCFC74}Spawneaste.", -1)
end

function cmd_af()
	sampShowDialog(D_AYUDA, "Comandos de FoXer", "/nombre - Cambia tu nombre y te reconecta.\
	\n/depositar - Activa/Deactiva el modo depositar\
	\n/transferir - Transfiere el dinero de una cuenta bancaria a otra.\
	\n/evadir - Activa/Desactiva el modo evadir.\
	\n/borrarv - Borra los vehículos de los usuarios.\
	\n/dinfo - Activa/Desactiva la información de los diálogos.\
	\n/registro - Muestra el diálogo de registro.\
	\n/spawn - Te vuelve a spawnear.",
		"Cerrar", 0)
end

function cmd_test()
	-- local result = isCharInAnyCar(PLAYER_PED)
	-- print(result)

	lua_thread.create(putBelt)
end

function putBelt()
	wait(5000)

	if isCharInAnyCar(PLAYER_PED) then
		sampSendChat("/poner cinturon")
	end
end

function getOwnId()
	local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)

	return id
end
