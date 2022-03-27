Exo = {
    MenuLib = {
        Theme = {
            WindowBgColor = Color3.fromRGB(43, 43, 43),
            HeaderBgColor = Color3.fromRGB(22, 22, 22),
            HeaderTitleColor = Color3.fromRGB(255, 255, 255),
            MainTextColor = Color3.fromRGB(255, 255, 255),
            BtnColor = Color3.fromRGB(255, 255, 255),
            NavBgColor = Color3.fromRGB(22, 22, 22),
            TabBtnColor = Color3.fromRGB(22, 22, 22),
            TabBtnHighlightColor = Color3.fromRGB(22, 112, 196),
            ToggleOnColor = Color3.fromRGB(22, 112, 196),
            ToggleOffColor = Color3.fromRGB(22, 22, 22),
            TitleFont = Enum.Font.GothamBold,
            MainFont = Enum.Font.Gotham,
            TabFont = Enum.Font.GothamSemibold
        }
    },
    LoggerLib = {},
    PrintLib = {},
    MathLib = {},
    CameraLib = {},
    EspLib = {},
    InputLib = {},
    SynapseUtilsLib = {},
}




--[[
MENU LIBRARY
--]]

function Exo.MenuLib:CreateWindow(title, parent)
    local window = {}
    local frameParent = parent

    -- Setup core window frame

    window.Frame = Instance.new("Frame")
    window.Frame.Parent = frameParent
    window.Frame.Name = title
    window.Frame.Style = Enum.FrameStyle.Custom
    window.Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    window.Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    window.Frame.BackgroundColor3 = self.Theme.WindowBgColor
    window.Frame.BorderSizePixel = 0
    window.Frame.BackgroundTransparency = 0.1
    window.Frame.Size = UDim2.new(0, 500, 0, 350)
    window.Frame.Active = true
    window.Frame.Draggable = true
    window.Frame.Selectable = true

    window.Header = Instance.new("Frame")
    window.Header.Parent = window.Frame
    window.Header.Name = "Header"
    window.Header.Style = Enum.FrameStyle.Custom
    window.Header.AnchorPoint = Vector2.new(0, 1)
    window.Header.BackgroundColor3 = self.Theme.HeaderBgColor
    window.Header.BorderSizePixel = 0
    window.Header.Size = UDim2.new(1, 0, 0, 30)
    window.Header.Active = true
    window.Header.Draggable = false
    window.Header.Selectable = false

    window.HeaderTitle = Instance.new("TextLabel")
    window.HeaderTitle.Parent = window.Header
    window.HeaderTitle.Text = title
    window.HeaderTitle.Font = self.Theme.TitleFont
    window.HeaderTitle.TextSize = 18
    window.HeaderTitle.AnchorPoint = Vector2.new(0.5, 0.5)
    window.HeaderTitle.TextXAlignment = Enum.TextXAlignment.Center
    window.HeaderTitle.TextYAlignment = Enum.TextYAlignment.Center
    window.HeaderTitle.Position = UDim2.new(0.5, 0, 0.5, 0)
    window.HeaderTitle.TextColor3 = self.Theme.HeaderTitleColor

    -- Setup navigation

    window.Navigation = {}
    window.Navigation.Frame = Instance.new("Frame")
    window.Navigation.Frame.Parent = window.Frame
    window.Navigation.Frame.Name = "Navigation"
    window.Navigation.Frame.Style = Enum.FrameStyle.Custom
    window.Navigation.Frame.AnchorPoint = Vector2.new(0, 0)
    window.Navigation.Frame.BackgroundColor3 = self.Theme.NavBgColor
    window.Navigation.Frame.BorderSizePixel = 0
    window.Navigation.Frame.Size = UDim2.new(0.2, 0, 1, 0)
    window.Navigation.Frame.Active = true
    window.Navigation.Frame.Draggable = false
    window.Navigation.Frame.Selectable = false
    window.Navigation.Frame.BackgroundTransparency = 0.5

    window.Navigation.TabList = Instance.new("UIListLayout")
    window.Navigation.TabList.Parent = window.Navigation.Frame
    window.Navigation.TabList.Name = "List"
    window.Navigation.TabList.FillDirection = Enum.FillDirection.Vertical
    window.Navigation.TabList.SortOrder = Enum.SortOrder.LayoutOrder

    window.Navigation.Tabs = {
        CurrentTab = "",
        SelectTab = function(self, tabName)
            if self.CurrentTab ~= "" then
                self[self.CurrentTab]:Deselect()
            end
            
            self[tabName]:Select()
            self.CurrentTab = tabName
        end
    }

    window.CreateTab = function(self, name)
        self.Navigation.Tabs[name] = {
            IsActive = true,
            Select = function(tab)
                tab.TabButton.BackgroundColor3 = Exo.MenuLib.Theme.TabBtnHighlightColor
                tab.Content.Frame.Visible = true
                tab.IsActive = true
            end,
            Deselect = function(tab)
                tab.TabButton.BackgroundColor3 = Exo.MenuLib.Theme.TabBtnColor
                tab.Content.Frame.Visible = false
                tab.IsActive = false
            end
        }
    
        self.Navigation.Tabs[name].TabButton = Instance.new("TextButton")
        self.Navigation.Tabs[name].TabButton.Parent = self.Navigation.Frame
        self.Navigation.Tabs[name].TabButton.Name = name .. "TabBtn"
        self.Navigation.Tabs[name].TabButton.AnchorPoint = Vector2.new(0, 0)
        self.Navigation.Tabs[name].TabButton.Size = UDim2.new(1, 0, 0, 45)
        self.Navigation.Tabs[name].TabButton.Text = name
        self.Navigation.Tabs[name].TabButton.Font = Exo.MenuLib.Theme.TabFont
        self.Navigation.Tabs[name].TabButton.TextSize = 14
        self.Navigation.Tabs[name].TabButton.BorderSizePixel = 0
        self.Navigation.Tabs[name].TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        self.Navigation.Tabs[name].TabButton.BackgroundColor3 = Exo.MenuLib.Theme.TabBtnColor
        self.Navigation.Tabs[name].TabButton.Activated:Connect(function()
            window.Navigation.Tabs:SelectTab(name)
        end)
    
        self.Navigation.Tabs[name].Content = {}
        self.Navigation.Tabs[name].Content.Frame = Instance.new("Frame")
        self.Navigation.Tabs[name].Content.Frame.Parent = self.Frame
        self.Navigation.Tabs[name].Content.Frame.AnchorPoint = Vector2.new(0, 0)
        self.Navigation.Tabs[name].Content.Frame.Size = UDim2.new(0.8, 0, 1, 0)
        self.Navigation.Tabs[name].Content.Frame.Position = UDim2.new(0.2, 0, 0, 0)
        self.Navigation.Tabs[name].Content.Frame.BackgroundTransparency = 1
        self.Navigation.Tabs[name].Content.Frame.Active = true
        self.Navigation.Tabs[name].Content.Frame.Draggable = false
        self.Navigation.Tabs[name].Content.Frame.Selectable = false
        self.Navigation.Tabs[name].Content.Frame.Visible = false

        self.Navigation.Tabs[name].Content.BorderPadding = Instance.new("UIPadding")
        self.Navigation.Tabs[name].Content.BorderPadding.Parent = self.Navigation.Tabs[name].Content.Frame
        self.Navigation.Tabs[name].Content.BorderPadding.PaddingTop = UDim.new(0, 10)
        self.Navigation.Tabs[name].Content.BorderPadding.PaddingBottom = UDim.new(0, 10)
        self.Navigation.Tabs[name].Content.BorderPadding.PaddingLeft = UDim.new(0, 10)
        self.Navigation.Tabs[name].Content.BorderPadding.PaddingRight = UDim.new(0, 10)

        self.Navigation.Tabs[name].Content.Layout = Instance.new("UIGridLayout")
        self.Navigation.Tabs[name].Content.Layout.Parent = self.Navigation.Tabs[name].Content.Frame
        self.Navigation.Tabs[name].Content.Layout.Name = "List"
        self.Navigation.Tabs[name].Content.Layout.CellSize = UDim2.new(0.5, 0, 0, 15)
        self.Navigation.Tabs[name].Content.Layout.SortOrder = Enum.SortOrder.LayoutOrder

        self.Navigation.Tabs[name].CreateLabel = function(_, labelText)
            local label = Instance.new("TextLabel")
            label.Parent = self.Navigation.Tabs[name].Content.Frame
            label.Text = labelText
            label.Font = Exo.MenuLib.Theme.MainFont
            label.TextSize = 14
            label.AnchorPoint = Vector2.new(0, 0)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextYAlignment = Enum.TextYAlignment.Top
            label.TextColor3 = Exo.MenuLib.Theme.MainTextColor
            label.BackgroundTransparency = 1
            return label
        end

        self.Navigation.Tabs[name].CreateToggle = function(_, labelText, defaultState, valueChangedCallback)
            local toggle = { IsOn = defaultState }

            toggle.Frame = Instance.new("Frame")
            toggle.Frame.Parent = self.Navigation.Tabs[name].Content.Frame
            toggle.Frame.Size = UDim2.new(1, 0, 1, 0)
            toggle.Frame.BackgroundTransparency = 1
            toggle.Frame.Active = true
            toggle.Frame.Draggable = false
            toggle.Frame.Selectable = false

            toggle.Label = Instance.new("TextLabel")
            toggle.Label.Parent = toggle.Frame
            toggle.Label.Text = labelText
            toggle.Label.Font = Exo.MenuLib.Theme.MainFont
            toggle.Label.TextSize = 14
            toggle.Label.AnchorPoint = Vector2.new(0, 0.5)
            toggle.Label.TextXAlignment = Enum.TextXAlignment.Left
            toggle.Label.TextYAlignment = Enum.TextYAlignment.Center
            toggle.Label.Size = UDim2.new(0.7, 0, 1, 0)
            toggle.Label.Position = UDim2.new(0, 0, 0.5, 0)
            toggle.Label.TextColor3 = Exo.MenuLib.Theme.MainTextColor
            toggle.Label.BackgroundTransparency = 1

            toggle.Button = Instance.new("TextButton")
            toggle.Button.Parent = toggle.Frame
            toggle.Button.Font = Exo.MenuLib.Theme.MainFont
            toggle.Button.TextSize = 14
            toggle.Button.AnchorPoint = Vector2.new(1, 0.5)
            toggle.Button.Position = UDim2.new(1, 0, 0.5, 0)
            toggle.Button.TextXAlignment = Enum.TextXAlignment.Center
            toggle.Button.TextYAlignment = Enum.TextYAlignment.Center
            toggle.Button.TextColor3 = Exo.MenuLib.Theme.MainTextColor
            toggle.Button.BorderSizePixel = 0
            toggle.Button.Size = UDim2.new(0.3, 0, 1, 0)
            toggle.Button.Activated:Connect(function()
                toggle:Toggle()
            end)

            toggle.Toggle = function(selfToggle)
                selfToggle:SetState(not toggle.IsOn)
                valueChangedCallback(selfToggle.IsOn)
            end

            toggle.SetState = function(selfToggle, newState)
                selfToggle.IsOn = newState

                if selfToggle.IsOn then
                    selfToggle.Button.BackgroundColor3 = Exo.MenuLib.Theme.ToggleOnColor
                    selfToggle.Button.Text = "On"
                else
                    selfToggle.Button.BackgroundColor3 = Exo.MenuLib.Theme.ToggleOffColor
                    selfToggle.Button.Text = "Off"
                end

                valueChangedCallback(selfToggle.IsOn)
            end

            toggle:SetState(defaultState)

            return toggle
        end

        self.Navigation.Tabs[name].CreateSlider = function(_, min, max, valueChangedCallback)
            return {}
        end

        self.Navigation.Tabs[name].CreateDropdown = function(_, options, valueChangedCallback)
            return {}
        end

        return self.Navigation.Tabs[name]
    end

    window.ToggleVisible = function(_)
        window:SetVisible(not window.Frame.Visible)
    end

    window.SetVisible = function(_, visibleState)
        window.Frame.Visible = visibleState
    end

    window.SelectTab = function(_, tabName)
        window.Navigation.Tabs:SelectTab(tabName)
    end

    window.GetTab = function(_, tabName)
        return window.Navigation.Tabs[tabName]
    end

    window.Destroy = function(_)
        window.Frame:Destroy()
    end
    return window
end




--[[
LOGGER LIBRARY
--]]

function Exo.LoggerLib:LogInfo(message)
    printconsole(message, 0, 0, 200)
end

function Exo.LoggerLib:LogWarning(message)
    printconsole(message, 200, 160, 0)
end

function Exo.LoggerLib:LogError(message)
    printconsole(message, 200, 0, 0)
end




--[[
PRINT LIBRARY
--]]

function Exo.PrintLib:PrintTable(name, tableToPrint, maxDepth)
    print("START", name)
    print("---------------------------------------------------------------")

    local printTable = function(selfFunc, t, depth)
        for key, value in pairs(t) do
            local currentDepth = depth
            local indentChars = {}
            for _ = 1, currentDepth, 1 do
                table.insert(indentChars, ">")
            end

            if currentDepth <= 0 then
                print("[" .. typeof(value) .. "]", tostring(key), "=", tostring(value))
            else
                print(table.concat(indentChars, ""), "[" .. typeof(value) .. "]", tostring(key), "=", tostring(value))
            end

            if typeof(value) == "table" and currentDepth < maxDepth then
                selfFunc(selfFunc, value, currentDepth + 1)
            end
        end
    end

    printTable(printTable, tableToPrint, 0)

    print("---------------------------------------------------------------")
    print("END")
end




--[[
MATH LIBRARY
--]]

function Exo.MathLib:Lerp(start, goal, alpha)
    return start + (goal - start) * alpha
end




--[[
CAMERA LIBRARY
--]]

function Exo.CameraLib:LookAt(camera, position)
    local target = CFrame.new(camera.CFrame.Position, position)
    camera.CFrame = target
    camera.Focus = camera.CFrame * CFrame.new(0, 0, -20)
end




--[[
ESP LIBRARY
--]]

function Exo.EspLib:CreateEspBox(parent, player)
    local espBox = {
        Player = player,
        Target = nil,
        TargetVisibilityCheckOrigin = nil
    }

    espBox.Frame = Instance.new("Frame")
    espBox.Frame.Parent = parent
    espBox.Frame.Name = "EspBox" .. player.UserId
    espBox.Frame.Style = Enum.FrameStyle.Custom
    espBox.Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    espBox.Frame.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    espBox.Frame.BackgroundTransparency = 0.85
    espBox.Frame.BorderSizePixel = 0
    espBox.Frame.Size = UDim2.new(0, 0, 0, 0)
    espBox.Frame.Active = false
    espBox.Frame.Draggable = false
    espBox.Frame.Selectable = false

    espBox.SetTarget = function(selfEspBox, newTarget)
        selfEspBox.Target = newTarget
    end

    espBox.CreateText = function(selfEspBox, textId, offsetPos)
        selfEspBox[textId] = Instance.new("TextLabel")
        selfEspBox[textId].Parent = espBox.Frame
        selfEspBox[textId].Text = player.Name
        selfEspBox[textId].TextColor3 = Color3.fromRGB(255, 255, 255)
        selfEspBox[textId].Position = offsetPos
        selfEspBox[textId].Font = Enum.Font.Highway
        selfEspBox[textId].TextSize = 13
        selfEspBox[textId].AnchorPoint = Vector2.new(0.5, 0)
        selfEspBox[textId].TextXAlignment = Enum.TextXAlignment.Center
        selfEspBox[textId].TextYAlignment = Enum.TextYAlignment.Top
        return selfEspBox[textId]
    end

    espBox.GetText = function(selfEspBox, textId)
        return selfEspBox[textId]
    end

    espBox.SetVisible = function(selfEspBox, show)
        selfEspBox.Frame.Visible = show
    end

    espBox.FollowTarget = function(selfEspBox, camera)
        if not selfEspBox.Target or selfEspBox.Target and not selfEspBox.Target.PrimaryPart then
            selfEspBox:SetVisible(false)
            return
        end

        local targetPos = selfEspBox.Target.PrimaryPart.Position
        
        local screenPos, isOnScreen = camera:WorldToScreenPoint(targetPos)
        selfEspBox:SetVisible(isOnScreen and selfEspBox.Player ~= game:GetService("Players").LocalPlayer)

        if not isOnScreen then
            return
        end

        selfEspBox:CalculateBoxSize(camera)
        selfEspBox.Frame.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y)

        if selfEspBox:IsTargetVisible(camera) then
            selfEspBox.Frame.BackgroundColor3 = Color3.fromRGB(67, 150, 0)
        else
            selfEspBox.Frame.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        end
    end

    espBox.IsTargetVisible = function(selfEspBox, camera)
        local targetPart = selfEspBox.Target.PrimaryPart
        if selfEspBox.TargetVisibilityCheckOrigin then
            targetPart = selfEspBox.TargetVisibilityCheckOrigin
        end

        local direction = (camera.CFrame.Position - targetPart.Position).Unit
        local distance = (camera.CFrame.Position - targetPart.Position).Magnitude - 4

        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {targetPart}
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastParams.IgnoreWater = true

        return not workspace:Raycast(targetPart.Position, direction * distance, raycastParams)
    end

    espBox.SetTransparency = function(selfEspBox, newTransparency)
        selfEspBox.Frame.BackgroundTransparency = newTransparency
    end

    espBox.CalculateBoxSize = function(selfEspBox, camera)
        local characterSize = selfEspBox.Target:GetExtentsSize()
        local characterCFrame = selfEspBox.Target.PrimaryPart.CFrame
        local characterPos = selfEspBox.Target.PrimaryPart.Position

        local topLeftScreenPos = camera:WorldToScreenPoint(characterPos + characterCFrame.UpVector * (characterSize.Y * 0.5) - characterCFrame.RightVector * (characterSize.X * 0.5))
        local bottomRightScreenPos = camera:WorldToScreenPoint(characterPos - characterCFrame.UpVector * (characterSize.Y * 0.5) + characterCFrame.RightVector * (characterSize.X * 0.5))

        local width = math.abs(topLeftScreenPos.X - bottomRightScreenPos.X)
        local height = math.abs(bottomRightScreenPos.Y - topLeftScreenPos.Y)
        selfEspBox.Frame.Size = UDim2.new(0, width, 0, height)
    end

    espBox.Destroy = function(selfEspBox)
        selfEspBox.Frame:Destroy()
    end

    return espBox
end




--[[
INPUT LIBRARY
--]]

function Exo.InputLib:InputBegan(callbackFunc)
    return game:GetService("UserInputService").InputBegan:Connect(callbackFunc)
end

function Exo.InputLib:InputEnded(callbackFunc)
    return game:GetService("UserInputService").InputEnded:Connect(callbackFunc)
end

function Exo.InputLib:InputChanged(callbackFunc)
    return game:GetService("UserInputService").InputChanged:Connect(callbackFunc)
end




--[[
SYNAPSE UTILS LIBRARY
--]]

function Exo.SynapseUtilsLib:IterateGCFuncs(script, iterationCallbackFunc)
    for _, v in next, getgc() do
        if typeof(v) == "function" then
            local currentScript = getfenv(v).script
            if currentScript and typeof(script) == "Instance" then
                if currentScript == script then
                    local func = v
                    iterationCallbackFunc(func)
                end
            end
        end
    end
end

function Exo.SynapseUtilsLib:GetGCScriptUpValues(script)
    local upvalues = {}
    for _, v in next, getgc() do
        if typeof(v) == "function" then
            local currentScript = getfenv(v).script
            if currentScript and typeof(script) == "Instance" then
                if currentScript == script then
                    for key, value in next, debug.getupvalues(v) do
                        upvalues[key] = value
                    end
                end
            end
        end
    end

    return upvalues
end

function Exo.SynapseUtilsLib:GetGCScriptConstants(script)
    local constants = {}
    for _, v in next, getgc() do
        if typeof(v) == "function" then
            local currentScript = getfenv(v).script
            if currentScript and typeof(script) == "Instance" then
                if currentScript == script then
                    for key, value in next, debug.getconstants(v) do
                        constants[key] = value
                    end
                end
            end
        end
    end

    return constants
end