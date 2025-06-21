-- MyUILibrary.lua
local MyUILibrary = {}

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Library Configuration
local LibConfig = {
    Title = "My UI Library",
    LoadingEnabled = true,
    ConfigFolder = "MyUIConfig"
}

-- Create Window
function MyUILibrary:CreateWindow(config)
    local Window = {}
    config = config or {}
    
    -- Merge config with defaults
    Window.Name = config.Name or LibConfig.Title
    Window.LoadingEnabled = config.LoadingEnabled or LibConfig.LoadingEnabled
    Window.ConfigSettings = config.ConfigSettings or {
        ConfigFolder = LibConfig.ConfigFolder
    }
    
    -- Store tabs
    Window.Tabs = {}
    
    -- Create new tab
    function Window:CreateTab(tabConfig)
        local Tab = {}
        tabConfig = tabConfig or {}
        
        -- Tab configuration
        Tab.Name = tabConfig.Name or "New Tab"
        Tab.Icon = tabConfig.Icon or ""
        Tab.Sections = {}
        
        -- Create section in tab
        function Tab:CreateSection(name)
            local Section = {}
            Section.Name = name
            Section.Elements = {}
            
            -- Create button
            function Section:CreateButton(config)
                local Button = {}
                Button.Name = config.Name
                Button.Description = config.Description
                Button.Callback = config.Callback
                
                table.insert(Section.Elements, Button)
                return Button
            end
            
            -- Create toggle
            function Section:CreateToggle(config)
                local Toggle = {}
                Toggle.Name = config.Name
                Toggle.Description = config.Description
                Toggle.CurrentValue = config.CurrentValue or false
                Toggle.Callback = config.Callback
                
                table.insert(Section.Elements, Toggle)
                return Toggle
            end
            
            -- Create dropdown
            function Section:CreateDropdown(config)
                local Dropdown = {}
                Dropdown.Name = config.Name
                Dropdown.Description = config.Description
                Dropdown.Options = config.Options or {}
                Dropdown.CurrentOption = config.CurrentOption
                Dropdown.MultipleOptions = config.MultipleOptions or false
                Dropdown.Callback = config.Callback
                
                function Dropdown:Set(newConfig)
                    self.Options = newConfig.Options or self.Options
                    self.CurrentOption = newConfig.CurrentOption or self.CurrentOption
                end
                
                table.insert(Section.Elements, Dropdown)
                return Dropdown
            end
            
            table.insert(Tab.Sections, Section)
            return Section
        end
        
        table.insert(Window.Tabs, Tab)
        return Tab
    end
    
    -- Create home tab
    function Window:CreateHomeTab(config)
        local HomeTab = self:CreateTab({
            Name = "Home",
            Icon = config.Icon or "home"
        })
        return HomeTab
    end
    
    -- Notification system
    function Window:Notification(config)
        print(string.format("[%s] %s: %s", 
            Window.Name,
            config.Title,
            config.Content
        ))
    end
    
    return Window
end

return MyUILibrary
