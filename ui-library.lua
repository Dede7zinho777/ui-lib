-- ===========================================
-- UI PERSONALIZADA (VERSÃO CORRIGIDA)
-- ===========================================

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

-- BOTÃO FLUTUANTE COM SEU NOVO ID
local botaoFlutuante = Instance.new("ImageButton")
botaoFlutuante.Name = "BotaoFechar"
botaoFlutuante.Parent = screenGui
botaoFlutuante.BackgroundTransparency = 1
botaoFlutuante.Image = "rbxassetid://138340742425851"  -- NOVO ID!
botaoFlutuante.Size = UDim2.new(0, 50, 0, 50)
botaoFlutuante.Position = UDim2.new(0, 100, 0, 100)
botaoFlutuante.Draggable = true
botaoFlutuante.Active = true

local uiAberta = true
local MainWindow = nil

-- FUNÇÃO PARA CRIAR UI
local function criarUI()
    if MainWindow then
        MainWindow:Destroy()
        MainWindow = nil
    end

    MainWindow = library:MakeWindow({
        Name = "MEU SCRIPT",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "MeuScriptConfig",
        IntroEnabled = false,
        Icon = "rbxassetid://138340742425851",  -- NOVO ID!
        CloseCallback = function()
            print("UI fechada")
            uiAberta = false
        end
    })

    local AbaPrincipal = MainWindow:MakeTab({
        Name = "Principal",
        Icon = "rbxassetid://138340742425851",  -- NOVO ID!
        PremiumOnly = false
    })

    AbaPrincipal:AddSection({Name = "🔧 TESTES"})

    -- SEU TESTE-MSG
    AbaPrincipal:AddToggle({
        Name = "teste-msg",
        Default = false,
        Callback = function(Value)
            if Value then
                print("🔔 TESTE ATIVADO!")
                library:MakeNotification({
                    Name = "✅ TESTE",
                    Content = "Mensagem ativada!",
                    Image = "rbxassetid://138340742425851",
                    Time = 3
                })
            else
                print("❌ TESTE DESATIVADO!")
                library:MakeNotification({
                    Name = "❌ TESTE",
                    Content = "Mensagem desativada!",
                    Image = "rbxassetid://138340742425851",
                    Time = 3
                })
            end
        end
    })

    AbaPrincipal:AddButton({
        Name = "Fechar UI",
        Callback = function()
            uiAberta = false
            MainWindow:Destroy()
            MainWindow = nil
        end
    })

    library:Init()
end

-- CONFIGURAR BOTÃO
botaoFlutuante.MouseButton1Click:Connect(function()
    if uiAberta then
        uiAberta = false
        if MainWindow then
            MainWindow:Destroy()
            MainWindow = nil
        end
    else
        uiAberta = true
        criarUI()
    end
end)

-- INICIAR
criarUI()

library:MakeNotification({
    Name = "✅ Carregado!",
    Content = "Use o botão flutuante",
    Image = "rbxassetid://138340742425851",
    Time = 4
})

print("🚀 Script carregado com ID 138340742425851!")
