local App = require("lib.GalaxyHelper.app")
local Colors = require("lib.GalaxyHelper.colors")

local Layout = {}
Layout.__index = Layout

function Layout:new(title, size_x, size_y)
    local self = setmetatable({}, Layout)

    self.title = title
    self.size_x = size_x
    self.size_y = size_y
    self.color_checked = 0xCC7BFC74
    self.color_unchecked = 0xCCFC7474
    self.dialog_id = nil
    self.component_counter = 0
    self.components = {
        current_pos_y = 10,
    }

    local RES_X, RES_Y = getScreenResolution()

    self.DIALOG_SIZE_X = size_x
    self.DIALOG_SIZE_Y = size_y
    self.DIALOG_POS_X = RES_X / 2 - (self.DIALOG_SIZE_X / 2)
    self.DIALOG_POS_Y = RES_Y / 2 - (self.DIALOG_SIZE_Y / 2)

    self.dialog_id = dxutCreateDialog(string.format("{%06X}%s {FFFFFF} - %s", Colors.PRIMARY, App.name, title))

    dxutSetDialogBackgroundColor(self.dialog_id, 0x99000000)
    dxutSetDialogPos(self.dialog_id, self.DIALOG_POS_X, self.DIALOG_POS_Y, self.DIALOG_SIZE_X, self.DIALOG_SIZE_Y)

    return self
end

function Layout:generate_component_id()
    self.component_counter = self.component_counter + 1
    return self.component_counter
end

function Layout:calculate_pos_y_checkbox()
    local pos = self.components.current_pos_y
    self.components.current_pos_y = self.components.current_pos_y + 25

    return pos
end

function Layout:create_checkbox(label, setting_name)
    local component_id = self:generate_component_id()
    table.insert(self.components, {id = component_id})
    
    local is_checked = App.settings[setting_name]
    local pos_y = self:calculate_pos_y_checkbox()


    dxutAddCheckbox(self.dialog_id, component_id, label, 5, pos_y, #label * 12, 20)
    dxutSetCheckboxColor(self.dialog_id, component_id, is_checked and self.color_checked or self.color_unchecked)
    dxutCheckboxSetChecked(self.dialog_id, component_id, is_checked)
end

function Layout:create_button(label, pos_x, pos_y, callback)
    BUTTON_SIZE_X = #label * 10 + 15
    BUTTON_SIZE_Y = 30

    -- Cuando pos_x recibe nil, entonces hay que centrarlo
    if not pos_x then
        pos_x = (self.DIALOG_SIZE_X - BUTTON_SIZE_X) / 2
    end

    local component_id = self:generate_component_id()
    table.insert(self.components, {id = component_id, action = callback})

    dxutAddButton(self.dialog_id, component_id, label, pos_x, pos_y, BUTTON_SIZE_X, BUTTON_SIZE_Y)
end

return Layout
