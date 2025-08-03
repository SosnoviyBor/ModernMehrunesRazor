local storage = require("openmw.storage")
local ambient = require("openmw.ambient")
local types = require("openmw.types")
local self = require("openmw.self")
local core = require("openmw.core")
local ui = require("openmw.ui")

local l10n = core.l10n("ModernMehrunesRazor")
local sectionGeneral = storage.playerSection("GeneralModernMehrunesRazor")
local sectionOnInstakill = storage.playerSection("OnInstakillModernMehrunesRazor")

local rollForPlayer = {
    ["Oblivion-style"] = function()
        local pl = types.Actor.stats.attributes.luck(self).modified
        return pl * 0.05
    end,
    ["Skyrim-style"] = function()
        return 1.98
    end,
    ["Custom"] = function()
        local bc = sectionGeneral:get("baseChance")
        local pl = types.Actor.stats.attributes.luck(self).modified
        local lm = sectionGeneral:get("luckModifier")
        return bc + pl * lm
    end
}

local function onHit(attackInfo)
    if (attackInfo.weapon == "mehrunes'_razor_unique"
            and attackInfo.successful
            and sectionGeneral:get("modEnabled")) then
        -- scaling down values to floats for precision
        local gameRoll = math.random()
        local playerRoll = rollForPlayer[sectionGeneral:get("preset")]() / 100
        if playerRoll >= gameRoll then
            -- if there will be any issues with this type of damage
            -- change it to actor->sethealth 0 via mwscript
            attackInfo.damage.health = math.maxinteger

            if sectionOnInstakill:get("showMessage") then
                ui.showMessage(l10n("messageDaedricBanishing"))
            end
            if sectionOnInstakill:get("playSFX") then
                ambient.playSound("critical damage")
            end
        end
    end
end

return {
    engineHandlers = {
        onLoad = function()
            if core.API_REVISION < 87 then
                ui.showMessage(
                    l10n("messageOutdatedLuaAPI"),
                    { showInDualogue = true }
                )
            end
        end
    },
    eventHandlers = {
        Hit = onHit,
    }
}
