local M = {}

--	f S   Path to the file in the buffer, as typed or relative to current
--	      directory.
M.rel_path = "%f"

--	F S   Full path to the file in the buffer.
M.abs_path = "%F"

--	t S   File name (tail) of file in the buffer.
M.filename = "%t"

--	m F   Modified flag, text is "[+]"; "[-]" if 'modifiable' is off.
M.modified = "%m"

--	M F   Modified flag, text is ",+" or ",-".
M.modified_list = "%M"

--	r F   Readonly flag, text is "[RO]".
M.readonly = "%r"

--	R F   Readonly flag, text is ",RO".
M.readonly_list = "%R"

--	h F   Help buffer flag, text is "[help]".
M.help = "%h"

--	H F   Help buffer flag, text is ",HLP".
M.help_list = "%H"

--	w F   Preview window flag, text is "[Preview]".
M.preview = "%w"

--	W F   Preview window flag, text is ",PRV".
M.preview_list = "%W"

--	y F   Type of file in the buffer, e.g., "[vim]".  See 'filetype'.
M.filetype = "%y"

--	Y F   Type of file in the buffer, e.g., ",VIM".  See 'filetype'.
M.filetype_capital = "%Y"

--	q S   "[Quickfix List]", "[Location List]" or empty.
M.quickfix = "%q"

--	k S   Value of "b:keymap_name" or 'keymap' when |:lmap| mappings are
-- 	      being used: "<keymap>"
M.keymap = "%k"

--	n N   Buffer number.
M.buff_num = "%n"

--	b N   Value of character under cursor.
M.char_value = "%b"

--	B N   As above, in hexadecimal.
M.char_value_hex = "%b"

--	o N   Byte number in file of byte under cursor, first byte is 1.
--	      Mnemonic: Offset from start of file (with one added)
M.byte_num = "%o"

--	O N   As above, in hexadecimal.
M.byte_num_hex = "%O"

--	N N   Printer page number.  (Only works in the 'printheader' option.)
M.page_num = "%N"

--	l N   Line number.
M.line = "%l"

--	L N   Number of lines in buffer.
M.last_line = "%L"

--	c N   Column number (byte index).
M.column = "%c"

--	v N   Virtual column number (screen column).
M.column_virt = "%v"

--	P S   Percentage through file of displayed window.  This is like the
--	      percentage described for 'ruler'.  Always 3 in length, unless
--	      translated.
M.percentage = "%P"

--	< -   Where to truncate line if too long.  Default is at the start.
--        No width fields allowed.
M.truncate = "%<"

--  %-0{width}l
M.line_with_width = function(width)
	return "%-0" .. width .. "l"
end

--  %-0{width}c
M.column_with_width = function(width)
	return "%-0" .. width .. "c"
end

return M
