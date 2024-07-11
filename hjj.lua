-- Create a GUI
local GUI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ButtonContainer = Instance.new("ScrollingFrame")

GUI.Name = "Script Hub"
GUI.ResetOnSpawn = false -- Ensure GUI persists after respawn
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0, 0, 0, 0) -- Set position to (0, 0) by default
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BackgroundTransparency = 0.5
MainFrame.BorderSizePixel = 5

local colors = {
    Color3.new(1, 0, 0), -- Red
    Color3.new(0, 1, 0), -- Green
    Color3.new(1, 1, 0), -- Yellow
    Color3.new(0, 0, 1), -- Blue
    Color3.new(1, 0, 1) -- Purple
}

local colorIndex = 1
local colorTransition = 0

game:GetService("RunService").RenderStepped:Connect(function()
    colorTransition = colorTransition + 0.01
    if colorTransition > 1 then
        colorTransition = 0
        colorIndex = (colorIndex % #colors) + 1
    end
    local currentColor = colors[colorIndex]
    local nextColor = colors[(colorIndex + 1) % #colors + 1]
    MainFrame.BorderColor3 = currentColor:lerp(nextColor, colorTransition)
    MainFrame.BorderColor3 = MainFrame.BorderColor3 * 1.5 -- Make the color brighter
end)

Title.Size = UDim2.new(0, 300, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Font = Enum.Font.SourceSans
Title.FontSize = Enum.FontSize.Size24
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextStrokeTransparency = 0
Title.TextStrokeColor3 = Color3.new(0, 0, 0)
Title.Text = "Script Hub"

ButtonContainer.Size = UDim2.new(0, 300, 0, 370)
ButtonContainer.Position = UDim2.new(0, 0, 0, 30)
ButtonContainer.BackgroundColor3 = Color3.new(0, 0, 0)
ButtonContainer.BackgroundTransparency = 0.5
ButtonContainer.ScrollBarThickness = 10

GUI.Parent = game.Players.LocalPlayer.PlayerGui
MainFrame.Parent = GUI
Title.Parent = MainFrame
ButtonContainer.Parent = MainFrame

-- Make the GUI draggable
local UserInputService = game:GetService("UserInputService")
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if dragging and dragInput then
        update(dragInput)
    end
end)

-- Create buttons
local function createButton(name, callback, position)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 280, 0, 30)
    Button.Position = UDim2.new(0, 10, 0, position)
    Button.Font = Enum.Font.SourceSans
    Button.FontSize = Enum.FontSize.Size18
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.TextStrokeTransparency = 0
    Button.TextStrokeColor3 = Color3.new(0, 0, 0)
    Button.Text = name
    Button.BackgroundColor3 = Color3.new(0, 0, 0)
    Button.BackgroundTransparency = 0.5
    Button.MouseButton1Click:Connect(callback)
    Button.Parent = ButtonContainer
    return Button
end

-- Walkspeed button
local WalkspeedButton = createButton("Walkspeed", function()
    local WalkspeedFrame = Instance.new("Frame")
    WalkspeedFrame.Size = UDim2.new(0, 200, 0, 50)
    WalkspeedFrame.Position = UDim2.new(0, 50, 0, 50)
    WalkspeedFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    WalkspeedFrame.BackgroundTransparency = 0.5

    local WalkspeedLabel = Instance.new("TextLabel")
    WalkspeedLabel.Size = UDim2.new(0, 200, 0, 20)
    WalkspeedLabel.Position = UDim2.new(0, 0, 0, 0)
    WalkspeedLabel.Font = Enum.Font.SourceSans
    WalkspeedLabel.FontSize = Enum.FontSize.Size18
    WalkspeedLabel.TextColor3 = Color3.new(1, 1, 1)
    WalkspeedLabel.TextStrokeTransparency = 0
    WalkspeedLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    WalkspeedLabel.Text = "Enter walkspeed value (max 999)"

    local WalkspeedInput = Instance.new("TextBox")
    WalkspeedInput.Size = UDim2.new(0, 200, 0, 30)
    WalkspeedInput.Position = UDim2.new(0, 0, 0, 30)
    WalkspeedInput.Font = Enum.Font.SourceSans
    WalkspeedInput.FontSize = Enum.FontSize.Size18
    WalkspeedInput.TextColor3 = Color3.new(1, 1, 1)
    WalkspeedInput.TextStrokeTransparency = 0
    WalkspeedInput.TextStrokeColor3 = Color3.new(0, 0, 0)
    WalkspeedInput.BackgroundColor3 = Color3.new(0, 0, 0)
    WalkspeedInput.BackgroundTransparency = 0.5
    WalkspeedInput.Text = ""

    WalkspeedInput.Changed:Connect(function(property)
        if property == "Text" then
            local text = WalkspeedInput.Text
            if #text > 3 then
                WalkspeedInput.Text = text:sub(1, 3)
            end
        end
    end)

    local WalkspeedSubmit = Instance.new("TextButton")
    WalkspeedSubmit.Size = UDim2.new(0, 200, 0, 30)
    WalkspeedSubmit.Position = UDim2.new(0, 0, 0, 60)
    WalkspeedSubmit.Font = Enum.Font.SourceSans
    WalkspeedSubmit.FontSize = Enum.FontSize.Size18
    WalkspeedSubmit.TextColor3 = Color3.new(1, 1, 1)
    WalkspeedSubmit.TextStrokeTransparency = 0
    WalkspeedSubmit.TextStrokeColor3 = Color3.new(0, 0, 0)
    WalkspeedSubmit.Text = "Submit"
    WalkspeedSubmit.BackgroundColor3 = Color3.new(0, 0, 0)
    WalkspeedSubmit.BackgroundTransparency = 0.5
    WalkspeedSubmit.MouseButton1Click:Connect(function()
        local walkspeed = tonumber(WalkspeedInput.Text)
        if walkspeed and walkspeed <= 999 then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkspeed
            WalkspeedFrame:Destroy() -- Close the window
        else
            WalkspeedInput.Text = ""
            WalkspeedLabel.Text = "Invalid walkspeed value (max 999)"
        end
    end)

    WalkspeedFrame.Parent = GUI
    WalkspeedLabel.Parent = WalkspeedFrame
    WalkspeedInput.Parent = WalkspeedFrame
    WalkspeedSubmit.Parent = WalkspeedFrame
end, 0)

-- Create walkspeed reset button
local WalkspeedResetButton = createButton("Reset WalkSpeed", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end, 30)

-- Create jump height button
local JumpHeightButton = createButton("Jump Height", function()
    local JumpHeightFrame = Instance.new("Frame")
    JumpHeightFrame.Size = UDim2.new(0, 200, 0, 50)
    JumpHeightFrame.Position = UDim2.new(0, 50, 0, 50)
    JumpHeightFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    JumpHeightFrame.BackgroundTransparency = 0.5

    local JumpHeightLabel = Instance.new("TextLabel")
    JumpHeightLabel.Size = UDim2.new(0, 200, 0, 20)
    JumpHeightLabel.Position = UDim2.new(0, 0, 0, 0)
    JumpHeightLabel.Font = Enum.Font.SourceSans
    JumpHeightLabel.FontSize = Enum.FontSize.Size18
    JumpHeightLabel.TextColor3 = Color3.new(1, 1, 1)
    JumpHeightLabel.TextStrokeTransparency = 0
    JumpHeightLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    JumpHeightLabel.Text = "Enter jump height value (max 500)"

    local JumpHeightInput = Instance.new("TextBox")
    JumpHeightInput.Size = UDim2.new(0, 200, 0, 30)
    JumpHeightInput.Position = UDim2.new(0, 0, 0, 30)
    JumpHeightInput.Font = Enum.Font.SourceSans
    JumpHeightInput.FontSize = Enum.FontSize.Size18
    JumpHeightInput.TextColor3 = Color3.new(1, 1, 1)
    JumpHeightInput.TextStrokeTransparency = 0
    JumpHeightInput.TextStrokeColor3 = Color3.new(0, 0, 0)
    JumpHeightInput.BackgroundColor3 = Color3.new(0, 0, 0)
    JumpHeightInput.BackgroundTransparency = 0.5
    JumpHeightInput.Text = ""

    JumpHeightInput.Changed:Connect(function(property)
        if property == "Text" then
            local text = JumpHeightInput.Text
            if #text > 3 then
                JumpHeightInput.Text = text:sub(1, 3)
            end
        end
    end)

    local JumpHeightSubmit = Instance.new("TextButton")
    JumpHeightSubmit.Size = UDim2.new(0, 200, 0, 30)
    JumpHeightSubmit.Position = UDim2.new(0, 0, 0, 60)
    JumpHeightSubmit.Font = Enum.Font.SourceSans
    JumpHeightSubmit.FontSize = Enum.FontSize.Size18
    JumpHeightSubmit.TextColor3 = Color3.new(1, 1, 1)
    JumpHeightSubmit.TextStrokeTransparency = 0
    JumpHeightSubmit.TextStrokeColor3 = Color3.new(0, 0, 0)
    JumpHeightSubmit.Text = "Submit"
    JumpHeightSubmit.BackgroundColor3 = Color3.new(0, 0, 0)
    JumpHeightSubmit.BackgroundTransparency = 0.5
    JumpHeightSubmit.MouseButton1Click:Connect(function()
        local jumpheight = tonumber(JumpHeightInput.Text)
        if jumpheight and jumpheight <= 500 then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = jumpheight
            JumpHeightFrame:Destroy() -- Close the window
        else
            JumpHeightInput.Text = ""
            JumpHeightLabel.Text = "Invalid jump height value (max 500)"
        end
    end)

    JumpHeightFrame.Parent = GUI
    JumpHeightLabel.Parent = JumpHeightFrame
    JumpHeightInput.Parent = JumpHeightFrame
    JumpHeightSubmit.Parent = JumpHeightFrame
end, 60)

-- Create jump height reset button
local JumpHeightResetButton = createButton("Reset Jump Height", function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
end, 90)

-- Create close button
local CloseButton = createButton("Close", function()
    GUI:Destroy()
end, 120)

-- Create undetectable section
local UndetectableSection = Instance.new("Frame")
UndetectableSection.Size = UDim2.new(0, 280, 0, 80)
UndetectableSection.Position = UDim2.new(0, 10, 0, 150)
UndetectableSection.BackgroundColor3 = Color3.new(0, 0, 0)
UndetectableSection.BackgroundTransparency = 0.5
UndetectableSection.Parent = ButtonContainer

local UndetectableTitle = Instance.new("TextLabel")
UndetectableTitle.Size = UDim2.new(0, 280, 0, 20)
UndetectableTitle.Position = UDim2.new(0, 0, 0, 0)
UndetectableTitle.Font = Enum.Font.SourceSans
UndetectableTitle.FontSize = Enum.FontSize.Size18
UndetectableTitle.TextColor3 = Color3.new(1, 1, 1)
UndetectableTitle.TextStrokeTransparency = 0
UndetectableTitle.TextStrokeColor3 = Color3.new(0, 0, 0)
UndetectableTitle.Text = "Undetectable"
UndetectableTitle.Parent = UndetectableSection

local JumpUndetectableButton = Instance.new("TextButton")
JumpUndetectableButton.Size = UDim2.new(0, 280, 0, 30)
JumpUndetectableButton.Position = UDim2.new(0, 0, 0, 20)
JumpUndetectableButton.Text = "Jump Undetectable (OFF)"
JumpUndetectableButton.Font = Enum.Font.SourceSans
JumpUndetectableButton.FontSize = Enum.FontSize.Size18
JumpUndetectableButton.TextColor3 = Color3.new(1, 1, 1)
JumpUndetectableButton.TextStrokeTransparency = 0
JumpUndetectableButton.TextStrokeColor3 = Color3.new(0, 0, 0)
JumpUndetectableButton.BackgroundColor3 = Color3.new(0, 0, 0)
JumpUndetectableButton.BackgroundTransparency = 0.5
JumpUndetectableButton.Parent = UndetectableSection

local SpeedUndetectableButton = Instance.new("TextButton")
SpeedUndetectableButton.Size = UDim2.new(0, 280, 0, 30)
SpeedUndetectableButton.Position = UDim2.new(0, 0, 0, 50)
SpeedUndetectableButton.Text = "Speed Undetectable (OFF)"
SpeedUndetectableButton.Font = Enum.Font.SourceSans
SpeedUndetectableButton.FontSize = Enum.FontSize.Size18
SpeedUndetectableButton.TextColor3 = Color3.new(1, 1, 1)
SpeedUndetectableButton.TextStrokeTransparency = 0
SpeedUndetectableButton.TextStrokeColor3 = Color3.new(0, 0, 0)
SpeedUndetectableButton.BackgroundColor3 = Color3.new(0, 0, 0)
SpeedUndetectableButton.BackgroundTransparency = 0.5
SpeedUndetectableButton.Parent = UndetectableSection

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character
local jumpEnabled = false
local speedEnabled = false

local function onJump(input)
    if input.KeyCode == Enum.KeyCode.Space then
        if jumpEnabled then
            character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame + Vector3.new(0, 10, 0)
        end
    end
end

UserInputService.InputBegan:Connect(onJump)

JumpUndetectableButton.MouseButton1Click:Connect(function()
    jumpEnabled = not jumpEnabled
    if jumpEnabled then
        JumpUndetectableButton.Text = "Jump Undetectable (ON)"
    else
        JumpUndetectableButton.Text = "Jump Undetectable (OFF)"
    end
end)

local function speed()
    while speedEnabled do
        wait()
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

        if hum and not hum.SeatPart then
            local movedir = hum.MoveDirection
            local speeddir = (movedir * 0.01) * 50

            game.Players.LocalPlayer.Character:TranslateBy(speeddir)
        end
    end
end

SpeedUndetectableButton.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    if speedEnabled then
        SpeedUndetectableButton.Text = "Speed Undetectable (ON)"
        speed()
    else
        SpeedUndetectableButton.Text = "Speed Undetectable (OFF)"
    end
end)
