---- Developer by git@camargo2019

local is_active

cmr = {}

cmr.notify = function(message)
    TriggerEvent("Notify","aviso",message,5000)
end

cmr.fpsbooster = function(shadow,air,entity,dynamic,tracker,depth,bounds,distance,tweak,sirens,lights)
        RopeDrawShadowEnabled(shadow)
        CascadeShadowsClearShadowSampleType()
        CascadeShadowsSetAircraftMode(air)
        CascadeShadowsEnableEntityTracker(entity)
        CascadeShadowsSetDynamicDepthMode(dynamic)
        CascadeShadowsSetEntityTrackerScale(tracker)
        CascadeShadowsSetDynamicDepthValue(depth)
        CascadeShadowsSetCascadeBoundsScale(bounds)
        SetFlashLightFadeDistance(distance)
        SetLightsCutoffDistanceTweak(tweak)
        DistantCopCarSirens(sirens)
        SetArtificialLightsState(lights)
end


cmr.change = function(value)
        if value == "normal" then
            cmr.fpsbooster(true,true,true,true,5.0,5.0,5.0,10.0,10.0,true,false)
            ClearTimecycleModifier()
        elseif value == "ruim" then
            cmr.fpsbooster(false,false,true,false,0.0,0.0,0.0,0.0,0.0,false,nil)
            SetTimecycleModifier("cinema")
        elseif value == "fraco" then
            cmr.fpsbooster(false,false,true,false,0.0,0.0,0.0,5.0,5.0,false,nil)
            SetTimecycleModifier("cinema")
        elseif value == "medio" then
            cmr.fpsbooster(true,false,true,false,5.0,3.0,3.0,3.0,3.0,false,false)
            SetTimecycleModifier("cinema")
        end
        is_active = value
        cmr.notify("Você alterou seu fps para "..is_active)
end

cmr.options = {
        ["normal"] = cmr.change,
        ["ruim"] = cmr.change,
        ["fraco"] = cmr.change,
        ["medio"] = cmr.change
}

cmr.setOption = function(option)
    if cmr.options[option] then
        cmr.options[option](option)
    else
        cmr.notify("Use: /fps [normal/ruim/fraco/medio]")
    end
end



RegisterNetEvent('fpsbooster:client:event', function(data)
end)

CreateThread(function()
    while true do
        if is_active == "ulow" then
            DisableOcclusionThisFrame()
            SetDisableDecalRenderingThisFrame()
            RemoveParticleFxInRange(GetEntityCoords(PlayerPedId()), 10.0)
            OverrideLodscaleThisFrame(0.4)
            SetArtificialLightsState(true)
            ClearAllBrokenGlass()
            ClearAllHelpMessages()
            LeaderboardsReadClearAll()
            ClearBrief()
            ClearGpsFlags()
            ClearPrints()
            ClearSmallPrints()
            ClearReplayStats()
            LeaderboardsClearCacheData()
            ClearFocus()
            ClearHdArea()
            ClearPedBloodDamage(PlayerPedId())
            ClearPedWetness(PlayerPedId())
            ClearPedEnvDirt(PlayerPedId())
            ResetPedVisibleDamage(PlayerPedId())
            ClearExtraTimecycleModifier()
            ClearTimecycleModifier()
            ClearOverrideWeather()
            ClearHdArea()
            DisableVehicleDistantlights(false)
            DisableScreenblurFade()
            SetRainLevel(0.0)
            SetWindSpeed(0.0)
        elseif is_active == "low" then
            SetDisableDecalRenderingThisFrame()
            RemoveParticleFxInRange(GetEntityCoords(PlayerPedId()), 10.0)
            OverrideLodscaleThisFrame(0.6)
            SetArtificialLightsState(true)
            ClearAllBrokenGlass()
            ClearAllHelpMessages()
            LeaderboardsReadClearAll()
            ClearBrief()
            ClearGpsFlags()
            ClearPrints()
            ClearSmallPrints()
            ClearReplayStats()
            LeaderboardsClearCacheData()
            ClearFocus()
            ClearHdArea()
            ClearPedBloodDamage(PlayerPedId())
            ClearPedWetness(PlayerPedId())
            ClearPedEnvDirt(PlayerPedId())
            ResetPedVisibleDamage(PlayerPedId())
            ClearExtraTimecycleModifier()
            ClearTimecycleModifier()
            ClearOverrideWeather()
            ClearHdArea()
            DisableVehicleDistantlights(false)
            DisableScreenblurFade()
            SetRainLevel(0.0)
            SetWindSpeed(0.0)
        elseif is_active == "medio" then
            OverrideLodscaleThisFrame(0.8)
            ClearAllBrokenGlass()
            ClearAllHelpMessages()
            LeaderboardsReadClearAll()
            ClearBrief()
            ClearGpsFlags()
            ClearPrints()
            ClearSmallPrints()
            ClearReplayStats()
            LeaderboardsClearCacheData()
            ClearFocus()
            ClearHdArea()
            SetWindSpeed(0.0)
            Wait(1000)
        else
            Wait(500)
        end
        Wait(500)
    end
end)

RegisterCommand("fps", function(_,args) 
    if args[1] == nil then
        cmr.notify("Use: /fps [normal/ruim/fraco/medio]")
        return 
    end
    cmr.setOption(args[1]) 
end, false)