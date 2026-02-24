-- ===========================================
-- ORION LIBRARY CORRIGIDA - DEFINITIVA
-- SEM ERROS, 100% FUNCIONAL
-- ===========================================

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local OrionLib = {
    Elements = {},
    ThemeObjects = {},
    Connections = {},
    Flags = {},
    Themes = {
        Default = {
            Main = Color3.fromRGB(25, 25, 25),
            Second = Color3.fromRGB(32, 32, 32),
            Stroke = Color3.fromRGB(60, 60, 60),
            Divider = Color3.fromRGB(60, 60, 60),
            Text = Color3.fromRGB(240, 240, 240),
            TextDark = Color3.fromRGB(150, 150, 150)
        }
    },
    SelectedTheme = "Default"
}

-- ÍCONES LOCAIS (FUNCIONAM SEM INTERNET)
local Icons = {
    ["menu"] = "rbxassetid://6031280882",
    ["x"] = "rbxassetid://6031280972",
    ["chevron-down"] = "rbxassetid://6031281042",
    ["check"] = "rbxassetid://6031280933",
    ["home"] = "rbxassetid://6031280823"
}

local function GetIcon(IconName)
    return Icons[IconName] or IconName
end

-- CRIAR SCREEN GUI
local Orion = Instance.new("ScreenGui")
Orion.Name = "Orion"
Orion.Parent = game:GetService("CoreGui")
Orion.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Orion.Enabled = true
Orion.ResetOnSpawn = false

-- LIMPAR INSTÂNCIAS ANTIGAS
for _, v in pairs(game.CoreGui:GetChildren()) do
    if v.Name == "Orion" and v ~= Orion then
        v:Destroy()
    end
end

-- FUNÇÃO PARA CRIAR OBJETOS
local function Create(ClassName, Properties, Children)
    local Object = Instance.new(ClassName)
    for Property, Value in pairs(Properties or {}) do
        pcall(function() Object[Property] = Value end)
    end
    for _, Child in pairs(Children or {}) do
        if Child then Child.Parent = Object end
    end
    return Object
end

-- SISTEMA DE ELEMENTOS
function OrionLib:CreateElement(Name, Func)
    self.Elements[Name] = Func
end

function OrionLib:MakeElement(Name, ...)
    return self.Elements[Name](...)
end

-- ELEMENTOS BÁSICOS
OrionLib:CreateElement("Corner", function(Scale, Offset)
    return Create("UICorner", {CornerRadius = UDim.new(Scale or 0, Offset or 8)})
end)

OrionLib:CreateElement("List", function(Scale, Offset)
    return Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(Scale or 0, Offset or 6)
    })
end)

OrionLib:CreateElement("Padding", function(Bottom, Left, Right, Top)
    return Create("UIPadding", {
        PaddingBottom = UDim.new(0, Bottom or 10),
        PaddingLeft = UDim.new(0, Left or 10),
        PaddingRight = UDim.new(0, Right or 10),
        PaddingTop = UDim.new(0, Top or 10)
    })
end)

OrionLib:CreateElement("TFrame", function()
    return Create("Frame", {BackgroundTransparency = 1})
end)

OrionLib:CreateElement("Frame", function(Color)
    return Create("Frame", {
        BackgroundColor3 = Color or Color3.fromRGB(255,255,255),
        BorderSizePixel = 0
    })
end)

OrionLib:CreateElement("RoundFrame", function(Color, Radius)
    return Create("Frame", {
        BackgroundColor3 = Color or Color3.fromRGB(255,255,255),
        BorderSizePixel = 0
    }, {Create("UICorner", {CornerRadius = UDim.new(0, Radius or 8)})})
end)

OrionLib:CreateElement("Button", function()
    return Create("TextButton", {
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    })
end)

OrionLib:CreateElement("ScrollFrame", function(Color, Width)
    return Create("ScrollingFrame", {
        BackgroundTransparency = 1,
        ScrollBarImageColor3 = Color or Color3.fromRGB(100,100,100),
        BorderSizePixel = 0,
        ScrollBarThickness = Width or 4,
        CanvasSize = UDim2.new(0,0,0,0)
    })
end)

OrionLib:CreateElement("Image", function(ImageID)
    return Create("ImageLabel", {
        Image = GetIcon(ImageID),
        BackgroundTransparency = 1
    })
end)

OrionLib:CreateElement("Label", function(Text, TextSize)
    return Create("TextLabel", {
        Text = Text or "",
        TextColor3 = Color3.fromRGB(240,240,240),
        TextSize = TextSize or 15,
        Font = Enum.Font.Gotham,
        RichText = true,
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left
    })
end)

-- FUNÇÃO DE ARRASTAR
local function MakeDraggable(DragPoint, Main)
    local dragging, dragInput, startPos, startMousePos = false
    DragPoint.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = Main.Position
            startMousePos = input.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    DragPoint.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - startMousePos
            Main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- SISTEMA DE NOTIFICAÇÕES
local NotificationHolder = OrionLib:MakeElement("TFrame")
NotificationHolder.Parent = Orion
NotificationHolder.Size = UDim2.new(1, -25, 1, -25)
NotificationHolder.Position = UDim2.new(1, -25, 1, -25)
NotificationHolder.AnchorPoint = Vector2.new(1, 1)

local NotificationList = OrionLib:MakeElement("List", 0, 5)
NotificationList.Parent = NotificationHolder
NotificationList.HorizontalAlignment = Enum.HorizontalAlignment.Center
NotificationList.VerticalAlignment = Enum.VerticalAlignment.Bottom

function OrionLib:MakeNotification(Config)
    Config = Config or {}
    Config.Name = Config.Name or "Notificação"
    Config.Content = Config.Content or "Teste"
    Config.Image = Config.Image or "rbxassetid://6031280882"
    Config.Time = Config.Time or 5

    local Holder = OrionLib:MakeElement("TFrame")
    Holder.Parent = NotificationHolder
    Holder.Size = UDim2.new(1, 0, 0, 0)
    Holder.AutomaticSize = Enum.AutomaticSize.Y

    local Frame = OrionLib:MakeElement("RoundFrame", Color3.fromRGB(25,25,25), 8)
    Frame.Parent = Holder
    Frame.Size = UDim2.new(1, 0, 0, 0)
    Frame.Position = UDim2.new(1, -55, 0, 0)
    Frame.AutomaticSize = Enum.AutomaticSize.Y

    local Icon = OrionLib:MakeElement("Image", Config.Image)
    Icon.Parent = Frame
    Icon.Size = UDim2.new(0, 20, 0, 20)
    Icon.Position = UDim2.new(0, 12, 0, 12)

    local Title = OrionLib:MakeElement("Label", Config.Name, 15)
    Title.Parent = Frame
    Title.Size = UDim2.new(1, -30, 0, 20)
    Title.Position = UDim2.new(0, 40, 0, 12)
    Title.Font = Enum.Font.GothamBold

    local Content = OrionLib:MakeElement("Label", Config.Content, 14)
    Content.Parent = Frame
    Content.Size = UDim2.new(1, -24, 0, 0)
    Content.Position = UDim2.new(0, 12, 0, 37)
    Content.Font = Enum.Font.GothamSemibold
    Content.TextColor3 = Color3.fromRGB(200,200,200)
    Content.AutomaticSize = Enum.AutomaticSize.Y
    Content.TextWrapped = true

    Content:GetPropertyChangedSignal("Text"):Connect(function()
        Frame.Size = UDim2.new(1, 0, 0, Content.TextBounds.Y + 52)
    end)

    Frame:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quint", 0.5, true)
    task.wait(Config.Time - 1)
    Frame:TweenPosition(UDim2.new(1, 20, 0, 0), "In", "Quint", 1, true)
    task.wait(1)
    Frame:Destroy()
    Holder:Destroy()
end

-- FUNÇÃO PARA CRIAR JANELA
function OrionLib:MakeWindow(WindowConfig)
    WindowConfig = WindowConfig or {}
    WindowConfig.Name = WindowConfig.Name or "Orion Library"
    WindowConfig.HidePremium = WindowConfig.HidePremium or false
    WindowConfig.SaveConfig = WindowConfig.SaveConfig or false
    WindowConfig.IntroEnabled = WindowConfig.IntroEnabled ~= nil and WindowConfig.IntroEnabled or true
    WindowConfig.IntroText = WindowConfig.IntroText or "Orion Library"
    WindowConfig.IntroIcon = WindowConfig.IntroIcon or "rbxassetid://6031280882"
    WindowConfig.CloseCallback = WindowConfig.CloseCallback or function() end

    local FirstTab = true
    local Minimized = false

    -- JANELA PRINCIPAL
    local MainWindow = OrionLib:MakeElement("RoundFrame", Color3.fromRGB(25,25,25), 8)
    MainWindow.Parent = Orion
    MainWindow.Position = UDim2.new(0.5, -307, 0.5, -172)
    MainWindow.Size = UDim2.new(0, 615, 0, 344)
    MainWindow.ClipsDescendants = true

    -- BARRA DE TÍTULO
    local TopBar = OrionLib:MakeElement("TFrame")
    TopBar.Parent = MainWindow
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.Name = "TopBar"

    local Title = OrionLib:MakeElement("Label", WindowConfig.Name, 20)
    Title.Parent = TopBar
    Title.Size = UDim2.new(1, -30, 2, 0)
    Title.Position = UDim2.new(0, 25, 0, -24)
    Title.Font = Enum.Font.GothamBlack

    -- BOTÕES DA BARRA
    local BtnFrame = OrionLib:MakeElement("RoundFrame", Color3.fromRGB(32,32,32), 6)
    BtnFrame.Parent = TopBar
    BtnFrame.Size = UDim2.new(0, 70, 0, 30)
    BtnFrame.Position = UDim2.new(1, -90, 0, 10)

    -- BOTÃO MINIMIZAR
    local MinBtn = OrionLib:MakeElement("Button")
    MinBtn.Parent = BtnFrame
    MinBtn.Size = UDim2.new(0.5, 0, 1, 0)
    local MinIcon = OrionLib:MakeElement("Image", "rbxassetid://7072719338")
    MinIcon.Parent = MinBtn
    MinIcon.Size = UDim2.new(0, 18, 0, 18)
    MinIcon.Position = UDim2.new(0, 9, 0, 6)

    -- BOTÃO FECHAR
    local CloseBtn = OrionLib:MakeElement("Button")
    CloseBtn.Parent = BtnFrame
    CloseBtn.Size = UDim2.new(0.5, 0, 1, 0)
    CloseBtn.Position = UDim2.new(0.5, 0, 0, 0)
    local CloseIcon = OrionLib:MakeElement("Image", "rbxassetid://7072725342")
    CloseIcon.Parent = CloseBtn
    CloseIcon.Size = UDim2.new(0, 18, 0, 18)
    CloseIcon.Position = UDim2.new(0, 9, 0, 6)

    -- DRAG POINT
    local DragPoint = OrionLib:MakeElement("TFrame")
    DragPoint.Parent = TopBar
    DragPoint.Size = UDim2.new(1, 0, 1, 0)
    MakeDraggable(DragPoint, MainWindow)

    -- FUNÇÕES DOS BOTÕES
    CloseBtn.MouseButton1Click:Connect(function()
        MainWindow.Visible = false
        WindowConfig.CloseCallback()
    end)

    MinBtn.MouseButton1Click:Connect(function()
        Minimized = not Minimized
        if Minimized then
            MinIcon.Image = "rbxassetid://7072720870"
            MainWindow:TweenSize(UDim2.new(0, 615, 0, 50), "Out", "Quint", 0.3, true)
            for _, v in pairs(MainWindow:GetChildren()) do
                if v ~= TopBar then v.Visible = false end
            end
        else
            MinIcon.Image = "rbxassetid://7072719338"
            MainWindow:TweenSize(UDim2.new(0, 615, 0, 344), "Out", "Quint", 0.3, true)
            task.wait(0.3)
            for _, v in pairs(MainWindow:GetChildren()) do
                if v ~= TopBar then v.Visible = true end
            end
        end
    end)

    -- ÁREA DAS ABAS
    local TabHolder = OrionLib:MakeElement("ScrollFrame", Color3.fromRGB(100,100,100), 4)
    TabHolder.Parent = MainWindow
    TabHolder.Size = UDim2.new(0, 150, 1, -50)
    TabHolder.Position = UDim2.new(0, 0, 0, 50)

    local TabList = OrionLib:MakeElement("List", 0, 6)
    TabList.Parent = TabHolder
    local TabPadding = OrionLib:MakeElement("Padding", 8, 8, 8, 8)
    TabPadding.Parent = TabHolder

    -- ÁREA DE CONTEÚDO
    local Container = OrionLib:MakeElement("ScrollFrame", Color3.fromRGB(100,100,100), 5)
    Container.Parent = MainWindow
    Container.Size = UDim2.new(1, -150, 1, -50)
    Container.Position = UDim2.new(0, 150, 0, 50)
    Container.Name = "ItemContainer"
    Container.Visible = false

    local ContainerList = OrionLib:MakeElement("List", 0, 6)
    ContainerList.Parent = Container
    local ContainerPadding = OrionLib:MakeElement("Padding", 15, 15, 15, 15)
    ContainerPadding.Parent = Container

    ContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Container.CanvasSize = UDim2.new(0, 0, 0, ContainerList.AbsoluteContentSize.Y + 30)
    end)

    TabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabHolder.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 16)
    end)

    -- FUNÇÃO PARA CRIAR ABAS
    local WindowAPI = {}
    
    function WindowAPI:MakeTab(TabConfig)
        TabConfig = TabConfig or {}
        TabConfig.Name = TabConfig.Name or "Tab"
        TabConfig.Icon = TabConfig.Icon or "rbxassetid://6031280882"

        local TabBtn = OrionLib:MakeElement("Button")
        TabBtn.Parent = TabHolder
        TabBtn.Size = UDim2.new(1, 0, 0, 30)

        local TabIcon = OrionLib:MakeElement("Image", TabConfig.Icon)
        TabIcon.Parent = TabBtn
        TabIcon.Size = UDim2.new(0, 18, 0, 18)
        TabIcon.Position = UDim2.new(0, 10, 0.5, -9)

        local TabTitle = OrionLib:MakeElement("Label", TabConfig.Name, 14)
        TabTitle.Parent = TabBtn
        TabTitle.Size = UDim2.new(1, -35, 1, 0)
        TabTitle.Position = UDim2.new(0, 35, 0, 0)
        TabTitle.Font = Enum.Font.GothamSemibold

        if FirstTab then
            FirstTab = false
            TabIcon.ImageTransparency = 0
            TabTitle.TextTransparency = 0
            TabTitle.Font = Enum.Font.GothamBlack
            Container.Visible = true
        else
            TabIcon.ImageTransparency = 0.4
            TabTitle.TextTransparency = 0.4
        end

        TabBtn.MouseButton1Click:Connect(function()
            for _, btn in pairs(TabHolder:GetChildren()) do
                if btn:IsA("TextButton") then
                    if btn:FindFirstChildOfClass("ImageLabel") then
                        btn:FindFirstChildOfClass("ImageLabel").ImageTransparency = 0.4
                    end
                    if btn:FindFirstChildOfClass("TextLabel") then
                        btn:FindFirstChildOfClass("TextLabel").TextTransparency = 0.4
                        btn:FindFirstChildOfClass("TextLabel").Font = Enum.Font.GothamSemibold
                    end
                end
            end
            for _, cont in pairs(MainWindow:GetChildren()) do
                if cont.Name == "ItemContainer" then
                    cont.Visible = false
                end
            end
            TabIcon.ImageTransparency = 0
            TabTitle.TextTransparency = 0
            TabTitle.Font = Enum.Font.GothamBlack
            Container.Visible = true
        end)

        -- ELEMENTOS DA ABA
        local Elements = {}
        
        function Elements:AddSection(SectionConfig)
            SectionConfig = SectionConfig or {}
            SectionConfig.Name = SectionConfig.Name or "Section"

            local Section = OrionLib:MakeElement("TFrame")
            Section.Parent = Container
            Section.Size = UDim2.new(1, 0, 0, 26)

            local SectionTitle = OrionLib:MakeElement("Label", SectionConfig.Name, 14)
            SectionTitle.Parent = Section
            SectionTitle.Size = UDim2.new(1, -12, 0, 16)
            SectionTitle.Position = UDim2.new(0, 0, 0, 3)
            SectionTitle.Font = Enum.Font.GothamSemibold
            SectionTitle.TextColor3 = Color3.fromRGB(150,150,150)

            local SectionHolder = OrionLib:MakeElement("TFrame")
            SectionHolder.Parent = Section
            SectionHolder.Size = UDim2.new(1, 0, 1, -24)
            SectionHolder.Position = UDim2.new(0, 0, 0, 23)

            local HolderList = OrionLib:MakeElement("List", 0, 6)
            HolderList.Parent = SectionHolder

            HolderList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Section.Size = UDim2.new(1, 0, 0, HolderList.AbsoluteContentSize.Y + 31)
                SectionHolder.Size = UDim2.new(1, 0, 0, HolderList.AbsoluteContentSize.Y)
            end)

            return Elements
        end

        function Elements:AddToggle(ToggleConfig)
            ToggleConfig = ToggleConfig or {}
            ToggleConfig.Name = ToggleConfig.Name or "Toggle"
            ToggleConfig.Default = ToggleConfig.Default or false
            ToggleConfig.Callback = ToggleConfig.Callback or function() end
            ToggleConfig.Color = ToggleConfig.Color or Color3.fromRGB(9, 99, 195)

            local Toggle = {Value = ToggleConfig.Default}

            local Frame = OrionLib:MakeElement("RoundFrame", Color3.fromRGB(32,32,32), 5)
            Frame.Parent = Container
            Frame.Size = UDim2.new(1, 0, 0, 38)

            local Text = OrionLib:MakeElement("Label", ToggleConfig.Name, 15)
            Text.Parent = Frame
            Text.Size = UDim2.new(1, -12, 1, 0)
            Text.Position = UDim2.new(0, 12, 0, 0)
            Text.Font = Enum.Font.GothamBold

            local ToggleBox = OrionLib:MakeElement("RoundFrame", ToggleConfig.Color, 4)
            ToggleBox.Parent = Frame
            ToggleBox.Size = UDim2.new(0, 24, 0, 24)
            ToggleBox.Position = UDim2.new(1, -24, 0.5, 0)
            ToggleBox.AnchorPoint = Vector2.new(0.5, 0.5)

            local Check = OrionLib:MakeElement("Image", "rbxassetid://3944680095")
            Check.Parent = ToggleBox
            Check.Size = UDim2.new(0, 20, 0, 20)
            Check.Position = UDim2.new(0.5, -10, 0.5, -10)

            local ClickArea = OrionLib:MakeElement("Button")
            ClickArea.Parent = Frame
            ClickArea.Size = UDim2.new(1, 0, 1, 0)

            function Toggle:Set(Value)
                self.Value = Value
                if Value then
                    ToggleBox.BackgroundColor3 = ToggleConfig.Color
                    Check.ImageTransparency = 0
                else
                    ToggleBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
                    Check.ImageTransparency = 1
                end
                ToggleConfig.Callback(Value)
            end

            Toggle:Set(Toggle.Value)

            ClickArea.MouseButton1Click:Connect(function()
                Toggle:Set(not Toggle.Value)
            end)

            return Toggle
        end

        function Elements:AddButton(ButtonConfig)
            ButtonConfig = ButtonConfig or {}
            ButtonConfig.Name = ButtonConfig.Name or "Button"
            ButtonConfig.Callback = ButtonConfig.Callback or function() end

            local Frame = OrionLib:MakeElement("RoundFrame", Color3.fromRGB(32,32,32), 5)
            Frame.Parent = Container
            Frame.Size = UDim2.new(1, 0, 0, 33)

            local Text = OrionLib:MakeElement("Label", ButtonConfig.Name, 15)
            Text.Parent = Frame
            Text.Size = UDim2.new(1, -12, 1, 0)
            Text.Position = UDim2.new(0, 12, 0, 0)
            Text.Font = Enum.Font.GothamBold

            local ClickArea = OrionLib:MakeElement("Button")
            ClickArea.Parent = Frame
            ClickArea.Size = UDim2.new(1, 0, 1, 0)

            ClickArea.MouseButton1Click:Connect(ButtonConfig.Callback)
            return Frame
        end

        return Elements
    end

    return WindowAPI
end

function OrionLib:Init()
    self:MakeNotification({
        Name = "Orion Library",
        Content = "Carregada com sucesso!",
        Time = 3
    })
end

function OrionLib:Destroy()
    Orion:Destroy()
end

return OrionLib
