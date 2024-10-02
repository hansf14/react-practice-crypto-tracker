import React from "react";
import styled, { css, ExecutionProps } from "styled-components";

export const Container = styled.div`
	padding: 0px 20px;
	max-width: 480px;
	margin: 0 auto;
`;

export const Header = styled.header`
	height: 10vh;
	display: flex;
	justify-content: center;
	align-items: center;
`;

export const Title = styled.h1`
	font-size: 48px;
	color: ${(props) => props.theme.accentColor};
`;

export const Loader = styled.span`
	text-align: center;
	display: block;
`;

export const Overview = styled.div`
	display: flex;
	justify-content: space-between;
	background-color: rgba(0, 0, 0, 0.5);
	padding: 10px 20px;
	border-radius: 10px;
`;

export const OverviewItem = styled.div`
	display: flex;
	flex-direction: column;
	align-items: center;
	span:first-child {
		font-size: 10px;
		font-weight: 400;
		text-transform: uppercase;
		margin-bottom: 5px;
	}
`;

export const OverviewGrid = styled.div`
	display: grid;
	// align-items: center;
	grid-template-columns: repeat(3, 1fr);
	background-color: rgba(0, 0, 0, 0.5);
	row-gap: 10px;
	column-gap: 20px;
	padding: 10px 20px;
	border-radius: 10px;
`;

export type OverviewGridItemAlignSelf = "stretch" | "center" | "start" | "end";

export interface OverviewGridItemProps
	extends React.ComponentPropsWithoutRef<"div">,
		ExecutionProps {
	customProps?: {
		alignSelf?: OverviewGridItemAlignSelf;
		columnSpan?: number;
	};
}

export const OverviewGridItem = styled.div.withConfig({
	shouldForwardProp: (prop) => !["customProps"].includes(prop),
})<OverviewGridItemProps>`
	grid-column: ${({ customProps }) =>
		customProps?.columnSpan === undefined
			? "span 1"
			: css`span ${customProps.columnSpan}`};
	display: flex;
	flex-direction: column;
	align-items: ${({ customProps }) => {
		const alignSelf: OverviewGridItemAlignSelf =
			customProps?.alignSelf ?? "start";
		return alignSelf;
	}};
	text-align: ${({ customProps }) => {
		const alignSelf: OverviewGridItemAlignSelf =
			customProps?.alignSelf ?? "start";
		return alignSelf;
	}};
	span:first-child {
		font-size: 10px;
		font-weight: 400;
		text-transform: uppercase;
		margin-bottom: 5px;
	}
`;

export const Description = styled.p`
	margin: 20px 0px;
`;

export const Tabs = styled.div`
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	margin: 25px 0px;
	gap: 10px;
`;

export const Tab = styled.span.withConfig({
	shouldForwardProp: (prop) => !["isActive"].includes(prop),
})<{ isActive: boolean }>`
	text-align: center;
	text-transform: uppercase;
	font-size: 12px;
	font-weight: 400;
	background-color: rgba(0, 0, 0, 0.5);
	padding: 7px 0px;
	border-radius: 10px;
	color: ${(props) =>
		props.isActive ? props.theme.accentColor : props.theme.textColor};
	a {
		display: block;
	}
`;
