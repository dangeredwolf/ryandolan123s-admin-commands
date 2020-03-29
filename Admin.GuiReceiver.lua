--GuiReceiver

--It's job is to receive guis

--Here's some settings:

tweentime = 0.5 --The base for how long things animate (AKA Tween). Certain things may take longer or shorter than the number here, it's just a base value. Lower numbers = faster
tweenstyle = "Back"

--Thanks for stopping by have a nice day


PlayerGui = script.Parent
player = game:GetService("Players").LocalPlayer
TellGuiBounceOffset = 3

local Images = {
	SysClose = "rbxassetid://146849649";
	SysCloseHover = "rbxassetid://146849670";
	SysCloseClick = "rbxassetid://150083629";
	Arrow = "rbxassetid://150085532";
	ArrowHover = "rbxassetid://150087188";
	ArrowClick = "rbxassetid://150085536";
}

for _,i in pairs(Images) do
	game:GetService("ContentProvider"):Preload(i)
end

Workspace:WaitForChild("RyanDolan123AdminService")

for _,i in pairs(Workspace:GetChildren()) do
	if i:IsA("Configuration") and i.Name == "RyanDolan123AdminService" then
		if i:FindFirstChild("ChangeSettingSignal") and i:FindFirstChild("ChangeSettingSignal"):IsA("RemoteEvent") then
			if i:FindFirstChild("DisplayMessageSignal") and i:FindFirstChild("DisplayMessageSignal"):IsA("RemoteEvent") then
				if i:FindFirstChild("DismissMessageSignal") and i:FindFirstChild("DismissMessageSignal"):IsA("RemoteEvent") then
					if i:FindFirstChild("DisplayScrollFrameSignal") and i:FindFirstChild("DisplayScrollFrameSignal"):IsA("RemoteEvent") then
						if i:FindFirstChild("TellSignal") and i:FindFirstChild("TellSignal"):IsA("RemoteEvent") then
							ChangeSetting = i:FindFirstChild("ChangeSettingSignal")
							DisplayMessage = i:FindFirstChild("DisplayMessageSignal")
							DismissMessage = i:FindFirstChild("DismissMessageSignal")
							DisplayScrollFrame = i:FindFirstChild("DisplayScrollFrameSignal")
							Tell = i:FindFirstChild("TellSignal")
						end
					end
				end
			end
		end
	end
end

function TweenBackgroundTransparency(element,starta,enda,length)
	coroutine.resume(coroutine.create(function()
		local startTime = time()
		local lastTrans = element.BackgroundTransparency
		while time() - startTime < length do
			if element.BackgroundTransparency == lastTrans then
				element.BackgroundTransparency = ((enda - starta) * ((time() - startTime)/length)) + starta
			else
				break
			end
			lastTrans = element.BackgroundTransparency
			wait(.01)
		end
		element.BackgroundTransparency = enda
		return true
	end))
end

function TweenRotation(element,starta,enda,length)
	coroutine.resume(coroutine.create(function()
		local startTime = time()
		local lastRot = element.Rotation
		while time() - startTime < length do
			if element.Rotation == lastRot then
				element.Rotation = ((enda - starta) * ((time() - startTime)/length)) + starta
			else
				break
			end
			lastRot = element.Rotation
			wait(.01)
		end
		element.Rotation = enda
		return true
	end))
end

function TweenTextTransparency(element,starta,enda,length)
	coroutine.resume(coroutine.create(function()
		local startTime = time()
		local lastTextTrans = element.TextTransparency
		local lastTextStrokeTrans = element.TextStrokeTransparency
		
		while time() - startTime < length do
			if element.TextTransparency == lastTextTrans and element.TextStrokeTransparency == lastTextStrokeTrans then
				element.TextTransparency = ((enda - starta) * ((time() - startTime)/length)) + starta
				element.TextStrokeTransparency = 0.75 + (element.TextTransparency * 0.25)
			else
				break
			end
			lastTextTrans = element.TextTransparency
			lastTextStrokeTrans = element.TextStrokeTransparency
			wait(.01)
		end
		element.TextTransparency = enda
		element.TextStrokeTransparency = 0.75 + (element.TextTransparency * 0.25)
		return true
	end))
end

function MakeAdmiGui()
	Gui = Instance.new("ScreenGui",PlayerGui)
	Gui.Name = "Admi"
	return Gui
end

function MakeMsgGui()
	
	if not Gui then
		MakeAdmiGui()
	end
	
	local MsgGui = Instance.new("Frame", Gui)
	MsgGui.Name = "Msg"
	MsgGui.Position = UDim2.new(0.5, -250, 0.5, -125)
	MsgGui.Size = UDim2.new(0, 500, 0, 300)
	MsgGui.BackgroundColor3 = Color3.new(0, 0, 0)
	MsgGui.BackgroundTransparency = 0.45
	MsgGui.BorderSizePixel = 0
	MsgGui.ZIndex = 10
	
	local Msg = Instance.new("TextLabel", MsgGui)
	Msg.Name = "Msg"
	Msg.Position = UDim2.new(0, 0, 0.2, 0)
	Msg.Size = UDim2.new(1, 0, 0.8, 0)
	Msg.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
	Msg.BackgroundTransparency = 1
	Msg.BorderSizePixel = 0
	Msg.Text = "Message"
	Msg.Font = "Arial"
	Msg.FontSize = "Size18"
	Msg.TextStrokeTransparency = 0.7
	Msg.TextWrapped = true
	Msg.TextYAlignment = "Top"
	Msg.TextColor3 = Color3.new(1, 1, 1)
	Msg.ZIndex = 10
	
	local Title = Instance.new("TextLabel", MsgGui)
	Title.Name = "Title"
	Title.Position = UDim2.new(0, 0, 0.08, 0)
	Title.Size = UDim2.new(1, 0, 0.115, 0)
	Title.BackgroundTransparency = 1
	Title.BorderSizePixel = 0
	Title.Text = "Message"
	Title.Font = "ArialBold"
	Title.FontSize = "Size24"
	Title.TextScaled = true
	Title.TextStrokeTransparency = 0.7
	Title.TextWrapped = true
	Title.TextYAlignment = "Top"
	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.ZIndex = 10
	
	return Msg
end

function DoDisplayMessage(title,text,displaytime)

	Spawn(function()
		local text,title = text,title
		
		if not Gui then
			MakeAdmiGui()
		end
		
		if not PlayerGui:FindFirstChild("Admi") or not PlayerGui:FindFirstChild("Admi"):FindFirstChild("Msg") then
			MakeMsgGui()
		end

		local message = PlayerGui:FindFirstChild("Admi"):FindFirstChild("Msg")
		
		if title == nil then
			title = "Message"
		end
		
		if text == nil then
			text = title
			title = "Message"
		end
		
		message.Size = UDim2.new(0,0,0,0)
		message.Visible = true		
		message.Title.Text = "[ Content Deleted ]"
		message.Msg.Text = "[ Content Deleted ]"
		message.Title.Text = tostring(title)
		message.Msg.Text = tostring(text)
		message.Position = UDim2.new(0.5,-125,0.5,-75)
		message.Size = UDim2.new(0,250,0,150)
		TweenTextTransparency(message.Title,1,0,tweentime*0.65)
		TweenTextTransparency(message.Msg,1,0,tweentime*0.65)
		TweenBackgroundTransparency(message,1,0.45,tweentime*0.5)
		TweenRotation(message,5,0,tweentime*0.65)
		--wait()
		message:TweenSizeAndPosition(UDim2.new(0,500,0,300),UDim2.new(0.5,-250,0.5,-150),nil,tweenstyle,tweentime*1.1,true)
		message.Visible = true
		wait(tweentime)
		if displaytime ~= nil then
			Delay(displaytime,function()if message.Msg.Text == tostring(text)then DoDismissMessage(player)end end)
		end
	end)
end

function MakeTellGui(parent)
	if parent == "root" or parent == root then
		return
	end
	if not Gui then
		MakeAdmiGui(parent)
	end
	local TellText = Instance.new("TextLabel",Gui)
	TellText.Name = "Message"
	TellText.BackgroundColor3 = Color3.new(0,0,0)
	TellText.BackgroundTransparency = 1
	TellText.BorderSizePixel = 0
	TellText.Font = "ArialBold"
	TellText.FontSize = "Size18"
	TellText.Text = "Message"
	TellText.TextStrokeTransparency = 0.5
	TellText.TextColor3 = Color3.new(1,1,1)
	TellText.Size = UDim2.new(1,0,0,32)
	TellText.Position = UDim2.new(0,0,0,-50)
	TellText.ZIndex = 10
	TellText.Rotation = 357
	
	local FakeBar = Instance.new("TextLabel",TellText)
	FakeBar.Name = "FakeBar"
	FakeBar.BackgroundColor3 = Color3.new(0,0,0)
	FakeBar.BackgroundTransparency = 0.35
	FakeBar.BorderSizePixel = 0
	FakeBar.Size = UDim2.new(2,0,0,180)
	FakeBar.Position = UDim2.new(0,0,0,-150)
	FakeBar.ZIndex = 9
	
	return TellText
end

function DoTell(length,msg)
	
	local length = length
	
	if length == nil then
		length = 3
	end
	
	if not Gui then
		MakeAdmiGui()
	end

	if not Gui:FindFirstChild("Message") or not letellmsg then
		letellmsg = MakeTellGui(PlayerGui)
	end
	
	if not msg then
		msg = ""
	end
	
	letellmsg.Text = msg
	letellmsg.Position = UDim2.new(0,0,0,-50)
	letellmsg.Rotation = TellGuiBounceOffset
	letellmsg:TweenPosition(UDim2.new(0,0,0,-2),nil,tweenstyle,tweentime*1.1,true)
	TweenRotation(letellmsg,TellGuiBounceOffset,0,tweentime*0.5)
	
	Delay(length,function()
		if letellmsg.Text == msg then
			TweenRotation(letellmsg,360,360-TellGuiBounceOffset,tweentime*0.5)
			letellmsg:TweenPosition(UDim2.new(0,0,0,-50),nil,tweenstyle,tweentime*1,true)
		end
	end)
end

function DoDisplayScrollFrame(title,text)
	
	if player == nil or player == root or player == "root" then
		return
	end
	
	if not Gui then
		MakeAdmiGui()
	end
	
	local title = title
	local text = text
	
	if title == nil then
		title = "Scrolling Frame"
	end
	if text == nil then
		text = title
		title = "Scrolling Frame"
	end
	
	if not PlayerGui:FindFirstChild("Admi") then
		MakeAdmiGui(player)
	end
	
	local MsgStrips = {}
	
	local ReenableMsg = false
	
	local ScrollGui = Instance.new("Frame", Gui)
	ScrollGui.Name = "ScrollGui"
	ScrollGui.Position = UDim2.new(0.5, -125, 0.5, -125)
	ScrollGui.Size = UDim2.new(0, 250, 0, 250)
	ScrollGui.BackgroundColor3 = Color3.new(0, 0, 0)
	ScrollGui.BackgroundTransparency = 0.45
	ScrollGui.BorderSizePixel = 0
	ScrollGui.ZIndex = 9
	ScrollGui.ClipsDescendants = true
	
	local ScrollingFrameCutter = Instance.new("Frame")
	ScrollingFrameCutter.Name = "ScrollingFrameCutter"
	ScrollingFrameCutter.Position = UDim2.new(0, 0, 0.65, -250)
	ScrollingFrameCutter.Size = UDim2.new(1, 0, 0.85, 0)
	ScrollingFrameCutter.BackgroundColor3 = Color3.new(0, 0, 0)
	ScrollingFrameCutter.BackgroundTransparency = 1
	ScrollingFrameCutter.BorderSizePixel = 0
	ScrollingFrameCutter.ZIndex = 9
	ScrollingFrameCutter.ClipsDescendants = true
	ScrollingFrameCutter.Visible = false
	
	local MsgContainer = Instance.new("TextLabel", ScrollingFrameCutter)
	MsgContainer.Name = "MsgContainer"
	MsgContainer.Size = UDim2.new(1, 0, 999, 0)
	MsgContainer.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
	MsgContainer.BackgroundTransparency = 1
	MsgContainer.BorderSizePixel = 0
	MsgContainer.Text = ""
	MsgContainer.Font = Enum.Font.Arial
	MsgContainer.FontSize = Enum.FontSize.Size18
	MsgContainer.TextTransparency = 1
	MsgContainer.TextWrapped = true
	MsgContainer.TextYAlignment = Enum.TextYAlignment.Top
	MsgContainer.TextXAlignment = Enum.TextXAlignment.Left
	MsgContainer.TextColor3 = Color3.new(1, 1, 1)
	MsgContainer.ZIndex = 9
	
	local Up = Instance.new("ImageButton", ScrollGui)
	Up.Name = "Up"
	Up.Position = UDim2.new(0.93, 0, 0.02, 0)
	Up.Size = UDim2.new(0.055, 0, 0.055, 0)
	Up.BackgroundTransparency = 1
	Up.ZIndex = 10
	Up.Image = Images.Arrow
	
	Up.MouseButton1Up:connect(function()
		if MsgContainer.Parent == nil then
			return
		end
		Up.Image = Images.Arrow
		local asds = MsgContainer.Position.Y.Scale+0.5
		if asds > 0 then
			asds = 0
		end
		MsgContainer:TweenPosition(UDim2.new(0,0,asds,0),nil,"Quint",tweentime*0.75,true)
	end)
	
	Up.MouseButton1Down:connect(function()
		Up.Image = Images.ArrowHover
	end)
	
	Up.MouseEnter:connect(function()
		Up.Image = Images.ArrowHover
	end)
	
	Up.MouseLeave:connect(function()
		Up.Image = Images.Arrow
	end)
	
	local Down = Instance.new("ImageButton", ScrollGui)
	Down.Name = "Down"
	Down.Position = UDim2.new(0.93, 0, 0.925, 0)
	Down.Size = UDim2.new(0.055, 0, 0.055, 0)
	Down.BackgroundTransparency = 1
	Down.ZIndex = 10
	Down.Image = Images.Arrow
	Down.Rotation = 180
	
	Down.MouseButton1Click:connect(function()
		if MsgContainer.Parent == nil then
			return
		end
		Down.Image = Images.Arrow
		MsgContainer:TweenPosition(UDim2.new(0,0,MsgContainer.Position.Y.Scale-0.5,0),nil,"Quint",tweentime*0.75,true)
	end)
	
	Down.MouseButton1Down:connect(function()
		Down.Image = Images.ArrowHover
	end)
	
	Down.MouseEnter:connect(function()
		Down.Image = Images.ArrowHover
	end)
	
	Down.MouseLeave:connect(function()
		Down.Image = Images.Arrow
	end)
	
	local Title = Instance.new("TextLabel", ScrollGui)
	Title.Name = "Title"
	Title.Position = UDim2.new(0, 0, 0.025, 0)
	Title.Size = UDim2.new(1, 0, 0.1, 0)
	Title.BackgroundTransparency = 1
	Title.BorderSizePixel = 0
	Title.Text = title
	Title.Font = Enum.Font.ArialBold
	Title.FontSize = Enum.FontSize.Size24
	Title.TextScaled = true
	Title.TextWrapped = true
	Title.TextYAlignment = Enum.TextYAlignment.Top
	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.ZIndex = 10
	
	local Close = Instance.new("ImageButton", ScrollGui)
	Close.Name = "Close"
	Close.Position = UDim2.new(0.01, 0, 0.01, 0)
	Close.Size = UDim2.new(0.045, 0, 0.045, 0)
	Close.BorderSizePixel = 0
	Close.BackgroundTransparency = 1
	Close.ZIndex = 10
	Close.Image = "rbxassetid://146849649"
	
	Close.MouseEnter:connect(function()
		Close.Image = "rbxassetid://146849670"
	end)

	Close.MouseLeave:connect(function()
		Close.Image = "rbxassetid://146849649"
	end)
	
	Close.MouseButton1Up:connect(function()
		if MsgContainer == nil or MsgContainer.Parent == nil then
			return
		end
		
		Close.Image = "rbxassetid://146849670"
		
		ScrollGui:TweenSizeAndPosition(UDim2.new(0,200,0,250),UDim2.new(0.5,-125,0.5,-125),nil,tweenstyle,tweentime,true)
		TweenBackgroundTransparency(ScrollGui,0.45,1,tweentime*0.4)
		--TweenBackgroundTransparency(Up,0.85,1,tweentime*0.375)
		--TweenBackgroundTransparency(Down,0.85,1,tweentime*0.375)
		--TweenBackgroundTransparency(Close,0.85,1,tweentime*0.375)

		--TweenTextTransparency(Up,0,1,tweentime*0.35)
		--TweenTextTransparency(Down,0,1,tweentime*0.35)
		--TweenTextTransparency(Close,0,1,tweentime*0.35)
		
		TweenTextTransparency(Title,0,1,tweentime*0.35)
		
		for _,i in pairs(MsgStrips) do
			i:Destroy()
		end
		
		if math.random() > 0.5 then
			TweenRotation(ScrollGui,360,math.random(325,340),tweentime*0.4)
		else
			TweenRotation(ScrollGui,0,math.random(20,35),tweentime*0.4)
		end
		
		wait(tweentime*0.3)
		
		Up.Visible = false
		Close.Visible = false
		Down.Visible = false
		
		wait(tweentime*0.7)
		
		ScrollGui:Destroy()
	end)
	
	Close.MouseButton1Down:connect(function()
		Close.Image = Images.SysCloseClick
	end)
	
	ScrollingFrameCutter.Visible = false
	
	TweenRotation(ScrollGui,7,0,tweentime*0.7)
	
	ScrollGui:TweenSizeAndPosition(UDim2.new(0,500,0,500),UDim2.new(0.5,-250,0.5,-250),nil,tweenstyle,tweentime*1.1,true)
	TweenBackgroundTransparency(ScrollGui,1,0.45,tweentime*0.45)
	--TweenBackgroundTransparency(Up,1,0.85,tweentime*0.5)
	--TweenBackgroundTransparency(Down,1,0.85,tweentime*0.5)
	--TweenBackgroundTransparency(Close,1,0.85,tweentime*0.5)
	
	--TweenTextTransparency(Up,1,0,tweentime*0.6)
	--TweenTextTransparency(Down,1,0,tweentime*0.6)
	--TweenTextTransparency(Close,1,0,tweentime*0.6)
	
	TweenTextTransparency(Title,1,0,tweentime*0.6)
	
	wait(tweentime*1.2)
	
	ScrollingFrameCutter.Parent = ScrollGui
	ScrollingFrameCutter.Visible = true
	
	for a in text:gmatch("[^\n]+") do
		local Msg = Instance.new("TextLabel", MsgContainer)
		Msg.Name = "Msg"..(#MsgStrips + 1)
		Msg.Size = UDim2.new(1, 0, 0, 20)
		Msg.Position = UDim2.new(0,0,0,#MsgStrips * 18)
		Msg.BackgroundColor3 = Color3.new(0.208, 0.208, 0.208)
		Msg.BackgroundTransparency = 1
		Msg.BorderSizePixel = 0
		Msg.Text = " "..tostring(a)
		Msg.Font = Enum.Font.Arial
		Msg.FontSize = Enum.FontSize.Size18
		Msg.TextTransparency = #MsgContainer:GetChildren() > 24 and 0 or 1
		Msg.TextWrapped = true
		Msg.TextYAlignment = Enum.TextYAlignment.Center
		Msg.TextXAlignment = Enum.TextXAlignment.Left
		Msg.TextColor3 = Color3.new(1, 1, 1)
		Msg.TextStrokeTransparency = #MsgContainer:GetChildren() > 24 and 0.75 or 1
		Msg.ZIndex = 9
		TweenTextTransparency(Msg,1,0,tweentime*0.25)
		table.insert(MsgStrips,Msg)
	end
	
	return ScrollGui
end

function DoDismissMessage()
	if not Gui then
		MakeAdmiGui()
	end	
	
	if not PlayerGui:FindFirstChild("Admi") or not PlayerGui:FindFirstChild("Admi"):FindFirstChild("Msg") then
		MakeMsgGui(player)
	end
	
	local message = PlayerGui:FindFirstChild("Admi"):FindFirstChild("Msg")
	TweenBackgroundTransparency(message,0.45,1,tweentime*0.4)
	TweenTextTransparency(message.Title,0,1,tweentime*0.275)
	TweenTextTransparency(message.Msg,0,1,tweentime*0.275)

	message:TweenSizeAndPosition(UDim2.new(0,0,0,0),--[[UDim2.new(0,250,0,150),UDim2.new(0.5,-125,0.5,-75)]]UDim2.new(0.5,0,0.5,0),nil,tweenstyle,tweentime*2.2,true)
	
	if math.random() > 0.5 then
		TweenRotation(message,360,math.random(320,325),tweentime*0.5)
	else
		TweenRotation(message,0,math.random(35,40),tweentime*0.5)
	end
	
	wait(tweentime*2.2)
	if message.Position == UDim2.new(0.5,0,0.5,0) and message.Size == UDim2.new(0,0,0,0) then
		message.Visible = false
	end
end


DisplayMessage.OnClientEvent:connect(function(title,text,displaytime)
	DoDisplayMessage(title,text,displaytime)
end)

DismissMessage.OnClientEvent:connect(function(title,text,displaytime)
	DoDismissMessage(title,text,displaytime)
end)

DisplayScrollFrame.OnClientEvent:connect(function(title,text,displaytime)
	DoDisplayScrollFrame(title,text)
end)

Tell.OnClientEvent:connect(function(text,displaytime)
	DoTell(text,displaytime)
end)