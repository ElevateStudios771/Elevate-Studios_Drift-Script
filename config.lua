-- Config File
Config = {}

-- Enable debug messages
Config.Debug = false

-- Allowed Vehicles for Drift Mode
Config.AllowedVehicles = {
    "futo",
    "elegy",
    "jester",
    "comet2"
}

-- Drift Settings
Config.DriftSettings = {
    tractionMin = 0.1,  -- Less grip
    tractionMax = 0.3,
    lateralGrip = 1.5,
    lowSpeedLoss = 1.5,
    powerMultiplier = 2.2 -- Engine power boost
}

local driftEnabled = {}

RegisterCommand("drift", function(source)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local vehicleModel = GetEntityModel(vehicle)
    local vehicleName = GetDisplayNameFromVehicleModel(vehicleModel):lower()

    if vehicle ~= 0 then
        if not Config.AllowedVehicles[vehicleName] then
            TriggerEvent("chat:addMessage", { args = { "^1Drift Mode: ^7This vehicle is not allowed!" } })
            return
        end

        if not driftEnabled[vehicle] then
            -- Enable Drift Mode
            SetVehicleReduceGrip(vehicle, true)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin", Config.DriftSettings.tractionMin)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax", Config.DriftSettings.tractionMax)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral", Config.DriftSettings.lateralGrip)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult", Config.DriftSettings.lowSpeedLoss)
            SetVehicleEnginePowerMultiplier(vehicle, Config.DriftSettings.powerMultiplier)
            driftEnabled[vehicle] = true
            TriggerEvent("chat:addMessage", { args = { "^2Drift Mode: ^7Enabled" } })
        else
            -- Disable Drift Mode
            SetVehicleReduceGrip(vehicle, false)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin", 1.0)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax", 1.2)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral", 2.0)
            SetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult", 0.5)
            SetVehicleEnginePowerMultiplier(vehicle, 1.0)
            driftEnabled[vehicle] = false
            TriggerEvent("chat:addMessage", { args = { "^1Drift Mode: ^7Disabled" } })
        end
    else
        TriggerEvent("chat:addMessage", { args = { "^1Error: ^7You must be in a vehicle!" } })
    end
end, false)
