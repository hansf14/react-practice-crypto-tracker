// import { useEffect, useState } from "react";
import { useQuery } from "react-query";
import { Link } from "react-router-dom";
import styled from "styled-components";
import { fetchCoins } from "../api";
import { Helmet } from "react-helmet-async";
import { useSetRecoilState } from "recoil";
import { atomIsDarkMode } from "../atoms";
import { useCallback } from "react";

const Container = styled.div`
	padding: 0px 20px;
	max-width: 480px;
	margin: 0 auto;
`;

const Header = styled.header`
	height: 10vh;
	display: flex;
	justify-content: center;
	align-items: center;
`;

const CoinsList = styled.ul``;

const Coin = styled.li`
	background-color: ${({ theme }) => theme.cardBgColor};
	color: ${({ theme }) => theme.textColor};
	margin-bottom: 10px;
	border-radius: 15px;
	border: 1px solid white;

	a {
		display: flex;
		align-items: center;
		padding: 20px;
		transition: color 0.2s ease-in-out;
	}

	&:hover {
		a {
			color: ${({ theme }) => theme.accentColor};
		}
	}
`;

const Title = styled.h1`
	font-size: 30px;
	font-weight: bold;
	color: ${({ theme }) => theme.accentColor};
`;

const Loader = styled.span`
	text-align: center;
	display: block;
`;

const Img = styled.img`
	width: 35px;
	height: 35px;
	margin-right: 10px;
`;

const ThemeToggler = styled.button`
	margin: 10px 0;
	padding: 5px;
	color: ${({ theme }) => theme.textColor};
	font-weight: bold;
	border: 1px solid ${({ theme }) => theme.textColor};
	border-radius: 5px;
	background: transparent;
`;

function Coins() {
	// const [coins, setCoins] = useState<CoinInterface[]>([]);
	// const [loading, setLoading] = useState(true);

	// useEffect(() => {
	// 	(async () => {
	// 		const response = await fetch("https://api.coinpaprika.com/v1/coins");
	// 		const json = await response.json();
	// 		// console.log(json);

	// 		setCoins(json.slice(0, 100));
	// 		setLoading(false);
	// 		console.log(coins);
	// 	})();
	// }, []);

	const { isLoading, data } = useQuery("coins", fetchCoins, {
		select: (data) => data.slice(0, 30),
	});

	const setIsDarkMode = useSetRecoilState(atomIsDarkMode);
	const toggleThemeHandler = useCallback(() => {
		setIsDarkMode((current) => !current);
	}, []);

	return (
		<Container>
			<Helmet>
				<title>코인</title>
				<link rel="icon" type="image/png" href="/favicon.png" sizes="16x16" />
			</Helmet>

			<ThemeToggler onClick={toggleThemeHandler}>테마 변경</ThemeToggler>

			<Header>
				<Title>코인</Title>
			</Header>

			{isLoading ? (
				<Loader>Loading...</Loader>
			) : (
				<CoinsList>
					{data?.map((coin) => (
						<Coin key={coin.id}>
							<Link
								to={{
									pathname: `/${coin.id}`,
									state: {
										name: coin.name,
									},
								}}
							>
								<Img
									src={`https://static.coinpaprika.com/coin/${coin.id}/logo.png`}
								/>
								{coin.name} &rarr;
							</Link>
						</Coin>
					))}
				</CoinsList>
			)}
		</Container>
	);
}
export default Coins;
