QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('shops:buyItem')
AddEventHandler('shops:buyItem', function(itemName, price, requiredJob)
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    
    local itemData = nil
    for _, item in ipairs(Config.ShopItems) do
        if item.name == itemName then
            itemData = item
            break
        end
    end
    
    if not itemData then
        print('Przedmiot nie istnieje: ' .. itemName)
        return
    end

    if requiredJob ~= "none" then
        local playerJob = xPlayer.job.name
        if playerJob ~= requiredJob then
            QBCore.Functions.Notify("Nie masz dostępu do zakupu tego przedmiotu.", "error")
            return
        end
    end
    
    if xPlayer.money() >= itemData.price then
        xPlayer.addInventoryItem(itemName, 1)
        xPlayer.removeMoney(itemData.price)
        TriggerClientEvent('QBCore:Notify', _source, 'Zakupiłeś ' .. itemData.label .. ' za $' .. itemData.price)
    else
        TriggerClientEvent('QBCore:Notify', _source, 'Nie masz wystarczająco pieniędzy.')
    end
end)