-- ===========================================
-- UI LIBRARY (VERSÃO CORRETA PARA BIBLIOTECA)
-- ===========================================

local library = {count = 0, queue = {}, callbacks = {}, rainbowtable = {}, toggled = true, binds = {}};
local defaults;
do
    local dragger = {};
    do
        local players = game:service('Players');
        local player = players.LocalPlayer;
        local mouse = player:GetMouse();
        local run = game:service('RunService');
        local stepped = run.Stepped;
        dragger.new = function(obj)
            spawn(function()
                local minitial;
                local initial;
                local isdragging;
                obj.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        isdragging = true;
                        minitial = input.Position;
                        initial = obj.Position;
                        local con;
                        con = stepped:Connect(function()
                            if isdragging then
                                local delta = Vector3.new(mouse.X, mouse.Y, 0) - minitial;
                                obj.Position = UDim2.new(initial.X.Scale, initial.X.Offset + delta.X, initial.Y.Scale, initial.Y.Offset + delta.Y);
                            else
                                con:Disconnect();
                            end;
                        end);
                        input.Changed:Connect(function()
                            if input.UserInputState == Enum.UserInputState.End then
                                isdragging = false;
                            end;
                        end);
                    end;
                end);
            end)
        end;
    end
    
    local types = {}; do
        types.__index = types;
        function types.window(name, options)
            library.count = library.count + 1
            local newWindow = library:Create('Frame', {
                Name = name;
                Size = UDim2.new(0, 190, 0, 30);
                BackgroundColor3 = options.topcolor;
                BorderSizePixel = 0;
                Parent = library.container;
                Position = UDim2.new(0, (15 + (200 * library.count) - 200), 0, 0);
                ZIndex = 3;
                library:Create('TextLabel', {
                    Text = name;
                    Size = UDim2.new(1, -10, 1, 0);
                    Position = UDim2.new(0, 5, 0, 0);
                    BackgroundTransparency = 1;
                    TextSize = options.titlesize;
                    Font = options.titlefont or Enum.Font.Code;
                    TextColor3 = options.titletextcolor or Color3.new(1,1,1);
                    TextStrokeTransparency = 1;
                    ZIndex = 3;
                });
                library:Create("TextButton", {
                    Size = UDim2.new(0, 30, 0, 30);
                    Position = UDim2.new(1, -35, 0, 0);
                    BackgroundTransparency = 1;
                    Text = "-";
                    TextSize = options.titlesize;
                    Font = options.titlefont or Enum.Font.Code;
                    Name = 'window_toggle';
                    TextColor3 = options.titletextcolor or Color3.new(1,1,1);
                    ZIndex = 3;
                });
                library:Create("Frame", {
                    Name = 'Underline';
                    Size = UDim2.new(1, 0, 0, 2);
                    Position = UDim2.new(0, 0, 1, -2);
                    BackgroundColor3 = options.underlinecolor or Color3.new(0,1,0);
                    BorderSizePixel = 0;
                    ZIndex = 3;
                });
                library:Create('Frame', {
                    Name = 'container';
                    Position = UDim2.new(0, 0, 1, 0);
                    Size = UDim2.new(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = options.bgcolor or Color3.new(0.2,0.2,0.2);
                    ClipsDescendants = false;
                    library:Create('UIListLayout', {
                        Name = 'List';
                        SortOrder = Enum.SortOrder.LayoutOrder;
                    })
                });
            })
            
            if options.underlinecolor == "rainbow" then
                table.insert(library.rainbowtable, newWindow:FindFirstChild('Underline'))
            end

            local window = setmetatable({
                count = 0;
                object = newWindow;
                container = newWindow.container;
                toggled = true;
                flags   = {};
            }, types)

            table.insert(library.queue, {
                w = window.object;
                p = window.object.Position;
            })

            newWindow:FindFirstChild("window_toggle").MouseButton1Click:connect(function()
                window.toggled = not window.toggled;
                newWindow:FindFirstChild("window_toggle").Text = (window.toggled and "+" or "-")
                if (not window.toggled) then
                    window.container.ClipsDescendants = true;
                end
                wait();
                local y = 0;
                for i, v in next, window.container:GetChildren() do
                    if (not v:IsA('UIListLayout')) then
                        y = y + v.AbsoluteSize.Y;
                    end
                end 

                local targetSize = window.toggled and UDim2.new(1, 0, 0, y+5) or UDim2.new(1, 0, 0, 0);
                local targetDirection = window.toggled and "In" or "Out"

                window.container:TweenSize(targetSize, targetDirection, "Quad", 0.15, true)
                wait(.15)
                if window.toggled then
                    window.container.ClipsDescendants = false;
                end
            end)

            return window;
        end
        
        function types:Resize()
            local y = 0;
            for i, v in next, self.container:GetChildren() do
                if (not v:IsA('UIListLayout')) then
                    y = y + v.AbsoluteSize.Y;
                end
            end 
            self.container.Size = UDim2.new(1, 0, 0, y+5)
        end
        
        function types:GetOrder() 
            local c = 0;
            for i, v in next, self.container:GetChildren() do
                if (not v:IsA('UIListLayout')) then
                    c = c + 1
                end
            end
            return c
        end
        
        function types:Section(name)
            local order = self:GetOrder();
            local check = library:Create('Frame', {
                Name = 'Section';
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 25);
                BackgroundColor3 = Color3.new(0.1,0.1,0.1);
                BorderSizePixel = 0;
                LayoutOrder = order;
                library:Create('TextLabel', {
                    Name = 'section_lbl';
                    Text = name;
                    BackgroundTransparency = 0;
                    BorderSizePixel = 0;
                    BackgroundColor3 = Color3.new(0.1,0.1,0.1);
                    TextColor3 = Color3.new(1,1,1);
                    Position = UDim2.new(0, 0, 0, 4);
                    Size = UDim2.new(1, 0, 0, 20);
                    Font = Enum.Font.SourceSans;
                    TextSize = 17;
                });
                Parent = self.container;
            });
            self:Resize();
        end

        function types:Button(name, callback)
            callback = callback or function() end;
            
            local check = library:Create('Frame', {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 25);
                LayoutOrder = self:GetOrder();
                library:Create('TextButton', {
                    Name = name;
                    Text = name;
                    BackgroundColor3 = Color3.new(0.1,0.1,0.1);
                    BorderColor3 = Color3.new(0.2,0.2,0.2);
                    TextColor3 = Color3.new(1,1,1);
                    Position = UDim2.new(0, 5, 0, 5);
                    Size = UDim2.new(1, -10, 0, 20);
                    Font = Enum.Font.SourceSans;
                    TextSize = 17;
                });
                Parent = self.container;
            });
            
            check:FindFirstChild(name).MouseButton1Click:connect(callback)
            self:Resize();
        end
        
        function types:Toggle(name, options, callback)
            local default = options.default or false;
            local location = options.location or self.flags;
            local flag = options.flag or "";
            local callback = callback or function() end;
            
            location[flag] = default;

            local check = library:Create('Frame', {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 25);
                LayoutOrder = self:GetOrder();
                library:Create('TextLabel', {
                    Name = name;
                    Text = "  " .. name;
                    BackgroundTransparency = 1;
                    TextColor3 = Color3.new(1,1,1);
                    Position = UDim2.new(0, 5, 0, 0);
                    Size = UDim2.new(1, -5, 1, 0);
                    TextXAlignment = Enum.TextXAlignment.Left;
                    Font = Enum.Font.SourceSans;
                    TextSize = 17;
                    library:Create('TextButton', {
                        Text = (location[flag] and "✓" or "");
                        Font = Enum.Font.SourceSans;
                        TextSize = 17;
                        Name = 'Checkmark';
                        Size = UDim2.new(0, 20, 0, 20);
                        Position = UDim2.new(1, -25, 0, 4);
                        TextColor3 = Color3.new(1,1,1);
                        BackgroundColor3 = Color3.new(0.2,0.2,0.2);
                        BorderColor3 = Color3.new(0.3,0.3,0.3);
                    })
                });
                Parent = self.container;
            });
                
            local function click()
                location[flag] = not location[flag];
                callback(location[flag])
                check:FindFirstChild(name).Checkmark.Text = location[flag] and "✓" or "";
            end

            check:FindFirstChild(name).Checkmark.MouseButton1Click:connect(click)
            library.callbacks[flag] = click;

            if location[flag] == true then
                callback(location[flag])
            end

            self:Resize();
        end
        
        function types:Slider(name, options, callback)
            local default = options.default or options.min;
            local min = options.min or 0;
            local max = options.max or 1;
            local location = options.location or self.flags;
            local flag = options.flag or "";
            local callback = callback or function() end

            location[flag] = default;

            local check = library:Create('Frame', {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 25);
                LayoutOrder = self:GetOrder();
                library:Create('TextLabel', {
                    Name = name;
                    Text = "  " .. name;
                    BackgroundTransparency = 1;
                    TextColor3 = Color3.new(1,1,1);
                    Position = UDim2.new(0, 5, 0, 2);
                    Size = UDim2.new(1, -5, 1, 0);
                    TextXAlignment = Enum.TextXAlignment.Left;
                    Font = Enum.Font.SourceSans;
                    TextSize = 17;
                    library:Create('Frame', {
                        Name = 'Container';
                        Size = UDim2.new(0, 60, 0, 20);
                        Position = UDim2.new(1, -65, 0, 3);
                        BackgroundTransparency = 1;
                        BorderSizePixel = 0;
                        library:Create('TextLabel', {
                            Name = 'ValueLabel';
                            Text = default;
                            BackgroundTransparency = 1;
                            TextColor3 = Color3.new(1,1,1);
                            Position = UDim2.new(0, -10, 0, 0);
                            Size = UDim2.new(0, 1, 1, 0);
                            TextXAlignment = Enum.TextXAlignment.Right;
                            Font = Enum.Font.SourceSans;
                            TextSize = 17;
                        });
                        library:Create('TextButton', {
                            Name = 'Button';
                            Size = UDim2.new(0, 5, 1, -2);
                            Position = UDim2.new(0, 0, 0, 1);
                            AutoButtonColor = false;
                            Text = "";
                            BackgroundColor3 = Color3.new(0.1,0.1,0.1);
                            BorderSizePixel = 0;
                            ZIndex = 2;
                        });
                        library:Create('Frame', {
                            Name = 'Line';
                            BackgroundTransparency = 0;
                            Position = UDim2.new(0, 0, 0.5, 0);
                            Size = UDim2.new(1, 0, 0, 1);
                            BackgroundColor3 = Color3.new(1,1,1);
                            BorderSizePixel = 0;
                        });
                    })
                });
                Parent = self.container;
            });

            local overlay = check:FindFirstChild(name);
            
            if default ~= min then
                local percent = 1 - ((max - default) / (max - min))
                overlay.Container.Button.Position = UDim2.new(math.clamp(percent, 0, 0.99), 0, 0, 1)
                overlay.Container.ValueLabel.Text = default
            end

            overlay.Container.MouseEnter:connect(function()
                local renderSteppedConnection;
                local function update()
                    if renderSteppedConnection then renderSteppedConnection:Disconnect() end
                    
                    renderSteppedConnection = game:GetService('RunService').RenderStepped:connect(function()
                        local mouse = game:GetService("UserInputService"):GetMouseLocation()
                        local percent = (mouse.X - overlay.Container.AbsolutePosition.X) / (overlay.Container.AbsoluteSize.X)
                        percent = math.clamp(percent, 0, 1)
                        percent = tonumber(string.format("%.2f", percent))

                        overlay.Container.Button.Position = UDim2.new(math.clamp(percent, 0, 0.99), 0, 0, 1)
                        
                        local num = min + (max - min) * percent
                        local value = math.floor(num)

                        overlay.Container.ValueLabel.Text = value;
                        callback(value)
                        location[flag] = value
                    end)
                end

                local function disconnect()
                    if renderSteppedConnection then renderSteppedConnection:Disconnect() end
                end

                overlay.Container.InputBegan:connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        update()
                    end
                end)

                overlay.Container.InputEnded:connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        disconnect()
                    end
                end)
            end)

            self:Resize();
        end
        
        function types:Dropdown(name, options, callback)
            local location = options.location or self.flags;
            local flag = options.flag or "";
            local callback = callback or function() end;
            local list = options.list or {};

            location[flag] = list[1]
            local check = library:Create('Frame', {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 25);
                LayoutOrder = self:GetOrder();
                library:Create('Frame', {
                    Name = 'dropdown_lbl';
                    BackgroundTransparency = 0;
                    BackgroundColor3 = Color3.new(0.1,0.1,0.1);
                    Position = UDim2.new(0, 5, 0, 4);
                    BorderColor3 = Color3.new(0.2,0.2,0.2);
                    Size = UDim2.new(1, -10, 0, 20);
                    library:Create('TextLabel', {
                        Name = 'Selection';
                        Size = UDim2.new(1, 0, 1, 0);
                        Text = list[1];
                        TextColor3 = Color3.new(1,1,1);
                        BackgroundTransparency = 1;
                        Font = Enum.Font.SourceSans;
                        TextSize = 17;
                    });
                    library:Create("TextButton", {
                        Name = 'drop';
                        BackgroundTransparency = 1;
                        Size = UDim2.new(0, 20, 1, 0);
                        Position = UDim2.new(1, -25, 0, 0);
                        Text = 'v';
                        TextColor3 = Color3.new(1,1,1);
                        Font = Enum.Font.SourceSans;
                        TextSize = 17;
                    })
                });
                Parent = self.container;
            });
            
            local button = check:FindFirstChild('dropdown_lbl').drop;
            local input;
            
            button.MouseButton1Click:connect(function()
                if (input and input.Connected) then
                    return
                end 
                
                local c = 0;
                for i, v in next, list do
                    c = c + 20;
                end

                local size = UDim2.new(1, 0, 0, c)
                local clampedSize;
                local scrollSize = 0;
                if size.Y.Offset > 100 then
                    clampedSize = UDim2.new(1, 0, 0, 100)
                    scrollSize = 5;
                end
                
                local goSize = (clampedSize ~= nil and clampedSize) or size;    
                local container = library:Create('ScrollingFrame', {
                    Name = 'DropContainer';
                    Parent = check:FindFirstChild('dropdown_lbl');
                    Size = UDim2.new(1, 0, 0, 0);
                    BackgroundColor3 = Color3.new(0.15,0.15,0.15);
                    BorderColor3 = Color3.new(0.2,0.2,0.2);
                    Position = UDim2.new(0, 0, 1, 0);
                    ScrollBarThickness = scrollSize;
                    CanvasSize = UDim2.new(0, 0, 0, size.Y.Offset);
                    ZIndex = 5;
                    ClipsDescendants = true;
                    library:Create('UIListLayout', {
                        Name = 'List';
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                })

                for i, v in next, list do
                    local btn = library:Create('TextButton', {
                        Size = UDim2.new(1, 0, 0, 20);
                        BackgroundColor3 = Color3.new(0.1,0.1,0.1);
                        BorderColor3 = Color3.new(0.2,0.2,0.2);
                        Text = v;
                        Font = Enum.Font.SourceSans;
                        TextSize = 17;
                        LayoutOrder = i;
                        Parent = container;
                        ZIndex = 5;
                        TextColor3 = Color3.new(1,1,1);
                    })
                    
                    btn.MouseButton1Click:connect(function()
                        check:FindFirstChild('dropdown_lbl'):WaitForChild('Selection').Text = btn.Text;
                        location[flag] = tostring(btn.Text);
                        callback(location[flag])
                        container:TweenSize(UDim2.new(1, 0, 0, 0), 'In', 'Quad', 0.15, true)
                        wait(0.15)
                        container:Destroy()
                        if input then input:Disconnect() end
                    end)
                end
                
                container:TweenSize(goSize, 'Out', 'Quad', 0.15, true)
                
                local function isInGui(frame)
                    local mloc = game:GetService('UserInputService'):GetMouseLocation();
                    local mouse = Vector2.new(mloc.X, mloc.Y - 36);
                    
                    local x1, x2 = frame.AbsolutePosition.X, frame.AbsolutePosition.X + frame.AbsoluteSize.X;
                    local y1, y2 = frame.AbsolutePosition.Y, frame.AbsolutePosition.Y + frame.AbsoluteSize.Y;
                
                    return (mouse.X >= x1 and mouse.X <= x2) and (mouse.Y >= y1 and mouse.Y <= y2)
                end
                
                input = game:GetService('UserInputService').InputBegan:connect(function(a)
                    if a.UserInputType == Enum.UserInputType.MouseButton1 and (not isInGui(container)) then
                        container:TweenSize(UDim2.new(1, 0, 0, 0), 'In', 'Quad', 0.15, true)
                        wait(0.15)
                        container:Destroy()
                        input:Disconnect();
                    end
                end)
            end)
            
            self:Resize();
        end
    end
    
    function library:Create(class, data)
        local obj = Instance.new(class);
        for i, v in next, data do
            if i ~= 'Parent' then
                if typeof(v) == "Instance" then
                    v.Parent = obj;
                else
                    obj[i] = v
                end
            end
        end
        obj.Parent = data.Parent;
        return obj
    end
    
    function library:CreateWindow(name, options)
        if (not library.container) then
            library.container = self:Create("ScreenGui", {
                self:Create('Frame', {
                    Name = 'Container';
                    Size = UDim2.new(1, -30, 1, 0);
                    Position = UDim2.new(0, 20, 0, 20);
                    BackgroundTransparency = 1;
                    Active = false;
                });
                Parent = game:GetService("CoreGui");
            }):FindFirstChild('Container');
        end
        
        if (not library.options) then
            library.options = options or {}
        end
        
        local window = types.window(name, library.options);
        dragger.new(window.object);
        return window
    end
end

return library
