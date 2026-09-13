--// SCORPION SYSTEM V2
--// Global Chat UI
--// Owner: parth251285
--// Roblox Studio LocalScript
--// Place in StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local OWNER = "parth251285"

--==================================================
-- COLORS
--==================================================

local BG = Color3.fromRGB(10, 10, 13)
local SIDEBAR = Color3.fromRGB(15, 15, 19)
local PANEL = Color3.fromRGB(20, 20, 25)
local PANEL2 = Color3.fromRGB(27, 27, 33)

local PINK = Color3.fromRGB(255, 45, 140)
local PINK2 = Color3.fromRGB(255, 85, 165)

local WHITE = Color3.fromRGB(245, 245, 248)
local MUTED = Color3.fromRGB(155, 155, 165)
local SYSTEM = Color3.fromRGB(190, 90, 255)

--==================================================
-- CLEAN OLD UI
--==================================================

local old = PlayerGui:FindFirstChild("ScorpionSystem")
if old then
	old:Destroy()
end

--==================================================
-- HELPERS
--==================================================

local function New(class, props, parent)
	local obj = Instance.new(class)

	for property, value in pairs(props) do
		obj[property] = value
	end

	obj.Parent = parent
	return obj
end

local function Corner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius)
	c.Parent = parent
	return c
end

local function Stroke(parent, color, thickness)
	local s = Instance.new("UIStroke")
	s.Color = color
	s.Thickness = thickness
	s.Transparency = 0.35
	s.Parent = parent
	return s
end

local function Tween(object, properties, duration)
	TweenService:Create(
		object,
		TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		properties
	):Play()
end

--==================================================
-- SCREEN GUI
--==================================================

local Gui = New("ScreenGui", {
	Name = "ScorpionSystem",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	DisplayOrder = 100
}, PlayerGui)

--==================================================
-- MAIN WINDOW
--==================================================

local Main = New("Frame", {
	Name = "Main",
	Size = UDim2.new(0.78, 0, 0.78, 0),
	Position = UDim2.new(0.11, 0, 0.11, 0),
	BackgroundColor3 = BG,
	BorderSizePixel = 0
}, Gui)

Corner(Main, 16)
Stroke(Main, PINK, 1)

--==================================================
-- TOP BAR
--==================================================

local Top = New("Frame", {
	Name = "TopBar",
	Size = UDim2.new(1, 0, 0, 65),
	BackgroundColor3 = PANEL,
	BorderSizePixel = 0
}, Main)

Corner(Top, 16)

local Title = New("TextLabel", {
	Size = UDim2.new(0, 280, 1, 0),
	Position = UDim2.new(0, 20, 0, 0),
	BackgroundTransparency = 1,
	Text = "🦂  SCORPION SYSTEM",
	TextColor3 = WHITE,
	TextSize = 22,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
}, Top)

local Version = New("TextLabel", {
	Size = UDim2.new(0, 100, 1, 0),
	Position = UDim2.new(0, 300, 0, 0),
	BackgroundTransparency = 1,
	Text = "V2.0",
	TextColor3 = PINK,
	TextSize = 13,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
}, Top)

local Close = New("TextButton", {
	Size = UDim2.new(0, 42, 0, 42),
	Position = UDim2.new(1, -52, 0, 11),
	BackgroundColor3 = Color3.fromRGB(35, 35, 42),
	Text = "×",
	TextColor3 = WHITE,
	TextSize = 25,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false
}, Top)

Corner(Close, 10)

Close.MouseEnter:Connect(function()
	Tween(Close, {BackgroundColor3 = PINK})
end)

Close.MouseLeave:Connect(function()
	Tween(Close, {BackgroundColor3 = Color3.fromRGB(35, 35, 42)})
end)

Close.MouseButton1Click:Connect(function()
	Gui.Enabled = false
end)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = New("Frame", {
	Name = "Sidebar",
	Size = UDim2.new(0, 185, 1, -65),
	Position = UDim2.new(0, 0, 0, 65),
	BackgroundColor3 = SIDEBAR,
	BorderSizePixel = 0
}, Main)

local SidebarTitle = New("TextLabel", {
	Size = UDim2.new(1, -20, 0, 45),
	Position = UDim2.new(0, 10, 0, 15),
	BackgroundTransparency = 1,
	Text = "SYSTEM",
	TextColor3 = MUTED,
	TextSize = 12,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
}, Sidebar)

local Pages = {
	{"💬", "Global Chat"},
	{"👥", "Players"},
	{"📜", "Scripts"},
	{"🛡", "Clan"},
	{"👑", "Ranks"}
}

local Buttons = {}
local CurrentPage = "Global Chat"

--==================================================
-- CONTENT
--==================================================

local Content = New("Frame", {
	Name = "Content",
	Size = UDim2.new(1, -185, 1, -65),
	Position = UDim2.new(0, 185, 0, 65),
	BackgroundColor3 = BG,
	BorderSizePixel = 0
}, Main)

--==================================================
-- GLOBAL CHAT PAGE
--==================================================

local ChatPage = New("Frame", {
	Name = "GlobalChat",
	Size = UDim2.new(1, -30, 1, -30),
	Position = UDim2.new(0, 15, 0, 15),
	BackgroundTransparency = 1
}, Content)

local ChatHeader = New("TextLabel", {
	Size = UDim2.new(1, 0, 0, 45),
	BackgroundTransparency = 1,
	Text = "GLOBAL CHAT",
	TextColor3 = WHITE,
	TextSize = 20,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
}, ChatPage)

local Online = New("TextLabel", {
	Size = UDim2.new(0, 150, 0, 30),
	Position = UDim2.new(1, -150, 0, 5),
	BackgroundTransparency = 1,
	Text = "●  ONLINE",
	TextColor3 = Color3.fromRGB(80, 255, 150),
	TextSize = 12,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Right
}, ChatPage)

-- message scrolling area

local Messages = New("ScrollingFrame", {
	Name = "Messages",
	Size = UDim2.new(1, 0, 1, -115),
	Position = UDim2.new(0, 0, 0, 45),
	BackgroundColor3 = PANEL,
	BorderSizePixel = 0,
	CanvasSize = UDim2.new(0, 0, 0, 0),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	ScrollBarThickness = 4,
	ScrollBarImageColor3 = PINK
}, ChatPage)

Corner(Messages, 12)

local MessageLayout = New("UIListLayout", {
	Padding = UDim.new(0, 8),
	SortOrder = Enum.SortOrder.LayoutOrder
}, Messages)

New("UIPadding", {
	PaddingTop = UDim.new(0, 12),
	PaddingBottom = UDim.new(0, 12),
	PaddingLeft = UDim.new(0, 12),
	PaddingRight = UDim.new(0, 12)
}, Messages)

--==================================================
-- MESSAGE CREATION
--==================================================

local function AddMessage(username, message, systemMessage)
	local Holder = New("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1
	}, Messages)

	local Name = New("TextLabel", {
		Size = UDim2.new(1, 0, 0, 22),
		BackgroundTransparency = 1,
		Text = systemMessage and "[SYSTEM] " .. username or username,
		TextColor3 = systemMessage and SYSTEM or PINK2,
		TextSize = 13,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left
	}, Holder)

	local Text = New("TextLabel", {
		Size = UDim2.new(1, 0, 0, 0),
		Position = UDim2.new(0, 0, 0, 21),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text = message,
		TextColor3 = systemMessage and MUTED or WHITE,
		TextSize = 14,
		Font = Enum.Font.Gotham,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top
	}, Holder)

	local Padding = New("UIPadding", {
		PaddingBottom = UDim.new(0, 5)
	}, Holder)

	Holder.BackgroundTransparency = 1
	Tween(Holder, {BackgroundTransparency = 0}, 0.25)
end

--==================================================
-- INPUT AREA
--==================================================

local InputArea = New("Frame", {
	Size = UDim2.new(1, 0, 0, 55),
	Position = UDim2.new(0, 0, 1, -55),
	BackgroundColor3 = PANEL2,
	BorderSizePixel = 0
}, ChatPage)

Corner(InputArea, 12)

-- emoji button

local Emoji = New("TextButton", {
	Size = UDim2.new(0, 45, 0, 43),
	Position = UDim2.new(0, 6, 0, 6),
	BackgroundColor3 = Color3.fromRGB(38, 38, 46),
	Text = "😊",
	TextSize = 20,
	Font = Enum.Font.Gotham,
	AutoButtonColor = false
}, InputArea)

Corner(Emoji, 10)

-- image button

local ImageButton = New("TextButton", {
	Size = UDim2.new(0, 45, 0, 43),
	Position = UDim2.new(0, 57, 0, 6),
	BackgroundColor3 = Color3.fromRGB(38, 38, 46),
	Text = "🖼",
	TextSize = 19,
	Font = Enum.Font.Gotham,
	AutoButtonColor = false
}, InputArea)

Corner(ImageButton, 10)

-- text box

local MessageBox = New("TextBox", {
	Size = UDim2.new(1, -220, 0, 43),
	Position = UDim2.new(0, 108, 0, 6),
	BackgroundColor3 = Color3.fromRGB(32, 32, 39),
	TextColor3 = WHITE,
	PlaceholderColor3 = MUTED,
	PlaceholderText = "Type a message...",
	Text = "",
	TextSize = 14,
	Font = Enum.Font.Gotham,
	ClearTextOnFocus = false,
	TextXAlignment = Enum.TextXAlignment.Left
}, InputArea)

Corner(MessageBox, 10)

New("UIPadding", {
	PaddingLeft = UDim.new(0, 12),
	PaddingRight = UDim.new(0, 12)
}, MessageBox)

-- send button

local Send = New("TextButton", {
	Size = UDim2.new(0, 95, 0, 43),
	Position = UDim2.new(1, -101, 0, 6),
	BackgroundColor3 = PINK,
	Text = "SEND  ➤",
	TextColor3 = WHITE,
	TextSize = 13,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false
}, InputArea)

Corner(Send, 10)

--==================================================
-- EMOJI PANEL
--==================================================

local EmojiPanel = New("Frame", {
	Size = UDim2.new(0, 250, 0, 150),
	Position = UDim2.new(0, 5, 1, -210),
	BackgroundColor3 = PANEL,
	Visible = false,
	BorderSizePixel = 0,
	ZIndex = 20
}, ChatPage)

Corner(EmojiPanel, 12)
Stroke(EmojiPanel, PINK, 1)

local emojis = {
	"😀","😂","😭","🤣","😍",
	"😎","🔥","❤️","💀","😈",
	"🤯","😱","🥶","🤡","👑",
	"🦂","⚡","✨","💯","👍"
}

for i, emoji in ipairs(emojis) do
	local x = (i - 1) % 5
	local y = math.floor((i - 1) / 5)

	local B = New("TextButton", {
		Size = UDim2.new(0, 42, 0, 32),
		Position = UDim2.new(0, 10 + x * 47, 0, 10 + y * 34),
		BackgroundTransparency = 1,
		Text = emoji,
		TextSize = 20,
		ZIndex = 21
	}, EmojiPanel)

	B.MouseButton1Click:Connect(function()
		MessageBox.Text = MessageBox.Text .. emoji
		MessageBox:CaptureFocus()
		EmojiPanel.Visible = false
	end)
end

Emoji.MouseButton1Click:Connect(function()
	EmojiPanel.Visible = not EmojiPanel.Visible
end)

--==================================================
-- IMAGE ATTACHMENT
--==================================================

ImageButton.MouseButton1Click:Connect(function()
	MessageBox.Text = MessageBox.Text .. " [Image: rbxassetid://]"
	MessageBox:CaptureFocus()
end)

--==================================================
-- ROBLOX GLOBAL TEXT CHAT
--==================================================

local GeneralChannel

task.spawn(function()
	local channels = TextChatService:WaitForChild("TextChannels", 10)

	if channels then
		GeneralChannel = channels:FindFirstChild("RBXGeneral")

		if GeneralChannel then
			GeneralChannel.MessageReceived:Connect(function(textMessage)

				local source = textMessage.TextSource

				if source then
					local speaker = Players:GetPlayerByUserId(source.UserId)

					if speaker then
						AddMessage(speaker.DisplayName, textMessage.Text, false)
					else
						AddMessage("PLAYER", textMessage.Text, false)
					end
				end
			end)
		end
	end
end)

--==================================================
-- SEND MESSAGE
--==================================================

local function SendMessage()
	local text = MessageBox.Text

	if text == "" then
		return
	end

	if not GeneralChannel then
		AddMessage("SYSTEM", "Global chat is still connecting...", true)
		return
	end

	local success, err = pcall(function()
		GeneralChannel:SendAsync(text)
	end)

	if success then
		MessageBox.Text = ""
	else
		warn("Scorpion Chat Error:", err)
	end
end

Send.MouseButton1Click:Connect(SendMessage)

MessageBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		SendMessage()
	end
end)

--==================================================
-- LOCAL JOIN MESSAGE
--==================================================

task.delay(1, function()
	AddMessage(Player.DisplayName, "joined Scorpion System", true)
end)

--==================================================
-- SIDEBAR BUTTONS
--==================================================

local function CreatePageButton(icon, name, index)

	local Button = New("TextButton", {
		Size = UDim2.new(1, -20, 0, 45),
		Position = UDim2.new(0, 10, 0, 65 + ((index - 1) * 50)),
		BackgroundColor3 = name == "Global Chat" and PINK or SIDEBAR,
		Text = icon .. "   " .. name,
		TextColor3 = WHITE,
		TextSize = 13,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left,
		AutoButtonColor = false
	}, Sidebar)

	Corner(Button, 9)

	New("UIPadding", {
		PaddingLeft = UDim.new(0, 12)
	}, Button)

	Button.MouseEnter:Connect(function()
		if CurrentPage ~= name then
			Tween(Button, {BackgroundColor3 = Color3.fromRGB(30, 30, 37)})
		end
	end)

	Button.MouseLeave:Connect(function()
		if CurrentPage ~= name then
			Tween(Button, {BackgroundColor3 = SIDEBAR})
		end
	end)

	Button.MouseButton1Click:Connect(function()

		CurrentPage = name

		for _, b in pairs(Buttons) do
			Tween(b, {
				BackgroundColor3 = SIDEBAR
			})
		end

		Tween(Button, {
			BackgroundColor3 = PINK
		})

		-- Future pages can be connected here.
		if name == "Global Chat" then
			ChatPage.Visible = true
		else
			ChatPage.Visible = true

			AddMessage(
				"SYSTEM",
				name .. " panel is ready for the next Scorpion System update.",
				true
			)
		end
	end)

	table.insert(Buttons, Button)
end

for i, data in ipairs(Pages) do
	CreatePageButton(data[1], data[2], i)
end

--==================================================
-- DRAG WINDOW
--==================================================

local dragging = false
local dragStart
local startPosition

Top.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPosition = Main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)

	if not dragging then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then

		local delta = input.Position - dragStart

		Main.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end
end)

--==================================================
-- RESPONSIVE UI
--==================================================

local function UpdateSize()

	if Main.AbsoluteSize.X < 650 then
		Main.Size = UDim2.new(0.94, 0, 0.82, 0)
		Main.Position = UDim2.new(0.03, 0, 0.09, 0)

		Sidebar.Size = UDim2.new(0, 125, 1, -65)
		Content.Position = UDim2.new(0, 125, 0, 65)
		Content.Size = UDim2.new(1, -125, 1, -65)
	end
end

Main:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateSize)

UpdateSize()

print("🦂 Scorpion System V2 loaded")
