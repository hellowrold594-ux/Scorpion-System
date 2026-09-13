--========================================================--
--                 🦂 SCORPION SYSTEM V3                 --
--              GLOBAL CHAT UI REDESIGN                  --
--========================================================--
-- Roblox Studio LocalScript
-- Place in:
-- StarterPlayer > StarterPlayerScripts
--
-- Owner:
-- parth251285
--
-- NOTE:
-- Roblox TextChatService filtering remains enabled.
-- Image attachments use Roblox asset IDs.
--========================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local OWNER = "parth251285"

--========================================================--
-- COLORS
--========================================================--

local COLORS = {
	Background = Color3.fromRGB(10, 9, 13),
	Sidebar = Color3.fromRGB(17, 16, 21),
	Panel = Color3.fromRGB(25, 23, 29),
	PanelLight = Color3.fromRGB(31, 29, 36),

	Pink = Color3.fromRGB(245, 35, 125),
	PinkLight = Color3.fromRGB(255, 72, 153),

	Purple = Color3.fromRGB(130, 70, 255),

	Text = Color3.fromRGB(245, 245, 248),
	SubText = Color3.fromRGB(155, 151, 165),
	Muted = Color3.fromRGB(100, 97, 108),

	Online = Color3.fromRGB(74, 235, 132),
	System = Color3.fromRGB(190, 105, 255),

	White = Color3.fromRGB(255, 255, 255)
}

--========================================================--
-- CLEAN OLD VERSION
--========================================================--

local OldGui = PlayerGui:FindFirstChild("ScorpionSystem")

if OldGui then
	OldGui:Destroy()
end

--========================================================--
-- HELPERS
--========================================================--

local function Create(className, properties, parent)

	local object = Instance.new(className)

	for property, value in pairs(properties) do
		object[property] = value
	end

	object.Parent = parent

	return object
end

local function Round(object, radius)

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = object

	return corner
end

local function AddStroke(object, color, thickness, transparency)

	local stroke = Instance.new("UIStroke")

	stroke.Color = color
	stroke.Thickness = thickness or 1
	stroke.Transparency = transparency or 0

	stroke.Parent = object

	return stroke
end

local function Animate(object, properties, time)

	local tween = TweenService:Create(
		object,
		TweenInfo.new(
			time or 0.2,
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.Out
		),
		properties
	)

	tween:Play()

	return tween
end

--========================================================--
-- SCREEN GUI
--========================================================--

local Gui = Create("ScreenGui", {
	Name = "ScorpionSystem",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	DisplayOrder = 999
}, PlayerGui)

--========================================================--
-- MAIN WINDOW
--========================================================--

local Main = Create("Frame", {
	Name = "Main",
	Size = UDim2.new(0.82, 0, 0.82, 0),
	Position = UDim2.new(0.09, 0, 0.09, 0),
	BackgroundColor3 = COLORS.Background,
	BorderSizePixel = 0,
	ClipsDescendants = true
}, Gui)

Round(Main, 18)
AddStroke(Main, Color3.fromRGB(70, 65, 80), 1, 0.3)

--========================================================--
-- TOP BAR
--========================================================--

local TopBar = Create("Frame", {
	Name = "TopBar",
	Size = UDim2.new(1, 0, 0, 70),
	BackgroundColor3 = COLORS.Panel,
	BorderSizePixel = 0
}, Main)

local Logo = Create("TextLabel", {
	Size = UDim2.new(0, 48, 0, 48),
	Position = UDim2.new(0, 15, 0, 11),
	BackgroundColor3 = COLORS.Pink,
	Text = "🦂",
	TextColor3 = COLORS.White,
	TextSize = 25,
	Font = Enum.Font.GothamBold
}, TopBar)

Round(Logo, 14)

local Title = Create("TextLabel", {
	Size = UDim2.new(0, 250, 0, 30),
	Position = UDim2.new(0, 75, 0, 12),
	BackgroundTransparency = 1,
	Text = "SCORPION SYSTEM",
	TextColor3 = COLORS.Text,
	TextSize = 20,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
}, TopBar)

local Subtitle = Create("TextLabel", {
	Size = UDim2.new(0, 300, 0, 20),
	Position = UDim2.new(0, 76, 0, 39),
	BackgroundTransparency = 1,
	Text = "Communication & control panel",
	TextColor3 = COLORS.SubText,
	TextSize = 11,
	Font = Enum.Font.Gotham,
	TextXAlignment = Enum.TextXAlignment.Left
}, TopBar)

-- Online indicator

local OnlineDot = Create("Frame", {
	Size = UDim2.new(0, 9, 0, 9),
	Position = UDim2.new(1, -180, 0, 25),
	BackgroundColor3 = COLORS.Online,
	BorderSizePixel = 0
}, TopBar)

Round(OnlineDot, 20)

local OnlineText = Create("TextLabel", {
	Size = UDim2.new(0, 90, 0, 30),
	Position = UDim2.new(1, -165, 0, 19),
	BackgroundTransparency = 1,
	Text = "ONLINE",
	TextColor3 = COLORS.SubText,
	TextSize = 11,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
}, TopBar)

-- Minimize

local Minimize = Create("TextButton", {
	Size = UDim2.new(0, 40, 0, 40),
	Position = UDim2.new(1, -95, 0, 15),
	BackgroundColor3 = COLORS.PanelLight,
	Text = "—",
	TextColor3 = COLORS.Text,
	TextSize = 20,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false
}, TopBar)

Round(Minimize, 10)

-- Close

local Close = Create("TextButton", {
	Size = UDim2.new(0, 40, 0, 40),
	Position = UDim2.new(1, -48, 0, 15),
	BackgroundColor3 = COLORS.PanelLight,
	Text = "×",
	TextColor3 = COLORS.Text,
	TextSize = 23,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false
}, TopBar)

Round(Close, 10)

Close.MouseEnter:Connect(function()
	Animate(Close, {
		BackgroundColor3 = COLORS.Pink
	})
end)

Close.MouseLeave:Connect(function()
	Animate(Close, {
		BackgroundColor3 = COLORS.PanelLight
	})
end)

Close.MouseButton1Click:Connect(function()
	Gui.Enabled = false
end)

--========================================================--
-- SIDEBAR
--========================================================--

local Sidebar = Create("Frame", {
	Name = "Sidebar",
	Size = UDim2.new(0, 190, 1, -70),
	Position = UDim2.new(0, 0, 0, 70),
	BackgroundColor3 = COLORS.Sidebar,
	BorderSizePixel = 0
}, Main)

local SideTitle = Create("TextLabel", {
	Size = UDim2.new(1, -30, 0, 25),
	Position = UDim2.new(0, 15, 0, 18),
	BackgroundTransparency = 1,
	Text = "NAVIGATION",
	TextColor3 = COLORS.Muted,
	TextSize = 10,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
}, Sidebar)

local Navigation = {
	{"💬", "Global Chat"},
	{"👥", "Players"},
	{"📜", "Scripts"},
	{"🛡", "Clan"},
	{"👑", "Ranks"}
}

local NavButtons = {}
local CurrentPage = "Global Chat"

--========================================================--
-- CONTENT
--========================================================--

local Content = Create("Frame", {
	Name = "Content",
	Size = UDim2.new(1, -190, 1, -70),
	Position = UDim2.new(0, 190, 0, 70),
	BackgroundColor3 = COLORS.Background,
	BorderSizePixel = 0
}, Main)

--========================================================--
-- CHAT PAGE
--========================================================--

local ChatPage = Create("Frame", {
	Name = "GlobalChatPage",
	Size = UDim2.new(1, -30, 1, -30),
	Position = UDim2.new(0, 15, 0, 15),
	BackgroundTransparency = 1
}, Content)

-- Header

local ChatTitle = Create("TextLabel", {
	Size = UDim2.new(1, -100, 0, 30),
	Position = UDim2.new(0, 5, 0, 0),
	BackgroundTransparency = 1,
	Text = "Global Chat",
	TextColor3 = COLORS.Text,
	TextSize = 23,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
}, ChatPage)

local ChatDescription = Create("TextLabel", {
	Size = UDim2.new(1, -100, 0, 20),
	Position = UDim2.new(0, 5, 0, 30),
	BackgroundTransparency = 1,
	Text = "Talk with everyone in the current server.",
	TextColor3 = COLORS.SubText,
	TextSize = 11,
	Font = Enum.Font.Gotham,
	TextXAlignment = Enum.TextXAlignment.Left
}, ChatPage)

-- Unread badge

local Unread = Create("TextLabel", {
	Size = UDim2.new(0, 25, 0, 25),
	Position = UDim2.new(1, -30, 0, 5),
	BackgroundColor3 = COLORS.Pink,
	Text = "0",
	TextColor3 = COLORS.White,
	TextSize = 11,
	Font = Enum.Font.GothamBold,
	Visible = false
}, ChatPage)

Round(Unread, 20)

--========================================================--
-- MESSAGE AREA
--========================================================--

local MessageArea = Create("ScrollingFrame", {
	Name = "MessageArea",
	Size = UDim2.new(1, 0, 1, -125),
	Position = UDim2.new(0, 0, 0, 65),
	BackgroundColor3 = COLORS.Panel,
	BorderSizePixel = 0,
	CanvasSize = UDim2.new(0, 0, 0, 0),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	ScrollBarThickness = 4,
	ScrollBarImageColor3 = COLORS.Pink,
	ScrollingDirection = Enum.ScrollingDirection.Y
}, ChatPage)

Round(MessageArea, 14)

Create("UIPadding", {
	PaddingTop = UDim.new(0, 14),
	PaddingBottom = UDim.new(0, 14),
	PaddingLeft = UDim.new(0, 14),
	PaddingRight = UDim.new(0, 14)
}, MessageArea)

local MessageList = Create("UIListLayout", {
	Padding = UDim.new(0, 9),
	SortOrder = Enum.SortOrder.LayoutOrder
}, MessageArea)

--========================================================--
-- ADD MESSAGE
--========================================================--

local function AddMessage(displayName, username, text, isSystem)

	local Card = Create("Frame", {
		Size = UDim2.new(1, 0, 0, 58),
		BackgroundColor3 = isSystem
			and Color3.fromRGB(38, 27, 45)
			or COLORS.PanelLight,
		BorderSizePixel = 0
	}, MessageArea)

	Round(Card, 12)

	AddStroke(
		Card,
		isSystem and COLORS.System or Color3.fromRGB(55, 52, 62),
		1,
		0.5
	)

	local Avatar = Create("ImageLabel", {
		Size = UDim2.new(0, 38, 0, 38),
		Position = UDim2.new(0, 10, 0, 10),
		BackgroundColor3 = COLORS.Sidebar,
		BorderSizePixel = 0,
		Image = ""
	}, Card)

	Round(Avatar, 19)

	if not isSystem then

		task.spawn(function()

			local success, image = pcall(function()
				return Players:GetUserThumbnailAsync(
					Players:GetUserIdFromNameAsync(username),
					Enum.ThumbnailType.HeadShot,
					Enum.ThumbnailSize.Size100x100
				)
			end)

			if success then
				Avatar.Image = image
			end

		end)

	else
		Avatar.Image = ""
		Avatar.BackgroundColor3 = COLORS.System

		local Icon = Create("TextLabel", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = "🦂",
			TextSize = 17,
			Font = Enum.Font.GothamBold
		}, Avatar)
	end

	local Name = Create("TextLabel", {
		Size = UDim2.new(1, -70, 0, 20),
		Position = UDim2.new(0, 60, 0, 8),
		BackgroundTransparency = 1,
		Text = isSystem
			and "[SYSTEM] " .. displayName
			or displayName,
		TextColor3 = isSystem and COLORS.System or COLORS.PinkLight,
		TextSize = 12,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left
	}, Card)

	local Message = Create("TextLabel", {
		Size = UDim2.new(1, -70, 0, 25),
		Position = UDim2.new(0, 60, 0, 27),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = isSystem and COLORS.SubText or COLORS.Text,
		TextSize = 13,
		Font = Enum.Font.Gotham,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left
	}, Card)

	-- animation

	Card.BackgroundTransparency = 1

	Animate(Card, {
		BackgroundTransparency = 0
	}, 0.25)

	task.defer(function()
		MessageArea.CanvasPosition = Vector2.new(
			0,
			math.max(
				0,
				MessageArea.AbsoluteCanvasSize.Y -
				MessageArea.AbsoluteWindowSize.Y
			)
		)
	end)
end

--========================================================--
-- WELCOME SYSTEM MESSAGE
--========================================================--

task.delay(0.5, function()

	AddMessage(
		LocalPlayer.DisplayName,
		LocalPlayer.Name,
		"joined Scorpion System",
		true
	)

end)

--========================================================--
-- COMPOSER
--========================================================--

local Composer = Create("Frame", {
	Name = "Composer",
	Size = UDim2.new(1, 0, 0, 52),
	Position = UDim2.new(0, 0, 1, -52),
	BackgroundColor3 = COLORS.Panel,
	BorderSizePixel = 0
}, ChatPage)

Round(Composer, 13)

-- Emoji

local EmojiButton = Create("TextButton", {
	Size = UDim2.new(0, 40, 0, 40),
	Position = UDim2.new(0, 6, 0, 6),
	BackgroundColor3 = COLORS.PanelLight,
	Text = "😊",
	TextSize = 18,
	Font = Enum.Font.Gotham,
	AutoButtonColor = false
}, Composer)

Round(EmojiButton, 10)

-- Image

local ImageButton = Create("TextButton", {
	Size = UDim2.new(0, 40, 0, 40),
	Position = UDim2.new(0, 51, 0, 6),
	BackgroundColor3 = COLORS.PanelLight,
	Text = "🖼",
	TextSize = 17,
	Font = Enum.Font.Gotham,
	AutoButtonColor = false
}, Composer)

Round(ImageButton, 10)

-- Input

local Input = Create("TextBox", {
	Size = UDim2.new(1, -205, 0, 40),
	Position = UDim2.new(0, 96, 0, 6),
	BackgroundColor3 = Color3.fromRGB(34, 32, 39),
	BorderSizePixel = 0,
	Text = "",
	PlaceholderText = "Type a message...",
	PlaceholderColor3 = COLORS.Muted,
	TextColor3 = COLORS.Text,
	TextSize = 13,
	Font = Enum.Font.Gotham,
	ClearTextOnFocus = false,
	TextXAlignment = Enum.TextXAlignment.Left
}, Composer)

Round(Input, 10)

Create("UIPadding", {
	PaddingLeft = UDim.new(0, 12),
	PaddingRight = UDim.new(0, 12)
}, Input)

-- Send

local SendButton = Create("TextButton", {
	Size = UDim2.new(0, 95, 0, 40),
	Position = UDim2.new(1, -101, 0, 6),
	BackgroundColor3 = COLORS.Pink,
	BorderSizePixel = 0,
	Text = "SEND  ➤",
	TextColor3 = COLORS.White,
	TextSize = 12,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false
}, Composer)

Round(SendButton, 10)

SendButton.MouseEnter:Connect(function()
	Animate(SendButton, {
		BackgroundColor3 = COLORS.PinkLight
	})
end)

SendButton.MouseLeave:Connect(function()
	Animate(SendButton, {
		BackgroundColor3 = COLORS.Pink
	})
end)

--========================================================--
-- EMOJI POPUP
--========================================================--

local EmojiPopup = Create("Frame", {
	Name = "EmojiPopup",
	Size = UDim2.new(0, 245, 0, 155),
	Position = UDim2.new(0, 5, 1, -215),
	BackgroundColor3 = COLORS.Panel,
	BorderSizePixel = 0,
	Visible = false,
	ZIndex = 50
}, ChatPage)

Round(EmojiPopup, 12)
AddStroke(EmojiPopup, COLORS.Pink, 1, 0.35)

local EmojiList = {
	"😀","😂","😭","🤣","😍",
	"😎","🔥","❤️","💀","😈",
	"🤯","😱","🥶","🤡","👑",
	"🦂","⚡","✨","💯","👍",
	"👏","🙏","😴","🎉","🚀"
}

for i, emoji in ipairs(EmojiList) do

	local column = (i - 1) % 5
	local row = math.floor((i - 1) / 5)

	local Button = Create("TextButton", {
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
		Font = Enum.Font.Gotham,
		ZIndex = 51
	}, EmojiPopup)

	Button.MouseButton1Click:Connect(function()

		Input.Text = Input.Text .. emoji
		Input:CaptureFocus()

		EmojiPopup.Visible = false

	end)
end

EmojiButton.MouseButton1Click:Connect(function()

	EmojiPopup.Visible = not EmojiPopup.Visible

end)

--========================================================--
-- IMAGE ASSET UI
--========================================================--

ImageButton.MouseButton1Click:Connect(function()

	local existing = ChatPage:FindFirstChild("ImagePrompt")

	if existing then
		existing:Destroy()
	end

	local Prompt = Create("Frame", {
		Name = "ImagePrompt",
		Size = UDim2.new(0, 320, 0, 125),
		Position = UDim2.new(0.5, -160, 0.5, -62),
		BackgroundColor3 = COLORS.Panel,
		BorderSizePixel = 0,
		ZIndex = 100
	}, ChatPage)

	Round(Prompt, 14)
	AddStroke(Prompt, COLORS.Pink, 1, 0.25)

	local PromptTitle = Create("TextLabel", {
		Size = UDim2.new(1, -20, 0, 25),
		Position = UDim2.new(0, 10, 0, 10),
		BackgroundTransparency = 1,
		Text = "🖼  Add Roblox Image",
		TextColor3 = COLORS.Text,
		TextSize = 14,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 101
	}, Prompt)

	local AssetInput = Create("TextBox", {
		Size = UDim2.new(1, -105, 0, 36),
		Position = UDim2.new(0, 10, 0, 48),
		BackgroundColor3 = COLORS.PanelLight,
		Text = "",
		PlaceholderText = "Asset ID...",
		PlaceholderColor3 = COLORS.Muted,
		TextColor3 = COLORS.Text,
		TextSize = 12,
		Font = Enum.Font.Gotham,
		ZIndex = 101
	}, Prompt)

	Round(AssetInput, 8)

	local Insert = Create("TextButton", {
		Size = UDim2.new(0, 80, 0, 36),
		Position = UDim2.new(1, -90, 0, 48),
		BackgroundColor3 = COLORS.Pink,
		Text = "INSERT",
		TextColor3 = COLORS.White,
		TextSize = 10,
		Font = Enum.Font.GothamBold,
		ZIndex = 101,
		AutoButtonColor = false
	}, Prompt)

	Round(Insert, 8)

	Insert.MouseButton1Click:Connect(function()

		local id = AssetInput.Text:gsub("%D", "")

		if id ~= "" then

			Input.Text =
				Input.Text ..
				" [Image: rbxassetid://" ..
				id ..
				"]"

		end

		Prompt:Destroy()
		Input:CaptureFocus()

	end)

end)

--========================================================--
-- TEXT CHAT SERVICE
--========================================================--

local GeneralChannel

task.spawn(function()

	local Channels = TextChatService:WaitForChild(
		"TextChannels",
		10
	)

	if not Channels then
		return
	end

	GeneralChannel = Channels:FindFirstChild("RBXGeneral")

	if not GeneralChannel then
		return
	end

	GeneralChannel.MessageReceived:Connect(function(message)

		local source = message.TextSource

		if not source then
			return
		end

		local speaker = Players:GetPlayerByUserId(
			source.UserId
		)

		if speaker then

			AddMessage(
				speaker.DisplayName,
				speaker.Name,
				message.Text,
				false
			)

		end

	end)

end)

--========================================================--
-- SEND MESSAGE
--========================================================--

local function SendMessage()

	local Text = Input.Text

	if Text == "" then
		return
	end

	if not GeneralChannel then

		AddMessage(
			"SYSTEM",
			"",
			"Chat channel is still connecting...",
			true
		)

		return
	end

	local success, errorMessage = pcall(function()

		GeneralChannel:SendAsync(Text)

	end)

	if success then

		Input.Text = ""

	else

		warn(
			"Scorpion System chat error:",
			errorMessage
		)

	end
end

SendButton.MouseButton1Click:Connect(SendMessage)

Input.FocusLost:Connect(function(enterPressed)

	if enterPressed then
		SendMessage()
	end

end)

--========================================================--
-- NAVIGATION BUTTONS
--========================================================--

local function CreateNavigationButton(icon, name, index)

	local Button = Create("TextButton", {
		Name = name:gsub("%s", ""),
		Size = UDim2.new(1, -20, 0, 45),
		Position = UDim2.new(
			0,
			10,
			0,
			55 + (index - 1) * 52
		),
		BackgroundColor3 =
			name == "Global Chat"
			and COLORS.Pink
			or COLORS.Sidebar,
		BorderSizePixel = 0,
		Text = icon .. "    " .. name,
		TextColor3 = COLORS.Text,
		TextSize = 12,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left,
		AutoButtonColor = false
	}, Sidebar)

	Round(Button, 10)

	Create("UIPadding", {
		PaddingLeft = UDim.new(0, 13)
	}, Button)

	NavButtons[name] = Button

	Button.MouseEnter:Connect(function()

		if CurrentPage ~= name then

			Animate(Button, {
				BackgroundColor3 = Color3.fromRGB(28, 27, 34)
			})

		end

	end)

	Button.MouseLeave:Connect(function()

		if CurrentPage ~= name then

			Animate(Button, {
				BackgroundColor3 = COLORS.Sidebar
			})

		end

	end)

	Button.MouseButton1Click:Connect(function()

		CurrentPage = name

		for pageName, navButton in pairs(NavButtons) do

			Animate(navButton, {
				BackgroundColor3 =
					pageName == name
					and COLORS.Pink
					or COLORS.Sidebar
			})

		end

		if name == "Global Chat" then

			ChatTitle.Text = "Global Chat"
			ChatDescription.Text =
				"Talk with everyone in the current server."

		elseif name == "Players" then

			ChatTitle.Text = "Players"
			ChatDescription.Text =
				"View players currently in your server."

		elseif name == "Scripts" then

			ChatTitle.Text = "Scripts"
			ChatDescription.Text =
				"Scorpion System utilities."

		elseif name == "Clan" then

			ChatTitle.Text = "Clan"
			ChatDescription.Text =
				"Manage your Scorpion clan."

		elseif name == "Ranks" then

			ChatTitle.Text = "Ranks"
			ChatDescription.Text =
				"View Scorpion System ranks."

		end

	end)

end

for index, data in ipairs(Navigation) do

	CreateNavigationButton(
		data[1],
		data[2],
		index
	)

end

--========================================================--
-- MINIMIZE
--========================================================--

local minimized = false

Minimize.MouseButton1Click:Connect(function()

	minimized = not minimized

	if minimized then

		Main.Size = UDim2.new(
			0,
			390,
			0,
			70
		)

		Sidebar.Visible = false
		Content.Visible = false

	else

		Main.Size = UDim2.new(
			0.82,
			0,
			0.82,
			0
		)

		Sidebar.Visible = true
		Content.Visible = true

	end

end)

--========================================================--
-- DRAGGING
--========================================================--

local Dragging = false
local DragStart
local StartPosition

TopBar.InputBegan:Connect(function(input)

	if
		input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch
	then

		Dragging = true
		DragStart = input.Position
		StartPosition = Main.Position

		input.Changed:Connect(function()

			if input.UserInputState ==
				Enum.UserInputState.End
			then

				Dragging = false

			end

		end)

	end

end)

UserInputService.InputChanged:Connect(function(input)

	if not Dragging then
		return
	end

	if
		input.UserInputType ==
			Enum.UserInputType.MouseMovement
		or input.UserInputType ==
			Enum.UserInputType.Touch
	then

		local Delta =
			input.Position - DragStart

		Main.Position = UDim2.new(
			StartPosition.X.Scale,
			StartPosition.X.Offset + Delta.X,
			StartPosition.Y.Scale,
			StartPosition.Y.Offset + Delta.Y
		)

	end

end)

--========================================================--
-- MOBILE RESPONSIVE
--========================================================--

local function UpdateResponsive()

	if Main.AbsoluteSize.X < 700 then

		Main.Size = UDim2.new(
			0.94,
			0,
			0.86,
			0
		)

		Main.Position = UDim2.new(
			0.03,
			0,
			0.07,
			0
		)

		Sidebar.Size = UDim2.new(
			0,
			135,
			1,
			-70
		)

		Content.Position = UDim2.new(
			0,
			135,
			0,
			70
		)

		Content.Size = UDim2.new(
			1,
			-135,
			1,
			-70
		)

	end

end

Main:GetPropertyChangedSignal(
	"AbsoluteSize"
):Connect(UpdateResponsive)

UpdateResponsive()

--========================================================--
-- FINAL
--========================================================--

print("🦂 SCORPION SYSTEM V3 LOADED")
print("Global Chat UI ready.")
