-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("trinity_identity",cRP)
vCLIENT = Tunnel.getInterface("trinity_identity")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYAVAILABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkIdentity(id, solicitacao)
    local source = source
    local user_id = vRP.getUserId(source)
    if id ~= nil then
        user_id = id
    end

    if vRP.getInventoryItemAmount(user_id,"identidade")[1] < 1 then
        if solicitacao then
            TriggerClientEvent("Notify",source,"aviso","O jogar não possui a sua <b>Identidade</b> em mãos.")
            return false
        end
        TriggerClientEvent("Notify",source,"aviso","Necessário possuir o item <b>Identidade</b>.")
        return false
    end
    local identity = vRP.userIdentity(user_id)
        if identity then
            local picture = 'https://static.snt.gg/avatar.png'
            local phone = 'Não cadastrado.'
            if (vRP.query("phone/verifyNamePhone",{ phone_number = identity.phone })[1]) ~= nil then
                phone = identity.phone
                local instapic = vRP.query("phone/getInstaPic",{ phone_number = identity.phone })
                if instapic[1]  then 
                    picture = instapic[1]["profile_image"]
                end
            end

            return true, {
                ['name1'] = identity.name,
                ['name2'] = identity.name2,
                ['idade'] = identity.age,
                ['phone'] = phone,
                ['user'] = user_id,
                ['registro'] = identity.serial,
                ['picture'] = picture
            }
    
        end
        return false
end