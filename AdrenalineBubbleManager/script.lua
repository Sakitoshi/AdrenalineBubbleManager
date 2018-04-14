--[[ 
	Adrenaline Bubble Manager VPK.
	Create and organize your direct adrenaline bubbles.
	
	Licensed by GNU General Public License v3.0
	
	Designed By:
	- Gdljjrod (https://twitter.com/gdljjrod).
	- DevDavisNunez (https://twitter.com/DevDavisNunez).
]]

--Show splash ...
splash.zoom("resources/splash.png")

dofile("system/commons.lua")
dofile("system/callbacks.lua")

if os.access() == 0 then
	if back then back:blit(0,0) end
	screen.flip()
	custom_msg(strings.unsafe,0)
	os.exit()
end

if __UPDATE then
	local wstrength = wlan.strength()
	if wstrength then
		if wstrength > 55 then dofile("git/updater.lua") end
	end
end

ADRENALINE = "ux0:app/PSPEMUCFW"
ADRENALINEK = ADRENALINE.."/sce_module/adrenaline_kernel.skprx"
ADRENALINEU = ADRENALINE.."/sce_module/adrenaline_user.suprx"
ADRENALINEV = ADRENALINE.."/sce_module/adrenaline_vsh.suprx"
oncopy = false

if game.exists("PSPEMUCFW") and files.exists(ADRENALINE) and
	files.exists(ADRENALINE.."/eboot.bin") and files.exists(ADRENALINE.."/eboot.pbp") then

	if __CHECKADR then
		if not files.exists(ADRENALINE.."/sce_module/adrbubblebooter.suprx") then
			oncopy = true
			files.copy("sce_module/", ADRENALINE)

		else

			if not files.exists(ADRENALINEK) then
				oncopy = true
				files.copy("sce_module/adrenaline_kernel.skprx", ADRENALINE.."/sce_module/")
			else
				if os.crc32(files.read(ADRENALINEK) ) != 0xA5989C79 then
					oncopy = true
					files.copy("sce_module/adrenaline_kernel.skprx", ADRENALINE.."/sce_module/")
				end
			end

			if not files.exists(ADRENALINEU) then
				oncopy = true
				files.copy("sce_module/adrenaline_user.suprx", ADRENALINE.."/sce_module/")
			else
				if os.crc32(files.read(ADRENALINEU)) != 0x759B33A9 then
					oncopy = true
					files.copy("sce_module/adrenaline_user.suprx", ADRENALINE.."/sce_module/")
				end
			end

			if not files.exists(ADRENALINEV) then
				oncopy = true
				files.copy("sce_module/adrenaline_vsh.suprx", ADRENALINE.."/sce_module/")
			else
				if os.crc32(files.read(ADRENALINEV)) != 0xBE8BAAE9 then
					oncopy = true
					files.copy("sce_module/adrenaline_vsh.suprx", ADRENALINE.."/sce_module/")
				end
			end
		end

	end--__CHECKADR

	if oncopy then
		custom_msg(strings.adrinst,0)
		os.delay(500)
		power.restart()
	end

	dofile("system/stars.lua")
	dofile("system/scan.lua")
	dofile("system/bubbles.lua")

	os.cpu(444)
		bubbles.scan()
		scan.games()
	os.cpu(333)
	scan.show()

else
	custom_msg(strings.notadr,0)
end
