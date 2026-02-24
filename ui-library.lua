-- ===========================================
-- UI PERSONALIZADA - FOTO SÓ NO BOTÃO FLUTUANTE
-- ===========================================

-- CARREGAR ORION LIBRARY
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- ===========================================
-- CRIAR BOTÃO FLUTUANTE (COM SUA FOTO)
-- ===========================================
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

-- BOTÃO FLUTUANTE (ÚNICO LUGAR COM A FOTO)
local botaoFlutuante = Instance.new("ImageButton")
botaoFlutuante.Name = "BotaoFechar"
botaoFlutuante.Parent = screenGui
botaoFlutuante.BackgroundTransparency = 1
botaoFlutuante.Image = "rbxassetid://138340742425851"  -- FOTO SÓ AQUI!
botaoFlutuante.Size = UDim2.new(0, 50, 0, 50)
botaoFlutuante.Position = UDim2.new(0, 100, 0, 100)
botaoFlutuante.Draggable = true  -- PODE ARRASTAR
botaoFlutuante.Active = true

-- VARIÁVEIS DE CONTROLE
local uiAberta = true
local MainWindow = nil

-- ===========================================
-- FUNÇÃO PARA CRIAR A UI (SEM FOTO)
-- ===========================================
local function criarUI()
    if MainWindow then
        MainWindow:Destroy()
        MainWindow = nil
    end

    -- JANELA PRINCIPAL (SEM ÍCONE)
    MainWindow = OrionLib:MakeWindow({
        Name = "MEU SCRIPT",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "MeuScriptConfig",
        IntroEnabled = false,
        -- Icon = nil  (SEM ÍCONE!)
        CloseCallback = function()
            print("UI fechada pelo X")
            uiAberta = false
        end
    })

    -- ABA PRINCIPAL (SEM ÍCONE)
    local AbaPrincipal = MainWindow:MakeTab({
        Name = "Principal",
        -- Icon = nil  (SEM ÍCONE!)
        PremiumOnly = false
    })

    -- SEÇÃO TESTE
    AbaPrincipal:AddSection({
        Name = "🔧 TESTES"
    })

    -- TOGGLE TESTE-MSG (o que você pediu)
    AbaPrincipal:AddToggle({
        Name = "teste-msg",
        Default = false,
        Callback = function(Value)
            if Value then
                print("🔔 TESTE ATIVADO!")
                OrionLib:MakeNotification({
                    Name = "✅ TESTE",
                    Content = "Mensagem de teste ativada!",
                    Image = "rbxassetid://138340742425851",  -- FOTO SÓ NA NOTIFICAÇÃO
                    Time = 3
                })
            else
                print("❌ TESTE DESATIVADO!")
                OrionLib:MakeNotification({
                    Name = "❌ TESTE",
                    Content = "Mensagem de teste desativada!",
                    Image = "rbxassetid://138340742425851",  -- FOTO SÓ NA NOTIFICAÇÃO
                    Time = 3
                })
            end
        end
    })

    -- BOTÃO PARA FECHAR UI
    AbaPrincipal:AddButton({
        Name = "Fechar UI",
        Callback = function()
            uiAberta = false
            MainWindow:Destroy()
            MainWindow = nil
        end
    })

    -- BOTÃO DE TESTE
    AbaPrincipal:AddButton({
        Name = "Testar Notificação",
        Callback = function()
            print("✅ Teste executado!")
            OrionLib:MakeNotification({
                Name = "✅ TESTE",
                Content = "Notificação funcionando!",
                Image = "rbxassetid://138340742425851",  -- FOTO SÓ NA NOTIFICAÇÃO
                Time = 3
            })
        end
    })

    OrionLib:Init()
end

-- ===========================================
-- CONFIGURAR O BOTÃO FLUTUANTE
-- ===========================================
botaoFlutuante.MouseButton1Click:Connect(function()
    if uiAberta then
        -- FECHAR UI
        uiAberta = false
        if MainWindow then
            MainWindow:Destroy()
            MainWindow = nil
        end
        -- Mostra notificação que fechou
        OrionLib:MakeNotification({
            Name = "🔴 UI Fechada",
            Content = "Clique no botão para abrir",
            Image = "rbxassetid://138340742425851",
            Time = 2
        })
    else
        -- ABRIR UI
        uiAberta = true
        criarUI()
        -- Mostra notificação que abriu
        OrionLib:MakeNotification({
            Name = "🟢 UI Aberta",
            Content = "teste-msg disponível",
            Image = "rbxassetid://138340742425851",
            Time = 2
        })
    end
end)

-- ===========================================
-- INICIAR TUDO
-- ===========================================
criarUI()

-- NOTIFICAÇÃO INICIAL
OrionLib:MakeNotification({
    Name = "✅ Script Carregado!",
    Content = "Use o botão flutuante para abrir/fechar",
    Image = "rbxassetid://138340742425851",
    Time = 4
})

print("🚀 Script carregado! Foto apenas no botão flutuante!")
