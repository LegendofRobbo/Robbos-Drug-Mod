util.AddNetworkString("UpdateBuffs")
util.AddNetworkString("SendBuffs")

resource.AddFile( "memes/shitmemes.mp3" )


--Drugmod_Buffs = {}

-- this is c+p from my populi gamemode, please for the love of god do not run this addon on a populi server or you'll screw everything up
local plymeta = FindMetaTable("Player")

function plymeta:AddBuff( buff, duration )
if !self:IsValid() or !self:Alive() then return end
if !Drugmod_Buffs[buff] then ErrorNoHalt( "Drugmod Error: attempting to give "..self:Nick().." an invalid drug effect: "..buff.."\n" ) return end
--if self:HasBuff( "Overdose" ) then return end

if self.Buffs[buff] then self.Buffs[buff] = math.Clamp(self.Buffs[buff] + duration, CurTime(), CurTime() + Drugmod_Buffs[buff].MaxDuration ) else
self.Buffs[buff] = math.Clamp(CurTime() + duration, CurTime(), CurTime() + Drugmod_Buffs[buff].MaxDuration )
if Drugmod_Buffs[buff].InitializeOnce then 
--	Drugmod_Buffs[buff].InitializeOnce( self ) 
	local s, e = pcall( Drugmod_Buffs[buff].InitializeOnce, self )
	if !s then print("Drugmod InitializeOnce error in buff: "..k.." on player "..self:Nick().." : "..e) end
end
end

--Drugmod_Buffs[buff].Initialize( self )

local s, e = pcall( Drugmod_Buffs[buff].Initialize, self )
if !s then print("Drugmod Initialize error in buff: "..k.." on player "..self:Nick().." : "..e) end

self:CheckOverdose()

net.Start("UpdateBuffs")
net.WriteTable(self.Buffs)
net.Send(self)

end

function plymeta:RemoveBuff( buff )
if !self:IsValid() or !self:Alive() then return end
if !Drugmod_Buffs[buff] then ErrorNoHalt( "Drugmod Error: attempting to remove invalid buff from "..self:Nick().."\n" ) return end

if self.Buffs[buff] then self.Buffs[buff] = nil end

net.Start("UpdateBuffs")
net.WriteTable(self.Buffs)
net.Send(self)

end

function plymeta:ClearBuffs()

if self.Buffs then
	for k, v in pairs( self.Buffs ) do
		if isfunction(Drugmod_Buffs[k].Terminate) then
			local s, e = pcall( Drugmod_Buffs[k].Terminate, self, v - CurTime() )
		end
	end
end

self.Buffs = {}
net.Start("UpdateBuffs")
net.WriteTable(self.Buffs)
net.Send(self)
end

function plymeta:HasBuff( name )
if self.Buffs[name] then return true else return false end
end

function plymeta:CountBuffs()
local i = 0
	for k, v in pairs(self.Buffs) do
		i = i + 1
	end
return i
end

function plymeta:CheckOverdose()
if Drugmod_Config["Overdose Threshold"] < 1 then return end

if self:CountBuffs() > Drugmod_Config["Overdose Threshold"] then
	self:ClearBuffs()
	self:AddBuff( "Overdose", 30 )	
end


end

hook.Add("PlayerDeath", "NoFunAllowedAfterYouDie", function( ply ) ply:ClearBuffs() end)
hook.Add("PlayerSpawn", "CopyPastedHook1", function( ply ) ply:ClearBuffs() end)
hook.Add("PlayerInitialSpawn", "CopyPastedHook2", function( ply ) ply:ClearBuffs() end)

local function BuffsLogic()
for _, ply in pairs(player.GetAll()) do

	if !ply.Buffs then ply.Buffs = {} continue end

	for k, v in pairs(ply.Buffs) do
		if isfunction(Drugmod_Buffs[k].Iterate) then
		local s, e = pcall( Drugmod_Buffs[k].Iterate, ply, v - CurTime() )
		if !s then print("Drugmod iterate error in buff: "..k.." on player "..ply:Nick().." : "..e) end
		end

		if v <= CurTime() then
			ply.Buffs[k] = nil  -- delete the buff from their active buffs table
			local s, e = pcall( Drugmod_Buffs[k].Terminate, ply ) -- run the end of buff function
			if !s then print("Drugmod terminate error in buff: "..k.." on player "..ply:Nick().." : "..e) end
		end
	end

	net.Start("UpdateBuffs")
	net.WriteTable(ply.Buffs)
	net.Send(ply)

end

end
timer.Create("drugmod_bufflogic", 1, 0, BuffsLogic)




hook.Add("SetupMove", "DoubleJumpHook", function(ply, cmd)
	if !ply:HasBuff( "DoubleJump" ) then return end

	if ply:OnGround() then ply:SetNWInt("jumplevel", 0) return end
	if !cmd:KeyPressed(IN_JUMP) then return end

	ply:SetNWInt("jumplevel", ply:GetNWInt("jumplevel") + 1 )

	if ply:GetNWInt("jumplevel") > 1 then return end

	local vel = ply:GetVelocity()

	vel.z = ply:GetJumpPower() * 1.2

	cmd:SetVelocity(vel)

	ply:DoCustomAnimEvent(PLAYERANIMEVENT_JUMP , -1)
end)

local function DMOD_TakeDamage( ent, dmg )
	if ent:IsPlayer() then
		local atk = dmg:GetAttacker()
		local amt = dmg:GetDamage()
		local hp = ent:Health()

		if atk:IsValid() and atk:IsPlayer() and atk:Alive() then

			if atk:HasBuff( "Gunslinger" ) and dmg:IsBulletDamage() then
				dmg:ScaleDamage( 1.25 )
			end

			if atk:HasBuff( "Meth" ) and atk:GetActiveWeapon():GetClass() == "weapon_fists" then
				dmg:ScaleDamage( 2.5 )
			end

			if atk:HasBuff( "Vampire" ) then
				atk:SetHealth(math.Clamp(atk:Health() + amt / 4, 0, atk:GetMaxHealth() ) )
			end

			if ent:HasBuff( "Painkillers" ) and !dmg:IsFallDamage() and dmg:GetDamageType() != DMG_DROWN then
				dmg:ScaleDamage( 0.8 )
			end

			if ent:HasBuff( "Drunk" ) and !dmg:IsFallDamage() and dmg:GetDamageType() != DMG_DROWN then
				dmg:ScaleDamage( 0.9 )
			end

		end

		if ent:HasBuff( "Muscle Relaxant" ) and ( dmg:IsFallDamage() or dmg:GetDamageType() == DMG_VEHICLE or dmg:GetDamageType() == DMG_CRUSH ) then
			dmg:ScaleDamage( 0.5 )
			dmg:SubtractDamage( 20 )
		end

		if ent:HasBuff( "Preserver" ) and hp - amt < 1 then
			ent:EmitSound( "items/gift_drop.wav", 80, 100 )
			dmg:ScaleDamage( 0 )
			dmg:SetDamage( 0 )
			ent:SetHealth( 25 )
			ent:RemoveBuff( "Preserver" )

			for i = 1, 6 do
				local effectdata = EffectData()
				effectdata:SetOrigin( ent:GetPos() + Vector( math.random( -10, 10), math.random( -10, 10), math.random( 0, 60) ) )
				util.Effect( "cball_bounce", effectdata )
			end

		end

	end
end
hook.Add("EntityTakeDamage", "DMOD_TakeDamage", DMOD_TakeDamage)

hook.Add("lockpickTime", "DMOD_lockpickmod", function( ply, ent )
	if ply and ply:IsValid() and ply:HasBuff( "Dextradose" ) then return util.SharedRandom("FAGGOT_"..ent:EntIndex(),8,15) end
end)

hook.Add( "OnPlayerChangedTeam", "DM_fixjobchange", function(ply) ply:ClearBuffs() end)