GlobalState.CooldownKasir = false
GlobalState.CooldownBrangkas = false

-- Function Untuk cek jarak player dari Kasir/Brangkas/etc
local function checkPlayerDistance(source)
    local ped = GetPlayerPed(source)
    local playerPos = GetEntityCoords(ped)
    for _, Lokasi in pairs(Config.Lokasi) do
        for _, location in pairs(Lokasi) do
            local distance = #(playerPos - location)
            if distance < 5 then
                return true
            end
        end
    end
    return false
end

-- Function Jika player berhasil membobol kasir
lib.callback.register('KioN_robbery:berhasilbobolkasir', function(source, verifyReward)
    local source = source
    local player = GetPlayer(source)
    local playerName = GetName(source)
    local playerId = player.source or player.PlayerData.source
    local distanceCheck = checkPlayerDistance(source)
    local rewardQuantity = nil
    if Config.DapatUangKasirRandom then
        rewardQuantity = math.random(Config.MinimalDapatUangKasir, Config.MaksimalDapatUangKasir)
    else
        rewardQuantity = Config.JumlahDapatUangKasir
    end
    if verifyReward == true then
        if distanceCheck then
            if Framework == 'qb' then
                local reward
                if Config.DapatUangKasir == 'markedbills' then
                    reward = {worth = rewardQuantity}
                else
                    reward = rewardQuantity
                end
                AddItem(source, Config.DapatUangKasir, reward)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.DapatUangKasir], "add")
            else
                AddItem(source, Config.DapatUangKasir, rewardQuantity)
            end
            CooldownKasir()
            return true
        else
            -- Apabila player melakukan cheating
            print('Player: ' ..playerName.. ' (ID: '..playerId..') Mencoba mendapatkan uang di luar jangkauan warung')
            return false
        end
    else
        -- Player cheating apabila verifyReward disetting false?
        print('Player: ' ..playerName.. ' (ID: '..source..') Mencoba mendapatkan uang saat verifyReward false')
        return false
    end
end)

-- Function Jika player berhasil membobol brangkas
lib.callback.register('KioN_robbery:berhasilbobolbrangkas', function(source, verifyReward)
    local source = source
    local player = GetPlayer(source)
    local playerName = GetName(source)
    local playerId = player.source or player.PlayerData.source
    local distanceCheck = checkPlayerDistance(source)
    local rewardQuantity = nil
    if Config.DapatUangBrangkasRandom then
        rewardQuantity = math.random(Config.MinimalDapatUangBrangkas, Config.MaksimalDapatUangBrangkas)
    else
        rewardQuantity = Config.JumlahDapatUangBrangkas
    end
    if verifyReward then
        if distanceCheck then
            if Framework == 'qb' then
                local reward
                if Config.DapatUangBrangkas == 'markedbills' then
                    reward = {worth = rewardQuantity}
                else
                    reward = rewardQuantity
                end
                AddItem(source, Config.DapatUangBrangkas, reward)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.DapatUangBrangkas], "add")
            else
                AddItem(source, Config.DapatUangBrangkas, rewardQuantity)
            end
            CooldownBrangkas()
            return true
        else
            -- Apabila player melakukan cheating
            print('Player: ' ..playerName.. ' (ID: '..playerId..') Mencoba mendapatkan uang di luar jangkauan warung')
            return false
        end
    else
        -- Player cheating apabila verifyReward disetting false?
        print('Player: ' ..playerName.. ' (ID: '..playerId..') Mencoba mendapatkan uang saat verifyReward false')
        return false
    end
end)

-- Function unutk menghapus medapatkan, jumlah, menghapus item
RegisterNetEvent('KioN_robbery:hapusitem')
AddEventHandler('KioN_robbery:hapusitem', function(source, item, quantity)
    local source = source
    RemoveItem(source, Config.ItemRampok, 1)
    if Framework == 'qb' then
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "remove")
    end
end)

-- Callback minimal polisi unutk memulai perampokan
lib.callback.register('KioN_robbery:MinimalPolisi', function()
    local MinPolisi = PlayersWithJob(Config.JobPolisi)
    return MinPolisi
end)

-- Function cooldwon kasir setelah dirampok
function CooldownKasir()
    GlobalState.CooldownKasir = true
    local cooldown = math.random(Config.MinimalCooldown * 60000, Config.MaxCooldown * 60000)
    local format = cooldown / 1000 / 60
    local cooldownRound = math.floor(format)
    print('Bobol mesin kasir tersedia setelah ' .. cooldownRound .. ' menit')
    Wait(cooldown)
    print('Bobol brangkas tersedia')
    GlobalState.CooldownKasir = false
end

-- Function cooldwon brangkas setelah dirampok
function CooldownBrangkas()
    GlobalState.CooldownBrangkas = true
    local cooldown = math.random(Config.MinimalCooldownBrangkas * 60000, Config.MaksimalCooldownBrangkas * 60000)
    local format = cooldown / 1000 / 60
    local cooldownRound = math.floor(format)
    print('Bobol brangkas tersedia setelah ' .. cooldownRound .. ' menit')
    Wait(cooldown)
    print('Bobol brangkas tersedia')
    GlobalState.CooldownBrangkas = false
end