-- ===========================================
-- SCRIPT COMPLETO COM UI E BOTÃO
-- (BASEADO NO QUE FUNCIONOU ANTES)
-- ===========================================

print("🚀 INICIANDO...")

-- ===========================================
-- PARTE 1: CRIAR A UI SIMPLES (QUE FUNCIONA)
-- ===========================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MinhaUI"
screenGui.Parent = game:GetService("CoreGui")
screenGui.ResetOnSpawn = false

-- JANELA PRINCIPAL
local janela = Instance.new("Frame")
janela.Parent = screenGui
janela.Size = UDim2.new(0, 450, 0, 350)
janela.Position = UDim2.new(0.5, -225, 0.5, -175)
janela.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
janela.Active = true
janela.Draggable = true
janela.Visible = true

-- BORDA ARREDONDADA
local uiCorner = Instance.new("UICorner")
uiCorner.Parent = janela
uiCorner.CornerRadius = UDim.new(0, 8)

-- BARRA DE TÍTULO
local barra = Instance.new("Frame")
barra.Parent = janela
barra.Size = UDim2.new(1, 0, 0, 40)
barra.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
barra.BorderSizePixel = 0

local barraCorner = Instance.new("UICorner")
barraCorner.Parent = barra
barraCorner.CornerRadius = UDim.new(0, 8)

-- TÍTULO
local titulo = Instance.new("TextLabel")
titulo.Parent = barra
titulo.Size = UDim2.new(1, -80, 1, 0)
titulo.Position = UDim2.new(0, 15, 0, 0)
titulo.BackgroundTransparency = 1
titulo.Text = "MEU SCRIPT"
titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
titulo.Font = Enum.Font.SourceSansBold
titulo.TextSize = 20
titulo.TextXAlignment = Enum.TextXAlignment.Left

-- BOTÃO MINIMIZAR
local minBtn = Instance.new("TextButton")
minBtn.Parent = barra
minBtn.Size = UDim2.new(0, 40, 1, 0)
minBtn.Position = UDim2.new(1, -80, 0, 0)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.BackgroundTransparency = 1
minBtn.Font = Enum.Font.SourceSansBold
minBtn.TextSize = 24

-- BOTÃO FECHAR
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = barra
closeBtn.Size = UDim2.new(0, 40, 1, 0)
closeBtn.Position = UDim2.new(1, -40, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 20

-- ===========================================
-- CONTEÚDO DA JANELA
-- ===========================================
local conteudo = Instance.new("Frame")
conteudo.Parent = janela
conteudo.Size = UDim2.new(1, -20, 1, -50)
conteudo.Position = UDim2.new(0, 10, 0, 45)
conteudo.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
conteudo.BorderSizePixel = 0

local conteudoCorner = Instance.new("UICorner")
conteudoCorner.Parent = conteudo
conteudoCorner.CornerRadius = UDim.new(0, 6)

-- ===========================================
-- ABAS (Main, Settings, Teste)
-- ===========================================
local abaFrame = Instance.new("Frame")
abaFrame.Parent = conteudo
abaFrame.Size = UDim2.new(1, -20, 0, 35)
abaFrame.Position = UDim2.new(0, 10, 0, 10)
abaFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
abaFrame.BorderSizePixel = 0

local abaCorner = Instance.new("UICorner")
abaCorner.Parent = abaFrame
abaCorner.CornerRadius = UDim.new(0, 6)

-- FUNÇÃO PARA CRIAR ABAS
local abas = {}
local conteudoAbas = {}

local function criarAba(nome, posX)
    local btn = Instance.new("TextButton")
    btn.Parent = abaFrame
    btn.Size = UDim2.new(0, 70, 1, -10)
    btn.Position = UDim2.new(0, posX, 0.5, -12.5)
    btn.Text = nome
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.BorderSizePixel = 0
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.Parent = btn
    btnCorner.CornerRadius = UDim.new(0, 4)
    
    -- ÁREA DE CONTEÚDO DA ABA
    local area = Instance.new("Frame")
    area.Parent = conteudo
    area.Size = UDim2.new(1, -20, 1, -100)
    area.Position = UDim2.new(0, 10, 0, 55)
    area.BackgroundTransparency = 1
    area.Visible = false
    
    table.insert(abas, {btn = btn, area = area, nome = nome})
    
    btn.MouseButton1Click:Connect(function()
        for _, aba in ipairs(abas) do
            aba.area.Visible = false
            aba.btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            aba.btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        area.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    return area
end

-- CRIAR AS 3 ABAS
local areaMain = criarAba("Main", 10)
local areaSettings = criarAba("Settings", 90)
local areaTeste = criarAba("TESTE", 170)

-- ATIVAR A PRIMEIRA ABA
abas[1].area.Visible = true
abas[1].btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
abas[1].btn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- ===========================================
-- CONTEÚDO DA ABA TESTE
-- ===========================================
local toggleFrame = Instance.new("Frame")
toggleFrame.Parent = areaTeste
toggleFrame.Size = UDim2.new(1, -20, 0, 40)
toggleFrame.Position = UDim2.new(0, 10, 0, 10)
toggleFrame.BackgroundTransparency = 1

local toggleText = Instance.new("TextLabel")
toggleText.Parent = toggleFrame
toggleText.Size = UDim2.new(0, 200, 1, 0)
toggleText.Position = UDim2.new(0, 10, 0, 0)
toggleText.BackgroundTransparency = 1
toggleText.Text = "teste-msg"
toggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleText.Font = Enum.Font.SourceSans
toggleText.TextSize = 18
toggleText.TextXAlignment = Enum.TextXAlignment.Left

local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = toggleFrame
toggleBtn.Size = UDim2.new(0, 60, 0, 30)
toggleBtn.Position = UDim2.new(1, -70, 0.5, -15)
toggleBtn.Text = "OFF"
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 16

local toggleAtivo = false
toggleBtn.MouseButton1Click:Connect(function()
    toggleAtivo = not toggleAtivo
    if toggleAtivo then
        toggleBtn.Text = "ON"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        print("🟢 TESTE ATIVADO!")
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "✅ TESTE",
            Text = "Mensagem de teste ativada!",
            Duration = 3
        })
    else
        toggleBtn.Text = "OFF"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        print("🔴 TESTE DESATIVADO!")
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "❌ TESTE",
            Text = "Mensagem de teste desativada!",
            Duration = 3
        })
    end
end)

-- BOTÃO DE TESTE
local testBtn = Instance.new("TextButton")
testBtn.Parent = areaTeste
testBtn.Size = UDim2.new(0, 150, 0, 35)
testBtn.Position = UDim2.new(0.5, -75, 0, 70)
testBtn.Text = "Testar Notificação"
testBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
testBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
testBtn.Font = Enum.Font.SourceSans
testBtn.TextSize = 16

testBtn.MouseButton1Click:Connect(function()
    print("✅ Botão de teste clicado!")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "📨 TESTE",
        Text = "Botão funcionando!",
        Duration = 2
    })
end)

-- ===========================================
-- CONTEÚDO DA ABA MAIN
-- ===========================================
local mainText = Instance.new("TextLabel")
mainText.Parent = areaMain
mainText.Size = UDim2.new(1, -20, 0, 30)
mainText.Position = UDim2.new(0, 10, 0, 10)
mainText.BackgroundTransparency = 1
mainText.Text = "Bem-vindo à aba Main!"
mainText.TextColor3 = Color3.fromRGB(255, 255, 255)
mainText.Font = Enum.Font.SourceSans
mainText.TextSize = 18

-- ===========================================
-- CONTEÚDO DA ABA SETTINGS
-- ===========================================
local settingsText = Instance.new("TextLabel")
settingsText.Parent = areaSettings
settingsText.Size = UDim2.new(1, -20, 0, 30)
settingsText.Position = UDim2.new(0, 10, 0, 10)
settingsText.BackgroundTransparency = 1
settingsText.Text = "Configurações do script"
settingsText.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsText.Font = Enum.Font.SourceSans
settingsText.TextSize = 18

-- ===========================================
-- FUNÇÕES DA BARRA
-- ===========================================
local minimizado = false
minBtn.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    if minimizado then
        conteudo.Visible = false
        janela.Size = UDim2.new(0, 450, 0, 40)
        minBtn.Text = "+"
    else
        conteudo.Visible = true
        janela.Size = UDim2.new(0, 450, 0, 350)
        minBtn.Text = "-"
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    janela.Visible = false
end)

-- ===========================================
-- PARTE 2: BOTÃO FLUTUANTE
-- ===========================================
local botaoFlutuante = Instance.new("ImageButton")
botaoFlutuante.Parent = game:GetService("CoreGui")
botaoFlutuante.BackgroundTransparency = 1
botaoFlutuante.Image = "rbxassetid://138340742425851"
botaoFlutuante.Size = UDim2.new(0, 70, 0, 70)
botaoFlutuante.Position = UDim2.new(0, 20, 0, 150)
botaoFlutuante.Draggable = true
botaoFlutuante.Name = "BotaoFlutuante"

local btnCorner = Instance.new("UICorner")
btnCorner.Parent = botaoFlutuante
btnCorner.CornerRadius = UDim.new(0, 35)

-- CONTROLAR A UI COM O BOTÃO
local uiVisivel = true
botaoFlutuante.MouseButton1Click:Connect(function()
    uiVisivel = not uiVisivel
    screenGui.Enabled = uiVisivel
    print("Botão clicado! UI " .. (uiVisivel and "aberta" or "fechada"))
end)

-- ===========================================
-- FINALIZAÇÃO
-- ===========================================
print("🎉 SCRIPT CARREGADO COM SUCESSO!")
print("👉 Botão flutuante com sua imagem")
print("👉 Abas: Main, Settings e TESTE")
print("👉 Toggle 'teste-msg' na aba TESTE")

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "✅ SCRIPT PRONTO",
    Text = "Tudo funcionando!",
    Duration = 4
})
