Config = {}

-- Notification system: 'qb', 'ox', 'custom' (you can extend)
Config.NotifySystem = 'qb' 

-- Notification settings (customize durations, types, etc.)
Config.NotifyDuration = 5000
Config.NotifyTypes = {
    success = 'success',
    error = 'error',
    info = 'inform',
    primary = 'primary',
}

-- Allowed jobs and roles with optional minimum grade level
Config.AllowedJobs = {
    police = { minGrade = 0 },
    mechanic = { minGrade = 2 },
    ambulance = { minGrade = 0 },
    -- add more as needed
}

-- Command settings
Config.Commands = {
    extraMenu = 'extra',       -- command to open the menu
    permission = nil,          -- optional permission string for advanced usage
}

-- Vehicle extra settings
Config.VehicleExtras = {
    maxExtras = 30,            -- max extra indexes to check
}

-- Livery settings
Config.Livery = {
    minCountToShow = 4,        -- min liveries to show the menu option
}

-- Localization strings (example, for easier translation)
Config.Locale = {
    notDriver = 'You must be the driver of a vehicle!',
    notAuthorized = 'You are not authorized to use this menu.',
    toggledExtra = 'Toggled Extra %s',
    liverySet = 'Livery set to %s',
    menuTitle = 'Vehicle Extras',
    liveryMenuTitle = 'Choose Livery',
}