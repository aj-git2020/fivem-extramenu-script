local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-extra:server:CanUseMenu', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then cb(false) return end

    local job = Player.PlayerData.job or {}
    local jobName = job.name
    local jobGrade = (job.grade and job.grade.level) or 0

    if not jobName then
        cb(false)
        return
    end

    local jobData = Config.AllowedJobs[jobName]

    if jobData == nil then
        cb(false)
        return
    end

    if type(jobData) == "table" and jobData.minGrade then
        cb(jobGrade >= jobData.minGrade)
        return
    end

    cb(true)
end)