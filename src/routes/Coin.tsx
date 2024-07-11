// import { useEffect, useState } from "react";
import {
	useLocation,
	useParams,
	useRouteMatch,
	Switch,
	Route,
	Link,
} from "react-router-dom";
import Price from "./Price";
import Chart from "./Chart";
import { useQuery } from "react-query";
import { fetchCoinInfo, fetchCoinTickers } from "../api";
import { Helmet } from "react-helmet-async";
import {
	Container,
	Description,
	Header,
	Loader,
	Overview,
	OverviewItem,
	Tab,
	Tabs,
	Title,
} from "../components";

export interface RouteParams {
	coinId: string;
}

export interface RouteState {
	name: string;
}

function Coin() {
	const { coinId } = useParams<RouteParams>();
	// const [loading, setLoading] = useState(true);
	// const {
	// 	state: { name },
	// } = useLocation<RouteState>();
	// // console.log(location);
	// console.log(name);

	const { state } = useLocation<RouteState>();
	// // console.log(state.name);

	// const [info, setInfo] = useState<InfoData>();
	// const [priceInfo, setPriceInfo] = useState<PriceData>();

	const { isLoading: isInfoDataLoading, data: infoData } = useQuery(
		["coin-info", coinId],
		() => fetchCoinInfo({ coinId })
		// {
		// 	refetchInterval: 5000,
		// }
	);
	const { isLoading: isTickersDataLoading, data: tickersData } = useQuery(
		["coin-tickers", coinId],
		() => fetchCoinTickers({ coinId })
		// {
		// 	refetchInterval: 5000,
		// }
	);

	const priceMatch = useRouteMatch("/:coinId/price");
	// console.log(priceMatch);
	const chartMatch = useRouteMatch("/:coinId/chart");
	// console.log(chartMatch);

	// useEffect(() => {
	// 	(async () => {
	// 		const infoData = await (
	// 			await fetch(`https://api.coinpaprika.com/v1/coins/${coinId}`)
	// 		).json();
	// 		console.log(infoData);

	// 		const priceData = await (
	// 			await fetch(`https://api.coinpaprika.com/v1/tickers/${coinId}`)
	// 		).json();
	// 		console.log(priceData);

	// 		setInfo(infoData);
	// 		setPriceInfo(priceData);
	// 		setLoading(false);
	// 	})();
	// }, []);

	const isLoading = isInfoDataLoading || isTickersDataLoading;

	return (
		<Container>
			<Helmet>
				<title>
					{state?.name ? state.name : isLoading ? "Loading..." : infoData?.name}
				</title>
				<link
					rel="icon"
					type="image/png"
					href={`https://static.coinpaprika.com/coin/${coinId}/logo.png`}
					sizes="16x16"
				/>
			</Helmet>

			<Header>
				<Title>
					{state?.name ? state.name : isLoading ? "Loading..." : infoData?.name}
				</Title>
			</Header>

			{isLoading ? (
				<Loader>Loading...</Loader>
			) : (
				<>
					<Overview>
						<OverviewItem>
							<span>Rank:</span>
							<span>{infoData?.rank}</span>
						</OverviewItem>
						<OverviewItem>
							<span>Symbol:</span>
							<span>{infoData?.symbol}</span>
						</OverviewItem>
						<OverviewItem>
							{/* <span>Open Source:</span> */}
							<span>Price:</span>
							{/* <span>{infoData?.open_source ? "Yes" : "No"}</span> */}
							<span>${tickersData?.quotes.USD.price.toFixed(3)}</span>
						</OverviewItem>
					</Overview>

					<Description>{infoData?.description}</Description>

					<Overview>
						<OverviewItem>
							<span>Total Supply:</span>
							<span>{tickersData?.total_supply}</span>
						</OverviewItem>
						<OverviewItem>
							<span>Max Supply:</span>
							<span>{tickersData?.max_supply}</span>
						</OverviewItem>
					</Overview>

					<Tabs>
						<Tab isActive={chartMatch !== null}>
							<Link to={`/${coinId}/chart`}>Chart</Link>
						</Tab>
						<Tab isActive={priceMatch !== null}>
							<Link to={`/${coinId}/price`}>Price</Link>
						</Tab>
					</Tabs>

					<Switch>
						<Route path={`/:coinId/price`}>
							<Price coinId={coinId} />
						</Route>
						<Route path={`/:coinId/chart`}>
							<Chart coinId={coinId} />
						</Route>
					</Switch>
				</>
			)}
		</Container>
	);
}
export default Coin;
