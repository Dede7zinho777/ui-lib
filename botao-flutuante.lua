-- ===========================================
-- BOTÃO FLUTUANTE (SEPARADO)
-- ===========================================

local Botao = {}

function Botao:Criar(config)
    config = config or {}
    local imagem = config.Image or "rbxassetid://138340742425851"
    local tamanho = config.Tamanho or 60
    local posicao = config.Posicao or UDim2.new(0, 20, 0, 150)
    
    -- CRIAR BOTÃO
    local botao = Instance.new("ImageButton")
    botao.Name = "BotaoFlutuante"
    botao.Parent = game:GetService("CoreGui")
    botao.BackgroundTransparency = 1
    botao.Image = imagem
    botao.Size = UDim2.new(0, tamanho, 0, tamanho)
    botao.Position = posicao
    botao.Draggable = true
    botao.Active = true
    
    -- BORDA ARREDONDADA
    local uiCorner = Instance.new("UICorner")
    uiCorner.Parent = botao
    uiCorner.CornerRadius = UDim.new(0, tamanho/2)
    
    -- EFEITO HOVER
    botao.MouseEnter:Connect(function()
        botao.Size = UDim2.new(0, tamanho + 5, 0, tamanho + 5)
    end)
    
    botao.MouseLeave:Connect(function()
        botao.Size = UDim2.new(0, tamanho, 0, tamanho)
    end)
    
    return botao
end

return Botao
