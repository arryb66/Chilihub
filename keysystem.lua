-- Create the main screen GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:GetService("CoreGui")

-- Create the main frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.Parent = screenGui

-- Create the title label
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Text = "Chili Hub"
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextScaled = true
titleLabel.Parent = mainFrame

-- Create the "Get Key" button
local getKeyButton = Instance.new("TextButton")
getKeyButton.Size = UDim2.new(0.45, 0, 0, 50)
getKeyButton.Position = UDim2.new(0.025, 0, 0.3, 0)
getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 128, 0)
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.Text = "Get Key"
getKeyButton.TextSize = 20
getKeyButton.Font = Enum.Font.SourceSans
getKeyButton.TextScaled = true
getKeyButton.Parent = mainFrame

-- Create the "Check Key" button
local checkKeyButton = Instance.new("TextButton")
checkKeyButton.Size = U
