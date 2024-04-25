local function hasPerm(plr)
		local PermNBC = 66254
		local PermBC = 64354
		local UserID = plr.UserId
		if string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PermNBC), PermNBC)
			or string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PermBC), PermBC) then
			return true
		else
			return false
		end
	end
	local function hasPersons(plr)
		local PersonNBC = 35748
		local PersonBC = 37127
		local UserID = plr.UserId
		if string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PersonNBC), PersonNBC)
			or string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PersonBC), PersonBC) then
			return true
		else
			return false
		end
	end
	local players = game:GetService("Players"):GetPlayers()
	game.StarterGui:SetCoreGuiEnabled("PlayerList", false)
	local PlayerList = game:GetService("CoreGui").PlayerList
	
	
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 150, 0, (60 + 5) * 7)
	frame.Position = UDim2.new(1, -180, 0.5, -227)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.Parent = PlayerList
	local function createBubble(parent)
		local bubble = Instance.new("Frame")
		bubble.Size = UDim2.new(1, 0, 0, 60)
		bubble.BackgroundTransparency = 1
		local cornerRadius = Instance.new("UICorner")
		cornerRadius.CornerRadius = UDim.new(0, 4)
		cornerRadius.Parent = bubble
		local displayNameLabel = Instance.new("TextLabel")
		displayNameLabel.Size = UDim2.new(1, -10, 0, 60 * 0.5)
		displayNameLabel.Position = UDim2.new(0, 5, 0, 1)
		displayNameLabel.BackgroundTransparency = 1
		displayNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		displayNameLabel.TextSize = 16
		displayNameLabel.Font = Enum.Font.SourceSansBold
		displayNameLabel.Parent = bubble
		local usernameLabel = Instance.new("TextLabel")
		usernameLabel.Size = UDim2.new(1, -10, 0, 60 * 0.5)
		usernameLabel.Position = UDim2.new(0, 5, 0, 60 * 0.3)
		usernameLabel.BackgroundTransparency = 1
		usernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		usernameLabel.TextSize = 14
		usernameLabel.Font = Enum.Font.SourceSans
		usernameLabel.Parent = bubble
		local thumbnailImage = Instance.new("ImageLabel")
		thumbnailImage.Visible = false
		thumbnailImage.Size = UDim2.new(0, 30, 0, 30)
		thumbnailImage.Position = UDim2.new(0, 5, 0, 60 * 0.5 + 9)
		thumbnailImage.AnchorPoint = Vector2.new(0, 0.5)
		thumbnailImage.BackgroundTransparency = 1
		thumbnailImage.Parent = bubble
		bubble.Parent = parent
		return bubble, displayNameLabel, usernameLabel, thumbnailImage
	end
	local function updatePlayerList()
		for _, child in pairs(frame:GetChildren()) do
			child:Destroy()
		end
		local totalHeight = frame.Size.Y.Offset
		local availableHeight = math.min(totalHeight, (#players * (60 + 5)) - 5)
		local spacing = availableHeight / #players
		for i, player in pairs(game.Players:GetPlayers()) do
			local bubble, displayNameLabel, usernameLabel, thumbnailImage = createBubble(frame)
			bubble.BackgroundColor3 = Color3.fromRGB(20,20,20)
			bubble.BackgroundTransparency = 0
			if player.Name == game.Players.LocalPlayer.Name then
				displayNameLabel.Text = player.DisplayName
				displayNameLabel.TextColor3 = Color3.fromRGB(75,200,255)
				usernameLabel.Text = "@" .. player.Name
				usernameLabel.TextColor3 = Color3.fromRGB(100,200,255)
			else
				displayNameLabel.Text = player.DisplayName;
				usernameLabel.Text = "@" .. player.Name;
			end
			local yOffset = (i - 1) * (60 + 5) + -240
			bubble.Position = UDim2.new(0, 15, 0, yOffset)
			local thumbnailType = Enum.ThumbnailType.HeadShot
			local thumbnailSize = Enum.ThumbnailSize.Size420x420
			local thumbnailUrl = game:GetService("Players"):GetUserThumbnailAsync(player.UserId, thumbnailType, thumbnailSize)
			thumbnailImage.Image = thumbnailUrl
			thumbnailImage.Size = UDim2.new(0, 30, 0, 30)
			local aspectRatio = thumbnailImage.ImageRectSize.X / thumbnailImage.ImageRectSize.Y
			if thumbnailImage.Size.X.Offset > 30 or thumbnailImage.Size.Y.Offset > 30 then
				if aspectRatio > 1 then
					thumbnailImage.Size = UDim2.new(0, 30, 0, 30 / aspectRatio)
				else
					thumbnailImage.Size = UDim2.new(0, 30 * aspectRatio, 0, 30)
				end
			end
			if hasPerm(player) then
				local permissionLabel = Instance.new("TextLabel")
				permissionLabel.Size = UDim2.new(0, 80, 0, 30)
				permissionLabel.Position = UDim2.new(1, -115, 0, 31)
				permissionLabel.BackgroundTransparency = 1
				permissionLabel.Text = "Perm"
				permissionLabel.TextColor3 = Color3.fromRGB(200, 50, 33)
				permissionLabel.TextSize = 14
				permissionLabel.Font = Enum.Font.SourceSans
				permissionLabel.TextXAlignment = Enum.TextXAlignment.Right
				permissionLabel.TextYAlignment = Enum.TextYAlignment.Center
				permissionLabel.Parent = bubble
			end
			if hasPersons(player) then
				local permissionLabelr = Instance.new("TextLabel")
				permissionLabelr.Size = UDim2.new(0, 80, 0, 30)
				permissionLabelr.Position = UDim2.new(1, -160, 0, 31)
				permissionLabelr.BackgroundTransparency = 1
				permissionLabelr.Text = "Person299"
				permissionLabelr.TextColor3 = Color3.fromRGB(40, 151, 126)
				permissionLabelr.TextSize = 14
				permissionLabelr.Font = Enum.Font.SourceSans
				permissionLabelr.TextXAlignment = Enum.TextXAlignment.Right
				permissionLabelr.TextYAlignment = Enum.TextYAlignment.Center
				permissionLabelr.Parent = bubble
			end
		end
	end
	
	local function slidePlayerList()
		isSlided = not isSlided
		local slidePosition = UDim2.new(1, -180, 0.5, -((60 + 5) * 7) / 2)
		local slideOutPosition = UDim2.new(1, 0, 0.5, -((60 + 5) * 7) / 2)
		local targetPosition = isSlided and slideOutPosition or slidePosition
		frame:TweenPosition(targetPosition, Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 0.3, true)
	end
	
	game:GetService("UserInputService").InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.Tab then
			slidePlayerList()
		end
	end)
	frame.Position = isSlided and UDim2.new(1, 0, 0.5, -((60 + 5) * 7) / 2) or UDim2.new(1, -220, 0.5, -((60 + 5) * 7) / 2)
	game:GetService("Players").PlayerAdded:Connect(updatePlayerList)
	local function isLocalPlayerLeaving(player)
		if player == game.Players.LocalPlayer then
			return true
		else
			return false
		end
	end
	
	local Connections = {}
	local function isLocalPlayerLeaving(player)
		if player == game.Players.LocalPlayer then
			return true
		else
			return false
		end
	end
	local function removeFunction()
		for _, Connection in pairs(Connections) do
			Connection:Disconnect()
			break
		end
	end
	Connections[#Connections + 1] = game:GetService("Players").PlayerRemoving:Connect(function(player)
		if isLocalPlayerLeaving(player) then
			removeFunction()
			return
		end
		updatePlayerList()
	end)
	updatePlayerList()
