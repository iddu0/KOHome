local Dispatcher = require("dispatcher")
local InfoMessage = require("ui/widget/infomessage")
local UIManager = require("ui/uimanager")
local WidgetContainer = require("ui/widget/container/widgetcontainer")
local InputDialog = require("ui/widget/inputdialog")
local Notification = require("ui/widget/notification")
local _ = require("gettext")

local KOHome = WidgetContainer:extend{
    name = "KOHome",
    is_doc_only = false,
}

function KOHome:onDispatcherRegisterActions()
    Dispatcher:registerAction("kohome", {
        category="none",
        event="KOHome",
        title=_("KOHome"),
        general=true,
    })
end

function KOHome:init()
    self:onDispatcherRegisterActions()
    self.ui.menu:registerToMainMenu(self)
end

function KOHome:sendAssistQuery(query)
    local http = require("socket.http")
    local ltn12 = require("ltn12")
    local json = require("json") 

    local token = "LONGLIVEDACCESSTOKEN" -- Put your Home Assistant Long Lived Access Token here
    local url = "http://homeassistant.local:8123/api/conversation/process" -- Put your Home Assistant URL Here

    local body = json.encode({ 
        text = query,
        conversation_id = "koreader",
        agent_id = "conversation.google_generative_ai"
    })

    local response_body = {}

    local res, code = http.request{
        url = url,
        method = "POST",
        headers = {
            ["Authorization"] = "Bearer " .. token,
            ["Content-Type"] = "application/json",
            ["Content-Length"] = tostring(#body),
        },
        source = ltn12.source.string(body),
        sink = ltn12.sink.table(response_body)
    }

    local resp_text = table.concat(response_body)
    local data = json.decode(resp_text)
    local speech_text

    if data and data.response and data.response.speech 
       and data.response.speech.plain then
        speech_text = data.response.speech.plain.speech
    end

    UIManager:show(Notification:new{
        text = speech_text or "No response from Home Assistant"
    })
end

function KOHome:openAssistDialog()
    local dlg = InputDialog:new{
        title = _("Home Assistant Assist"),
        input = "",
        input_hint = _("Ask Assist.."),

        save_callback = function(content, closing)
            if content and content ~= "" then
                self:sendAssistQuery(content)
            end
            return true 
        end,

        close_cancel_button_text = _("Cancel"),
        fullscreen = false,
        condensed = false,
        allow_newline = false,
    }

    UIManager:show(dlg)
    dlg:onShowKeyboard()
end

function KOHome:addToMainMenu(menu_items)
    menu_items.kohome = {
        text = _("KOHome"),
        sorting_hint = "tools",
        callback = function()
            self:openAssistDialog()
        end,
    }
end

function KOHome:onKOHome()
    local popup = InfoMessage:new{
        text = _("Currently for Testing!"),
    }
    UIManager:show(popup)
end

return KOHome
