local coreGui = game:GetService("CoreGui")

Theme = {
    WindowBgColor = Color3.fromRGB(43, 43, 43),
    HeaderBgColor = Color3.fromRGB(22, 22, 22),
    HeaderTitleColor = Color3.fromRGB(255, 255, 255),
    MainTextColor = Color3.fromRGB(255, 255, 255),
    BtnColor = Color3.fromRGB(255, 255, 255),
    NavBgColor = Color3.fromRGB(22, 22, 22),
    TabBtnColor = Color3.fromRGB(22, 22, 22),
    TabBtnHighlightColor = Color3.fromRGB(22, 112, 196),
    TitleFont = Enum.Font.GothamBold,
    MainFont = Enum.Font.Gotham,
    TabFont = Enum.Font.GothamSemibold
}

function CreateWindow(title, parent)
    local window = {}
    local frameParent = coreGui

    if parent then
        frameParent = parent
    end

    -- Setup core window frame

    window.Frame = Instance.new("Frame")
    window.Frame.Parent = frameParent
    window.Frame.Name = title
    window.Frame.Style = Enum.FrameStyle.Custom
    window.Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    window.Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    window.Frame.BackgroundColor3 = Theme.WindowBgColor
    window.Frame.BorderSizePixel = 0
    window.Frame.Size = UDim2.new(0, 600, 0, 350)
    window.Frame.Active = true
    window.Frame.Draggable = true
    window.Frame.Selectable = true

    window.Header = Instance.new("Frame")
    window.Header.Parent = window.Frame
    window.Header.Name = "Header"
    window.Header.Style = Enum.FrameStyle.Custom
    window.Header.AnchorPoint = Vector2.new(0, 1)
    window.Header.BackgroundColor3 = Theme.HeaderBgColor
    window.Header.BorderSizePixel = 0
    window.Header.Size = UDim2.new(1, 0, 0, 30)
    window.Header.Active = true
    window.Header.Draggable = false
    window.Header.Selectable = false

    window.HeaderTitle = Instance.new("TextLabel")
    window.HeaderTitle.Parent = window.Header
    window.HeaderTitle.Text = "Title"
    window.HeaderTitle.Font = Theme.TitleFont
    window.HeaderTitle.TextSize = 18
    window.HeaderTitle.AnchorPoint = Vector2.new(0.5, 0.5)
    window.HeaderTitle.TextXAlignment = Enum.TextXAlignment.Center
    window.HeaderTitle.TextYAlignment = Enum.TextYAlignment.Center
    window.HeaderTitle.Position = UDim2.new(0.5, 0, 0.5, 0)
    window.HeaderTitle.TextColor3 = Theme.HeaderTitleColor

    -- Setup navigation

    window.Navigation = {}
    window.Navigation.Frame = Instance.new("Frame")
    window.Navigation.Frame.Parent = window.Frame
    window.Navigation.Frame.Name = "Navigation"
    window.Navigation.Frame.Style = Enum.FrameStyle.Custom
    window.Navigation.Frame.AnchorPoint = Vector2.new(0, 0)
    window.Navigation.Frame.BackgroundColor3 = Theme.NavBgColor
    window.Navigation.Frame.BorderSizePixel = 0
    window.Navigation.Frame.Size = UDim2.new(0.2, 0, 1, 0)
    window.Navigation.Frame.Active = true
    window.Navigation.Frame.Draggable = false
    window.Navigation.Frame.Selectable = false

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
                tab.TabButton.BackgroundColor3 = Theme.TabBtnHighlightColor
                tab.ContentFrame.Visible = true
                tab.IsActive = true
            end,
            Deselect = function(tab)
                tab.TabButton.BackgroundColor3 = Theme.TabBtnColor
                tab.ContentFrame.Visible = false
                tab.IsActive = false
            end
        }
    
        self.Navigation.Tabs[name].TabButton = Instance.new("TextButton")
        local tabButton = self.Navigation.Tabs[name].TabButton
        tabButton.Parent = window.Frame
        tabButton.Name = name .. "TabBtn"
        tabButton.AnchorPoint = Vector2.new(0, 0)
        tabButton.Size = UDim2.new(1, 0, 0, 45)
        tabButton.Text = name
        tabButton.Font = name
        tabButton.BorderSizePixel = 0
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.BackgroundColor3 = Theme.TabBtnColor
        tabButton.Activated:Connect(function()
            window.Navigation.Tabs:SelectTab(name)
        end)
    
        self.Navigation.Tabs[name].Content.Frame = Instance.new("Frame")
        local content = self.Navigation.Tabs[name].Content
        content.Frame.Parent = self.Frame
        content.Frame.AnchorPoint = Vector2.new(0, 0)
        content.Frame.Size = UDim2.new(0.8, 0, 1, 0)
        content.Frame.Position = UDim2.new(0.2, 0, 0, 0)
        content.Frame.BackgroundTransparency = 1
        content.Frame.Active = true
        content.Frame.Draggable = false
        content.Frame.Selectable = false

        content.BorderPadding = Instance.new("UIPadding")
        content.BorderPadding.Parent = content.Frame
        content.BorderPadding.PaddingTop = UDim.new(0, 10)
        content.BorderPadding.PaddingBottom = UDim.new(0, 10)
        content.BorderPadding.PaddingLeft = UDim.new(0, 10)
        content.BorderPadding.PaddingRight = UDim.new(0, 10)

        content.Layout = Instance.new("UIGridLayout")
        content.Layout.Parent = content.Frame
        content.Layout.Name = "List"
        content.Layout.CellSize = UDim2.new(0.5, 0, 0, 30)
        content.Layout.SortOrder = Enum.SortOrder.LayoutOrder
    
        local tab = self.Navigation.Tabs[name]
        tab.CreateLabel = function(_, labelText)
            local label = Instance.new("TextLabel")
            label.Parent = content.Frame
            label.Text = labelText
            label.Font = Theme.MainFont
            label.TextSize = 14
            label.AnchorPoint = Vector2.new(0, 0)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextYAlignment = Enum.TextYAlignment.Top
            label.TextColor3 = Theme.MainTextColor
            return label
        end

        tab.CreateToggle = function(_, labelText, valueChangedCallback)

            return {}
        end

        tab.CreateSlider = function(_, min, max, valueChangedCallback)
            return {}
        end

        tab.CreateDropdown = function(_, options, valueChangedCallback)
            return {}
        end

        return tab
    end

    window.Destroy = function()
        window.Frame:Destroy()
    end
    return window
end