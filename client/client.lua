local inShop = false;

function AddShopMarkers()
    for _, shop in ipairs(Config.ShopLocations) do
        local marker = AddBlipForCoord(shop.coords)
        SetBlipSprite(marker, 52)
        SetBlipDisplay(marker, 4)
        SetBlipScale(marker, 0.7)
        SetBlipColour(marker, 2)
        SetBlipAsShortRange(marker, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(shop.name)
        EndTextCommandSetBlipName(marker)
    end
end

function OpenShopUI()
    SetNuiFocus(true, true)
    SendNUIMessage({ type = 'open_shop' })
    inShop = true
end

function CloseShopUI()
    SetNuiFocus(false, false)
    SendNUIMessage({ type = 'close_shop' })
    inShop = false
end

function IsPlayerInAnyShopLocation(playerCoords, radius)
    for _, shop in ipairs(Config.ShopLocations) do
        local distance = #(playerCoords - shop.coords)
        if distance <= radius then
            return true
        end
    end
    -- if #(playerCoords - vector3(0,0,0)) <= 3 then
    --     return true
    -- end

    return false
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    AddShopMarkers()
end)

RegisterKeyMapping('openShop', 'Otwórz sklep', 'keyboard', 'e')

RegisterCommand('openShop', function()
    local playerCoords = GetEntityCoords(PlayerPedId())

    if(IsPlayerInAnyShopLocation(playerCoords, 3.0)) then
        OpenShopUI()
    end
end)

RegisterNUICallback("close_ui", function()
    CloseShopUI();
end)

RegisterNUICallback('buy_item', function(data, cb)
    TriggerServerEvent('shops:buyItem', data.itemName, data.price, data.job)
    cb('ok')
end)
