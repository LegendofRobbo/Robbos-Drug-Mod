Drugmod_Config = {
	["Overdose Threshold"] = 3, -- more than 3 active drugs will cause you to overdose and die, set to 0 for unlimited drug effects
	["Max Drug Duration"] = 240, -- a generic max duration setting for all drugs, default = 240 / 4 minutes
}

Drugmod_Buffs = {

	["Weed"] = {
		ItemName = "Weed",
		Description = "Duuuuude",
		Col = Color(155, 255, 155),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) end,
		Terminate = function(ply) end,
		Iterate = function( ply, duration ) ply:SetHealth(math.Clamp(ply:Health() + 1, 0, ply:GetMaxHealth() ) ) end,
		ColorModify = {
			["$pp_colour_addr"] = 0,
			["$pp_colour_addg"] = 0,
			["$pp_colour_addb"] = 0,
			["$pp_colour_brightness"] = 0,
			["$pp_colour_contrast"] = 1.5,
			["$pp_colour_colour"] = 1.5,
			["$pp_colour_mulr"] = 0,
			["$pp_colour_mulg"] = 0,
			["$pp_colour_mulb"] = 0
		},
		Illegal = true,
--		SobelEffect = 20,
	},

	["HealthRecovery"] = {
		ItemName = "Health Recovery",
		Description = "You feel healthy!",
		Col = Color(55, 255, 55),
		MaxDuration = Drugmod_Config["Max Drug Duration"] / 6 or 30,
		Initialize = function(ply) end,
		Terminate = function(ply) end,
		Iterate = function( ply, duration ) ply:SetHealth(math.Clamp(ply:Health() + 5, 0, ply:GetMaxHealth() ) ) end,
	},

	["DoubleJump"] = {
		ItemName = "Bouncer",
		Description = "You can jump again in midair",
		Col = Color(255, 255, 55),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) end,
		Terminate = function(ply) end,
		Iterate = function( ply, duration ) end,
	},

	["Volatile"] = {
		ItemName = "Volatile Blood",
		Description = "Explode upon death",
		Col = Color(255, 85, 55),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) end,
		Terminate = function(ply) end,
		Iterate = function( ply, duration ) if ply:Health() < 2 then ply:Kill() else ply:SetHealth(math.Clamp(ply:Health() - 2, 0, ply:GetMaxHealth() ) ) end end,
		Illegal = true,
	},

	["Dextradose"] = {
		ItemName = "Dextradose",
		Description = "40% faster lockpicking",
		Col = Color(155, 55, 155),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) end,
		Terminate = function(ply) end,
		Iterate = function( ply, duration ) end,
		Illegal = true,
	},

	["Steroids"] = {
		ItemName = "Steroids",
		Description = "20% faster run speed",
		Col = Color(255, 125, 125),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) end,
		InitializeOnce = function(ply) ply:SetRunSpeed(ply:GetRunSpeed() * 1.2) end,
		Terminate = function(ply) ply:SetRunSpeed(GAMEMODE.Config.runspeed) end,
		Iterate = function( ply, duration ) end,
		Illegal = true,
	},

	["Vampire"] = {
		ItemName = "Haemophage",
		Description = "Leech enemies life force",
		Col = Color(195, 55, 55),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) end,
		Terminate = function(ply) end,
		Iterate = function( ply, duration ) end,
		Illegal = true,
	},

	["Painkillers"] = {
		ItemName = "Painkillers",
		Description = "20% damage resist",
		Col = Color(205, 205, 255),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) end,
		Terminate = function(ply) end,
		Iterate = function( ply, duration ) end,
	},

	["Drunk"] = {
		ItemName = "Drunk",
		Description = "You are having a gooood time",
		Col = Color(55, 55, 255),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) end,
		Terminate = function(ply) end,
		Iterate = function( ply, duration ) end,
	},

	["Gunslinger"] = {
		ItemName = "Gunslinger",
		Description = "25% increased gun damage",
		Col = Color(255, 155, 55),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) end,
		Terminate = function(ply) end,
		Iterate = function( ply, duration ) end,
		Illegal = true,
	},

	["Muscle Relaxant"] = {
		ItemName = "Muscle Relaxant",
		Description = "Greatly reduced impact damage",
		Col = Color(255, 155, 255),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) end,
		Terminate = function(ply) end,
		Iterate = function( ply, duration ) end,
	},

	["Meth"] = {
		ItemName = "Crystal Meth",
		Description = "Fists of fury!",
		Col = Color(5, 185, 245),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) end,
		Terminate = function(ply) end,
		Iterate = function( ply, duration ) end,
		ColorModify = {
			["$pp_colour_addr"] = 0,
			["$pp_colour_addg"] = 0,
			["$pp_colour_addb"] = 0.1,
			["$pp_colour_brightness"] = 0,
			["$pp_colour_contrast"] = 1.3,
			["$pp_colour_colour"] = 1,
			["$pp_colour_mulr"] = 0,
			["$pp_colour_mulg"] = 0,
			["$pp_colour_mulb"] = 0
		},
		MotionBlur = { 0.3, 0.8, 0.01 },
		Illegal = true,
	},

	["Pingaz"] = {
		ItemName = "Pingaz",
		Description = "Get your bounce on",
		Col = Color(255, 225, 5),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) 
			local playerClass = baseclass.Get(player_manager.GetPlayerClass(ply))
			ply:SetJumpPower(playerClass.JumpPower * 1.5) 
		end,
		Terminate = function(ply)
		 	local playerClass = baseclass.Get(player_manager.GetPlayerClass(ply))
			ply:SetJumpPower(playerClass.JumpPower)  
		end,
		Iterate = function( ply, duration ) end,
		ColorModify = {
			["$pp_colour_addr"] = 0.1,
			["$pp_colour_addg"] = 0,
			["$pp_colour_addb"] = 0.1,
			["$pp_colour_brightness"] = 0,
			["$pp_colour_contrast"] = 1.5,
			["$pp_colour_colour"] = 2,
			["$pp_colour_mulr"] = 0,
			["$pp_colour_mulg"] = 0,
			["$pp_colour_mulb"] = 0
		},
		Sharpen = { 1.2, 1.2 },
		Illegal = true,
	},

	["Preserver"] = {
		ItemName = "Life Preserver",
		Description = "Save yourself from lethal damage",
		Col = Color(150, 255, 195),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) end,
		Terminate = function(ply) end,
		Iterate = function( ply, duration ) end,
	},

	["Vaporwave"] = {
		ItemName = "Vaporwave",
		Description = "You feel ａｅｓｔｈｅｔｉｃ ａｓ ｆｕｃｋ",
		Col = Color(250, 95, 250),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) ply:SendLua( [[Drugmod_VWMusic( true )]] ) end,
		Terminate = function(ply) ply:SendLua( [[Drugmod_VWMusic( false )]] ) end,
		Iterate = function( ply, duration ) end,
	},

	["Overdose"] = {
		ItemName = "Overdose",
		Description = "Now you fucked up!",
		Col = Color(255, 0, 0),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) ply:EmitSound("vo/npc/male01/moan0"..math.random(1,5)..".wav") end,
		Terminate = function(ply) end,
		Iterate = function( ply, duration ) 
			local d = DamageInfo()
			d:SetDamage( 5 )
			d:SetDamageType( DMG_PARALYZE )
			d:SetAttacker( game.GetWorld() )
			d:SetInflictor( game.GetWorld() )
			ply:TakeDamageInfo( d )
		if math.random(1,10) > 8 then ply:EmitSound("vo/npc/male01/moan0"..math.random(1,5)..".wav") end 
		end,
		ColorModify = {
			["$pp_colour_addr"] = 0,
			["$pp_colour_addg"] = 0,
			["$pp_colour_addb"] = 0,
			["$pp_colour_brightness"] = 0,
			["$pp_colour_contrast"] = 1,
			["$pp_colour_colour"] = 0.2,
			["$pp_colour_mulr"] = 5,
			["$pp_colour_mulg"] = 0,
			["$pp_colour_mulb"] = 0
		},
		MotionBlur = { 0.4, 0.8, 0.01 },
	},

	["Nicotine"] = {
		ItemName = "Nicotine",
		Description = "You feel relaxed",
		Col = Color(80, 80, 80),
		MaxDuration = Drugmod_Config["Max Drug Duration"] or 180,
		Initialize = function(ply) end,
		Terminate = function(ply) end,
		Iterate = function( ply, duration ) end,
		ColorModify = {
			["$pp_colour_addr"] = 0,
			["$pp_colour_addg"] = 0,
			["$pp_colour_addb"] = 0,
			["$pp_colour_brightness"] = 0,
			["$pp_colour_contrast"] = 0.95,
			["$pp_colour_colour"] = 0.95,
			["$pp_colour_mulr"] = 0,
			["$pp_colour_mulg"] = 0,
			["$pp_colour_mulb"] = 0
		},
		Sharpen = { 1.1, 1.1 },
	},


}

local function DMOD_DoPlayerDeath( ply, attacker, dmg )
	if ply:HasBuff( "Volatile" ) then
	local pos = ply:GetPos()
	timer.Simple( 0.3, function()
	util.BlastDamage( ply, ply, pos, 350, 125 )

	local effectdata = EffectData()
		effectdata:SetOrigin(pos)
	util.Effect("Explosion", effectdata)
	ply:ClearBuffs()
	end)
	end
end
hook.Add("DoPlayerDeath", "DMOD_DoPlayerDeath", DMOD_DoPlayerDeath)