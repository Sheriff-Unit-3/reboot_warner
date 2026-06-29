-- Simple reboot warning mod
local ie = core.request_insecure_environment()
local timer = 0
local warning_file = core.get_worldpath() .. "/reboot_warning"
local S = core.get_translator("reboot_warner")

core.register_globalstep(function(_)
	if timer > 600 then -- 600 tenths = 1 minute
		timer = 0
		local f = io.open(warning_file, "r")
		if f then
			io.close(f)
			ie.os.remove(warning_file)
			for _, player in ipairs(core.get_connected_players()) do
				local playername = player:get_player_name()
				if playername then
					notice.send(
						playername,
						S(
							"*** IMPORTANT NOTICE: | The server will be | rebooting for its nightly | backup in a few minutes!"
						)
					)
					core.log("Issued reboot warning to " .. playername)
				end
			end
		end
	end
	timer = timer + 1
end)
