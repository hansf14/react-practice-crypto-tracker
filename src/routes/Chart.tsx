// import { useParams } from "react-router-dom";

import { useQuery } from "react-query";
import { fetchCoinHistory } from "../api";
import ApexChart from "react-apexcharts";
import { useRecoilValue } from "recoil";
import { atomIsDarkMode } from "../atoms";

export interface ChartProps {
	coinId: string;
}

function Chart({ coinId }: ChartProps) {
	// const params = useParams();
	const { isLoading, data, isError } = useQuery(
		["coin-history", coinId],
		() => fetchCoinHistory({ coinId })
		// {
		// 	refetchInterval: 10000,
		// }
	);

	const isDarkMode = useRecoilValue(atomIsDarkMode);

	return (
		<div>
			{
				isError ? (
					"Error: Possibly API limit has been reached."
				) : isLoading ? (
					"Loading chart..."
				) : (
					<ApexChart
						type="line"
						options={{
							theme: { mode: isDarkMode ? "dark" : "light" },
							chart: {
								width: 500,
								height: 300,
								toolbar: { show: false },
								background: "transparent",
							},
							grid: { show: false },
							stroke: {
								curve: "smooth",
								width: 5,
							},
							yaxis: { show: false },
							xaxis: {
								labels: { show: false },
								axisBorder: { show: false },
								axisTicks: {
									show: false,
								},
								type: "datetime",
								categories: (data ?? []).map((price) => {
									// const date = new Date(parseInt(price.time_close) * 1000)
									// 	.toISOString()
									// 	.split("T")[0];
									//
									// return date;
									// 2024-04-13

									const date = new Date(parseInt(price.time_close) * 1000);
									const year = date.getFullYear();
									const monthIndex = date.getMonth();
									const day = date.getDate();

									const months = [
										"Jan",
										"Feb",
										"Mar",
										"Apr",
										"May",
										"Jun",
										"Jul",
										"Aug",
										"Sep",
										"Oct",
										"Nov",
										"Dec",
									];

									const formattedDate = `${year}/${months[monthIndex]}/${
										day < 10 ? "0" + day : day
									}`;

									return formattedDate;
								}),
							},
							fill: {
								type: "gradient",
								gradient: {
									// gradientToColors: ["blue"],
									gradientToColors: ["#0be881"],
									stops: [0, 100],
								},
							},
							// colors: ["red"],
							colors: ["#0fbcf9"],
							tooltip: {
								y: {
									formatter: (value) => `$${value.toFixed(2)}`,
								},
							},
						}}
						series={[
							{
								name: "Price",
								data: (data ?? []).map((price) => price.close) ?? [],
							},
						]}
					/>
				)
				// <ApexChart
				// 	type="line"
				// 	options={{
				// 		theme: { mode: "dark" },
				// 		chart: { width: 500, height: 500 },
				// 	}}
				// 	series={[
				// 		{
				// 			name: "hello",
				// 			data: [1, 2, 3, 4, 5, 6],
				// 		},
				// 		{
				// 			name: "sales",
				// 			data: [15, 18, 15, 78, 56],
				// 		},
				// 	]}
				// />
			}
		</div>
	);
}

export default Chart;
