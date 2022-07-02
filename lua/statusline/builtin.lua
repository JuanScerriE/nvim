local builtin = {}

--	f S   Path to the file in the buffer, as typed or relative to current
--	      directory.
builtin.rel_path = "%f"

--	F S   Full path to the file in the buffer.
builtin.abs_path = "%F"

--	t S   File name (tail) of file in the buffer.
builtin.filename = "%t"

--	m F   Modified flag, text is "[+]"; "[-]" if 'modifiable' is off.
builtin.modified = "%m"

--	M F   Modified flag, text is ",+" or ",-".
builtin.modified_list = "%M"

--	r F   Readonly flag, text is "[RO]".
builtin.readonly = "%r"

--	R F   Readonly flag, text is ",RO".
builtin.readonly_list = "%R"

--	h F   Help buffer flag, text is "[help]".
builtin.help = "%h"

--	H F   Help buffer flag, text is ",HLP".
builtin.help_list = "%H"

--	w F   Preview window flag, text is "[Preview]".
builtin.preview = "%w"

--	W F   Preview window flag, text is ",PRV".
builtin.preview_list = "%W"

--	y F   Type of file in the buffer, e.g., "[vim]".  See 'filetype'.
builtin.filetype = "%y"

--	Y F   Type of file in the buffer, e.g., ",VIM".  See 'filetype'.
builtin.filetype_capital = "%Y"

--	q S   "[Quickfix List]", "[Location List]" or empty.
builtin.quickfix = "%q"

--	k S   Value of "b:keymap_name" or 'keymap' when |:lmap| mappings are
-- 	      being used: "<keymap>"
builtin.keymap = "%k"

--	n N   Buffer number.
builtin.buff_num = "%n"

--	b N   Value of character under cursor.
builtin.char_value = "%b"

--	B N   As above, in hexadecimal.
builtin.char_value_hex = "%b"

--	o N   Byte number in file of byte under cursor, first byte is 1.
--	      Mnemonic: Offset from start of file (with one added)
builtin.byte_num = "%o"

--	O N   As above, in hexadecimal.
builtin.byte_num_hex = "%O"

--	N N   Printer page number.  (Only works in the 'printheader' option.)
builtin.page_num = "%N"

--	l N   Line number.
builtin.line = "%l"

--	L N   Number of lines in buffer.
builtin.last_line = "%L"

--	c N   Column number (byte index).
builtin.column = "%c"

--	v N   Virtual column number (screen column).
builtin.column_virt = "%v"

--	P S   Percentage through file of displayed window.  This is like the
--	      percentage described for 'ruler'.  Always 3 in length, unless
--	      translated.
builtin.percentage = "%P"

--  %-0{width}l
builtin.line_with_width = function(width)
	return "%-0" .. width .. "l"
end

--  %-0{width}c
builtin.column_with_width = function(width)
	return "%-0" .. width .. "c"
end

return builtin
