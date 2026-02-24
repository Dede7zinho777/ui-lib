-- ===========================================
-- ORION LIBRARY CORRIGIDA
-- SEM DEPENDÊNCIAS EXTERNAS
-- ===========================================

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
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
	SelectedTheme = "Default",
	Folder = nil,
	SaveCfg = false
}

-- ÍCONES SIMPLES (SEM DEPENDÊNCIA EXTERNA)
local Icons = {
	["menu"] = "rbxassetid://6031280882",
	["x"] = "rbxassetid://6031280972",
	["chevron-down"] = "rbxassetid://6031281042",
	["check"] = "rbxassetid://6031280933",
}

local function GetIcon(IconName)
	return Icons[IconName] or IconName
end

local Orion = Instance.new("ScreenGui")
Orion.Name = "Orion"
Orion.Parent = game:GetService("CoreGui")
Orion.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Orion.Enabled = true

local function AddConnection(Signal, Function)
	local SignalConnect = Signal:Connect(Function)
	table.insert(OrionLib.Connections, SignalConnect)
	return SignalConnect
end

local function AddDraggingFunctionality(DragPoint, Main)
	local Dragging, DragInput, MousePos, FramePos = false
	
	DragPoint.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = true
			MousePos = Input.Position
			FramePos = Main.Position

			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)
	
	DragPoint.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement then
			DragInput = Input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(Input)
		if Input == DragInput and Dragging then
			local Delta = Input.Position - MousePos
			Main.Position = UDim2.new(
				FramePos.X.Scale,
				FramePos.X.Offset + Delta.X,
				FramePos.Y.Scale,
				FramePos.Y.Offset + Delta.Y
			)
		end
	end)
end

local function Create(Name, Properties, Children)
	local Object = Instance.new(Name)
	for i, v in pairs(Properties or {}) do
		pcall(function()
			Object[i] = v
		end)
	end
	for i, v in pairs(Children or {}) do
		if v then
			v.Parent = Object
		end
	end
	return Object
end

local function CreateElement(ElementName, ElementFunction)
	OrionLib.Elements[ElementName] = ElementFunction
end

local function MakeElement(ElementName, ...)
	return OrionLib.Elements[ElementName](...)
end

-- ELEMENTOS BÁSICOS
CreateElement("Corner", function(Scale, Offset)
	return Create("UICorner", {
		CornerRadius = UDim.new(Scale or 0, Offset or 10)
	})
end)

CreateElement("Stroke", function(Color, Thickness)
	return Create("Frame", {
		BackgroundColor3 = Color or Color3.fromRGB(60, 60, 60),
		BorderSizePixel = 0,
		Visible = false  -- DESATIVADO PARA EVITAR ERROS
	})
end)

CreateElement("List", function(Scale, Offset)
	return Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(Scale or 0, Offset or 0)
	})
end)

CreateElement("Padding", function(Bottom, Left, Right, Top)
	return Create("UIPadding", {
		PaddingBottom = UDim.new(0, Bottom or 4),
		PaddingLeft = UDim.new(0, Left or 4),
		PaddingRight = UDim.new(0, Right or 4),
		PaddingTop = UDim.new(0, Top or 4)
	})
end)

CreateElement("TFrame", function()
	return Create("Frame", {
		BackgroundTransparency = 1
	})
end)

CreateElement("Frame", function(Color)
	return Create("Frame", {
		BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0
	})
end)

CreateElement("RoundFrame", function(Color, Scale, Offset)
	return Create("Frame", {
		BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0
	}, {
		Create("UICorner", {
			CornerRadius = UDim.new(Scale or 0, Offset or 10)
		})
	})
end)

CreateElement("Button", function()
	return Create("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0
	})
end)

CreateElement("ScrollFrame", function(Color, Width)
	return Create("ScrollingFrame", {
		BackgroundTransparency = 1,
		ScrollBarImageColor3 = Color or Color3.fromRGB(100, 100, 100),
		BorderSizePixel = 0,
		ScrollBarThickness = Width or 4,
		CanvasSize = UDim2.new(0, 0, 0, 0)
	})
end)

CreateElement("Image", function(ImageID)
	return Create("ImageLabel", {
		Image = GetIcon(ImageID),
		BackgroundTransparency = 1
	})
end)

CreateElement("ImageButton", function(ImageID)
	return Create("ImageButton", {
		Image = GetIcon(ImageID),
		BackgroundTransparency = 1
	})
end)

CreateElement("Label", function(Text, TextSize, Transparency)
	return Create("TextLabel", {
		Text = Text or "",
		TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = Transparency or 0,
		TextSize = TextSize or 15,
		Font = Enum.Font.Gotham,
		RichText = true,
		BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left
	})
end)

-- NOTIFICAÇÕES
local NotificationHolder = MakeElement("TFrame")
NotificationHolder.Parent = Orion
NotificationHolder.Size = UDim2.new(1, -25, 1, -25)
NotificationHolder.Position = UDim2.new(1, -25, 1, -25)
NotificationHolder.AnchorPoint = Vector2.new(1, 1)

local NotificationList = MakeElement("List", 0, 5)
NotificationList.Parent = NotificationHolder
NotificationList.HorizontalAlignment = Enum.HorizontalAlignment.Center
NotificationList.VerticalAlignment = Enum.VerticalAlignment.Bottom

function OrionLib:MakeNotification(NotificationConfig)
	NotificationConfig = NotificationConfig or {}
	NotificationConfig.Name = NotificationConfig.Name or "Notification"
	NotificationConfig.Content = NotificationConfig.Content or "Test"
	NotificationConfig.Image = NotificationConfig.Image or "rbxassetid://6031280882"
	NotificationConfig.Time = NotificationConfig.Time or 15

	local NotificationParent = MakeElement("TFrame")
	NotificationParent.Parent = NotificationHolder
	NotificationParent.Size = UDim2.new(1, 0, 0, 0)
	NotificationParent.AutomaticSize = Enum.AutomaticSize.Y

	local NotificationFrame = MakeElement("RoundFrame", Color3.fromRGB(25, 25, 25), 0, 8)
	NotificationFrame.Parent = NotificationParent
	NotificationFrame.Size = UDim2.new(1, 0, 0, 0)
	NotificationFrame.Position = UDim2.new(1, -55, 0, 0)
	NotificationFrame.AutomaticSize = Enum.AutomaticSize.Y
	NotificationFrame.BackgroundTransparency = 0.1

	local Icon = MakeElement("Image", NotificationConfig.Image)
	Icon.Parent = NotificationFrame
	Icon.Size = UDim2.new(0, 20, 0, 20)
	Icon.Position = UDim2.new(0, 12, 0, 12)

	local Title = MakeElement("Label", NotificationConfig.Name, 15)
	Title.Parent = NotificationFrame
	Title.Size = UDim2.new(1, -30, 0, 20)
	Title.Position = UDim2.new(0, 40, 0, 12)
	Title.Font = Enum.Font.GothamBold

	local Content = MakeElement("Label", NotificationConfig.Content, 14)
	Content.Parent = NotificationFrame
	Content.Size = UDim2.new(1, -24, 0, 0)
	Content.Position = UDim2.new(0, 12, 0, 37)
	Content.Font = Enum.Font.GothamSemibold
	Content.TextColor3 = Color3.fromRGB(200, 200, 200)
	Content.AutomaticSize = Enum.AutomaticSize.Y
	Content.TextWrapped = true

	Content:GetPropertyChangedSignal("Text"):Connect(function()
		NotificationFrame.Size = UDim2.new(1, 0, 0, Content.TextBounds.Y + 52)
	end)

	NotificationFrame:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quint", 0.5, true)
	
	task.wait(NotificationConfig.Time - 1)
	
	NotificationFrame:TweenPosition(UDim2.new(1, 20, 0, 0), "In", "Quint", 1, true)
	task.wait(1)
	NotificationFrame:Destroy()
end

function OrionLib:MakeWindow(WindowConfig)
	WindowConfig = WindowConfig or {}
	WindowConfig.Name = WindowConfig.Name or "Orion Library"
	WindowConfig.ConfigFolder = WindowConfig.ConfigFolder or WindowConfig.Name
	WindowConfig.SaveConfig = WindowConfig.SaveConfig or false
	WindowConfig.HidePremium = WindowConfig.HidePremium or false
	WindowConfig.IntroEnabled = WindowConfig.IntroEnabled ~= nil and WindowConfig.IntroEnabled or true
	WindowConfig.IntroText = WindowConfig.IntroText or "Orion Library"
	WindowConfig.CloseCallback = WindowConfig.CloseCallback or function() end
	WindowConfig.Icon = WindowConfig.Icon or "rbxassetid://6031280882"
	WindowConfig.IntroIcon = WindowConfig.IntroIcon or "rbxassetid://6031280882"

	local FirstTab = true
	local Minimized = false

	-- JANELA PRINCIPAL
	local MainWindow = MakeElement("RoundFrame", Color3.fromRGB(25, 25, 25), 0, 8)
	MainWindow.Parent = Orion
	MainWindow.Position = UDim2.new(0.5, -307, 0.5, -172)
	MainWindow.Size = UDim2.new(0, 615, 0, 344)
	MainWindow.ClipsDescendants = true

	-- BARRA DE TÍTULO
	local TopBar = MakeElement("TFrame")
	TopBar.Parent = MainWindow
	TopBar.Size = UDim2.new(1, 0, 0, 50)
	TopBar.Name = "TopBar"

	local WindowName = MakeElement("Label", WindowConfig.Name, 20)
	WindowName.Parent = TopBar
	WindowName.Size = UDim2.new(1, -30, 2, 0)
	WindowName.Position = UDim2.new(0, 25, 0, -24)
	WindowName.Font = Enum.Font.GothamBlack

	-- BOTÕES DA BARRA
	local ButtonFrame = MakeElement("RoundFrame", Color3.fromRGB(32, 32, 32), 0, 6)
	ButtonFrame.Parent = TopBar
	ButtonFrame.Size = UDim2.new(0, 70, 0, 30)
	ButtonFrame.Position = UDim2.new(1, -90, 0, 10)

	local MinimizeBtn = MakeElement("Button")
	MinimizeBtn.Parent = ButtonFrame
	MinimizeBtn.Size = UDim2.new(0.5, 0, 1, 0)
	
	local MinimizeIcon = MakeElement("Image", "rbxassetid://7072719338")
	MinimizeIcon.Parent = MinimizeBtn
	MinimizeIcon.Size = UDim2.new(0, 18, 0, 18)
	MinimizeIcon.Position = UDim2.new(0, 9, 0, 6)
	MinimizeIcon.Name = "Ico"

	local CloseBtn = MakeElement("Button")
	CloseBtn.Parent = ButtonFrame
	CloseBtn.Size = UDim2.new(0.5, 0, 1, 0)
	CloseBtn.Position = UDim2.new(0.5, 0, 0, 0)

	local CloseIcon = MakeElement("Image", "rbxassetid://7072725342")
	CloseIcon.Parent = CloseBtn
	CloseIcon.Size = UDim2.new(0, 18, 0, 18)
	CloseIcon.Position = UDim2.new(0, 9, 0, 6)

	-- DRAG POINT
	local DragPoint = MakeElement("TFrame")
	DragPoint.Parent = TopBar
	DragPoint.Size = UDim2.new(1, 0, 1, 0)
	AddDraggingFunctionality(DragPoint, MainWindow)

	-- FUNÇÃO DO BOTÃO FECHAR
	CloseBtn.MouseButton1Click:Connect(function()
		MainWindow.Visible = false
		WindowConfig.CloseCallback()
	end)

	-- FUNÇÃO DO BOTÃO MINIMIZAR
	MinimizeBtn.MouseButton1Click:Connect(function()
		Minimized = not Minimized
		if Minimized then
			MinimizeIcon.Image = "rbxassetid://7072720870"
			MainWindow:TweenSize(UDim2.new(0, 615, 0, 50), "Out", "Quint", 0.3, true)
			for _, v in pairs(MainWindow:GetChildren()) do
				if v ~= TopBar then
					v.Visible = false
				end
			end
		else
			MinimizeIcon.Image = "rbxassetid://7072719338"
			MainWindow:TweenSize(UDim2.new(0, 615, 0, 344), "Out", "Quint", 0.3, true)
			task.wait(0.3)
			for _, v in pairs(MainWindow:GetChildren()) do
				if v ~= TopBar then
					v.Visible = true
				end
			end
		end
	end)

	-- SEÇÃO DE ABAS
	local TabHolder = MakeElement("ScrollFrame", Color3.fromRGB(100, 100, 100), 4)
	TabHolder.Parent = MainWindow
	TabHolder.Size = UDim2.new(1, 0, 1, -50)
	TabHolder.Position = UDim2.new(0, 0, 0, 50)

	local TabList = MakeElement("List", 0, 6)
	TabList.Parent = TabHolder

	local TabPadding = MakeElement("Padding", 8, 0, 0, 8)
	TabPadding.Parent = TabHolder

	-- CONTEÚDO DA ABA
	local Container = MakeElement("ScrollFrame", Color3.fromRGB(100, 100, 100), 5)
	Container.Parent = MainWindow
	Container.Size = UDim2.new(1, -150, 1, -50)
	Container.Position = UDim2.new(0, 150, 0, 50)
	Container.Visible = false
	Container.Name = "ItemContainer"

	local ContainerList = MakeElement("List", 0, 6)
	ContainerList.Parent = Container

	local ContainerPadding = MakeElement("Padding", 15, 10, 10, 15)
	ContainerPadding.Parent = Container

	ContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		Container.CanvasSize = UDim2.new(0, 0, 0, ContainerList.AbsoluteContentSize.Y + 30)
	end)

	TabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabHolder.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 16)
	end)

	-- FUNÇÃO DA ABA
	local TabFunction = {}
	function TabFunction:MakeTab(TabConfig)
		TabConfig = TabConfig or {}
		TabConfig.Name = TabConfig.Name or "Tab"
		TabConfig.Icon = TabConfig.Icon or "rbxassetid://6031280882"

		local TabFrame = MakeElement("Button")
		TabFrame.Parent = TabHolder
		TabFrame.Size = UDim2.new(1, 0, 0, 30)

		local TabIcon = MakeElement("Image", TabConfig.Icon)
		TabIcon.Parent = TabFrame
		TabIcon.Size = UDim2.new(0, 18, 0, 18)
		TabIcon.Position = UDim2.new(0, 10, 0.5, -9)
		TabIcon.Name = "Ico"

		local TabTitle = MakeElement("Label", TabConfig.Name, 14)
		TabTitle.Parent = TabFrame
		TabTitle.Size = UDim2.new(1, -35, 1, 0)
		TabTitle.Position = UDim2.new(0, 35, 0, 0)
		TabTitle.Font = Enum.Font.GothamSemibold
		TabTitle.Name = "Title"

		if FirstTab then
			FirstTab = false
			TabIcon.ImageTransparency = 0
			TabTitle.TextTransparency = 0
			TabTitle.Font = Enum.Font.GothamBlack
			Container.Visible = true
		end

		TabFrame.MouseButton1Click:Connect(function()
			for _, Tab in pairs(TabHolder:GetChildren()) do
				if Tab:IsA("TextButton") then
					Tab.Title.Font = Enum.Font.GothamSemibold
					Tab.Title.TextTransparency = 0.4
					Tab.Ico.ImageTransparency = 0.4
				end
			end
			for _, ItemContainer in pairs(MainWindow:GetChildren()) do
				if ItemContainer.Name == "ItemContainer" then
					ItemContainer.Visible = false
				end
			end
			TabIcon.ImageTransparency = 0
			TabTitle.TextTransparency = 0
			TabTitle.Font = Enum.Font.GothamBlack
			Container.Visible = true
		end)

		-- FUNÇÕES DOS ELEMENTOS
		local function AddElements(Parent)
			local Elements = {}
			
			function Elements:AddSection(SectionConfig)
				SectionConfig = SectionConfig or {}
				SectionConfig.Name = SectionConfig.Name or "Section"

				local SectionFrame = MakeElement("TFrame")
				SectionFrame.Parent = Parent
				SectionFrame.Size = UDim2.new(1, 0, 0, 26)

				local SectionTitle = MakeElement("Label", SectionConfig.Name, 14)
				SectionTitle.Parent = SectionFrame
				SectionTitle.Size = UDim2.new(1, -12, 0, 16)
				SectionTitle.Position = UDim2.new(0, 0, 0, 3)
				SectionTitle.Font = Enum.Font.GothamSemibold
				SectionTitle.TextColor3 = Color3.fromRGB(150, 150, 150)

				local SectionHolder = MakeElement("TFrame")
				SectionHolder.Parent = SectionFrame
				SectionHolder.Size = UDim2.new(1, 0, 1, -24)
				SectionHolder.Position = UDim2.new(0, 0, 0, 23)
				SectionHolder.Name = "Holder"

				local HolderList = MakeElement("List", 0, 6)
				HolderList.Parent = SectionHolder

				HolderList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					SectionFrame.Size = UDim2.new(1, 0, 0, HolderList.AbsoluteContentSize.Y + 31)
					SectionHolder.Size = UDim2.new(1, 0, 0, HolderList.AbsoluteContentSize.Y)
				end)

				local SectionElements = {}
				for i, v in pairs(AddElements(SectionHolder)) do
					SectionElements[i] = v
				end
				return SectionElements
			end

			function Elements:AddButton(ButtonConfig)
				ButtonConfig = ButtonConfig or {}
				ButtonConfig.Name = ButtonConfig.Name or "Button"
				ButtonConfig.Callback = ButtonConfig.Callback or function() end

				local ButtonFrame = MakeElement("RoundFrame", Color3.fromRGB(32, 32, 32), 0, 5)
				ButtonFrame.Parent = Parent
				ButtonFrame.Size = UDim2.new(1, 0, 0, 33)

				local ButtonText = MakeElement("Label", ButtonConfig.Name, 15)
				ButtonText.Parent = ButtonFrame
				ButtonText.Size = UDim2.new(1, -12, 1, 0)
				ButtonText.Position = UDim2.new(0, 12, 0, 0)
				ButtonText.Font = Enum.Font.GothamBold

				local Click = MakeElement("Button")
				Click.Parent = ButtonFrame
				Click.Size = UDim2.new(1, 0, 1, 0)

				Click.MouseButton1Click:Connect(function()
					ButtonConfig.Callback()
				end)

				Click.MouseEnter:Connect(function()
					ButtonFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				end)

				Click.MouseLeave:Connect(function()
					ButtonFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
				end)
			end

			function Elements:AddToggle(ToggleConfig)
				ToggleConfig = ToggleConfig or {}
				ToggleConfig.Name = ToggleConfig.Name or "Toggle"
				ToggleConfig.Default = ToggleConfig.Default or false
				ToggleConfig.Callback = ToggleConfig.Callback or function() end
				ToggleConfig.Color = ToggleConfig.Color or Color3.fromRGB(9, 99, 195)
				ToggleConfig.Flag = ToggleConfig.Flag or nil

				local Toggle = {Value = ToggleConfig.Default}

				local ToggleFrame = MakeElement("RoundFrame", Color3.fromRGB(32, 32, 32), 0, 5)
				ToggleFrame.Parent = Parent
				ToggleFrame.Size = UDim2.new(1, 0, 0, 38)

				local ToggleText = MakeElement("Label", ToggleConfig.Name, 15)
				ToggleText.Parent = ToggleFrame
				ToggleText.Size = UDim2.new(1, -12, 1, 0)
				ToggleText.Position = UDim2.new(0, 12, 0, 0)
				ToggleText.Font = Enum.Font.GothamBold

				local ToggleBox = MakeElement("RoundFrame", ToggleConfig.Color, 0, 4)
				ToggleBox.Parent = ToggleFrame
				ToggleBox.Size = UDim2.new(0, 24, 0, 24)
				ToggleBox.Position = UDim2.new(1, -24, 0.5, 0)
				ToggleBox.AnchorPoint = Vector2.new(0.5, 0.5)

				local ToggleCheck = MakeElement("Image", "rbxassetid://3944680095")
				ToggleCheck.Parent = ToggleBox
				ToggleCheck.Size = UDim2.new(0, 20, 0, 20)
				ToggleCheck.Position = UDim2.new(0.5, -10, 0.5, -10)
				ToggleCheck.ImageColor3 = Color3.fromRGB(255, 255, 255)

				local Click = MakeElement("Button")
				Click.Parent = ToggleFrame
				Click.Size = UDim2.new(1, 0, 1, 0)

				function Toggle:Set(Value)
					self.Value = Value
					if Value then
						ToggleBox.BackgroundColor3 = ToggleConfig.Color
						ToggleCheck.ImageTransparency = 0
						ToggleCheck.Size = UDim2.new(0, 20, 0, 20)
					else
						ToggleBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
						ToggleCheck.ImageTransparency = 1
						ToggleCheck.Size = UDim2.new(0, 8, 0, 8)
					end
					ToggleConfig.Callback(Value)
				end

				Toggle:Set(Toggle.Value)

				Click.MouseButton1Click:Connect(function()
					Toggle:Set(not Toggle.Value)
				end)

				if ToggleConfig.Flag then
					OrionLib.Flags[ToggleConfig.Flag] = Toggle
				end

				return Toggle
			end

			function Elements:AddSlider(SliderConfig)
				SliderConfig = SliderConfig or {}
				SliderConfig.Name = SliderConfig.Name or "Slider"
				SliderConfig.Min = SliderConfig.Min or 0
				SliderConfig.Max = SliderConfig.Max or 100
				SliderConfig.Default = SliderConfig.Default or 50
				SliderConfig.Callback = SliderConfig.Callback or function() end
				SliderConfig.Color = SliderConfig.Color or Color3.fromRGB(9, 149, 98)
				SliderConfig.Flag = SliderConfig.Flag or nil

				local Slider = {Value = SliderConfig.Default}
				local Dragging = false

				local SliderFrame = MakeElement("RoundFrame", Color3.fromRGB(32, 32, 32), 0, 5)
				SliderFrame.Parent = Parent
				SliderFrame.Size = UDim2.new(1, 0, 0, 65)

				local SliderName = MakeElement("Label", SliderConfig.Name, 15)
				SliderName.Parent = SliderFrame
				SliderName.Size = UDim2.new(1, -12, 0, 14)
				SliderName.Position = UDim2.new(0, 12, 0, 10)
				SliderName.Font = Enum.Font.GothamBold

				local SliderValue = MakeElement("Label", tostring(SliderConfig.Default), 14)
				SliderValue.Parent = SliderFrame
				SliderValue.Size = UDim2.new(1, -24, 0, 14)
				SliderValue.Position = UDim2.new(0, 12, 0, 30)
				SliderValue.Font = Enum.Font.GothamBold
				SliderValue.TextColor3 = SliderConfig.Color

				local SliderBar = MakeElement("RoundFrame", SliderConfig.Color, 0, 5)
				SliderBar.Parent = SliderFrame
				SliderBar.Size = UDim2.new(1, -24, 0, 6)
				SliderBar.Position = UDim2.new(0, 12, 0, 48)
				SliderBar.BackgroundTransparency = 0.7

				local SliderFill = MakeElement("RoundFrame", SliderConfig.Color, 0, 5)
				SliderFill.Parent = SliderBar
				SliderFill.Size = UDim2.new(0, 0, 1, 0)
				SliderFill.BackgroundTransparency = 0

				function Slider:Set(Value)
					self.Value = math.clamp(Value, SliderConfig.Min, SliderConfig.Max)
					local Percent = (self.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min)
					SliderFill.Size = UDim2.new(Percent, 0, 1, 0)
					SliderValue.Text = tostring(math.floor(self.Value))
					SliderConfig.Callback(self.Value)
				end

				Slider:Set(Slider.Value)

				SliderBar.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Dragging = true
					end
				end)

				SliderBar.InputEnded:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Dragging = false
					end
				end)

				UserInputService.InputChanged:Connect(function(Input)
					if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
						local Percent = (Input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
						Percent = math.clamp(Percent, 0, 1)
						local Value = SliderConfig.Min + (SliderConfig.Max - SliderConfig.Min) * Percent
						Slider:Set(Value)
					end
				end)

				if SliderConfig.Flag then
					OrionLib.Flags[SliderConfig.Flag] = Slider
				end

				return Slider
			end

			return Elements
		end

		return AddElements(Container)
	end

	return TabFunction
end

function OrionLib:Init()
	if OrionLib.SaveCfg then
		OrionLib:MakeNotification({
			Name = "Configuration",
			Content = "Auto-loaded configuration",
			Time = 3
		})
	end
end

function OrionLib:Destroy()
	Orion:Destroy()
end

return OrionLib
