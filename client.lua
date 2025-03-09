local driftEnabled = false

RegisterCommand("drift", function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle ~= 0 then
        if not driftEnabled then
            -- Enable Drift Mode
            SetVehicleReduceGrip(vehicle, true)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin", 0.1) -- Less grip
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax", 0.3)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral", 2.5)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult", 1.5)
            SetVehicleEnginePowerMultiplier(vehicle, 1.2) -- Slight power boost
            driftEnabled = true
            TriggerEvent("chat:addMessage", { args = { "^2Drift Mode: ^7Enabled" } })
        else
            -- Disable Drift Mode
            SetVehicleReduceGrip(vehicle, false)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin", 1.0)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax", 1.2)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral", 2.0)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult", 0.5)
            SetVehicleEnginePowerMultiplier(vehicle, 1.0)
            driftEnabled = false
            TriggerEvent("chat:addMessage", { args = { "^1Drift Mode: ^7Disabled" } })
        end
    else
        TriggerEvent("chat:addMessage", { args = { "^1Error: ^7You must be in a vehicle!" } })
    end
end, false)
