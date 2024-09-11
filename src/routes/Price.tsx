import { useQuery } from "react-query";
import { fetchCoinTickers } from "../api";
import { getFormattedDateTime } from "../utils";
import { Loader, OverviewGrid, OverviewGridItem } from "../components";

export interface PriceProps {
	coinId: string;
}

function Price({ coinId }: PriceProps) {
	const { isLoading, data } = useQuery(
		["coin-tickers", coinId],
		() => fetchCoinTickers({ coinId })
		// {
		// 	refetchInterval: 10000,
		// }
	);

	const price =
		data?.quotes.USD.price !== undefined
			? `$${data.quotes.USD.price.toFixed(2)}`
			: "unknown";
	const totalSupply = data?.total_supply ?? "unknown";
	// const maxSupply = data?.max_supply ?? "unknown";
	// ㄴ The API return value is 0. Seems like I won't need this.
	const lastUpdated = data?.last_updated
		? getFormattedDateTime({
				date: new Date(data.last_updated),
		  })
		: "unknown";

	const athPrice =
		data?.quotes.USD.ath_price !== undefined
			? `$${data.quotes.USD.ath_price.toFixed(2)}`
			: "unknown";
	const percentFromPriceAth =
		data?.quotes.USD.percent_from_price_ath !== undefined
			? `${data.quotes.USD.percent_from_price_ath}%`
			: "unknown";
	const athDate = data?.quotes.USD.ath_date
		? getFormattedDateTime({
				date: new Date(data?.quotes.USD.ath_date),
		  })
		: "unknown";

	const percentChange15m =
		data?.quotes.USD.percent_change_15m !== undefined
			? `${data.quotes.USD.percent_change_15m}%`
			: "unknown";
	const percentChange30m =
		data?.quotes.USD.percent_change_30m !== undefined
			? `${data.quotes.USD.percent_change_30m}%`
			: "unknown";
	const percentChange1h =
		data?.quotes.USD.percent_change_1h !== undefined
			? `${data.quotes.USD.percent_change_1h}%`
			: "unknown";

	const percentChange6h =
		data?.quotes.USD.percent_change_6h !== undefined
			? `${data.quotes.USD.percent_change_6h}%`
			: "unknown";
	const percentChange12h =
		data?.quotes.USD.percent_change_12h !== undefined
			? `${data.quotes.USD.percent_change_12h}%`
			: "unknown";
	const percentChange24h =
		data?.quotes.USD.percent_change_24h !== undefined
			? `${data.quotes.USD.percent_change_24h}%`
			: "unknown";

	const percentChange7d =
		data?.quotes.USD.percent_change_7d !== undefined
			? `${data.quotes.USD.percent_change_7d}%`
			: "unknown";
	const percentChange30d =
		data?.quotes.USD.percent_change_30d !== undefined
			? `${data.quotes.USD.percent_change_30d}%`
			: "unknown";
	const percentChange1y =
		data?.quotes.USD.percent_change_1y !== undefined
			? `${data.quotes.USD.percent_change_1y}%`
			: "unknown";

	const marketCap =
		data?.quotes.USD.market_cap !== undefined
			? `$${data.quotes.USD.market_cap.toFixed(2)}`
			: "unknown";
	const marketCapChange24h =
		data?.quotes.USD.market_cap_change_24h ?? "unknown";
	const volume24h =
		data?.quotes.USD.volume_24h !== undefined
			? `$${data.quotes.USD.volume_24h.toFixed(2)}`
			: "unknown";

	return (
		<>
			{isLoading ? (
				<Loader>Loading...</Loader>
			) : (
				<>
					<OverviewGrid>
						<OverviewGridItem customProps={{ alignSelf: "start" }}>
							<span>Price:</span>
							<span>{price}</span>
						</OverviewGridItem>
						<OverviewGridItem customProps={{ alignSelf: "center" }}>
							<span>Total Supply:</span>
							<span>{totalSupply}</span>
						</OverviewGridItem>
						{/* <OverviewGridItem customProps={{ alignSelf: "center" }}>
							<span>Symbol:</span>
							<span>{maxSupply}</span>
						</OverviewGridItem> */}
						<OverviewGridItem customProps={{ alignSelf: "end" }}>
							<span>Last Updated:</span>
							<span>{lastUpdated}</span>
						</OverviewGridItem>

						<OverviewGridItem customProps={{ alignSelf: "start" }}>
							<span>ATH Price:</span>
							<span>{athPrice}</span>
						</OverviewGridItem>
						<OverviewGridItem customProps={{ alignSelf: "center" }}>
							<span>From ATH Price (%):</span>
							<span>{percentFromPriceAth}</span>
						</OverviewGridItem>
						<OverviewGridItem customProps={{ alignSelf: "end" }}>
							<span>ATH Date:</span>
							<span>{athDate}</span>
						</OverviewGridItem>

						<OverviewGridItem customProps={{ alignSelf: "start" }}>
							<span>
								Percent Change
								<br />
								15 min (%):
							</span>
							<span>{percentChange15m}</span>
						</OverviewGridItem>
						<OverviewGridItem customProps={{ alignSelf: "center" }}>
							<span>
								Percent Change
								<br />
								30 min (%):
							</span>
							<span>{percentChange30m}</span>
						</OverviewGridItem>
						<OverviewGridItem customProps={{ alignSelf: "end" }}>
							<span>
								Percent Change
								<br />1 hour (%):
							</span>
							<span>{percentChange1h}</span>
						</OverviewGridItem>

						<OverviewGridItem customProps={{ alignSelf: "start" }}>
							<span>
								Percent Change
								<br />6 hours (%):
							</span>
							<span>{percentChange6h}</span>
						</OverviewGridItem>
						<OverviewGridItem customProps={{ alignSelf: "center" }}>
							<span>
								Percent Change
								<br />
								12 hours (%):
							</span>
							<span>{percentChange12h}</span>
						</OverviewGridItem>
						<OverviewGridItem customProps={{ alignSelf: "end" }}>
							<span>
								Percent Change
								<br />
								24 hours (%):
							</span>
							<span>{percentChange24h}</span>
						</OverviewGridItem>

						<OverviewGridItem customProps={{ alignSelf: "start" }}>
							<span>
								Percent Change
								<br />7 days (%):
							</span>
							<span>{percentChange7d}</span>
						</OverviewGridItem>
						<OverviewGridItem customProps={{ alignSelf: "center" }}>
							<span>
								Percent Change
								<br />
								30 days (%):
							</span>
							<span>{percentChange30d}</span>
						</OverviewGridItem>
						<OverviewGridItem customProps={{ alignSelf: "end" }}>
							<span>
								Percent Change
								<br />1 year (%):
							</span>
							<span>{percentChange1y}</span>
						</OverviewGridItem>

						<OverviewGridItem customProps={{ alignSelf: "start" }}>
							<span>Market Capacity:</span>
							<span>{marketCap}</span>
						</OverviewGridItem>
						<OverviewGridItem customProps={{ alignSelf: "center" }}>
							<span>Market Capacity Change:</span>
							<span>{marketCapChange24h}</span>
						</OverviewGridItem>
						<OverviewGridItem customProps={{ alignSelf: "end" }}>
							<span>
								Volume
								<br />
								24 hours:
							</span>
							<span>{volume24h}</span>
						</OverviewGridItem>
					</OverviewGrid>
				</>
			)}
		</>
	);
}

export default Price;
