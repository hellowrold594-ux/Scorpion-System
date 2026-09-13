--========================================================--
--              🦂 SCORPION SYSTEM V4                   --
--                 CUSTOM GLOBAL CHAT                   --
--========================================================--
-- LocalScript
-- StarterPlayer > StarterPlayerScripts
--========================================================--

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Remote = ReplicatedStorage:WaitForChild("ScorpionChatRemote")

--========================================================--
-- COLORS
--========================================================--

local C = {
	BG = Color3.fromRGB(9, 8, 12),
	Sidebar = Color3.fromRGB(15, 14, 19),
	Panel = Color3.fromRGB(21, 20, 27),
	Panel2 = Color3.fromRGB(28, 26, 34),

	Pink = Color3.fromRGB(245, 35, 125),
	Pink2 = Color3.fromRGB(255, 75, 155),

	Purple = Color3.fromRGB(170, 80, 255),

	White = Color3.fromRGB(245, 245, 248),
	Gray = Color3.fromRGB(155, 151, 165),
	DarkGray = Color3.fromRGB(90, 87, 98),

	Online = Color3.fromRGB(70, 235, 130)
}

--========================================================--
-- CLEAN OLD GUI
--========================================================--

local Old = PlayerGui:FindFirstChild("ScorpionSystem")

if Old then
	Old:Destroy()
end

--========================================================--
-- HELPERS
--========================================================--

local function New(class, properties, parent)

	local obj = Instance.new(class)

	for property, value in pairs(properties) do
		obj[property] = value
	end

	obj.Parent = parent

	return obj
end

local function Corner(obj, radius)

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius)
	c.Parent = obj

end

local function Stroke(obj, color, thickness, transparency)

	local s = Instance.new("UIStroke")

	s.Color = color
	s.Thickness = thickness or 1
	s.Transparency = transparency or 0

	s.Parent = obj

end

local function Tween(obj, props, duration)

	TweenService:Create(
		obj,
		TweenInfo.new(
			duration or .2,
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.Out
		),
		props
	):Play()

end

--========================================================--
-- SCREEN GUI
--========================================================--

local Gui = New("ScreenGui", {
	Name = "ScorpionSystem",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	DisplayOrder = 999
}, PlayerGui)

--========================================================--
-- MAIN
--========================================================--

local Main = New("Frame", {
	Name = "Main",
	Size = UDim2.new(.84,0,.82,0),
	Position = UDim2.new(.08,0,.09,0),
	BackgroundColor3 = C.BG,
	BorderSizePixel = 0,
	ClipsDescendants = true
}, Gui)

Corner(Main,18)
Stroke(Main,Color3.fromRGB(70,65,80),1,.25)

--========================================================--
-- TOP
--========================================================--

local Top = New("Frame", {
	Size = UDim2.new(1,0,0,70),
	BackgroundColor3 = C.Panel,
	BorderSizePixel = 0
},Main)

local Logo = New("TextLabel", {
	Size = UDim2.new(0,48,0,48),
	Position = UDim2.new(0,14,0,11),
	BackgroundColor3 = C.Pink,
	Text = "🦂",
	TextSize = 25,
	Font = Enum.Font.GothamBold
},Top)

Corner(Logo,14)

local Title = New("TextLabel", {
	Size = UDim2.new(0,260,0,28),
	Position = UDim2.new(0,74,0,10),
	BackgroundTransparency = 1,
	Text = "SCORPION SYSTEM",
	TextColor3 = C.White,
	TextSize = 20,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
},Top)

local Subtitle = New("TextLabel", {
	Size = UDim2.new(0,300,0,20),
	Position = UDim2.new(0,75,0,37),
	BackgroundTransparency = 1,
	Text = "Private communication network",
	TextColor3 = C.Gray,
	TextSize = 11,
	Font = Enum.Font.Gotham,
	TextXAlignment = Enum.TextXAlignment.Left
},Top)

local OnlineDot = New("Frame", {
	Size = UDim2.new(0,8,0,8),
	Position = UDim2.new(1,-155,0,26),
	BackgroundColor3 = C.Online,
	BorderSizePixel = 0
},Top)

Corner(OnlineDot,20)

local Online = New("TextLabel", {
	Size = UDim2.new(0,90,0,25),
	Position = UDim2.new(1,-142,0,18),
	BackgroundTransparency = 1,
	Text = "ONLINE",
	TextColor3 = C.Gray,
	TextSize = 10,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
},Top)

local Close = New("TextButton", {
	Size = UDim2.new(0,40,0,40),
	Position = UDim2.new(1,-50,0,15),
	BackgroundColor3 = C.Panel2,
	Text = "×",
	TextColor3 = C.White,
	TextSize = 23,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false
},Top)

Corner(Close,10)

Close.MouseButton1Click:Connect(function()
	Gui.Enabled = false
end)

--========================================================--
-- SIDEBAR
--========================================================--

local Sidebar = New("Frame", {
	Size = UDim2.new(0,185,1,-70),
	Position = UDim2.new(0,0,0,70),
	BackgroundColor3 = C.Sidebar,
	BorderSizePixel = 0
},Main)

local NavTitle = New("TextLabel", {
	Size = UDim2.new(1,-25,0,20),
	Position = UDim2.new(0,15,0,17),
	BackgroundTransparency = 1,
	Text = "SCORPION",
	TextColor3 = C.DarkGray,
	TextSize = 10,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
},Sidebar)

local Navigation = {
	{"💬","Global Chat"},
	{"👥","Players"},
	{"📜","Scripts"},
	{"🛡","Clan"},
	{"👑","Ranks"}
}

local NavButtons = {}

for i,data in ipairs(Navigation) do

	local Button = New("TextButton", {
		Size = UDim2.new(1,-20,0,45),
		Position = UDim2.new(0,10,0,48+(i-1)*51),
		BackgroundColor3 = i == 1 and C.Pink or C.Sidebar,
		Text = data[1].."   "..data[2],
		TextColor3 = C.White,
		TextSize = 12,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left,
		AutoButtonColor = false
	},Sidebar)

	Corner(Button,10)

	New("UIPadding",{
		PaddingLeft = UDim.new(0,13)
	},Button)

	NavButtons[data[2]] = Button

	Button.MouseButton1Click:Connect(function()

		for _,other in pairs(NavButtons) do
			Tween(other,{
				BackgroundColor3 = C.Sidebar
			})
		end

		Tween(Button,{
			BackgroundColor3 = C.Pink
		})

	end)
end

--========================================================--
-- CONTENT
--========================================================--

local Content = New("Frame", {
	Size = UDim2.new(1,-185,1,-70),
	Position = UDim2.new(0,185,0,70),
	BackgroundColor3 = C.BG,
	BorderSizePixel = 0
},Main)

--========================================================--
-- CHAT PAGE
--========================================================--

local Chat = New("Frame", {
	Size = UDim2.new(1,-30,1,-30),
	Position = UDim2.new(0,15,0,15),
	BackgroundTransparency = 1
},Content)

local ChatTitle = New("TextLabel", {
	Size = UDim2.new(1,0,0,30),
	BackgroundTransparency = 1,
	Text = "Global Chat",
	TextColor3 = C.White,
	TextSize = 23,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
},Chat)

local ChatSub = New("TextLabel", {
	Size = UDim2.new(1,0,0,20),
	Position = UDim2.new(0,0,0,30),
	BackgroundTransparency = 1,
	Text = "Scorpion users only",
	TextColor3 = C.Gray,
	TextSize = 11,
	Font = Enum.Font.Gotham,
	TextXAlignment = Enum.TextXAlignment.Left
},Chat)

--========================================================--
-- MESSAGE SCROLLER
--========================================================--

local Messages = New("ScrollingFrame", {
	Size = UDim2.new(1,0,1,-120),
	Position = UDim2.new(0,0,0,65),
	BackgroundColor3 = C.Panel,
	BorderSizePixel = 0,
	ScrollBarThickness = 4,
	ScrollBarImageColor3 = C.Pink,
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	CanvasSize = UDim2.new()
},Chat)

Corner(Messages,14)

New("UIPadding",{
	PaddingTop = UDim.new(0,12),
	PaddingBottom = UDim.new(0,12),
	PaddingLeft = UDim.new(0,12),
	PaddingRight = UDim.new(0,12)
},Messages)

local Layout = New("UIListLayout",{
	Padding = UDim.new(0,8),
	SortOrder = Enum.SortOrder.LayoutOrder
},Messages)

--========================================================--
-- MESSAGE CREATOR
--========================================================--

local function AddMessage(displayName, username, message, system)

	local Height = system and 52 or 64

	local Card = New("Frame", {
		Size = UDim2.new(1,0,0,Height),
		BackgroundColor3 = system
			and Color3.fromRGB(40,27,47)
			or C.Panel2,
		BorderSizePixel = 0
	},Messages)

	Corner(Card,12)

	Stroke(
		Card,
		system and C.Purple or Color3.fromRGB(55,52,62),
		1,
		.55
	)

	-- Avatar

	local Avatar = New("ImageLabel", {
		Size = UDim2.new(0,40,0,40),
		Position = UDim2.new(0,10,0,10),
		BackgroundColor3 = C.Sidebar,
		BorderSizePixel = 0,
		Image = ""
	},Card)

	Corner(Avatar,20)

	if system then

		Avatar.BackgroundColor3 = C.Purple

		local Icon = New("TextLabel",{
			Size = UDim2.new(1,0,1,0),
			BackgroundTransparency = 1,
			Text = "🦂",
			TextSize = 17
		},Avatar)

	else

		task.spawn(function()

			local ok,image = pcall(function()

				return Players:GetUserThumbnailAsync(
					Players:GetUserIdFromNameAsync(username),
					Enum.ThumbnailType.HeadShot,
					Enum.ThumbnailSize.Size100x100
				)

			end)

			if ok then
				Avatar.Image = image
			end

		end)

	end

	-- Name

	local Name = New("TextLabel", {
		Size = UDim2.new(1,-65,0,20),
		Position = UDim2.new(0,60,0,8),
		BackgroundTransparency = 1,
		Text = system
			and "[SYSTEM] "..displayName
			or displayName,
		TextColor3 = system and C.Purple or C.Pink2,
		TextSize = 12,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left
	},Card)

	-- Message

	local Body = New("TextLabel", {
		Size = UDim2.new(1,-65,0,30),
		Position = UDim2.new(0,60,0,29),
		BackgroundTransparency = 1,
		Text = message,
		TextColor3 = system and C.Gray or C.White,
		TextSize = 13,
		Font = Enum.Font.Gotham,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top
	},Card)

	Card.BackgroundTransparency = 1

	Tween(Card,{
		BackgroundTransparency = 0
	},.2)

	task.defer(function()

		Messages.CanvasPosition = Vector2.new(
			0,
			math.max(
				0,
				Messages.AbsoluteCanvasSize.Y -
				Messages.AbsoluteWindowSize.Y
			)
		)

	end)
end

--========================================================--
-- COMPOSER
--========================================================--

local Composer = New("Frame", {
	Size = UDim2.new(1,0,0,50),
	Position = UDim2.new(0,0,1,-50),
	BackgroundColor3 = C.Panel,
	BorderSizePixel = 0
},Chat)

Corner(Composer,13)

-- Emoji

local EmojiButton = New("TextButton", {
	Size = UDim2.new(0,38,0,38),
	Position = UDim2.new(0,6,0,6),
	BackgroundColor3 = C.Panel2,
	Text = "😊",
	TextSize = 18,
	AutoButtonColor = false
},Composer)

Corner(EmojiButton,9)

-- Image

local ImageButton = New("TextButton", {
	Size = UDim2.new(0,38,0,38),
	Position = UDim2.new(0,49,0,6),
	BackgroundColor3 = C.Panel2,
	Text = "🖼",
	TextSize = 17,
	AutoButtonColor = false
},Composer)

Corner(ImageButton,9)

-- Input

local Input = New("TextBox", {
	Size = UDim2.new(1,-200,0,38),
	Position = UDim2.new(0,92,0,6),
	BackgroundColor3 = Color3.fromRGB(34,32,40),
	BorderSizePixel = 0,
	Text = "",
	PlaceholderText = "Message Scorpion users...",
	PlaceholderColor3 = C.DarkGray,
	TextColor3 = C.White,
	TextSize = 13,
	Font = Enum.Font.Gotham,
	ClearTextOnFocus = false,
	TextXAlignment = Enum.TextXAlignment.Left
},Composer)

Corner(Input,9)

New("UIPadding",{
	PaddingLeft = UDim.new(0,12),
	PaddingRight = UDim.new(0,12)
},Input)

-- Send

local Send = New("TextButton", {
	Size = UDim2.new(0,92,0,38),
	Position = UDim2.new(1,-98,0,6),
	BackgroundColor3 = C.Pink,
	Text = "SEND  ➤",
	TextColor3 = C.White,
	TextSize = 11,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false
},Composer)

Corner(Send,9)

--========================================================--
-- EMOJIS
--========================================================--

local EmojiPopup = New("Frame", {
	Size = UDim2.new(0,245,0,155),
	Position = UDim2.new(0,5,1,-215),
	BackgroundColor3 = C.Panel,
	BorderSizePixel = 0,
	Visible = false,
	ZIndex = 100
},Chat)

Corner(EmojiPopup,12)
Stroke(EmojiPopup,C.Pink,1,.3)

local Emojis = {
	"😀","😂","😭","🤣","😍",
	"😎","🔥","❤️","💀","😈",
	"🤯","😱","🥶","🤡","👑",
	"🦂","⚡","✨","💯","👍",
	"👏","🙏","😴","🎉","🚀"
}

for i,emoji in ipairs(Emojis) do

	local x = (i-1)%5
	local y = math.floor((i-1)/5)

	local B = New("TextButton", {
		Size = UDim2.new(0,40,0,27),
		Position = UDim2.new(0,9+x*46,0,9+y*29),
		BackgroundTransparency = 1,
		Text = emoji,
		TextSize = 18,
		ZIndex = 101
	},EmojiPopup)

	B.MouseButton1Click:Connect(function()

		Input.Text = Input.Text..emoji
		Input:CaptureFocus()
		EmojiPopup.Visible = false

	end)

end

EmojiButton.MouseButton1Click:Connect(function()

	EmojiPopup.Visible = not EmojiPopup.Visible

end)

--========================================================--
-- IMAGE ATTACHMENT
--========================================================--

ImageButton.MouseButton1Click:Connect(function()

	Input.Text =
		Input.Text ..
		" [Image: rbxassetid://]"

	Input:CaptureFocus()

end)

--========================================================--
-- SEND
--========================================================--

local function SendMessage()

	local text = Input.Text

	if text == "" then
		return
	end

	Remote:FireServer(
		"Message",
		text
	)

	Input.Text = ""

end

Send.MouseButton1Click:Connect(SendMessage)

Input.FocusLost:Connect(function(enter)

	if enter then
		SendMessage()
	end

end)

--========================================================--
-- RECEIVE
--========================================================--

Remote.OnClientEvent:Connect(function(
	messageType,
	displayName,
	username,
	message
)

	if messageType == "Message" then

		AddMessage(
			displayName,
			username,
			message,
			false
		)

	elseif messageType == "System" then

		AddMessage(
			displayName,
			"",
			message,
			true
		)

	end

end)

--========================================================--
-- REGISTER
--========================================================--

Remote:FireServer("Register")

--========================================================--
-- DRAG WINDOW
--========================================================--

local Dragging = false
local DragStart
local StartPosition

Top.InputBegan:Connect(function(input)

	if
		input.UserInputType ==
			Enum.UserInputType.MouseButton1
		or
		input.UserInputType ==
			Enum.UserInputType.Touch
	then

		Dragging = true
		DragStart = input.Position
		StartPosition = Main.Position

	end

end)

Top.InputEnded:Connect(function(input)

	if
		input.UserInputType ==
			Enum.UserInputType.MouseButton1
		or
		input.UserInputType ==
			Enum.UserInputType.Touch
	then

		Dragging = false

	end

end)

UserInputService.InputChanged:Connect(function(input)

	if not Dragging then
		return
	end

	if
		input.UserInputType ==
			Enum.UserInputType.MouseMovement
		or
		input.UserInputType ==
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

print("🦂 SCORPION SYSTEM V4 READY")
