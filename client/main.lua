local hasSpawned = false

local function setMBA(entitySet)
    local interior = GetInteriorAtCoords(-324.22, -1968.49, 20.60)

    if interior ~= 0 then
        local removeSets, newEntitySet = Config.Removals.interiors, Config.Sets[entitySet]
        local removeSigns, newSign = Config.Removals.signs, Config.Signs[entitySet]

        for i = 1, #removeSets do
            DeactivateInteriorEntitySet(interior, removeSets[i])
        end

        for i = 1, #removeSigns do
            RemoveIpl(removeSigns[i])
        end

        Wait(100)

        for i = 1, #newEntitySet do
            ActivateInteriorEntitySet(interior, newEntitySet[i])
        end

        if newSign then
            RequestIpl(newSign)
        end

        RefreshInterior(interior)
    end
end

CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/setmba', 'Set the maze bank arena interior.',
        { { name = 'interior', help = 'The interior entity set name' } })
end)

AddEventHandler('playerSpawned', function()
    if not hasSpawned then
        setMBA(GlobalState.mba)

        hasSpawned = true
    end
end)

AddStateBagChangeHandler('mba', nil, function(bagName, key, value, _unused, replicated)
    setMBA(value)
end)

local interiorOptions = {}

for name, _ in pairs(Config.Sets) do
    interiorOptions[#interiorOptions + 1] = {
        title = name,
        onSelect = function()
            lib.print.debug("Selected interior: " .. name)
            if GlobalState.mba == name then
                lib.print.error("Interior is already set to " .. name)
                lib.notify({
                    type = "error",
                    description = "Interior is already set to " .. name,
                    duration = 6500,
                    position = "center-right",
                })
                return
            end
            TriggerServerEvent("gabzmba:select", name)
        end
    }
end

lib.registerContext({
    id = "gabzmba:interior",
    title = "Maze Bank Arena - Interior Selector",
    options = interiorOptions,
})

RegisterNetEvent("gabzmba:select", function()
    lib.showContext("gabzmba:interior")
end)
