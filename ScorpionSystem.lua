--========================================================--
-- 🦂 SCORPION SYSTEM - SINGLE SCRIPT
-- Place this ONE LocalScript in:
-- StarterPlayer > StarterPlayerScripts
--========================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--========================================================--
-- CONFIG
--========================================================--

local OWNER = "parth251285"

--========================================================--
-- COLORS
--========================================================--

local BG = Color3.fromRGB(9, 8, 12)
local SIDEBAR = Color3.fromRGB(15, 14, 19)
local PANEL = Color3.fromRGB(21, 20, 27)
local PANEL2 = Color3.fromRGB(29, 27, 36)

local PINK = Color3.fromRGB(245, 35, 125)
local PINK2 = Color3.fromRGB(255, 75, 155)
local PURPLE = Color3.fromRGB(175, 80, 255)

local WHITE = Color3.fromRGB(245, 245, 248)
local GRAY = Color3.fromRGB(155, 151, 165)
local MUTED = Color3.fromRGB(92, 89, 101)

--========================================================--
-- REMOVE OLD VERSION
--========================================================--

local old = playerGui:FindFirstChild("ScorpionSystem")

if old then
	old:Destroy()
end

--========================================================--
-- HELPERS
--========================================================--

local function create(className, properties, parent)

	local object = Instance.new(className)

	for property, value in pairs(properties) do
		object[property] = value
	end

	object.Parent = parent

	return object
end

local function corner(object, radius)

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius)
	c.Parent = object

end

local function stroke(object, color, thickness, transparency)

	local s = Instance.new("UIStroke")

	s.Color = color
	s.Thickness = thickness or 1
	s.Transparency = transparency or 0

	s.Parent = object

end

local function tween(object, properties, duration)

	local t = TweenService:Create(
		object,
		TweenInfo.new(
			duration or 0.2,
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.Out
		),
		properties
	)

	t:Play()

	return t
end

--========================================================--
-- SCREEN GUI
--========================================================--

local gui = create("ScreenGui", {
	Name = "ScorpionSystem",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	DisplayOrder = 999,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, playerGui)

--========================================================--
-- MAIN WINDOW
--========================================================--

local main = create("Frame", {
	Name = "Main",
	Size = UDim2.new(0.84, 0, 0.82, 0),
	Position = UDim2.new(0.08, 0, 0.09, 0),
	BackgroundColor3 = BG,
	BorderSizePixel = 0,
	ClipsDescendants = true
}, gui)

corner(main, 18)
stroke(main, Color3.fromRGB(75, 70, 85), 1, 0.2)

--========================================================--
-- TOP BAR
--========================================================--

local top = create("Frame", {
	Name = "TopBar",
	Size = UDim2.new(1, 0, 0, 70),
	BackgroundColor3 = PANEL,
	BorderSizePixel = 0
}, main)

local logo = create("TextLabel", {
	Size = UDim2.new(0, 48, 0, 48),
	Position = UDim2.new(0, 14, 0, 11),
	BackgroundColor3 = PINK,
	Text = "🦂",
	TextColor3 = WHITE,
	TextSize = 25,
	Font = Enum.Font.GothamBold
}, top)

corner(logo, 14)

local title = create("TextLabel", {
	Size = UDim2.new(0, 270, 0, 28),
	Position = UDim2.new(0, 74, 0, 10),
	BackgroundTransparency = 1,
	Text = "SCORPION SYSTEM",
	TextColor3 = WHITE,
	TextSize = 20,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
}, top)

local subtitle = create("TextLabel", {
	Size = UDim2.new(0, 300, 0, 20),
	Position = UDim2.new(0, 75, 0, 38),
	BackgroundTransparency = 1,
	Text = "Private communication system",
	TextColor3 = GRAY,
	TextSize = 11,
	Font = Enum.Font.Gotham,
	TextXAlignment = Enum.TextXAlignment.Left
}, top)

local onlineDot = create("Frame", {
	Size = UDim2.new(0, 8, 0, 8),
	Position = UDim2.new(1, -135, 0, 26),
	BackgroundColor3 = Color3.fromRGB(70, 235, 130),
	BorderSizePixel = 0
}, top)

corner(onlineDot, 20)

local onlineText = create("TextLabel", {
	Size = UDim2.new(0, 70, 0, 25),
	Position = UDim2.new(1, -122, 0, 18),
	BackgroundTransparency = 1,
	Text = "ONLINE",
	TextColor3 = GRAY,
	TextSize = 10,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
}, top)

local close = create("TextButton", {
	Size = UDim2.new(0, 40, 0, 40),
	Position = UDim2.new(1, -50, 0, 15),
	BackgroundColor3 = PANEL2,
	Text = "×",
	TextColor3 = WHITE,
	TextSize = 23,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false
}, top)

corner(close, 10)

close.MouseButton1Click:Connect(function()
	gui.Enabled = false
end)

--========================================================--
-- SIDEBAR
--========================================================--

local sidebar = create("Frame", {
	Name = "Sidebar",
	Size = UDim2.new(0, 185, 1, -70),
	Position = UDim2.new(0, 0, 0, 70),
	BackgroundColor3 = SIDEBAR,
	BorderSizePixel = 0
}, main)

local navTitle = create("TextLabel", {
	Size = UDim2.new(1, -25, 0, 20),
	Position = UDim2.new(0, 15, 0, 17),
	BackgroundTransparency = 1,
	Text = "NAVIGATION",
	TextColor3 = MUTED,
	TextSize = 10,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
}, sidebar)

local nav = {
	{"💬", "Global Chat"},
	{"👥", "Players"},
	{"📜", "Scripts"},
	{"🛡", "Clan"},
	{"👑", "Ranks"}
}

local navButtons = {}

--========================================================--
-- CONTENT
--========================================================--

local content = create("Frame", {
	Name = "Content",
	Size = UDim2.new(1, -185, 1, -70),
	Position = UDim2.new(0, 185, 0, 70),
	BackgroundColor3 = BG,
	BorderSizePixel = 0
}, main)

--========================================================--
-- CHAT PAGE
--========================================================--

local chatPage = create("Frame", {
	Name = "GlobalChat",
	Size = UDim2.new(1, -30, 1, -30),
	Position = UDim2.new(0, 15, 0, 15),
	BackgroundTransparency = 1
}, content)

local chatTitle = create("TextLabel", {
	Size = UDim2.new(1, -100, 0, 30),
	Position = UDim2.new(0, 4, 0, 0),
	BackgroundTransparency = 1,
	Text = "Global Chat",
	TextColor3 = WHITE,
	TextSize = 23,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
}, chatPage)

local chatSub = create("TextLabel", {
	Size = UDim2.new(1, -100, 0, 20),
	Position = UDim2.new(0, 4, 0, 30),
	BackgroundTransparency = 1,
	Text = "Scorpion System users",
	TextColor3 = GRAY,
	TextSize = 11,
	Font = Enum.Font.Gotham,
	TextXAlignment = Enum.TextXAlignment.Left
}, chatPage)

--========================================================--
-- MESSAGE AREA
--========================================================--

local messages = create("ScrollingFrame", {
	Name = "Messages",
	Size = UDim2.new(1, 0, 1, -120),
	Position = UDim2.new(0, 0, 0, 65),
	BackgroundColor3 = PANEL,
	BorderSizePixel = 0,
	ScrollBarThickness = 4,
	ScrollBarImageColor3 = PINK,
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	CanvasSize = UDim2.new(0, 0, 0, 0)
}, chatPage)

corner(messages, 14)

create("UIPadding", {
	PaddingTop = UDim.new(0, 12),
	PaddingBottom = UDim.new(0, 12),
	PaddingLeft = UDim.new(0, 12),
	PaddingRight = UDim.new(0, 12)
}, messages)

local messageLayout = create("UIListLayout", {
	Padding = UDim.new(0, 8),
	SortOrder = Enum.SortOrder.LayoutOrder
}, messages)

--========================================================--
-- ADD MESSAGE
--========================================================--

local function addMessage(name, username, text, system)

	local card = create("Frame", {
		Size = UDim2.new(1, 0, 0, system and 55 or 70),
		BackgroundColor3 = system
			and Color3.fromRGB(40, 28, 47)
			or PANEL2,
		BorderSizePixel = 0
	}, messages)

	corner(card, 12)

	stroke(
		card,
		system and PURPLE or Color3.fromRGB(55, 52, 62),
		1,
		0.55
	)

	local avatar = create("ImageLabel", {
		Size = UDim2.new(0, 42, 0, 42),
		Position = UDim2.new(0, 10, 0, 10),
		BackgroundColor3 = system and PURPLE or SIDEBAR,
		BorderSizePixel = 0,
		Image = ""
	}, card)

	corner(avatar, 21)

	if system then

		local icon = create("TextLabel", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = "🦂",
			TextSize = 17,
			Font = Enum.Font.GothamBold
		}, avatar)

	else

		task.spawn(function()

			local ok, userId = pcall(function()
				return Players:GetUserIdFromNameAsync(username)
			end)

			if ok then

				local ok2, image = pcall(function()

					return Players:GetUserThumbnailAsync(
						userId,
						Enum.ThumbnailType.HeadShot,
						Enum.ThumbnailSize.Size100x100
					)

				end)

				if ok2 then
					avatar.Image = image
				end

			end

		end)

	end

	local nameLabel = create("TextLabel", {
		Size = UDim2.new(1, -70, 0, 20),
		Position = UDim2.new(0, 62, 0, 8),
		BackgroundTransparency = 1,
		Text = system and "[SYSTEM] " .. name or name,
		TextColor3 = system and PURPLE or PINK2,
		TextSize = 12,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left
	}, card)

	local body = create("TextLabel", {
		Size = UDim2.new(1, -70, 0, system and 25 or 38),
		Position = UDim2.new(0, 62, 0, 30),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = system and GRAY or WHITE,
		TextSize = 13,
		Font = Enum.Font.Gotham,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top
	}, card)

	card.BackgroundTransparency = 1

	tween(card, {
		BackgroundTransparency = 0
	}, 0.2)

	task.defer(function()

		messages.CanvasPosition = Vector2.new(
			0,
			math.max(
				0,
				messages.AbsoluteCanvasSize.Y -
				messages.AbsoluteWindowSize.Y
			)
		)

	end)

end

--========================================================--
-- INITIAL SYSTEM MESSAGE
--========================================================--

addMessage(
	player.DisplayName,
	player.Name,
	"joined Scorpion System",
	true
)

--========================================================--
-- COMPOSER
--========================================================--

local composer = create("Frame", {
	Name = "Composer",
	Size = UDim2.new(1, 0, 0, 50),
	Position = UDim2.new(0, 0, 1, -50),
	BackgroundColor3 = PANEL,
	BorderSizePixel = 0
}, chatPage)

corner(composer, 13)

-- Emoji

local emojiButton = create("TextButton", {
	Size = UDim2.new(0, 38, 0, 38),
	Position = UDim2.new(0, 6, 0, 6),
	BackgroundColor3 = PANEL2,
	Text = "😊",
	TextSize = 18,
	AutoButtonColor = false
}, composer)

corner(emojiButton, 9)

-- Image

local imageButton = create("TextButton", {
	Size = UDim2.new(0, 38, 0, 38),
	Position = UDim2.new(0, 49, 0, 6),
	BackgroundColor3 = PANEL2,
	Text = "🖼",
	TextSize = 17,
	AutoButtonColor = false
}, composer)

corner(imageButton, 9)

-- Input

local input = create("TextBox", {
	Size = UDim2.new(1, -200, 0, 38),
	Position = UDim2.new(0, 92, 0, 6),
	BackgroundColor3 = Color3.fromRGB(34, 32, 40),
	BorderSizePixel = 0,
	Text = "",
	PlaceholderText = "Message Scorpion users...",
	PlaceholderColor3 = MUTED,
	TextColor3 = WHITE,
	TextSize = 13,
	Font = Enum.Font.Gotham,
	ClearTextOnFocus = false,
	TextXAlignment = Enum.TextXAlignment.Left
}, composer)

corner(input, 9)

create("UIPadding", {
	PaddingLeft = UDim.new(0, 12),
	PaddingRight = UDim.new(0, 12)
}, input)

-- Send

local send = create("TextButton", {
	Size = UDim2.new(0, 92, 0, 38),
	Position = UDim2.new(1, -98, 0, 6),
	BackgroundColor3 = PINK,
	Text = "SEND  ➤",
	TextColor3 = WHITE,
	TextSize = 11,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false
}, composer)

corner(send, 9)

--========================================================--
-- EMOJI PANEL
--========================================================--

local emojiPanel = create("Frame", {
	Size = UDim2.new(0, 245, 0, 155),
	Position = UDim2.new(0, 5, 1, -215),
	BackgroundColor3 = PANEL,
	BorderSizePixel = 0,
	Visible = false,
	ZIndex = 50
}, chatPage)

corner(emojiPanel, 12)
stroke(emojiPanel, PINK, 1, 0.3)

local emojis = {
	"😀","😂","😭","🤣","😍",
	"😎","🔥","❤️","💀","😈",
	"🤯","😱","🥶","🤡","👑",
	"🦂","⚡","✨","💯","👍",
	"👏","🙏","😴","🎉","🚀"
}

for i, emoji in ipairs(emojis) do

	local column = (i - 1) % 5
	local row = math.floor((i - 1) / 5)

	local button = create("TextButton", {
		Size = UDim2.new(0, 40, 0, 27),
		Position = UDim2.new(
			0,
			9 + column * 46,
			0,
			9 + row * 29
		),
		BackgroundTransparency = 1,
		Text = emoji,
		TextSize = 18,
		ZIndex = 51
	}, emojiPanel)

	button.MouseButton1Click:Connect(function()

		input.Text = input.Text .. emoji

		input:CaptureFocus()

		emojiPanel.Visible = false

	end)

end

emojiButton.MouseButton1Click:Connect(function()

	emojiPanel.Visible = not emojiPanel.Visible

end)

--========================================================--
-- IMAGE BUTTON
--========================================================--

imageButton.MouseButton1Click:Connect(function()

	input.Text = input.Text .. " [Image: rbxassetid://]"

	input:CaptureFocus()

end)

--========================================================--
-- LOCAL SEND
--========================================================--

local function sendMessage()

	local text = input.Text

	if text == "" then
		return
	end

	-- Local preview.
	-- A server is required for real multiplayer synchronization.

	addMessage(
		player.DisplayName,
		player.Name,
		text,
		false
	)

	input.Text = ""

end

send.MouseButton1Click:Connect(sendMessage)

input.FocusLost:Connect(function(enterPressed)

	if enterPressed then
		sendMessage()
	end

end)

--========================================================--
-- NAVIGATION
--========================================================--

for i, data in ipairs(nav) do

	local button = create("TextButton", {
		Size = UDim2.new(1, -20, 0, 45),
		Position = UDim2.new(
			0,
			10,
			0,
			48 + (i - 1) * 51
		),
		BackgroundColor3 = i == 1 and PINK or SIDEBAR,
		BorderSizePixel = 0,
		Text = data[1] .. "   " .. data[2],
		TextColor3 = WHITE,
		TextSize = 12,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left,
		AutoButtonColor = false
	}, sidebar)

	corner(button, 10)

	create("UIPadding", {
		PaddingLeft = UDim.new(0, 13)
	}, button)

	navButtons[data[2]] = button

	button.MouseEnter:Connect(function()

		if data[2] ~= "Global Chat" then

			tween(button, {
				BackgroundColor3 = Color3.fromRGB(28, 27, 34)
			})

		end

	end)

	button.MouseLeave:Connect(function()

		if data[2] ~= "Global Chat" then

			tween(button, {
				BackgroundColor3 = SIDEBAR
			})

		end

	end)

	button.MouseButton1Click:Connect(function()

		for _, other in pairs(navButtons) do

			tween(other, {
				BackgroundColor3 = SIDEBAR
			})

		end

		tween(button, {
			BackgroundColor3 = PINK
		})

		if data[2] == "Global Chat" then

			chatTitle.Text = "Global Chat"
			chatSub.Text = "Scorpion System users"

		else

			chatTitle.Text = data[2]
			chatSub.Text = "Scorpion System"

		end

	end)

end

--========================================================--
-- DRAGGING
--========================================================--

local dragging = false
local dragStart
local startPosition

top.InputBegan:Connect(function(inputObject)

	if
		inputObject.UserInputType == Enum.UserInputType.MouseButton1
		or inputObject.UserInputType == Enum.UserInputType.Touch
	then

		dragging = true
		dragStart = inputObject.Position
		startPosition = main.Position

	end

end)

top.InputEnded:Connect(function(inputObject)

	if
		inputObject.UserInputType == Enum.UserInputType.MouseButton1
		or inputObject.UserInputType == Enum.UserInputType.Touch
	then

		dragging = false

	end

end)

UserInputService.InputChanged:Connect(function(inputObject)

	if not dragging then
		return
	end

	if
		inputObject.UserInputType == Enum.UserInputType.MouseMovement
		or inputObject.UserInputType == Enum.UserInputType.Touch
	then

		local delta = inputObject.Position - dragStart

		main.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)

	end

end)

--========================================================--
-- MOBILE SIZE
--========================================================--

local function responsive()

	if main.AbsoluteSize.X < 700 then

		main.Size = UDim2.new(
			0.94,
			0,
			0.86,
			0
		)

		main.Position = UDim2.new(
			0.03,
			0,
			0.07,
			0
		)

		sidebar.Size = UDim2.new(
			0,
			130,
			1,
			-70
		)

		content.Position = UDim2.new(
			0,
			130,
			0,
			70
		)

		content.Size = UDim2.new(
			1,
			-130,
			1,
			-70
		)

	end

end

main:GetPropertyChangedSignal("AbsoluteSize"):Connect(responsive)

responsive()

print("🦂 SCORPION SYSTEM LOADED SUCCESSFULLY")
