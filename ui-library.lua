-- ===========================================
-- UI BONITA COM BOTÃO FLUTUANTE
-- (FEITA MANUALMENTE - SEM ERROS!)
-- ===========================================

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui
screenGui.Name = "UIBonita"

-- ===========================================
-- FUNÇÃO PARA CRIAR CANTO ARREDONDADO
-- ===========================================
local function criarCantoArredondado(parent, tamanho)
    local canto = Instance.new("UICorner")
    canto.Parent = parent
    canto.CornerRadius = UDim.new(0, tamanho or 8)
end

-- ===========================================
-- BOTÃO FLUTUANTE (QUE JÁ FUNCIONA)
-- ===========================================
local botaoFlutuante = Instance.new("ImageButton")
botaoFlutuante.Parent = screenGui
botaoFlutuante.BackgroundTransparency = 1
botaoFlutuante.Image = "rbxassetid://138340742425851"
botaoFlutuante.Size = UDim2.new(0, 70, 0, 70)
botaoFlutuante.Position = UDim2.new(0, 50, 0, 150)
botaoFlutuante.Draggable = true
botaoFlutuante.Name = "BotaoFlutuante"

-- ===========================================
-- JANELA PRINCIPAL (ESTILO ORION)
-- ===========================================
local janela = Instance.new("Frame")
janela.Parent = screenGui
janela.Size = UDim2.new(0, 400, 0, 350)
janela.Position = UDim2.new(0.5, -200, 0.5, -175)
janela.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
janela.Active = true
janela.Draggable = true
janela.Visible = true
janela.Name = "JanelaPrincipal"
criarCantoArredondado(janela, 10)

-- Sombra (opcional)
local sombra = Instance.new("ImageLabel")
sombra.Parent = janela
sombra.Size = UDim2.new(1, 20, 1, 20)
sombra.Position = UDim2.new(0, -10, 0, -10)
sombra.BackgroundTransparency = 1
sombra.Image = "rbxassetid://13111393922"
sombra.ImageColor3 = Color3.fromRGB(0, 0, 0)
sombra.ImageTransparency = 0.5
sombra.ZIndex = -1

-- ===========================================
-- BARRA DE TÍTULO (ESTILO ORION)
-- ===========================================
local barraTitulo = Instance.new("Frame")
barraTitulo.Parent = janela
barraTitulo.Size = UDim2.new(1, 0, 0, 45)
barraTitulo.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
barraTitulo.BorderSizePixel = 0
barraTitulo.Name = "BarraTitulo"
criarCantoArredondado(barraTitulo, 10)
-- Só arredondar em cima
barraTitulo.ClipsDescendants = true

-- Ícone da barra (sua foto)
local iconeBarra = Instance.new("ImageLabel")
iconeBarra.Parent = barraTitulo
iconeBarra.Size = UDim2.new(0, 30, 0, 30)
iconeBarra.Position = UDim2.new(0, 10, 0.5, -15)
iconeBarra.BackgroundTransparency = 1
iconeBarra.Image = "rbxassetid://138340742425851"
iconeBarra.Name = "IconeBarra"

-- Título
local titulo = Instance.new("TextLabel")
titulo.Parent = barraTitulo
titulo.Size = UDim2.new(1, -100, 1, 0)
titulo.Position = UDim2.new(0, 45, 0, 0)
titulo.BackgroundTransparency = 1
titulo.Text = "MEU SCRIPT BONITO"
titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
titulo.Font = Enum.Font.GothamBold
titulo.TextSize = 18
titulo.TextXAlignment = Enum.TextXAlignment.Left

-- Botões da barra
local function criarBotaoBarra(nome, texto, cor, posX)
    local btn = Instance.new("TextButton")
    btn.Parent = barraTitulo
    btn.Size = UDim2.new(0, 30, 0, 30)
    btn.Position = UDim2.new(1, posX, 0.5, -15)
    btn.Text = texto
    btn.TextColor3 = cor or Color3.fromRGB(255, 255, 255)
    btn.BackgroundTransparency = 1
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.Name = nome
    return btn
end

local btnMinimizar = criarBotaoBarra("BtnMinimizar", "—", Color3.fromRGB(255, 255, 255), -70)
local btnFechar = criarBotaoBarra("BtnFechar", "✕", Color3.fromRGB(255, 100, 100), -35)

-- ===========================================
-- CONTEÚDO DA JANELA
-- ===========================================
local conteudo = Instance.new("Frame")
conteudo.Parent = janela
conteudo.Size = UDim2.new(1, -20, 1, -55)
conteudo.Position = UDim2.new(0, 10, 0, 50)
conteudo.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
conteudo.BorderSizePixel = 0
conteudo.Name = "Conteudo"
criarCantoArredondado(conteudo, 8)

-- ===========================================
-- SEÇÃO TESTE (ESTILO ORION)
-- ===========================================
local secao = Instance.new("Frame")
secao.Parent = conteudo
secao.Size = UDim2.new(1, -20, 0, 35)
secao.Position = UDim2.new(0, 10, 0, 10)
secao.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
secao.BorderSizePixel = 0
secao.Name = "Secao"
criarCantoArredondado(secao, 6)

local secaoTexto = Instance.new("TextLabel")
secaoTexto.Parent = secao
secaoTexto.Size = UDim2.new(1, -10, 1, 0)
secaoTexto.Position = UDim2.new(0, 10, 0, 0)
secaoTexto.BackgroundTransparency = 1
secaoTexto.Text = "🔧 TESTES"
secaoTexto.TextColor3 = Color3.fromRGB(0, 200, 255)
secaoTexto.Font = Enum.Font.GothamBold
secaoTexto.TextSize = 14
secaoTexto.TextXAlignment = Enum.TextXAlignment.Left

-- ===========================================
-- TOGGLE TESTE-MSG (ESTILO ORION)
-- ===========================================
local toggleFrame = Instance.new("Frame")
toggleFrame.Parent = conteudo
toggleFrame.Size = UDim2.new(1, -20, 0, 45)
toggleFrame.Position = UDim2.new(0, 10, 0, 55)
toggleFrame.BackgroundTransparency = 1
toggleFrame.Name = "ToggleFrame"

local toggleTexto = Instance.new("TextLabel")
toggleTexto.Parent = toggleFrame
toggleTexto.Size = UDim2.new(0, 200, 1, 0)
toggleTexto.Position = UDim2.new(0, 5, 0, 0)
toggleTexto.BackgroundTransparency = 1
toggleTexto.Text = "teste-msg"
toggleTexto.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleTexto.Font = Enum.Font.Gotham
toggleTexto.TextSize = 16
toggleTexto.TextXAlignment = Enum.TextXAlignment.Left

-- Botão toggle estilo Orion
local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = toggleFrame
toggleBtn.Size = UDim2.new(0, 60, 0, 30)
toggleBtn.Position = UDim2.new(1, -65, 0.5, -15)
toggleBtn.Text = "OFF"
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
toggleBtn.Name = "ToggleBtn"
criarCantoArredondado(toggleBtn, 6)

local toggleAtivo = false
toggleBtn.MouseButton1Click:Connect(function()
    toggleAtivo = not toggleAtivo
    if toggleAtivo then
        toggleBtn.Text = "ON"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(70, 255, 70)
        print("🟢 TESTE ATIVADO!")
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "✅ TESTE",
            Text = "Mensagem de teste ativada!",
            Duration = 2
        })
    else
        toggleBtn.Text = "OFF"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
        print("🔴 TESTE DESATIVADO!")
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "❌ TESTE",
            Text = "Mensagem de teste desativada!",
            Duration = 2
        })
    end
end)

-- ===========================================
-- BOTÕES ESTILO ORION
-- ===========================================
local function criarBotaoBonito(texto, cor, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = conteudo
    btn.Size = UDim2.new(0, 160, 0, 40)
    btn.Position = UDim2.new(0.5, -80, 0, posY)
    btn.Text = texto
    btn.BackgroundColor3 = cor or Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Name = "Btn" .. texto
    criarCantoArredondado(btn, 6)
    
    -- Efeito hover
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = cor and cor + Color3.fromRGB(20,20,20) or Color3.fromRGB(70,70,70)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = cor or Color3.fromRGB(50,50,50)
    end)
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Botão Notificação
criarBotaoBonito("📨 NOTIFICAÇÃO", Color3.fromRGB(0, 120, 255), 110, function()
    print("✅ Notificação!")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "📨 TESTE",
        Text = "Botão funcionando!",
        Duration = 2
    })
end)

-- Botão Fechar UI
criarBotaoBonito("🔴 FECHAR", Color3.fromRGB(255, 70, 70), 160, function()
    janela.Visible = false
end)

-- ===========================================
-- FUNÇÕES DOS BOTÕES DA BARRA
-- ===========================================
local minimizado = false
btnMinimizar.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    if minimizado then
        conteudo.Visible = false
        janela.Size = UDim2.new(0, 400, 0, 45)
        btnMinimizar.Text = "+"
    else
        conteudo.Visible = true
        janela.Size = UDim2.new(0, 400, 0, 350)
        btnMinimizar.Text = "—"
    end
end)

btnFechar.MouseButton1Click:Connect(function()
    janela.Visible = false
end)

-- ===========================================
-- FUNÇÃO DO BOTÃO FLUTUANTE
-- ===========================================
botaoFlutuante.MouseButton1Click:Connect(function()
    janela.Visible = not janela.Visible
    if janela.Visible then
        print("🟢 UI Aberta")
    else
        print("🔴 UI Fechada")
    end
end)

-- ===========================================
-- FINALIZAÇÃO
-- ===========================================
print("🚀 UI BONITA CARREGADA!")
print("✅ Botão flutuante com sua foto")
print("✅ Toggle teste-msg funcionando")
print("✅ Estilo Orion manual (sem erros)")

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "✨ UI Bonita",
    Text = "Botão flutuante com sua foto",
    Duration = 3
})
