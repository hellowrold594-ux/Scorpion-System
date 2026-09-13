--// SCORPION SYSTEM
--// Original Roblox Studio LocalScript
--// Owner: parth251285

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local OWNER = "parth251285"
local IsOwner = Player.Name:lower() == OWNER:lower()

--==================================================
-- CLEAN OLD GUI
--==================================================

local old = PlayerGui:FindFirstChild("ScorpionSystem")

if old then
	old:Destroy()
end

--==================================================
-- COLORS
--==================================================

local PINK = Color3.fromRGB(225, 45, 115)
local PINK2 = Color3.fromRGB(245, 75, 140)
local BG = Color3.fromRGB(20, 20, 24)
local PANEL = Color3.fromRGB(30, 30, 35)
local PANEL2 = Color3.fromRGB(42, 42, 48)
local TEXT = Color3.fromRGB(245, 245, 245)
local MUTED = Color3.fromRGB(160, 160, 170)

--==================================================
-- HELPERS
--==================================================

local function create(class, properties, parent)
	local object = Instance.new(class)

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

local function stroke(object, color)
	local s = Instance.new("UIStroke")
	s.Color = color
	s.Thickness = 1
	s.Transparency = .35
	s.Parent = object
end

--==================================================
-- SCREEN GUI
--==================================================

local Gui = create("ScreenGui", {
	Name = "ScorpionSystem",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

--==================================================
-- OPEN BUTTON
--==================================================

local Open = create("TextButton", {
	Name = "Open",
	Size = UDim2.fromOffset(55,55),
	Position = UDim2.new(0,20,.5,-25),
	BackgroundColor3 = PINK,
	Text = "🦂",
	TextSize = 25,
	TextColor3 = Color3.new(1,1,1),
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false
}, Gui)

corner(Open,16)
stroke(Open,PINK2)

--==================================================
-- MAIN
--==================================================

local Main = create("Frame", {
	Name = "Main",
	Size = UDim2.fromOffset(760,500),
	Position = UDim2.new(.5,-380,.5,-250),
	BackgroundColor3 = BG
}, Gui)

corner(Main,18)
stroke(Main,PINK)

--==================================================
-- HEADER
--==================================================

local Header = create("Frame", {
	Size = UDim2.new(1,0,0,65),
	BackgroundColor3 = PANEL
}, Main)

corner(Header,18)

create("TextLabel", {
	Size = UDim2.new(1,-120,0,32),
	Position = UDim2.fromOffset(20,6),
	BackgroundTransparency = 1,
	Text = "●  SCORPION SYSTEM",
	TextColor3 = TEXT,
	TextSize = 20,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left
}, Header)

create("TextLabel", {
	Size = UDim2.new(1,-120,0,20),
	Position = UDim2.fromOffset(21,38),
	BackgroundTransparency = 1,
	Text = IsOwner and "OWNER • "..OWNER or "PLAYER",
	TextColor3 = IsOwner and PINK2 or MUTED,
	TextSize = 11,
	Font = Enum.Font.GothamSemibold,
	TextXAlignment = Enum.TextXAlignment.Left
}, Header)

local Minimize = create("TextButton", {
	Size = UDim2.fromOffset(38,38),
	Position = UDim2.new(1,-95,0,13),
	BackgroundColor3 = PANEL2,
	Text = "—",
	TextColor3 = TEXT,
	TextSize = 18,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false
}, Header)

corner(Minimize,10)

local Close = create("TextButton", {
	Size = UDim2.fromOffset(38,38),
	Position = UDim2.new(1,-48,0,13),
	BackgroundColor3 = PANEL2,
	Text = "×",
	TextColor3 = TEXT,
	TextSize = 22,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false
}, Header)

corner(Close,10)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = create("Frame", {
	Size = UDim2.new(0,165,1,-80),
	Position = UDim2.fromOffset(12,70),
	BackgroundColor3 = PANEL
}, Main)

corner(Sidebar,14)

create("UIPadding", {
	PaddingTop = UDim.new(0,10),
	PaddingLeft = UDim.new(0,8),
	PaddingRight = UDim.new(0,8)
}, Sidebar)

create("UIListLayout", {
	Padding = UDim.new(0,7)
}, Sidebar)

--==================================================
-- CONTENT
--==================================================

local Content = create("Frame", {
	Size = UDim2.new(1,-190,1,-80),
	Position = UDim2.fromOffset(178,70),
	BackgroundTransparency = 1
}, Main)

local Pages = {}

local function makePage(name)

	local page = create("ScrollingFrame", {
		Name = name,
		Size = UDim2.fromScale(1,1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = false,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = PINK,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new()
	}, Content)

	create("UIListLayout", {
		Padding = UDim.new(0,9)
	}, page)

	create("UIPadding", {
		PaddingTop = UDim.new(0,5),
		PaddingLeft = UDim.new(0,5),
		PaddingRight = UDim.new(0,10),
		PaddingBottom = UDim.new(0,15)
	}, page)

	Pages[name] = page

	return page
end

local Chat = makePage("Chat")
local PlayersPage = makePage("Players")
local Scripts = makePage("Scripts")
local Clan = makePage("Clan")
local Ranks = makePage("Ranks")

--==================================================
-- PAGE HEADER
--==================================================

local function pageHeader(page,title,description)

	local holder = create("Frame", {
		Size = UDim2.new(1,0,0,65),
		BackgroundTransparency = 1
	}, page)

	create("TextLabel", {
		Size = UDim2.new(1,0,0,32),
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = TEXT,
		TextSize = 21,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left
	}, holder)

	create("TextLabel", {
		Size = UDim2.new(1,0,0,25),
		Position = UDim2.fromOffset(0,34),
		BackgroundTransparency = 1,
		Text = description,
		TextColor3 = MUTED,
		TextSize = 11,
		Font = Enum.Font.Gotham,
		TextXAlignment = Enum.TextXAlignment.Left
	}, holder)

end

--==================================================
-- BUTTON
--==================================================

local function addButton(page,title,description,callback)

	local button = create("TextButton", {
		Size = UDim2.new(1,0,0,62),
		BackgroundColor3 = PANEL,
		Text = "",
		AutoButtonColor = false
	}, page)

	corner(button,11)

	create("TextLabel", {
		Size = UDim2.new(1,-20,0,25),
		Position = UDim2.fromOffset(12,7),
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = TEXT,
		TextSize = 13,
		Font = Enum.Font.GothamSemibold,
		TextXAlignment = Enum.TextXAlignment.Left
	}, button)

	create("TextLabel", {
		Size = UDim2.new(1,-20,0,20),
		Position = UDim2.fromOffset(12,34),
		BackgroundTransparency = 1,
		Text = description,
		TextColor3 = MUTED,
		TextSize = 10,
		Font = Enum.Font.Gotham,
		TextXAlignment = Enum.TextXAlignment.Left
	}, button)

	button.MouseEnter:Connect(function()
		TweenService:Create(
			button,
			TweenInfo.new(.12),
			{BackgroundColor3 = PANEL2}
		):Play()
	end)

	button.MouseLeave:Connect(function()
		TweenService:Create(
			button,
			TweenInfo.new(.12),
			{BackgroundColor3 = PANEL}
		):Play()
	end)

	button.MouseButton1Click:Connect(callback)

	return button
end

--==================================================
-- CHAT
--==================================================

pageHeader(
	Chat,
	"Chat",
	"Scorpion communication panel."
)

local ChatBox = create("TextBox", {
	Size = UDim2.new(1,0,0,48),
	BackgroundColor3 = PANEL,
	Text = "",
	PlaceholderText = "Type a message...",
	PlaceholderColor3 = MUTED,
	TextColor3 = TEXT,
	TextSize = 13,
	Font = Enum.Font.Gotham,
	ClearTextOnFocus = false
}, Chat)

corner(ChatBox,11)

addButton(
	Chat,
	"Send",
	"Send through your game's chat system.",
	function()
		if ChatBox.Text ~= "" then
			print("[Scorpion Chat]",ChatBox.Text)
			ChatBox.Text = ""
		end
	end
)

--==================================================
-- PLAYERS
--==================================================

pageHeader(
	PlayersPage,
	"Players",
	"Players currently inside the server."
)

local function refreshPlayers()

	for _,item in ipairs(PlayersPage:GetChildren()) do
		if item:GetAttribute("ScorpionPlayer") then
			item:Destroy()
		end
	end

	for _,p in ipairs(Players:GetPlayers()) do

		local button = addButton(
			PlayersPage,
			p.DisplayName,
			"@"..p.Name,
			function()
				print("Selected player:",p.Name)
			end
		)

		button:SetAttribute("ScorpionPlayer",true)

	end
end

refreshPlayers()

Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(refreshPlayers)

--==================================================
-- SCRIPTS
--==================================================

pageHeader(
	Scripts,
	"Scripts",
	"Developer controls for your own experience."
)

if IsOwner then

	addButton(
		Scripts,
		"☀ Day",
		"Set Lighting to daytime.",
		function()
			Lighting.ClockTime = 12
		end
	)

	addButton(
		Scripts,
		"🌙 Night",
		"Set Lighting to nighttime.",
		function()
			Lighting.ClockTime = 0
		end
	)

	addButton(
		Scripts,
		"🌅 Sunset",
		"Set Lighting to sunset.",
		function()
			Lighting.ClockTime = 18
		end
	)

	addButton(
		Scripts,
		"❤️ Heal",
		"Heal your character.",
		function()

			local character = Player.Character
			local humanoid = character and
				character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				humanoid.Health = humanoid.MaxHealth
			end

		end
	)

else

	addButton(
		Scripts,
		"🔒 Locked",
		"Owner controls are unavailable.",
		function()
			warn("Scorpion: owner permission required")
		end
	)

end

--==================================================
-- CLAN
--==================================================

pageHeader(
	Clan,
	"Clan",
	"Clan management panel."
)

local ClanName = create("TextBox", {
	Size = UDim2.new(1,0,0,45),
	BackgroundColor3 = PANEL,
	Text = "",
	PlaceholderText = "Clan name...",
	PlaceholderColor3 = MUTED,
	TextColor3 = TEXT,
	TextSize = 13,
	Font = Enum.Font.Gotham,
	ClearTextOnFocus = false
}, Clan)

corner(ClanName,11)

addButton(
	Clan,
	"🛡 Create Clan",
	"Create a clan in your game.",
	function()

		if ClanName.Text == "" then
			warn("Enter a clan name")
			return
		end

		print("Create clan:",ClanName.Text)

		-- Connect your server Clan RemoteEvent here.

	end
)

addButton(
	Clan,
	"👥 Members",
	"View clan members.",
	function()
		print("Open clan members")
	end
)

addButton(
	Clan,
	"🚪 Leave Clan",
	"Leave your current clan.",
	function()
		print("Leave clan")
	end
)

--==================================================
-- RANKS
--==================================================

pageHeader(
	Ranks,
	"Ranks",
	"Only the Scorpion owner can manage ranks."
)

if IsOwner then

	local Target = create("TextBox", {
		Size = UDim2.new(1,0,0,45),
		BackgroundColor3 = PANEL,
		Text = "",
		PlaceholderText = "Username...",
		PlaceholderColor3 = MUTED,
		TextColor3 = TEXT,
		TextSize = 13,
		Font = Enum.Font.Gotham,
		ClearTextOnFocus = false
	}, Ranks)

	corner(Target,11)

	local rankList = {
		{"Member","Standard rank"},
		{"Premium","Premium rank"},
		{"VIP","VIP rank"},
		{"Legend","Legend rank"}
	}

	for _,info in ipairs(rankList) do

		addButton(
			Ranks,
			"⭐ "..info[1],
			info[2],
			function()

				if Target.Text == "" then
					warn("Enter a username")
					return
				end

				print(
					"Rank request:",
					Target.Text,
					info[1]
				)

				-- IMPORTANT:
				-- Connect this to your SERVER
				-- rank RemoteEvent.
			end
		)

	end

	addButton(
		Ranks,
		"♻ Remove Rank",
		"Return player to Member.",
		function()

			if Target.Text ~= "" then
				print("Remove rank:",Target.Text)
			end

		end
	)

else

	addButton(
		Ranks,
		"🔒 Rank Management Locked",
		"Only "..OWNER.." can manage ranks.",
		function()
			warn("Owner permission required")
		end
	)

end

--==================================================
-- TABS
--==================================================

local function createTab(name,icon)

	local button = create("TextButton", {
		Size = UDim2.new(1,0,0,41),
		BackgroundColor3 = PANEL,
		Text = icon.."  "..name,
		TextColor3 = MUTED,
		TextSize = 12,
		Font = Enum.Font.GothamSemibold,
		AutoButtonColor = false
	}, Sidebar)

	corner(button,9)

	button.MouseButton1Click:Connect(function()

		for pageName,page in pairs(Pages) do
			page.Visible = pageName == name
		end

		for _,item in ipairs(Sidebar:GetChildren()) do
			if item:IsA("TextButton") then
				item.BackgroundColor3 = PANEL
				item.TextColor3 = MUTED
			end
		end

		button.BackgroundColor3 = PINK
		button.TextColor3 = Color3.new(1,1,1)

	end)

	return button
end

local ChatTab = createTab("Chat","💬")
createTab("Players","👥")
createTab("Scripts","📜")
createTab("Clan","🛡")
createTab("Ranks","👑")

Chat.Visible = true
ChatTab.BackgroundColor3 = PINK
ChatTab.TextColor3 = Color3.new(1,1,1)

--==================================================
-- CLOSE / MINIMIZE
--==================================================

Close.MouseButton1Click:Connect(function()
	Main.Visible = false
	Open.Visible = true
end)

Open.MouseButton1Click:Connect(function()
	Main.Visible = true
	Open.Visible = false
end)

Minimize.MouseButton1Click:Connect(function()
	Main.Visible = false
	Open.Visible = true
end)

Open.Visible = false

--==================================================
-- DRAGGING
--==================================================

local dragging = false
local dragStart
local startPosition

Header.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPosition = Main.Position

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

UserInputService.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = false

	end

end)

--==================================================
-- MOBILE
--==================================================

local function resize()

	local camera = workspace.CurrentCamera

	if not camera then
		return
	end

	local viewport = camera.ViewportSize

	if viewport.X < 700 then

		Main.Size = UDim2.new(.94,0,.84,0)
		Main.Position = UDim2.new(.03,0,.08,0)

	else

		Main.Size = UDim2.fromOffset(760,500)
		Main.Position = UDim2.new(.5,-380,.5,-250)

	end

end

resize()

workspace.CurrentCamera:GetPropertyChangedSignal(
	"ViewportSize"
):Connect(resize)

print("🦂 SCORPION SYSTEM LOADED")
print("Owner:",OWNER)
