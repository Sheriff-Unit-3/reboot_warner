# Reboot Warner

[![luacheck](https://github.com/mt-mods/reboot_warner/actions/workflows/luacheck.yml/badge.svg)](https://github.com/mt-mods/reboot_warner/actions/workflows/luacheck.yml?query=branch%3Amaster)

This mod simply looks for a file periodically, which must be created by
`touch(1)` or something similar, and owned by the same user who is
running the Luanti server. This file simply serves as a sort of flag.

If found, the file is immediately deleted, and pop-up warnings are
issued to all players on the server that it will be rebooting soon.

This mod must be listed in secure.trusted_mods (assuming mod security is
enabled) in order for the `os.remove()` function to work.

The pop-up function is provided by [kaeza's notice mod](https://github.com/kaeza/minetest-kaeza_misc/blob/master/notice/init.lua#L4-L34).

## Dependencies

- Luanti/Minetest v5.2
