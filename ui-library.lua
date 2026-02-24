-- ===========================================
-- UI PERSONALIZADA COM BOTÃO FLUTUANTE
-- BASEADA NA ORION LIBRARY
-- ===========================================

-- CARREGAR ORION LIBRARY
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- ===========================================
-- CRIAR BOTÃO FLUTUANTE PERSONALIZADO
-- =========================================--
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

-- CRIAR O BOTÃO COM SUA IMAGEM
local botaoFlutuante = Instance.new("ImageButton")
botaoFlutuante.Name = "BotaoFechar"
botaoFlutuante.Parent = screenGui
botaoFlutuante.BackgroundTransparency = 1
botaoFlutuante.Image = "rbxassetid://131107493489043"  -- SUA IMAGEM!
botaoFlutuante.Size = UDim2.new(0, 50, 0, 50)  -- Tamanho 50x50
botaoFlutuante.Position = UDim2.new(0, 100, 0, 100)  -- Posição inicial
botaoFlutuante.Draggable = true  -- PERMITE ARRASTAR!
botaoFlutuante.Active = true
botaoFlutuante.Selectable = true

-- VARIÁVEL PARA CONTROLAR SE A UI ESTÁ ABERTA
local uiAberta = true
local MainWindow = nil

-- ===========================================
-- FUNÇÃO PARA CRIAR A UI PRINCIPAL
-- ===========================================
local function criarUI()
    if MainWindow then
        MainWindow:Destroy()
        MainWindow = nil
    end
    
    -- CRIAR JANELA PRINCIPAL (COM ÍCONE)
    MainWindow = OrionLib:MakeWindow({
        Name = "MEU SCRIPT PERSONALIZADO",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "MeuScriptConfig",
        IntroEnabled = false,  -- Desliga animação de intro
        Icon = "rbxassetid://131107493489043",  -- SUA IMAGEM COMO ÍCONE
        CloseCallback = function()
            print("UI fechada pelo X")
            uiAberta = false
        end
    })
    
    -- ===========================================
    -- ABA PRINCIPAL
    -- ===========================================
    local AbaPrincipal = MainWindow:MakeTab({
        Name = "Principal",
        Icon = "rbxassetid://131107493489043",  -- SUA IMAGEM
        PremiumOnly = false
    })
    
    -- SEÇÃO TESTE
    local SecaoTeste = AbaPrincipal:AddSection({
        Name = "🔧 TESTES"
    })
    
    -- BOTÃO TESTE
    AbaPrincipal:AddButton({
        Name = "Testar Notificação",
        Callback = function()
            OrionLib:MakeNotification({
                Name = "✅ TESTE",
                Content = "Notificação funcionando!",
                Image = "rbxassetid://131107493489043",  -- SUA IMAGEM
                Time = 3
            })
            print("✅ Teste executado!")
        end
    })
    
    -- TOGGLE TESTE-MSG
    AbaPrincipal:AddToggle({
        Name = "teste-msg",
        Default = false,
        Callback = function(Value)
            if Value then
                -- ATIVOU
                print("🔔 TESTE ATIVADO!")
                OrionLib:MakeNotification({
                    Name = "✅ TESTE",
                    Content = "Mensagem de teste ativada!",
                    Image = "rbxassetid://131107493489043",
                    Time = 3
                })
            else
                -- DESATIVOU
                print("❌ TESTE DESATIVADO!")
                OrionLib:MakeNotification({
                    Name = "❌ TESTE",
                    Content = "Mensagem de teste desativada!",
                    Image = "rbxassetid://131107493489043",
                    Time = 3
                })
            end
        end
    })
    
    -- BOTÃO PARA FECHAR UI (DENTRO DA UI)
    AbaPrincipal:AddButton({
        Name = "Fechar UI",
        Callback = function()
            uiAberta = false
            MainWindow:Destroy()
            MainWindow = nil
            botaoFlutuante.Visible = true  -- Garante que botão aparece
        end
    })
    
    -- SLIDER DE TESTE
    AbaPrincipal:AddSlider({
        Name = "Velocidade Teste",
        Min = 1,
        Max = 100,
        Default = 50,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = "%",
        Callback = function(Value)
            print("Velocidade: " .. Value .. "%")
        end
    })
    
    OrionLib:Init()  -- INICIALIZAR ORION
end

-- ===========================================
-- CONFIGURAR O BOTÃO FLUTUANTE
-- ===========================================
botaoFlutuante.MouseButton1Click:Connect(function()
    if uiAberta then
        -- SE UI ESTIVER ABERTA, FECHA
        uiAberta = false
        if MainWindow then
            MainWindow:Destroy()
            MainWindow = nil
        end
    else
        -- SE UI ESTIVER FECHADA, ABRE
        uiAberta = true
        criarUI()
    end
end)

-- ===========================================
-- CRIAR UI INICIAL
-- ===========================================
criarUI()

-- ===========================================
-- NOTIFICAÇÃO INICIAL
-- ===========================================
OrionLib:MakeNotification({
    Name = "✅ Script Carregado!",
    Content = "Use o botão flutuante para abrir/fechar",
    Image = "rbxassetid://131107493489043",
    Time = 4
})

print("🚀 Script carregado! Botão flutuante com sua imagem pronto!")
