-- ===========================================
-- FLUENT UI - APENAS A INTERFACE
-- (Sem funções, só a cara)
-- ===========================================

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

if not Fluent then
    warn("❌ Erro: Não foi possível carregar a Fluent UI")
    return
end

-- Criar a janela
local Window = Fluent:CreateWindow({
    Title = "MINHA UI",
    SubTitle = "by Dede7zinho777",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark"
})

-- Criar as abas (Main, Settings e Teste)
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
    Teste = Window:AddTab({ Title = "TESTE", Icon = "test-tube" })
}

-- Retornar tudo para ser usado
return {
    Fluent = Fluent,
    Window = Window,
    Tabs = Tabs
}
