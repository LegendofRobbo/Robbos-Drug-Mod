include("shared.lua")

function ENT:Draw()
    self.Entity:DrawModel()
end

local function wewlad()

local EMenu = vgui.Create("DFrame")
EMenu:SetSize(500,455)
EMenu:SetTitle("Drug Lab Menu")
EMenu:Center()
EMenu:MakePopup()

EMenu.Paint = function( self, w, h )
surface.SetDrawColor( Color( 0, 0, 0, 240 ) )
surface.DrawRect( 0, 0, w, h )
end


end
concommand.Add("testmenu", wewlad )