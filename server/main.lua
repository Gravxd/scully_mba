local format = string.format

CreateThread(function()
    GlobalState.mba = Config.Default
end)

RegisterCommand('setmba', function(source)
    TriggerClientEvent("gabzmba:select", source)
end, true)

RegisterServerEvent("gabzmba:select", function(index)
    local src = source
    if not IsPlayerAceAllowed(src, "command.setmba") then
        print(format("%s [%s] attempted to exploit MBA event.", GetPlayerName(src), src))
        DropPlayer(src, "Exploiting.")
        return
    end

    if not Config.Sets[index] then return end

    print(format("%s [%s] set MBA to %s.", GetPlayerName(src), src, index))
    GlobalState.mba = index

    TriggerClientEvent('ox_lib:notify', src, {
        description = "Interior Updated!",
        type = "success",
        duration = 6500,
        position = "center-right",
    })
end)
