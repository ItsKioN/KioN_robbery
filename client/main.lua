local qtarget = exports.qtarget
local KasirAktif, BrangkasAktif = false, false
local Tersedia, verifyReward = false, false
local BuatKode, KodePrangkas = nil, nil
local PinSalah = 0

function CekKondisi()
    local hasItem = HasItem(Config.ItemRampok, 1)
    if hasItem then
        if Config.ButuhPolisi then
            local MinPolisi = lib.callback.await('KioN_robbery:MinimalPolisi', false)
            if MinPolisi >= Config.MinPolisi then
                Tersedia = true
                MulaiBobolKasir()
            else
                Tersedia = false
                KasirAktif = false
                ShowNotification(Notify.TidakCukupPolisi, 'error')
            end
        else
            Tersedia = true
            MulaiBobolKasir()
        end
    else
        Tersedia = false
        KasirAktif = false
        ShowNotification(Notify.TidakPunyaLockpick, 'error')
    end
end

function MulaiBobolKasir()
    if Tersedia then
        local coords = GetEntityCoords(cache.ped)
        local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
        local data = {coords = coords, street = streetName}
        local cooldown = GlobalState.CooldownKasir
        if cooldown == false then
            local success = lib.skillCheck(Config.Diffuculty, Config.Input)
            if success then
                TriggerServerEvent('KioN_robbery:hapusitem', cache.serverId, Config.ItemRampok, 1)
                PoliceDispatch(data)
                if lib.progressCircle({
                    label = ProgressCircle.LabelKasir,
                    duration = ProgressCircle.registerDuration,
                    position = ProgressCircle.position,
                    useWhileDead = false,
                    canCancel = true,
                    disable = { car = true, move = true, combat = true },
                    anim = { dict = 'anim@heists@ornate_bank@grab_cash', clip = 'grab' }
                }) then
                    local DapatKodeBrangkas = math.random(1, 100)
                    if DapatKodeBrangkas <= Config.DapatKodeBrangkas then
                        BuatKode = math.random(1111, 9999)
                        KodePrangkas = BuatKode
                        local note = lib.alertDialog({
                            header = AlertDialog.HeaderKasir,
                            content = AlertDialog.TextKasir ..BuatKode,
                            centered = true,
                            labels = {
                                confirm = AlertDialog.TombolKonfirmasi
                            }
                        })
                        if note == 'confirm' then
                            BrangkasAktif = true
                            verifyReward = true
                            local reward = lib.callback.await('KioN_robbery:berhasilbobolkasir', false, verifyReward)
                            if reward then
                                verifyReward = false
                            else
                                -- Kick/drop player? Jika melakukan cheating
                                verifyReward = false
                            end
                        else
                            KasirAktif = false
                        end
                    else
                        verifyReward = true
                        local reward = lib.callback.await('KioN_robbery:berhasilbobolkasir', false, verifyReward)
                        if reward then
                            verifyReward = false
                        else
                            -- Kick/drop player? Jika melakukan cheating
                            verifyReward = false
                        end
                    end
                else
                    KasirAktif = false
                    ShowNotification(Notify.BatalRampok, 'error')
                end
            else
                local LockpickHancur = math.random(1, 100)
                if LockpickHancur <= Config.LockpickHancur then
                    TriggerServerEvent('KioN_robbery:hapusitem', cache.serverId, Config.ItemRampok, 1)
                    ShowNotification(Notify.LockpickHancur, 'error')
                end
                KasirAktif = false
            end
        else
            ShowNotification(Notify.CooldownKasir, 'error')
            KasirAktif = false
        end
    else
        return
    end
end

function MulaiBobolBrangkas()
    BrangkasAktif = false
    if PinSalah < Config.MaksimalInputKode then
        local inputCode = lib.inputDialog(InputDialog.HeaderBrangkas, {
            {type = 'input', label = InputDialog.LabelBrangkas, description = InputDialog.DeskripsiBrangkas, placeholder = InputDialog.ContohKode, icon = InputDialog.IconBrangkas, required = true, min = 4, max = 16},
        })
        if not inputCode then
            BrangkasAktif = true
            return
        end
        local convertedCode = tonumber(inputCode[1])
        if convertedCode ~= KodePrangkas then
            PinSalah = PinSalah + 1
            BrangkasAktif = true
            ShowNotification(Notify.PinSalah, 'error')
        elseif convertedCode == KodePrangkas then
            BrangkasAktif = false
            PinSalah = 0
            if lib.progressCircle({
                label = ProgressCircle.LabelBrangkas,
                duration = ProgressCircle.safeDuration,
                position = ProgressCircle.position,
                useWhileDead = false,
                canCancel = true,
                disable = { car = true, move = true, combat = true },
                anim = { dict = 'anim@heists@ornate_bank@grab_cash', clip = 'grab' }
            }) then
                KasirAktif = false
                verifyReward = true
                local reward = lib.callback.await('KioN_robbery:berhasilbobolbrangkas', false, verifyReward)
                if reward then
                    verifyReward = false
                else
                    -- Kick/drop player? Jika melakukan cheating
                    verifyReward = false
                end
            else
            end
        else
            ShowNotification(Notify.Error, 'error')
        end
    else
        KasirAktif = false
        BrangkasAktif = false
        PinSalah = 0
        ShowNotification(Notify.SeringSalah, 'error')
    end
end

for k, v in pairs(Config.Lokasi.Kasir) do
    qtarget:AddCircleZone('cash_register' ..k, v, 0.35, {
        name = 'cash_register' ..k,
        debugPoly = Target.debugTargets,
    }, {
        options = {
            {
                icon = Target.IconKasir,
                label = Target.LabelKasir,
                canInteract = function()
                    if KasirAktif then
                        return false
                    else
                        return true
                    end
                end,
                action = function()
                    KasirAktif = true
                    CekKondisi()
                end
            }
        },
        distance = 2,
    })
end

for k, v in pairs(Config.Lokasi.Brangkas) do
    qtarget:AddCircleZone('safe' ..k, v, 0.45, {
        name = 'safe' ..k,
        debugPoly = Target.debugTargets,
    }, {
        options = {
            {
                icon = Target.IconBrangkas,
                label = Target.LabelBrangkas,
                canInteract = function()
                    if BrangkasAktif then
                        return true
                    else
                        return false
                    end
                end,
                action = function()
                    MulaiBobolBrangkas()
                end
            }
        },
        distance = 2,
    })
end