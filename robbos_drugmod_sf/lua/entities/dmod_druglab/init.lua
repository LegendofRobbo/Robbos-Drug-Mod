--local meme = {{ user_id | 25 }}
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--Called when the SENT is spawned
function ENT:Initialize()
	self:SetModel( "models/props/de_nuke/PowerPlantTank.mdl" )
 	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
 	self:SetColor( Color(255, 255, 255, 255) )
	self:SetUseType( SIMPLE_USE )
	
	local PhysAwake = self:GetPhysicsObject()
	if ( PhysAwake:IsValid() ) then
		PhysAwake:Wake()
	end 
end

function ENT:Use( activator, caller )
end