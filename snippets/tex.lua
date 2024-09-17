return {
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
		";;tex-hdr",
		t({
			"% !TEX encoding = UTF-8 Unicode",
			"% !TEX root = main.tex",
			"% LTeX: language=en-GB",
		})
	),
}
