local QBCore = exports['qb-core']:GetCoreObject()


local function Notify(msg, type)
    local notifyType = type or Config.NotifyTypes.info

    if Config.NotifySystem == 'qb' then
        QBCore.Functions.Notify(msg, notifyType, Config.NotifyDuration)
    elseif Config.NotifySystem == 'ox' then
        lib.notify({
            title = Config.Locale.menuTitle,
            description = msg,
            type = notifyType
        })
    else
        print(('[Notify] %s: %s'):format(notifyType, msg))
    end
end


local function IsPlayerDriver()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh == 0 then return false, nil end
    if GetPedInVehicleSeat(veh, -1) ~= ped then return false, veh end
    return true, veh
end


local function OpenExtraMenu(veh)
    local items = {}

    for extra = 1, Config.VehicleExtras.maxExtras do
        if DoesExtraExist(veh, extra) then
            local enabled = IsVehicleExtraTurnedOn(veh, extra)
            table.insert(items, {
                title = ('Extra %d [%s]'):format(extra, enabled and 'ON' or 'OFF'),
                description = enabled and 'Turn OFF' or 'Turn ON',
                icon = enabled and 'ban' or 'plus',
                onSelect = function()
                    SetVehicleExtra(veh, extra, enabled and 1 or 0)
                    Notify(('<b>' .. Config.Locale.toggledExtra .. '</b>'):format(extra), Config.NotifyTypes.info)
                    OpenExtraMenu(veh) -- Refresh menu after toggling
                end,
            })
        end
    end

    local liveryCount = GetVehicleLiveryCount(veh)
    if liveryCount and liveryCount >= Config.Livery.minCountToShow then
        table.insert(items, {
            title = Config.Locale.liveryMenuTitle,
            icon = 'palette',
            onSelect = function()
                OpenLiveryMenu(veh, liveryCount)
            end,
        })
    end

    lib.registerContext({
        id = 'qb_extra_menu',
        title = Config.Locale.menuTitle,
        options = items,
    })

    lib.showContext('qb_extra_menu')
end


function OpenLiveryMenu(veh, count)
    local items = {}
    for i = 0, count - 1 do
        table.insert(items, {
            title = ('Livery %d'):format(i),
            onSelect = function()
                SetVehicleLivery(veh, i)
                Notify(('<b>' .. Config.Locale.liverySet .. '</b>'):format(i), Config.NotifyTypes.success)
            end,
        })
    end

    lib.registerContext({
        id = 'qb_extra_livery_menu',
        title = Config.Locale.liveryMenuTitle,
        options = items,
    })
    lib.showContext('qb_extra_livery_menu')
end


RegisterCommand(Config.Commands.extraMenu, function()
    local isDriver, veh = IsPlayerDriver()
    if not isDriver then
        Notify(Config.Locale.notDriver, Config.NotifyTypes.error)
        return
    end

    QBCore.Functions.TriggerCallback('qb-extra:server:CanUseMenu', function(allowed)
        if not allowed then
            Notify(Config.Locale.notAuthorized, Config.NotifyTypes.error)
            return
        end
        OpenExtraMenu(veh)
    end)
end, false)