-- ===========================================
-- FLUENT UI LIBRARY (APENAS A INTERFACE)
-- ===========================================

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Verificar se carregou
if not Fluent then
    warn("❌ Erro ao carregar Fluent UI")
    return
end

-- Criar a janela principal
local Window = Fluent:CreateWindow({
    Title = "Minha UI",
    SubTitle = "by Dede7zinho777",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark"
})

-- Criar as abas padrão (Main e Settings)
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
    Teste = Window:AddTab({ Title = "TESTE", Icon = "test-tube" }) -- Aba extra
}

-- Retornar tudo para ser usado no script
return {
    Fluent = Fluent,
    Window = Window,
    Tabs = Tabs
}
