local DesyncLibrary = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local plr = Players.LocalPlayer

local desyncOn = false
local desyncChair = nil

local function setTransparency(char, val)
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
            p.Transparency = val
        end
    end
end

local function createDesyncChair(char)
    if desyncChair then
        desyncChair:Destroy()
    end
    
    local playerPos = char.HumanoidRootPart.Position
    desyncChair = Instance.new("Seat")
    desyncChair.Name = "desyncchair"
    desyncChair.Parent = workspace
    desyncChair.Anchored = false
    desyncChair.CanCollide = false
    desyncChair.Transparency = 1
    desyncChair.Position = playerPos + Vector3.new(0, -3, 0)
    
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if torso then
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = desyncChair
        weld.Part1 = torso
        weld.Parent = desyncChair
    end
    
    print("[DesyncChair created UNDER player at:", desyncChair.Position, "]")
end

function DesyncLibrary:Enable()
    local char = plr.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    if desyncOn then return end

    setTransparency(char, 0.5)
    local techPos = char.HumanoidRootPart.Position + Vector3.new(0, -3, 0)
    local savedCFrame = char.HumanoidRootPart.CFrame

    char:MoveTo(techPos)
    task.wait(0.15)

    createDesyncChair(char)

    char.HumanoidRootPart.CFrame = savedCFrame
    desyncOn = true
    print("[Desync Enabled - Tech point UNDER player!]")
end

function DesyncLibrary:Disable()
    local char = plr.Character
    if not char then return end
    if not desyncOn then return end

    setTransparency(char, 0)
    if desyncChair then
        desyncChair:Destroy()
        desyncChair = nil
    end
    desyncOn = false
    print("[Desync Disabled]")
end

plr.CharacterAdded:Connect(function(char)
    if desyncOn then
        task.wait(1)
        createDesyncChair(char)
    end
end)

return DesyncLibrary
