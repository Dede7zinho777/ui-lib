-- ===========================================
-- BOTÃO FLUTUANTE LIBRARY
-- ===========================================

local BotaoFlutuanteLib = {}

function BotaoFlutuanteLib:Criar(Config)
    Config = Config or {}
    Config.Image = Config.Image or "rbxassetid://138340742425851"  -- SUA IMAGEM
    Config.Tamanho = Config.Tamanho or 60
    Config.Posicao = Config.Posicao or UDim2.new(0, 30, 0, 200)
    Config.Arrastavel = Config.Arrastavel ~= nil and Config.Arrastavel or true
    Config.UIAlvo = Config.UIAlvo or "Orion"
    
    -- CRIAR O BOTÃO
    local FloatingButton = Instance.new("ImageButton")
    FloatingButton.Parent = game:GetService("CoreGui")
    FloatingButton.BackgroundTransparency = 1
    FloatingButton.Image = Config.Image
    FloatingButton.Size = UDim2.new(0, Config.Tamanho, 0, Config.Tamanho)
    FloatingButton.Position = Config.Posicao
    FloatingButton.Draggable = Config.Arrastavel
    FloatingButton.Name = "FloatingButton"
    
    -- BORDA ARREDONDADA
    local UICorner = Instance.new("UICorner")
    UICorner.Parent = FloatingButton
    UICorner.CornerRadius = UDim.new(0, Config.Tamanho/2)
    
    -- CONTROLE DA UI
    local uiVisible = true
    
    -- FUNÇÃO PARA ENCONTRAR A UI
    local function encontrarUI()
        for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
            if v.Name == Config.UIAlvo then
                return v
            end
        end
        return nil
    end
    
    -- CLIQUE NO BOTÃO
    FloatingButton.MouseButton1Click:Connect(function()
        uiVisible = not uiVisible
        local ui = encontrarUI()
        if ui then
            ui.Enabled = uiVisible
        end
        if Config.AoClick then
            Config.AoClick(uiVisible)
        end
    end)
    
    print("✅ Botão flutuante criado! Controla: " .. Config.UIAlvo)
    
    -- RETORNA O BOTÃO
    return FloatingButton
end

return BotaoFlutuanteLib
