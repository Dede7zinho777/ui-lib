-- ===========================================
-- UI SIMPLES FEITA DO ZERO (SEM ERROS!)
-- ===========================================

-- CRIAR A TELA
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui
screenGui.Name = "MinhaUISimples"

-- ===========================================
-- BOTÃO FLUTUANTE COM SUA FOTO
-- ===========================================
local botaoFlutuante = Instance.new("ImageButton")
botaoFlutuante.Parent = screenGui
botaoFlutuante.BackgroundTransparency = 1
botaoFlutuante.Image = "rbxassetid://138340742425851"
botaoFlutuante.Size = UDim2.new(0, 60, 0, 60)
botaoFlutuante.Position = UDim2.new(0, 100, 0, 100)
botaoFlutuante.Draggable = true
botaoFlutuante.Name = "BotaoFlutuante"

-- ===========================================
-- JANELA PRINCIPAL (FEITA MANUALMENTE)
-- ===========================================
local janela = Instance.new("Frame")
janela.Parent = screenGui
janela.Size = UDim2.new(0, 300, 0, 200)
janela.Position = UDim2.new(0.5, -150, 0.5, -100)
janela.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
janela.Active = true
janela.Draggable = true
janela.Visible = true
janela.Name = "JanelaPrincipal"

-- BARRA DE TÍTULO
local barraTitulo = Instance.new("Frame")
barraTitulo.Parent = janela
barraTitulo.Size = UDim2.new(1, 0, 0, 30)
barraTitulo.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
barraTitulo.Name = "BarraTitulo"

-- TÍTULO
local titulo = Instance.new("TextLabel")
titulo.Parent = barraTitulo
titulo.Size = UDim2.new(1, -30, 1, 0)
titulo.Position = UDim2.new(0, 5, 0, 0)
titulo.BackgroundTransparency = 1
titulo.Text = "MEU SCRIPT"
titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
titulo.Font = Enum.Font.SourceSans
titulo.TextSize = 18
titulo.TextXAlignment = Enum.TextXAlignment.Left

-- BOTÃO MINIMIZAR (-)
local btnMinimizar = Instance.new("TextButton")
btnMinimizar.Parent = barraTitulo
btnMinimizar.Size = UDim2.new(0, 30, 1, 0)
btnMinimizar.Position = UDim2.new(1, -30, 0, 0)
btnMinimizar.Text = "-"
btnMinimizar.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMinimizar.BackgroundTransparency = 1
btnMinimizar.Font = Enum.Font.SourceSans
btnMinimizar.TextSize = 20
btnMinimizar.Name = "BtnMinimizar"

-- ===========================================
-- CONTEÚDO DA JANELA
-- ===========================================
local conteudo = Instance.new("Frame")
conteudo.Parent = janela
conteudo.Size = UDim2.new(1, 0, 1, -30)
conteudo.Position = UDim2.new(0, 0, 0, 30)
conteudo.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
conteudo.Name = "Conteudo"

-- TÍTULO DA SEÇÃO
local secaoTitulo = Instance.new("TextLabel")
secaoTitulo.Parent = conteudo
secaoTitulo.Size = UDim2.new(1, 0, 0, 25)
secaoTitulo.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
secaoTitulo.Text = "  🔧 TESTES"
secaoTitulo.TextColor3 = Color3.fromRGB(255, 255, 255)
secaoTitulo.Font = Enum.Font.SourceSans
secaoTitulo.TextSize = 16
secaoTitulo.TextXAlignment = Enum.TextXAlignment.Left

-- TOGGLE (teste-msg)
local toggleFrame = Instance.new("Frame")
toggleFrame.Parent = conteudo
toggleFrame.Size = UDim2.new(1, 0, 0, 30)
toggleFrame.Position = UDim2.new(0, 0, 0, 30)
toggleFrame.BackgroundTransparency = 1

local toggleTexto = Instance.new("TextLabel")
toggleTexto.Parent = toggleFrame
toggleTexto.Size = UDim2.new(0, 200, 1, 0)
toggleTexto.Position = UDim2.new(0, 5, 0, 0)
toggleTexto.BackgroundTransparency = 1
toggleTexto.Text = "teste-msg"
toggleTexto.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleTexto.Font = Enum.Font.SourceSans
toggleTexto.TextSize = 16
toggleTexto.TextXAlignment = Enum.TextXAlignment.Left

local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = toggleFrame
toggleBtn.Size = UDim2.new(0, 40, 0, 20)
toggleBtn.Position = UDim2.new(1, -45, 0.5, -10)
toggleBtn.Text = "OFF"
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.SourceSans
toggleBtn.TextSize = 14
toggleBtn.Name = "ToggleBtn"

-- VARIÁVEL DO TOGGLE
local toggleAtivo = false

toggleBtn.MouseButton1Click:Connect(function()
    toggleAtivo = not toggleAtivo
    if toggleAtivo then
        toggleBtn.Text = "ON"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        print("🟢 TESTE ATIVADO!")
        -- Notificação
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "✅ TESTE",
            Text = "Mensagem de teste ativada!",
            Duration = 2
        })
    else
        toggleBtn.Text = "OFF"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        print("🔴 TESTE DESATIVADO!")
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "❌ TESTE",
            Text = "Mensagem de teste desativada!",
            Duration = 2
        })
    end
end)

-- BOTÃO TESTAR
local btnTestar = Instance.new("TextButton")
btnTestar.Parent = conteudo
btnTestar.Size = UDim2.new(0, 100, 0, 30)
btnTestar.Position = UDim2.new(0.5, -50, 0, 70)
btnTestar.Text = "Testar"
btnTestar.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
btnTestar.TextColor3 = Color3.fromRGB(255, 255, 255)
btnTestar.Font = Enum.Font.SourceSans
btnTestar.TextSize = 16

btnTestar.MouseButton1Click:Connect(function()
    print("✅ Botão Testar clicado!")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "✅ FUNCIONOU!",
        Text = "UI feita do zero!",
        Duration = 2
    })
end)

-- BOTÃO FECHAR
local btnFechar = Instance.new("TextButton")
btnFechar.Parent = conteudo
btnFechar.Size = UDim2.new(0, 100, 0, 30)
btnFechar.Position = UDim2.new(0.5, -50, 0, 110)
btnFechar.Text = "Fechar UI"
btnFechar.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
btnFechar.TextColor3 = Color3.fromRGB(255, 255, 255)
btnFechar.Font = Enum.Font.SourceSans
btnFechar.TextSize = 16

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
-- FUNÇÃO MINIMIZAR
-- ===========================================
local minimizado = false

btnMinimizar.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    if minimizado then
        conteudo.Visible = false
        janela.Size = UDim2.new(0, 300, 0, 30)
        btnMinimizar.Text = "+"
    else
        conteudo.Visible = true
        janela.Size = UDim2.new(0, 300, 0, 200)
        btnMinimizar.Text = "-"
    end
end)

-- ===========================================
-- FINALIZAÇÃO
-- ===========================================
print("🚀 UI SIMPLES CARREGADA!")
print("💡 Clique no botão com a foto para abrir/fechar")
print("💡 Use o '-' para minimizar")

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "✅ UI Carregada!",
    Text = "Feita do zero - sem erros!",
    Duration = 3
})
