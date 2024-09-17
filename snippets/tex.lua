return {
	s(
		";;tex-hdr",
		t({
			"% !TEX encoding = UTF-8 Unicode",
			"% !TEX root = main.tex",
			"% LTeX: language=en-GB",
		})
	),
	s(
		";;fig",
		fmt(
			[[
              \begin{figure}
                \centering
                \includegraphics[width=<>]{<>}
                \caption{<>}
              \end{figure}
            ]],
			{ i(1), i(2), i(3) },
			{ delimiters = "<>" }
		)
	),
	s(
		{ trig = ";;env", snippetType = "autosnippet" },
		fmt(
			[[
              \begin{<>}
                <>
              \end{<>}
            ]],
			{ i(1), i(2), rep(1) },
			{ delimiters = "<>" }
		)
	),
	s(
		";;def",
		fmt(
			[[
              \begin{definition}
                <>
              \end{definition}
            ]],
			{ i(1) },
			{ delimiters = "<>" }
		)
	),
}
