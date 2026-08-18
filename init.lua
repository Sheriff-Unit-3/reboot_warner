-- Simple reboot warning mod
local ie = core.request_insecure_environment()
local timer = 0
local warning_file = core.get_worldpath() .. "/reboot_warning"

-- function below is from notice by kaeza under CC0
-- https://github.com/kaeza/minetest-kaeza_misc/blob/master/notice/init.lua#L4-L34
local function send(target, text)
	local player = core.get_player_by_name(target)
	if not player then
		return false, ("There's no player named '%s'."):format(target)
	end
	local fs = ""
	local lines = {}
	for i, line in ipairs(text:split("|")) do
		local lt = {}
		for i2 = 1, #line, 40 do
			table.insert(lt, line:sub(i2, i2 + 39))
		end
		lines[i] = table.concat(lt, "\n")
	end
	text = core.formspec_escape(table.concat(lines, "\n"))
	table.insert(fs, "size[8,4]")
	table.insert(fs, "label[1,.2;" .. text .. "]")
	table.insert(fs, "button_exit[3,3.2;2,0.5;ok;OK]")
	fs = table.concat(fs)
	core.after(0.5, function()
		core.show_formspec(target, "notice:notice", fs)
	end)
	return true
end

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
					send(
						playername,
						"*** IMPORTANT NOTICE: | The server will be | rebooting for its nightly | backup in a few minutes!"
					)
					core.log("Issued reboot warning to " .. playername)
				end
			end
		end
	end
	timer = timer + 1
end)
