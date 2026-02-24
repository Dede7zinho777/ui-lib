-- ===========================================
-- UI CORRIGIDA - SEM ERROS DE ÍCONE
-- ===========================================

-- CARREGAR ORION LIBRARY
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- ===========================================
-- CRIAR BOTÃO FLUTUANTE (ÚNICO LUGAR COM A FOTO)
-- ===========================================
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

-- BOTÃO FLUTUANTE (SÓ ELE TEM FOTO)
local botaoFlutuante = Instance.new("ImageButton")
botaoFlutuante.Parent = screenGui
botaoFlutuante.BackgroundTransparency = 1
botaoFlutuante.Image = "rbxassetid://138340742425851"
botaoFlutuante.Size = UDim2.new(0, 60, 0, 60)
botaoFlutuante.Position = UDim2.new(0, 100, 0, 100)
botaoFlutuante.Draggable = true
botaoFlutuante.Active = true

-- VARIÁVEIS
local uiAberta = true
local MainWindow = nil

-- ===========================================
-- FUNÇÃO PARA CRIAR UI (SEM NENHUM ÍCONE!)
-- ===========================================
local function criarUI()
    if MainWindow then
        MainWindow:Destroy()
        MainWindow = nil
    end

    -- JANELA PRINCIPAL - SEM ÍCONE
    MainWindow = OrionLib:MakeWindow({
        Name = "MEU SCRIPT",
        HidePremium = true,  -- Muda pra true pra evitar coisas premium
        SaveConfig = false,  -- Desativa config pra evitar erros
        IntroEnabled = false,
        -- NÃO colocar Icon aqui!
    })

    -- ABA PRINCIPAL - SEM ÍCONE
    local AbaPrincipal = MainWindow:MakeTab({
        Name = "Principal"
        -- NÃO colocar Icon aqui!
    })

    -- SEÇÃO TESTE
    AbaPrincipal:AddSection({
        Name = "🔧 TESTES"
    })

    -- TOGGLE TESTE-MSG (sem imagem nas notificações pra evitar erro)
    AbaPrincipal:AddToggle({
        Name = "teste-msg",
        Default = false,
        Callback = function(Value)
            if Value then
                print("🟢 TESTE ATIVADO!")
                -- Notificação SEM imagem
                OrionLib:MakeNotification({
                    Name = "✅ TESTE",
                    Content = "Mensagem de teste ativada!",
                    Time = 3
                    -- SEM Image aqui!
                })
            else
                print("🔴 TESTE DESATIVADO!")
                OrionLib:MakeNotification({
                    Name = "❌ TESTE",
                    Content = "Mensagem de teste desativada!",
                    Time = 3
                    -- SEM Image aqui!
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
            -- Notificação sem imagem
            OrionLib:MakeNotification({
                Name = "🔴 UI Fechada",
                Content = "Clique no botão para abrir",
                Time = 2
            })
        end
    })

    -- BOTÃO DE TESTE
    AbaPrincipal:AddButton({
        Name = "Testar",
        Callback = function()
            print("✅ Teste executado!")
            OrionLib:MakeNotification({
                Name = "✅ FUNCIONOU!",
                Content = "Tudo certo!",
                Time = 2
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
        -- Botão continua visível
    else
        -- ABRIR UI
        uiAberta = true
        criarUI()
    end
end)

-- ===========================================
-- INICIAR
-- ===========================================
criarUI()

-- Mensagem inicial no console apenas
print("🚀 Script carregado! Botão flutuante com sua foto funcionando!")
print("💡 Clique no botão com a foto para abrir/fechar a UI")
