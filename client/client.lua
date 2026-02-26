local config = lib.load('shared.configuration')

local oneHanded = {
    enabled = config.enabled,
    clipset = config.clipset,
}

local hasWeapon = false

lib.onCache('weapon', function(weapon)
    if weapon then
        hasWeapon = true 
        if oneHanded.enabled then
            SetPedWeaponMovementClipset(cache.ped, oneHanded.clipset)
        end
        return
    end

    if not weapon and oneHanded.enabled then 
        ResetPedWeaponMovementClipset(cache.ped)
    end
    
    hasWeapon = false
end)

local function toggleWeaponClipset()
    if not hasWeapon then return end

    if not oneHanded.enabled then 
        lib.requestAnimSet(oneHanded.clipset)
        SetPedWeaponMovementClipset(cache.ped, oneHanded.clipset)
        oneHanded.enabled = true
        RemoveAnimSet(ondeHanded.clipset)
    else
        ResetPedWeaponMovementClipset(cache.ped)
        oneHanded.enabled = false
    end
end

RegisterCommand(config.command, toggleWeaponClipset, false)

RegisterKeyMapping(config.command, "Toggle weapon movement style.", "keyboard", config.key)

