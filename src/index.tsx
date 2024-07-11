import React from "react";
import ReactDOM from "react-dom";
import { ThemeProvider } from "styled-components";
import App from "./App";
import { theme } from "./theme";
import { HelmetProvider } from "react-helmet-async";
import { QueryClient, QueryClientProvider } from "react-query";

const queryClient = new QueryClient({
	defaultOptions: {
		queries: {
			staleTime: 60 * (60 * 1000), // 60 mins
			cacheTime: 65 * (60 * 1000), // 65 mins
			refetchInterval: 65 * (60 * 1000),
		},
	},
});

ReactDOM.render(
	<React.StrictMode>
		<HelmetProvider>
			<QueryClientProvider client={queryClient}>
				<ThemeProvider theme={theme}>
					<App />
				</ThemeProvider>
			</QueryClientProvider>
		</HelmetProvider>
	</React.StrictMode>,
	document.getElementById("root")
);
