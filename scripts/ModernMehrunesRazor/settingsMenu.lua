local I = require('openmw.interfaces')

I.Settings.registerPage {
    key = 'ModernMehrunesRazor',
    l10n = 'ModernMehrunesRazor',
    name = 'page_name',
    description = 'page_description',
}

I.Settings.registerGroup {
    key = 'GeneralModernMehrunesRazor',
    page = 'ModernMehrunesRazor',
    l10n = 'ModernMehrunesRazor',
    name = 'general_group_name',
    permanentStorage = true,
    settings = {
        {
            key = 'modEnabled',
            name = 'modEnabled_name',
            renderer = 'checkbox',
            default = true,
        },
        {
            key = 'preset',
            name = 'preset_name',
            description = 'preset_description',
            renderer = 'select',
            argument = {
                l10n = "ModernMehrunesRazor",
                items = {
                    "Oblivion-style",
                    "Skyrim-style",
                    "Custom"
                },
            }
        },
        {
            key = 'baseChance',
            name = 'baseChance_name',
            description = 'baseChance_description',
            renderer = 'number',
            integer = false,
            default = 1,
        },
        {
            key = 'luckModifier',
            name = 'luckModifier_name',
            description = 'luckModifier_description',
            renderer = 'number',
            integer = false,
            default = 0.02,
        },
    }
}

I.Settings.registerGroup {
    key = 'OnInstakillModernMehrunesRazor',
    page = 'ModernMehrunesRazor',
    l10n = 'ModernMehrunesRazor',
    name = 'onInstakill_group_name',
    permanentStorage = true,
    settings = {
        {
            key = 'showMessage',
            name = 'showMessage_name',
            description = 'showMessage_description',
            renderer = 'checkbox',
            default = true,
        },
        {
            key = 'playSFX',
            name = 'playSFX_name',
            renderer = 'checkbox',
            default = true,
        },
    }
}