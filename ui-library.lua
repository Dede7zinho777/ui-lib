-- ===========================================
-- FLUENT UI - BASE (APENAS A INTERFACE)
-- ===========================================

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

if not Fluent then
    warn("❌ Erro: Fluent não carregou")
    return
end

-- Criar janela
local Window = Fluent:CreateWindow({
    Title = "MEU SCRIPT",
    SubTitle = "by Dede7zinho777",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Criar abas (Main, Settings e TESTE)
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
    Teste = Window:AddTab({ Title = "TESTE", Icon = "test-tube" })
}

-- Carregar addons (opcional)
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
InterfaceManager:SetFolder("MeuScript")
SaveManager:SetFolder("MeuScript/config")

-- Construir seção de configurações na aba Settings
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

-- Retornar tudo
return {
    Fluent = Fluent,
    Window = Window,
    Tabs = Tabs,
    SaveManager = SaveManager,
    InterfaceManager = InterfaceManager,
    Options = Fluent.Options
}
