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
}
