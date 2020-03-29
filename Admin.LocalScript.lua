																																																																																																																								--[[
This is a very secure script loader included in RyanDolan123's Admin Commands

Whenever a script or localscript is launched using this external script, it is hashed in SHA-1 and acts as a signature of the code
Then both the hashed and raw versions of the admin script are passed onto this script where everything is verified.
The script is also made undisableable just like the main admin script, and is also not allowed to restart to prevent the code from being modified

If either the signature or the code is tampered and does not match, the script will not execute the code.

I have not seen any other admin commands with this high level of security yet.


If you can write up a CE Lua exploit which can breach this remotely with an unmodified version of the Admin Commands version 1.1 and above, I might want to offer you a reward (Likely robux) if you can release the source code to me


The Lua5.1 SHA-1 encryption is provided by http://cube3d.de/
Released under the MIT license																																																																																																																									
																																																																																																																											
																																																																																																																								--]]

if script:FindFirstChild("DO_NOT_REENABLE") then
	return
end


wait()


Spawn(function()

CodeSignCache = {[ [[
			local Player = game:GetService("Players").LocalPlayer
			local Mouse = Player:GetMouse()
			local Torso = Player.Character:WaitForChild("Torso")
			local Humanoid = Player.Character:WaitForChild("Humanoid")
			local Flying = true
			local Control = {f = 0, b = 0, l = 0, r = 0} 
			local LastControl = {f = 0, b = 0, l = 0, r = 0} 
			local MaxSpeed = 50 
			local Speed = 0
			local Camera = Workspace.CurrentCamera
			
			local FlySmoke = Instance.new("Smoke",Torso)
			FlySmoke.Name = "FlySmoke"
			FlySmoke.Opacity = 0.08
			FlySmoke.Size = 25
			
			Instance.new("StringValue",script).Name = "DO_NOT_REENABLE"			
			
			script.Parent = Player:FindFirstChild("PlayerGui")
			script.Name = "ADMIN_FLY_SCRIPT"
			
			function Fly() 
				local Gyro = Instance.new("BodyGyro", Torso) 
				Gyro.P = 9e4 
				Gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
				Gyro.cframe = Torso.CFrame --why is cframe in lowercase for BodyGyros
				
				local Velocity = Instance.new("BodyVelocity", Torso) 
				Velocity.velocity = Vector3.new(0,0.1,0) --roblox why is velocity lowercase
				Velocity.maxForce = Vector3.new(9e9, 9e9, 9e9) 
				
				repeat
					wait() 
					
					Humanoid.PlatformStand = true 
					
					if Control.l + Control.r + Control.f + Control.b > 0 then
						FlySmoke.Enabled = true
					else
						FlySmoke.Enabled = false
					end
					
					if Control.l + Control.r ~= 0 or Control.f + Control.b ~= 0 then 
					
						Speed = Speed+.5+(Speed/MaxSpeed) 
						
						if Speed > MaxSpeed then 
							Speed = MaxSpeed 
						end 
					elseif not (Control.l + Control.r ~= 0 or Control.f + Control.b ~= 0) and Speed ~= 0 then 
						Speed = Speed-1 
						if Speed < 0 then 
							Speed = 0 
						end 
					end 
						
					if (Control.l + Control.r) ~= 0 or (Control.f + Control.b) ~= 0 then 
					
						Velocity.velocity = 
							((Camera.CoordinateFrame.lookVector * (Control.f + Control.b)) +
							((Camera.CoordinateFrame * CFrame.new(Control.l + Control.r,(Control.f + Control.b) * 0.2, 0).p) - --yuck
							Camera.CoordinateFrame.p))*Speed
							
						LastControl = {f = Control.f, b = Control.b, l = Control.l, r = Control.r}
						
					elseif (Control.l + Control.r) == 0 and (Control.f + Control.b) == 0 and Speed ~= 0 then 
					
						Velocity.velocity = 
							((Camera.CoordinateFrame.lookVector * (LastControl.f + LastControl.b)) +
							((Camera.CoordinateFrame * CFrame.new(LastControl.l + LastControl.r, (LastControl.f + LastControl.b) * 0.2, 0).p) - --also yuck
							Camera.CoordinateFrame.p))*Speed 
							
					else 
						Velocity.velocity = Vector3.new(0,0.1,0) 
					end
					
					Gyro.cframe = Camera.CoordinateFrame * CFrame.Angles(-math.rad((Control.f+Control.b)*50*Speed/MaxSpeed),0,0) 
					
				until not Flying or not script.Parent
				
				Control = {f = 0, b = 0, l = 0, r = 0} 
				LastControl = {f = 0, b = 0, l = 0, r = 0} 
				Speed = 0
				Gyro:Destroy()
				Velocity:Destroy()
				Humanoid.PlatformStand = false 
				
			end
			
			Mouse.KeyDown:connect(function(key) 
				if key:lower() == "e" then 
					Flying = not Flying
					if Flying then
						Fly()
					end
				elseif key:lower() == "w" then 
					Control.f = 1 
				elseif key:lower() == "s" then 
					Control.b = -1 
				elseif key:lower() == "a" then 
					Control.l = -1 
				elseif key:lower() == "d" then 
					Control.r = 1 
				end 
			end) 
			
			Mouse.KeyUp:connect(function(key) 
				if key:lower() == "w" then 
					Control.f = 0 
				elseif key:lower() == "s" then 
					Control.b = 0 
				elseif key:lower() == "a" then 
					Control.l = 0 
				elseif key:lower() == "d" then 
					Control.r = 0 
				end 
			end)
			
			Fly()]]] = "bc194bb513ac52f25311f39279e7b6859c1bc754";
			
			[ [[
			local Player = game.Players.LocalPlayer
			local Mouse = Player:GetMouse()
			local Character = Player.Character
			local Humanoid = Character:FindFirstChild("Humanoid")
			local Torso = Character:WaitForChild("Torso")
			local Camera = Workspace.CurrentCamera
			local Move = {W = 0, S = 0, A = 0, D = 0}
			local Speed = 2
			
			Instance.new("StringValue",script).Name = "DO_NOT_REENABLE"			
			
			script.Parent = Player:FindFirstChild("PlayerGui")
			script.Name = "ADMIN_NOCLIP_SCRIPT"
			
			Mouse.KeyDown:connect(function(key)
				if key:lower() == "w" then
					Move.W = 1
				elseif key:lower() == "s" then
					Move.S = 1
				elseif key:lower() == "a" then
					Move.A = 1
				elseif key:lower() == "d" then
					Move.D = 1
				elseif key:lower() == "q" then
					Speed = Speed + 1
				elseif key:lower() == "e" then
					Speed = Speed - 1
				end
			end)
			
			Mouse.KeyUp:connect(function(key)
				if key:lower() == "w" then
					Move.W = 0
				elseif key:lower() == "s" then
					Move.S = 0
				elseif key:lower() == "a" then
					Move.A = 0
				elseif key:lower() == "d" then
					Move.D = 0
				end
			end)
			
			Torso.Anchored = true
			Humanoid.PlatformStand = true
			
			local eventt = Humanoid.Changed:connect(function()
				Humanoid.PlatformStand = true
			end)
			
			local event = game:GetService("RunService").RenderStepped:connect(function()
				Torso.CFrame = CFrame.new(
					Torso.Position,
					Camera.CoordinateFrame.p) *
					CFrame.Angles(0, math.rad(180), 0) *
					CFrame.new((Move.D - Move.A) *
					Speed,
					0,
					(Move.S - Move.W) *
					Speed
				)
			end)
			
			repeat wait(0.25) until not script.Parent
			
			event:disconnect()
			eventt:disconnect()]]] = "b7d0deea7bfdf2cc3f3be7e6c56f837229231258";
}


Workspace = game:GetService("Workspace")
Players = game:GetService("Players")
Lighting = game:GetService("Lighting")
ReplicatedStorage = game:GetService("ReplicatedStorage")
ServerStorage = game:GetService("ServerStorage")
ServerScriptStorage = game:GetService("ServerScriptService")
StarterGui = game:GetService("StarterGui")
StarterPack = game:GetService("StarterPack")
Debris = game:GetService("Debris")
Teams = game:GetService("Teams")
TeleportService = game:GetService("TeleportService")
MarketplaceService = game:GetService("MarketplaceService")

tweentime = 0.5
tweenstyle = "Quart"

if not script:IsA("LocalScript") then
	script.Parent = nil
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

sha1 = {}

local cfg_caching = false

local floor,modf = math.floor,math.modf
local char,format,rep = string.char,string.format,string.rep

local function bytes_to_w32 (a,b,c,d) return a*0x1000000+b*0x10000+c*0x100+d end

local function w32_to_bytes (i)
	return floor(i/0x1000000)%0x100,floor(i/0x10000)%0x100,floor(i/0x100)%0x100,i%0x100
end

local function w32_rot (bits,a)
	local b2 = 2^(32-bits)
	local a,b = modf(a/b2)
	return a+b*b2*(2^(bits))
end

local function cache2arg (fn)
	if not cfg_caching then return fn end
	local lut = {}
	for i=0,0xffff do
		local a,b = floor(i/0x100),i%0x100
		lut[i] = fn(a,b)
	end
	return function (a,b)
		return lut[a*0x100+b]
	end
end

local function byte_to_bits (b)
	local b = function (n)
		local b = floor(b/n)
		return b%2==1
	end
	return b(1),b(2),b(4),b(8),b(16),b(32),b(64),b(128)
end

local function bits_to_byte (a,b,c,d,e,f,g,h)
	local function n(b,x) return b and x or 0 end
	return n(a,1)+n(b,2)+n(c,4)+n(d,8)+n(e,16)+n(f,32)+n(g,64)+n(h,128)
end

local function bits_to_string (a,b,c,d,e,f,g,h)
	local function x(b) return b and "1" or "0" end
	return ("%s%s%s%s %s%s%s%s"):format(x(a),x(b),x(c),x(d),x(e),x(f),x(g),x(h))
end

local function byte_to_bit_string (b)
	return bits_to_string(byte_to_bits(b))
end

local function w32_to_bit_string(a)
	if type(a) == "string" then return a end
	local aa,ab,ac,ad = w32_to_bytes(a)
	local s = byte_to_bit_string
	return ("%s %s %s %s"):format(s(aa):reverse(),s(ab):reverse(),s(ac):reverse(),s(ad):reverse()):reverse()
end

local band = cache2arg (function(a,b)
	local A,B,C,D,E,F,G,H = byte_to_bits(b)
	local a,b,c,d,e,f,g,h = byte_to_bits(a)
	return bits_to_byte(
		A and a, B and b, C and c, D and d,
		E and e, F and f, G and g, H and h)
end)

local bor = cache2arg(function(a,b)
	local A,B,C,D,E,F,G,H = byte_to_bits(b)
	local a,b,c,d,e,f,g,h = byte_to_bits(a)
	return bits_to_byte(
		A or a, B or b, C or c, D or d,
		E or e, F or f, G or g, H or h)
end)

local bxor = cache2arg(function(a,b)
	local A,B,C,D,E,F,G,H = byte_to_bits(b)
	local a,b,c,d,e,f,g,h = byte_to_bits(a)
	return bits_to_byte(
		A ~= a, B ~= b, C ~= c, D ~= d,
		E ~= e, F ~= f, G ~= g, H ~= h)
end)

local function bnot (x)
	return 255-(x % 256)
end

local function w32_comb(fn)
	return function (a,b)
		local aa,ab,ac,ad = w32_to_bytes(a)
		local ba,bb,bc,bd = w32_to_bytes(b)
		return bytes_to_w32(fn(aa,ba),fn(ab,bb),fn(ac,bc),fn(ad,bd))
	end
end

local w32_and = w32_comb(band)
local w32_xor = w32_comb(bxor)
local w32_or = w32_comb(bor)

local function w32_xor_n (a,...)
	local aa,ab,ac,ad = w32_to_bytes(a)
	for i=1,select('#',...) do
		local ba,bb,bc,bd = w32_to_bytes(select(i,...))
		aa,ab,ac,ad = bxor(aa,ba),bxor(ab,bb),bxor(ac,bc),bxor(ad,bd)
	end
	return bytes_to_w32(aa,ab,ac,ad)
end

local function w32_or3 (a,b,c)
	local aa,ab,ac,ad = w32_to_bytes(a)
	local ba,bb,bc,bd = w32_to_bytes(b)
	local ca,cb,cc,cd = w32_to_bytes(c)
	return bytes_to_w32(
		bor(aa,bor(ba,ca)), bor(ab,bor(bb,cb)), bor(ac,bor(bc,cc)), bor(ad,bor(bd,cd))
	)
end

local function w32_not (a)
	return 4294967295-(a % 4294967296)
end

local function w32_add (a,b) return (a+b) % 4294967296 end

local function w32_add_n (a,...)
	for i=1,select('#',...) do
		a = (a+select(i,...)) % 4294967296
	end
	return a
end

local function w32_to_hexstring (w) return format("%08x",w) end

function sha1.hex(msg)
	local H0,H1,H2,H3,H4 = 0x67452301,0xEFCDAB89,0x98BADCFE,0x10325476,0xC3D2E1F0
	local msg_len_in_bits = #msg * 8

	local first_append = char(0x80) -- append a '1' bit plus seven '0' bits

	local non_zero_message_bytes = #msg +1 +8 -- the +1 is the appended bit 1, the +8 are for the final appended length
	local current_mod = non_zero_message_bytes % 64
	local second_append = current_mod>0 and rep(char(0), 64 - current_mod) or ""

	-- now to append the length as a 64-bit number.
	local B1, R1 = modf(msg_len_in_bits  / 0x01000000)
	local B2, R2 = modf( 0x01000000 * R1 / 0x00010000)
	local B3, R3 = modf( 0x00010000 * R2 / 0x00000100)
	local B4	  =	0x00000100 * R3

	local L64 = char( 0) .. char( 0) .. char( 0) .. char( 0) -- high 32 bits
				.. char(B1) .. char(B2) .. char(B3) .. char(B4) --  low 32 bits

	msg = msg .. first_append .. second_append .. L64

	assert(#msg % 64 == 0)

	local chunks = #msg / 64

	local W = { }
	local start, A, B, C, D, E, f, K, TEMP
	local chunk = 0

	while chunk < chunks do
		--
		-- break chunk up into W[0] through W[15]
		--
		start,chunk = chunk * 64 + 1,chunk + 1

		for t = 0, 15 do
			W[t] = bytes_to_w32(msg:byte(start, start + 3))
			start = start + 4
		end

		--
		-- build W[16] through W[79]
		--
		for t = 16, 79 do
			-- For t = 16 to 79 let Wt = S1(Wt-3 XOR Wt-8 XOR Wt-14 XOR Wt-16).
			W[t] = w32_rot(1, w32_xor_n(W[t-3], W[t-8], W[t-14], W[t-16]))
		end

		A,B,C,D,E = H0,H1,H2,H3,H4

		for t = 0, 79 do
			if t <= 19 then
				-- (B AND C) OR ((NOT B) AND D)
				f = w32_or(w32_and(B, C), w32_and(w32_not(B), D))
				K = 0x5A827999
			elseif t <= 39 then
				-- B XOR C XOR D
				f = w32_xor_n(B, C, D)
				K = 0x6ED9EBA1
			elseif t <= 59 then
				-- (B AND C) OR (B AND D) OR (C AND D
				f = w32_or3(w32_and(B, C), w32_and(B, D), w32_and(C, D))
				K = 0x8F1BBCDC
			else
				-- B XOR C XOR D
				f = w32_xor_n(B, C, D)
				K = 0xCA62C1D6
			end

			-- TEMP = S5(A) + ft(B,C,D) + E + Wt + Kt;
			A,B,C,D,E = w32_add_n(w32_rot(5, A), f, E, W[t], K),
				A, w32_rot(30, B), C, D
		end
		-- Let H0 = H0 + A, H1 = H1 + B, H2 = H2 + C, H3 = H3 + D, H4 = H4 + E.
		H0,H1,H2,H3,H4 = w32_add(H0, A),w32_add(H1, B),w32_add(H2, C),w32_add(H3, D),w32_add(H4, E)
	end
	local f = w32_to_hexstring
	return f(H0) .. f(H1) .. f(H2) .. f(H3) .. f(H4)
end

local function hex_to_binary(hex)
	return hex:gsub('..', function(hexval)
		return string.char(tonumber(hexval, 16))
	end)
end

function sha1.bin(msg)
	return hex_to_binary(sha1.hex(msg))
end

local xor_with_0x5c = {}
local xor_with_0x36 = {}
-- building the lookuptables ahead of time (instead of littering the source code
-- with precalculated values)
for i=0,0xff do
	xor_with_0x5c[char(i)] = char(bxor(i,0x5c))
	xor_with_0x36[char(i)] = char(bxor(i,0x36))
end

local blocksize = 64 -- 512 bits

function sha1.hmacHex(key, text)
	assert(type(key)  == 'string', "key passed to hmacHex should be a string")
	assert(type(text) == 'string', "text passed to hmacHex should be a string")

	if #key > blocksize then
		key = sha1.bin(key)
	end

	local key_xord_with_0x36 = key:gsub('.', xor_with_0x36) .. string.rep(string.char(0x36), blocksize - #key)
	local key_xord_with_0x5c = key:gsub('.', xor_with_0x5c) .. string.rep(string.char(0x5c), blocksize - #key)

	return sha1.hex(key_xord_with_0x5c .. sha1.bin(key_xord_with_0x36 .. text))
end

function sha1.hmacBin(key, text)
	return hex_to_binary(sha1.hmacHex(key, text))
end



function MakeMsgGui(player)
	if player == ROOT or player == "ROOT" then
		return true
	end
	local Gui = player:WaitForChild("PlayerGui"):FindFirstChild("Admi")
	if not Gui or not Gui:IsA("ScreenGui") then
		Gui = MakeAdmiGui(player:WaitForChild("PlayerGui"))
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
	Title.Size = UDim2.new(1, 0, 0.125, 0)
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

function DisplayScrollFrame(player,title,text)
	if player == ROOT or player == "ROOT" then
		return true
	end
	local Gui = player:WaitForChild("PlayerGui"):FindFirstChild("Admi")
	if not Gui or not Gui:IsA("ScreenGui") then
		Gui = MakeAdmiGui(player:WaitForChild("PlayerGui"))
	end
	if Gui:FindFirstChild("ScrollGui") then
		Gui:FindFirstChild("ScrollGui"):Destroy()
	end
	
	local title = title
	local text = text
	
	if title == nil then
		title = "Message"
	end
	if text == nil then
		text = title
		title = "Message"
	end
		
	local ReenableMsg = (Gui:FindFirstChild("Msg") and Gui:FindFirstChild("Msg").Visible) or false
	
	local ScrollGui = Instance.new("Frame", Gui)
	ScrollGui.Name = "ScrollGui"
	ScrollGui.Position = UDim2.new(0.5, -125, 0.5, -125)
	ScrollGui.Size = UDim2.new(0, 250, 0, 250)
	ScrollGui.BackgroundColor3 = Color3.new(0, 0, 0)
	ScrollGui.BackgroundTransparency = 0.44999998807907
	ScrollGui.BorderSizePixel = 0
	ScrollGui.ZIndex = 9
	ScrollGui.ClipsDescendants = true
	ScrollGui.Visible = false
	
	local ScrollingFrameCutter = Instance.new("Frame", ScrollGui)
	ScrollingFrameCutter.Name = "ScrollingFrameCutter"
	ScrollingFrameCutter.Position = UDim2.new(0.5, -250, 0.64999997615814, -250)
	ScrollingFrameCutter.Size = UDim2.new(1, 0, 0.85000002384186, 0)
	ScrollingFrameCutter.BackgroundColor3 = Color3.new(0, 0, 0)
	ScrollingFrameCutter.BackgroundTransparency = 1
	ScrollingFrameCutter.BorderSizePixel = 0
	ScrollingFrameCutter.ZIndex = 9
	ScrollingFrameCutter.ClipsDescendants = true
	
	local MsgContainer = Instance.new("TextLabel", ScrollingFrameCutter)
	MsgContainer.Name = "MsgContainer"
	MsgContainer.Size = UDim2.new(1, 0, 999, 0)
	MsgContainer.BackgroundColor3 = Color3.new(0.20784315466881, 0.20784315466881, 0.20784315466881)
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
	
	local MsgStrips = {}
	
	for a in text:gmatch("[^\n]+") do
		local Msg = Instance.new("TextLabel", MsgContainer)
		Msg.Name = "Msg"..(#MsgStrips + 1)
		Msg.Size = UDim2.new(1, 0, 0, 20)
		Msg.Position = UDim2.new(0,0,0,#MsgStrips * 18)
		Msg.BackgroundColor3 = Color3.new(0.20784315466881, 0.20784315466881, 0.20784315466881)
		Msg.BackgroundTransparency = 1
		Msg.BorderSizePixel = 0
		Msg.Text = a
		Msg.Font = Enum.Font.Arial
		Msg.FontSize = Enum.FontSize.Size18
		Msg.TextTransparency = 1
		Msg.TextWrapped = true
		Msg.TextYAlignment = Enum.TextYAlignment.Center
		Msg.TextXAlignment = Enum.TextXAlignment.Left
		Msg.TextColor3 = Color3.new(1, 1, 1)
		Msg.ZIndex = 9
		table.insert(MsgStrips,Msg)
	end
	
	local Up = Instance.new("TextButton", ScrollGui)
	Up.Name = "Up"
	Up.Position = UDim2.new(0.94999998807907, 0, 0, 0)
	Up.Size = UDim2.new(0.050000000745058, 0, 0.050000000745058, 0)
	Up.BackgroundColor3 = Color3.new(1, 1, 1)
	Up.BackgroundTransparency = 0.85000002384186
	Up.Text = "^"
	Up.Font = Enum.Font.ArialBold
	Up.FontSize = Enum.FontSize.Size36
	Up.TextStrokeTransparency = 0.75
	Up.TextYAlignment = Enum.TextYAlignment.Top
	Up.TextColor3 = Color3.new(1, 1, 1)
	Up.ZIndex = 10
	Up.MouseButton1Click:connect(function()
		if MsgContainer.Parent == nil then
			return
		end
		local asds = MsgContainer.Position.Y.Scale+0.5
		if asds > 0 then
			asds = 0
		end
		MsgContainer:TweenPosition(UDim2.new(0,0,asds,0),nil,"Quint",tweentime*0.75,true)
	end)
	
	local Down = Instance.new("TextButton", ScrollGui)
	Down.Name = "Down"
	Down.Position = UDim2.new(0.94999998807907, 0, 0.94999998807907, 0)
	Down.Size = UDim2.new(0.050000000745058, 0, 0.050000000745058, 0)
	Down.BackgroundColor3 = Color3.new(1, 1, 1)
	Down.BackgroundTransparency = 0.85000002384186
	Down.Text = "v"
	Down.Font = Enum.Font.ArialBold
	Down.FontSize = Enum.FontSize.Size24
	Down.TextStrokeTransparency = 0.75
	Down.TextColor3 = Color3.new(1, 1, 1)
	Down.ZIndex = 10
	Down.MouseButton1Click:connect(function()
		if MsgContainer.Parent == nil then
			return
		end
		MsgContainer:TweenPosition(UDim2.new(0,0,MsgContainer.Position.Y.Scale-0.5,0),nil,"Quint",tweentime*0.75,true)
	end)
	
	local Title = Instance.new("TextLabel", ScrollGui)
	Title.Name = "Title"
	Title.Position = UDim2.new(0, 0, 0.025000000372529, 0)
	Title.Size = UDim2.new(1, 0, 0.10000000149012, 0)
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
	
	local Close = Instance.new("TextButton", ScrollGui)
	Close.Name = "Close"
	Close.Position = UDim2.new(0, 0, 0, 0)
	Close.Size = UDim2.new(0.050000000745058, 0, 0.050000000745058, 0)
	Close.BackgroundColor3 = Color3.new(1, 1, 1)
	Close.BackgroundTransparency = 0.85000002384186
	Close.Text = "X"
	Close.Font = Enum.Font.ArialBold
	Close.FontSize = Enum.FontSize.Size24
	Close.TextStrokeTransparency = 0.75
	Close.TextYAlignment = Enum.TextYAlignment.Top
	Close.TextColor3 = Color3.new(1, 1, 1)
	Close.ZIndex = 10
	
	Close.MouseButton1Click:connect(function()
		if MsgContainer == nil or MsgContainer.Parent == nil then
			return
		end
		ScrollGui:TweenSizeAndPosition(UDim2.new(0,250,0,250),UDim2.new(0.5,-125,0.5,-125),nil,"Quint",tweentime,true)
		TweenBackgroundTransparency(ScrollGui,0.45,1,tweentime*0.4)
		TweenBackgroundTransparency(Up,0.85,1,tweentime*0.4)
		TweenBackgroundTransparency(Down,0.85,1,tweentime*0.4)
		TweenBackgroundTransparency(Close,0.85,1,tweentime*0.4)

		TweenTextTransparency(Up,0,1,tweentime*0.35)
		TweenTextTransparency(Down,0,1,tweentime*0.35)
		TweenTextTransparency(Close,0,1,tweentime*0.35)
		
		TweenTextTransparency(Title,0,1,tweentime*0.35)
		
		for _,i in pairs(MsgStrips) do
			TweenTextTransparency(i,0,1,tweentime*0.35)
		end
		
		wait(tweentime)
		ScrollGui.Visible = false
		Gui:FindFirstChild("Msg").Visible = ReenableMsg
	end)
	
	ScrollGui:TweenSizeAndPosition(UDim2.new(0,500,0,500),UDim2.new(0.5,-250,0.5,-250),nil,"Quint",tweentime,true)
	TweenBackgroundTransparency(ScrollGui,1,0.45,tweentime*0.45)
	TweenBackgroundTransparency(Up,1,0.85,tweentime*0.5)
	TweenBackgroundTransparency(Down,1,0.85,tweentime*0.5)
	TweenBackgroundTransparency(Close,1,0.85,tweentime*0.5)
	
	TweenTextTransparency(Up,1,0,tweentime*0.6)
	TweenTextTransparency(Down,1,0,tweentime*0.6)
	TweenTextTransparency(Close,1,0,tweentime*0.6)
	
	TweenTextTransparency(Title,1,0,tweentime*0.6)
	
	for _,i in pairs(MsgStrips) do
		TweenTextTransparency(i,1,0,tweentime*0.6)
	end
	
	ScrollGui.Visible = true
	
	return ScrollGui
end


function DisplayMessage(player,title,text,displaytime)
	if player == ROOT or player == "ROOT" or player == nil then
		return
	end
	Spawn(function()
		local text,title = text,title
		local pgui = player:FindFirstChild("PlayerGui")
		if not pgui then
			for _,i in pairs(player:GetChildren()) do
				if i:IsA("PlayerGui") then
					pgui = i
				end
			end
		end
		if not pgui:FindFirstChild("Admi") or not pgui:FindFirstChild("Admi"):FindFirstChild("Msg") then
			MakeMsgGui(player)
		end
		--[[if not pgui:FindFirstChild("Admi"):IsA("ScreenGui") or not message:IsA("Frame") or not message.Msg:IsA("TextLabel") or not message.Title:IsA("TextLabel") then
			MakeMsgGui(player)
		end]]
		local message = player:WaitForChild("PlayerGui"):FindFirstChild("Admi"):FindFirstChild("Msg")
		if title == nil then
			title = "Message"
		end
		if text == nil then
			text = title
			title = "Message"
		end
		message.Title.Text = "[ Content Deleted ]"
		message.Msg.Text = "[ Content Deleted ]"
		message.Title.Text = tostring(title)
		message.Msg.Text = tostring(text)
		message.Position = UDim2.new(0.5,-125,0.5,-75)
		message.Size = UDim2.new(0,250,0,150)
		TweenTextTransparency(message.Title,1,0,tweentime*0.65)
		TweenTextTransparency(message.Msg,1,0,tweentime*0.65)
		TweenBackgroundTransparency(message,1,0.45,tweentime*0.5)
		wait()
		message:TweenSizeAndPosition(UDim2.new(0,500,0,300),UDim2.new(0.5,-250,0.5,-150),nil,"Quint",tweentime,true,function()end)
		message.Visible = true
		wait(tweentime)
		if displaytime ~= nil then
			Delay(displaytime,function()if message.Msg.Text == tostring(text)then DismissMessage(player)end end)
		end
	end)
end

function DisplayMessageAll(title,text,displaytime)
	for _,i in pairs(Players:GetPlayers()) do
		DisplayMessage(i,title,text,displaytime)
	end
end

function DismissMessageAll()
	for _,i in pairs(Players:GetPlayers()) do
		DismissMessage(i)
	end
end
	
function DismissMessage(player)
	if player == ROOT or player == "ROOT" then
		return
	end
	if not player:WaitForChild("PlayerGui"):FindFirstChild("Admi") or not player:WaitForChild("PlayerGui"):FindFirstChild("Admi"):FindFirstChild("Msg") then
		MakeMsgGui(player)
	end
	local message = player:WaitForChild("PlayerGui"):FindFirstChild("Admi"):FindFirstChild("Msg")
	TweenBackgroundTransparency(message,0.45,1,tweentime*0.5)
	TweenTextTransparency(message.Title,0,1,tweentime*0.22)
	TweenTextTransparency(message.Msg,0,1,tweentime*0.22)
	message:TweenSizeAndPosition(UDim2.new(0,0,0,0),--[[UDim2.new(0,250,0,150),UDim2.new(0.5,-125,0.5,-75)]]UDim2.new(0.5,0,0.5,0),nil,"Quint",tweentime*2.5,true,function()message.Visible = false end)
end

function MakeAdmiGui(parent)
	if parent == "ROOT" or parent == ROOT then
		return
	end
	local Gui = Instance.new("ScreenGui",parent)
	Gui.Name = "Admi"
	return Gui
end

function MakeTellGui(parent)
	if parent == "ROOT" or parent == ROOT then
		return
	end
	local Gui = parent:FindFirstChild("Admi")
	if not Gui then
		Gui = MakeAdmiGui(parent)
	end
	local Bar = Instance.new("TextLabel",Gui)
	Bar.Name = "Message"
	Bar.BackgroundColor3 = Color3.new(0,0,0)
	Bar.BackgroundTransparency = 0.35
	Bar.BorderSizePixel = 0
	Bar.Font = "ArialBold"
	Bar.FontSize = "Size18"
	Bar.Text = "Message"
	Bar.TextStrokeTransparency = 0.5
	Bar.TextColor3 = Color3.new(1,1,1)
	Bar.Size = UDim2.new(1,0,0,30)
	Bar.Position = UDim2.new(0,0,0,-30)
	return Gui
end

function Tell(player,msg,length)
	if player == "ROOT" or player == ROOT then
		return
	end
	local length = length
	if length == nil then
		length = 3
	end
	local PlayerGui = player:WaitForChild("PlayerGui")
	if not PlayerGui:FindFirstChild("Admi") or not PlayerGui:FindFirstChild("Admi"):FindFirstChild("Message") then
		MakeTellGui(PlayerGui)
	end
	PlayerGui:FindFirstChild("Admi"):FindFirstChild("Message").Text = msg
	PlayerGui:FindFirstChild("Admi"):FindFirstChild("Message").Position = UDim2.new(0,0,0,-30)
	PlayerGui:FindFirstChild("Admi"):FindFirstChild("Message"):TweenPosition(UDim2.new(0,0,0,0),nil,tweenstyle,tweentime,true)
	Delay(length,function()
		if PlayerGui:FindFirstChild("Admi"):FindFirstChild("Message").Text == msg then
			PlayerGui:FindFirstChild("Admi"):FindFirstChild("Message"):TweenPosition(UDim2.new(0,0,0,-30),nil,tweenstyle,tweentime,true)
		end
	end)
end

function TellAll(msg,length)
	for _,i in pairs(Players:GetPlayers()) do
		Tell(i,msg,length)
	end
end

function TellAdmins(msg,length)
	for _,i in pairs(Players:GetPlayers()) do
		if Permissions[i.Name] and Permissions[i.Name] > 0 then
			Tell(i,msg,length)
		end
	end
end

rawunpack = unpack

function unpack(oldtab)
	assert(oldtab,"u wot m8")
	local new = ""
	local tab = {}
	for i = 1, #oldtab do
		table.insert(tab,tostring(oldtab[i]))
	end
	table.sort(tab)
	for i = 1, #tab do
		new = new..tostring(tab[i])..", "
	end
	new = new:sub(1,#new-2)
	return new
end

function stringtobool(str)
	if str:lower() == "yes" or str:lower() == "on" or str:lower() == "ye" or str:lower() == "yea" or str:lower() == "yeah" or str:lower() == "yep" or str == "true" then
		return true
	elseif str:lower() == "no" or str:lower() == "off" or str:lower() == "nop" or str:lower() == "nope" or str:lower() == "nah" or str:lower() == "na" or str:lower() == "false" then
		return false
	end
end

if not script:FindFirstChild("ADMIN_ENCODED_SOURCE") then
	DisplayMessageAll("AdminScriptCreatorSecurity","ADMIN_ENCODED_SOURCE isn't present in the script. The "..script.className:lower().." has not been executed.",5)
	return
end

if not script:FindFirstChild("ADMIN_SCRIPT_SIGNATURE") then
	DisplayMessageAll("AdminScriptCreatorSecurity","ADMIN_SCRIPT_SIGNATURE isn't present in the script. The "..script.className:lower().." has not been executed.",5)
	return
end

Source = script:FindFirstChild("ADMIN_ENCODED_SOURCE").Value
Signature = script:FindFirstChild("ADMIN_SCRIPT_SIGNATURE").Value

local signaturecheck1 = Signature
local signaturecheck2 = CodeSignCache[Source] or sha1.hex(Source)

if signaturecheck1 ~= signaturecheck2 then
	DisplayMessageAll("AdminScriptCreatorSecurity","The code signature provided is invalid. The "..script.className:lower().." has not been executed.",5)
	return
end

print("Signature correct! Yay!")

local Source = Source

local exe,err = loadstring("local exe = nil\n"..Source)

if not exe then
	DisplayMessageAll(script.className.." Executer","The "..script.className:lower().." that tried to be executed encountered a syntax error:\n\n"..tostring(err),7)
	return
end

local ok,err = ypcall(function()
	local Source,Signature,signaturecheck1,signaturecheck2,Source,err = nil
	exe()
end)

if not ok then
	DisplayMessageAll(script.className.." Executer","The "..script.className:lower().." that was executed encountered a runtime error:\n\n"..tostring(err),7)
end

end)
