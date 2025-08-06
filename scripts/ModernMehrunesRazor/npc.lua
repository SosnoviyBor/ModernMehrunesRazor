local storage = require("openmw.storage")
local types = require("openmw.types")
local self = require("openmw.self")
local I = require('openmw.interfaces')

local sectionGeneral = storage.globalSection("SettingsModernMehrunesRazor_general")

local actorBlacklist = {
    -- theyre meant to be unkillable, so yeah
    "dagoth_ur_2",
    "heart_akulakhan"
}

local presets = {
    ["Oblivion-style"] = function(player)
        local pl = types.Actor.stats.attributes.luck(player).modified
        return pl * 0.05
    end,
    ["Skyrim-style"] = function(player)
        return 1.98
    end,
    ["Custom"] = function(player)
        local bc = sectionGeneral:get("baseChance")
        local pl = types.Actor.stats.attributes.luck(player).modified
        local lm = sectionGeneral:get("luckModifier")
        return bc + pl * lm
    end
}

I.Combat.addOnHitHandler(function(attack)
    print("\n\n\nANYTHING\n\n\n")
    if not sectionGeneral:get("modEnabled") then return end
    if not attack.weapon == "mehrunes'_razor_unique" or not attack.successful then return end
    -- check blacklist
    for _, id in ipairs(actorBlacklist) do if id == self.id then return end end

    local gameRoll = math.random()
    local preset = presets[sectionGeneral:get("preset")]
    local playerRoll = preset(attack.attacker) / 100 -- scaling down values to floats for precision
    if playerRoll >= gameRoll then
        attack.damage.health = math.maxinteger
        attack.attacker:sendEvent("onInstakill")
    end
end)

return {}
