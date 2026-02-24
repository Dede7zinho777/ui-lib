-- ===========================================
-- UI COMPLETA COM BOTÃO FLUTUANTE
-- (BASEADA NO SCRIPT DE TESTE QUE FUNCIONOU)
-- ===========================================

-- CRIAR A TELA PRINCIPAL
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui
screenGui.Name = "MinhaUICompleta"

-- ===========================================
-- BOTÃO FLUTUANTE (QUE JÁ FUNCIONOU!)
-- ===========================================
local botaoFlutuante = Instance.new("ImageButton")
botaoFlutuante.Parent = screenGui
botaoFlutuante.BackgroundTransparency = 1
botaoFlutuante.Image = "rbxassetid://138340742425851"  -- SUA FOTO
botaoFlutuante.Size = UDim2.new(0, 70, 0, 70)  -- UM POUCO MAIOR
botaoFlutuante.Position = UDim2.new(0, 50, 0, 150)
botaoFlutuante.Draggable = true
botaoFlutuante.Name = "BotaoFlutuante"

-- ===========================================
-- JANELA PRINCIPAL (IGUAL AO TESTE)
-- ===========================================
local janela = Instance.new("Frame")
janela.Parent = screenGui
janela.Size = UDim2.new(0, 350, 0, 300)  -- UM POUCO MAIOR
janela.Position = UDim2.new(0.5, -175, 0.5, -150)
janela.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
janela.Active = true
janela.Draggable = true
janela.Visible = true
janela.Name = "JanelaPrincipal"

-- BORDA ARREDONDADA (OPCIONAL)
janela.BackgroundTransparency = 0
-- Se quiser borda arredondada, descomente:
-- local UICorner = Instance.new("UICorner")
-- UICorner.Parent = janela
-- UICorner.CornerRadius = UDim.new(0, 8)

-- ===========================================
-- BARRA DE TÍTULO (PARA ARRASTAR)
-- ===========================================
local barraTitulo = Instance.new("Frame")
barraTitulo.Parent = janela
barraTitulo.Size = UDim2.new(1, 0, 0, 35)
barraTitulo.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
barraTitulo.Name = "BarraTitulo"

-- TÍTULO DA JANELA
local titulo = Instance.new("TextLabel")
titulo.Parent = barraTitulo
titulo.Size = UDim2.new(1, -70, 1, 0)
titulo.Position = UDim2.new(0, 10, 0, 0)
titulo.BackgroundTransparency = 1
titulo.Text = "📱 MEU SCRIPT PERSONALIZADO"
titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
titulo.Font = Enum.Font.SourceSansBold
titulo.TextSize = 18
titulo.TextXAlignment = Enum.TextXAlignment.Left

-- BOTÃO MINIMIZAR (-)
local btnMinimizar = Instance.new("TextButton")
btnMinimizar.Parent = barraTitulo
btnMinimizar.Size = UDim2.new(0, 35, 1, 0)
btnMinimizar.Position = UDim2.new(1, -70, 0, 0)
btnMinimizar.Text = "-"
btnMinimizar.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMinimizar.BackgroundTransparency = 1
btnMinimizar.Font = Enum.Font.SourceSansBold
btnMinimizar.TextSize = 24
btnMinimizar.Name = "BtnMinimizar"

-- BOTÃO FECHAR (X)
local btnFechar = Instance.new("TextButton")
btnFechar.Parent = barraTitulo
btnFechar.Size = UDim2.new(0, 35, 1, 0)
btnFechar.Position = UDim2.new(1, -35, 0, 0)
btnFechar.Text = "X"
btnFechar.TextColor3 = Color3.fromRGB(255, 100, 100)
btnFechar.BackgroundTransparency = 1
btnFechar.Font = Enum.Font.SourceSansBold
btnFechar.TextSize = 20
btnFechar.Name = "BtnFechar"

-- ===========================================
-- CONTEÚDO DA JANELA
-- ===========================================
local conteudo = Instance.new("Frame")
conteudo.Parent = janela
conteudo.Size = UDim2.new(1, 0, 1, -35)
conteudo.Position = UDim2.new(0, 0, 0, 35)
conteudo.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
conteudo.Name = "Conteudo"

-- ===========================================
-- SEÇÃO TESTE
-- ===========================================
local secaoTitulo = Instance.new("TextLabel")
secaoTitulo.Parent = conteudo
secaoTitulo.Size = UDim2.new(1, -20, 0, 30)
secaoTitulo.Position = UDim2.new(0, 10, 0, 10)
secaoTitulo.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
secaoTitulo.Text = "  🔧 TESTES"
secaoTitulo.TextColor3 = Color3.fromRGB(255, 255, 255)
secaoTitulo.Font = Enum.Font.SourceSansBold
secaoTitulo.TextSize = 16
secaoTitulo.TextXAlignment = Enum.TextXAlignment.Left

-- ===========================================
-- TOGGLE TESTE-MSG (IGUAL AO QUE FUNCIONOU)
-- ===========================================
local toggleFrame = Instance.new("Frame")
toggleFrame.Parent = conteudo
toggleFrame.Size = UDim2.new(1, -20, 0, 40)
toggleFrame.Position = UDim2.new(0, 10, 0, 45)
toggleFrame.BackgroundTransparency = 1

local toggleTexto = Instance.new("TextLabel")
toggleTexto.Parent = toggleFrame
toggleTexto.Size = UDim2.new(0, 200, 1, 0)
toggleTexto.Position = UDim2.new(0, 5, 0, 0)
toggleTexto.BackgroundTransparency = 1
toggleTexto.Text = "📢 teste-msg"
toggleTexto.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleTexto.Font = Enum.Font.SourceSans
toggleTexto.TextSize = 16
toggleTexto.TextXAlignment = Enum.TextXAlignment.Left

local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = toggleFrame
toggleBtn.Size = UDim2.new(0, 50, 0, 25)
toggleBtn.Position = UDim2.new(1, -55, 0.5, -12.5)
toggleBtn.Text = "OFF"
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.SourceSansBold
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

-- ===========================================
-- BOTÃO TESTAR NOTIFICAÇÃO
-- ===========================================
local btnNotificacao = Instance.new("TextButton")
btnNotificacao.Parent = conteudo
btnNotificacao.Size = UDim2.new(0, 150, 0, 35)
btnNotificacao.Position = UDim2.new(0.5, -75, 0, 100)
btnNotificacao.Text = "📨 Testar Notificação"
btnNotificacao.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
btnNotificacao.TextColor3 = Color3.fromRGB(255, 255, 255)
btnNotificacao.Font = Enum.Font.SourceSans
btnNotificacao.TextSize = 16

btnNotificacao.MouseButton1Click:Connect(function()
    print("✅ Notificação testada!")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "📨 NOTIFICAÇÃO",
        Text = "Isso é um teste!",
        Duration = 2
    })
end)

-- ===========================================
-- BOTÃO FECHAR UI
-- ===========================================
local btnFecharUI = Instance.new("TextButton")
btnFecharUI.Parent = conteudo
btnFecharUI.Size = UDim2.new(0, 150, 0, 35)
btnFecharUI.Position = UDim2.new(0.5, -75, 0, 150)
btnFecharUI.Text = "🔴 Fechar UI"
btnFecharUI.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
btnFecharUI.TextColor3 = Color3.fromRGB(255, 255, 255)
btnFecharUI.Font = Enum.Font.SourceSans
btnFecharUI.TextSize = 16

btnFecharUI.MouseButton1Click:Connect(function()
    janela.Visible = false
end)

-- ===========================================
-- BOTÃO ABRIR NOVAMENTE (DENTRO DA UI)
-- ===========================================
local btnAbrir = Instance.new("TextButton")
btnAbrir.Parent = conteudo
btnAbrir.Size = UDim2.new(0, 150, 0, 35)
btnAbrir.Position = UDim2.new(0.5, -75, 0, 200)
btnAbrir.Text = "🟢 Abrir (teste)"
btnAbrir.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
btnAbrir.TextColor3 = Color3.fromRGB(255, 255, 255)
btnAbrir.Font = Enum.Font.SourceSans
btnAbrir.TextSize = 16
btnAbrir.Visible = false  -- Invisível por enquanto

-- ===========================================
-- FUNÇÕES DOS BOTÕES DA BARRA
-- ===========================================

-- FECHAR JANELA (X)
btnFechar.MouseButton1Click:Connect(function()
    janela.Visible = false
    -- Mostra o botão de abrir dentro da UI (opcional)
    btnAbrir.Visible = true
end)

-- MINIMIZAR (-)
local minimizado = false
btnMinimizar.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    if minimizado then
        conteudo.Visible = false
        janela.Size = UDim2.new(0, 350, 0, 35)
        btnMinimizar.Text = "+"
    else
        conteudo.Visible = true
        janela.Size = UDim2.new(0, 350, 0, 300)
        btnMinimizar.Text = "-"
    end
end)

-- BOTÃO ABRIR (quando a UI está fechada)
btnAbrir.MouseButton1Click:Connect(function()
    janela.Visible = true
    btnAbrir.Visible = false
end)

-- ===========================================
-- FUNÇÃO DO BOTÃO FLUTUANTE (IGUAL AO TESTE)
-- ===========================================
botaoFlutuante.MouseButton1Click:Connect(function()
    janela.Visible = not janela.Visible
    if janela.Visible then
        print("🟢 UI Aberta pelo botão flutuante")
        btnAbrir.Visible = false
    else
        print("🔴 UI Fechada pelo botão flutuante")
        btnAbrir.Visible = true
    end
end)

-- ===========================================
-- FINALIZAÇÃO
-- ===========================================
print("🚀 UI COMPLETA CARREGADA!")
print("✅ Botão flutuante com sua foto funcionando!")
print("✅ Toggle 'teste-msg' pronto!")
print("💡 Use o botão com a foto para abrir/fechar")

-- NOTIFICAÇÃO INICIAL
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "✅ UI Carregada!",
    Text = "Botão flutuante com sua foto",
    Duration = 3
})
