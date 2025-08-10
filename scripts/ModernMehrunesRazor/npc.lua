local storage = require("openmw.storage")
local types = require("openmw.types")
local self = require("openmw.self")
local I = require('openmw.interfaces')

local sectionGeneral = storage.globalSection("SettingsModernMehrunesRazor_general")
local getActorLuck = types.Actor.stats.attributes.luck

local actorBlacklist = {
    "dagoth_ur_2",
    "heart_akulakhan"
}

local presets = {
    ["Oblivion-style"] = function(player)
        local pl = getActorLuck(player).modified
        return pl * 0.05
    end,
    ["Skyrim-style"] = function(player)
        return 1.98
    end,
    ["Custom"] = function(player)
        local bc = sectionGeneral:get("baseChance")
        local pl = getActorLuck(player).modified
        local lm = sectionGeneral:get("luckModifier")
        return bc + pl * lm
    end,
    ["Cheater"] = function(player)
        return math.huge
    end
}

I.Combat.addOnHitHandler(function(attack)
    if not sectionGeneral:get("modEnabled") then return end
    if not attack.weapon == "mehrunes'_razor_unique" or not attack.successful then return end
    -- check blacklist
    for _, id in ipairs(actorBlacklist) do if id == self.recordId then return end end

    local gameRoll = math.random()
    local preset = presets[sectionGeneral:get("preset")]
    local instakillChance = preset(attack.attacker)

    if sectionGeneral:get("counterRollEnabled") then
        local el = getActorLuck(self).modified
        local elm = sectionGeneral:get("counterRollModifier")
        instakillChance = instakillChance - el * elm
    end

    -- scaling down values to floats for precision
    instakillChance = instakillChance / 100
    if instakillChance >= gameRoll then
        attack.damage.health = math.huge
        attack.attacker:sendEvent("onInstakill")
    end

    if sectionGeneral:get("debugMode") then
        print(
            "Modern Mehrunes' Razor debug message!\n" ..
            "Victim:            " .. self.recordId .. "\n" ..
            "Player chance:     " .. preset(attack.attacker) / 100 .. "\n" ..
            "Enemy chance:      " .. getActorLuck(self).modified * sectionGeneral:get("counterRollModifier") .. "\n" ..
            "Calculated chance: " .. instakillChance .. "\n" ..
            "Game roll:         " .. gameRoll .. "\n" ..
            "Instakill:         " .. tostring(instakillChance >= gameRoll))
    end
end)

return {}
