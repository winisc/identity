-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("trinity_identity",cRP)
vSERVER = Tunnel.getInterface("trinity_identity")
-----------------------------------------------------------------------------------------------------------------------------------------
-- Open Identity
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("trinity:openIdentity")
AddEventHandler("trinity:openIdentity", function(user_id,solicitacao)
	openIdentity(user_id,solicitacao)
end)

function openIdentity(user_id,solicitacao) 
    local playerPed = PlayerPedId()
    local sucess, identity = vSERVER.checkIdentity(user_id,solicitacao)

    if sucess and GetEntityHealth(playerPed) > 101 then
        TriggerEvent('snt/animations/play', {
            dict = "cellphone@", 
            anim = "cellphone_text_read_base", 
            prop = "prop_npc_phone_02",
            bone = 6286, 
            propPlacement = {0.1, 0.04, -0.015, -70.0, 190.0, 130.0, },
        })

        TriggerEvent('snt/animations/setBlocked', true)
        SetNuiFocus(true,true)
        SendNuiMessage(json.encode({
            action = "open", 
            name1 = identity.name1, 
            name2 = identity.name2, 
            idade = identity.idade,
            phone = identity.phone,
            user = identity.user,
            registro = identity.registro,
            picture = identity.picture
        }))
    end

end


RegisterKeyMapping("openIdentity","Abrir identitdade.","keyboard","F11")

RegisterCommand("openIdentity",function(source,args,rawCommand)
    TriggerEvent("trinity:openIdentity")
end)

RegisterNUICallback("close",function()
    TriggerEvent('snt/animations/setBlocked', false)
    TriggerEvent('snt/animations/stop')
    SendNuiMessage(json.encode({action = "close"}))
    SetNuiFocus(false, false)
end)