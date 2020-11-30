Citizen.CreateThread(function()
    AddTextEntry("press_pub", "~INPUT_CONTEXT~ pour publier une publicité")
    
    while true do 
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local coords  = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(vector3(-592.39, -929.90, 23.86), coords, true)
        if distance <= 5 then
            DisplayHelpTextThisFrame("press_pub")
            if IsControlPressed(1, 38) then
                Pub()
            end
        end
    end

end)

function Pub()
    local Titlepub = KeyboardInput("Saisir le titre - Prix de la pub: 50$ - CB seulement", "",20)
    local textpub = KeyboardInput("Saisir le texte - Prix de la pub: 50$ - CB seulement", "",200)
    if textpub ~= nil or textpub ~= "" and Titlepub ~= nil then
        TriggerServerEvent("pub:check_money", textpub, Titlepub)
    end
end

RegisterNetEvent("pub:sendpub")
AddEventHandler("pub:sendpub", function(text, titre)

    notifadvanced("Publicité", titre, text, "CHAR_LIFEINVADER", 2)

end)

RegisterNetEvent("pub:notif")
AddEventHandler("pub:notif", function(text, color)

    notifcolor(text, color)

end)

function notifadvanced (title, subject, msg, icon, iconType)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(msg)
	SetNotificationMessage(icon, icon, false, iconType, title, subject)
	DrawNotification(false, false)
end

function notifcolor(text, color)
    Citizen.InvokeNative(0x92F0DA1E27DB96DC, tonumber(color))
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, true)
end

function pedspawn()
    local modelped = 826475330 
	RequestModel(modelped)
    while not HasModelLoaded(modelped) do
        Wait(1)
    end

    local ped = CreatePed(1, modelped, -592.39, -929.90, 22.90, 92.0, false, true)
    SetModelAsNoLongerNeeded(modelped)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedDiesWhenInjured(ped, false)
    SetPedCanPlayAmbientAnims(ped, true)
    SetPedCanRagdollFromPlayerImpact(ped, false)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
	
end



function KeyboardInput(textEntry, inputText, maxLength) -- Thanks to Flatracer for the function.
	AddTextEntry('FMMC_KEY_TIP8', textEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", inputText, "", "", "", maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        return result
    else
        Citizen.Wait(500)
        return nil
    end
end