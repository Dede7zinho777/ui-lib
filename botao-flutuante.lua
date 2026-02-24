-- ===========================================
-- BOTÃO FLUTUANTE LIBRARY - DEFINITIVO
-- ===========================================

local BotaoFlutuanteLib = {}

function BotaoFlutuanteLib:Criar(Config)
    Config = Config or {}
    Config.Image = Config.Image or "rbxassetid://138340742425851"
    Config.Tamanho = Config.Tamanho or 60
    Config.Posicao = Config.Posicao or UDim2.new(0, 30, 0, 200)
    Config.Arrastavel = Config.Arrastavel ~= nil and Config.Arrastavel or true
    Config.UIAlvo = Config.UIAlvo or "Orion"
    
    -- CRIAR BOTÃO
    local Botao = Instance.new("ImageButton")
    Botao.Parent = game:GetService("CoreGui")
    Botao.BackgroundTransparency = 1
    Botao.Image = Config.Image
    Botao.Size = UDim2.new(0, Config.Tamanho, 0, Config.Tamanho)
    Botao.Position = Config.Posicao
    Botao.Draggable = Config.Arrastavel
    Botao.Name = "BotaoFlutuante"
    Botao.BackgroundColor3 = Color3.fromRGB(255,255,255)
    
    -- BORDA ARREDONDADA
    local UICorner = Instance.new("UICorner")
    UICorner.Parent = Botao
    UICorner.CornerRadius = UDim.new(0, Config.Tamanho/2)
    
    -- CONTROLE DA UI
    local uiVisible = true
    
    -- FUNÇÃO PARA ENCONTRAR UI
    local function encontrarUI()
        for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
            if v.Name == Config.UIAlvo then
                return v
            end
        end
        return nil
    end
    
    -- CLIQUE NO BOTÃO
    Botao.MouseButton1Click:Connect(function()
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
    return Botao
end

return BotaoFlutuanteLib
