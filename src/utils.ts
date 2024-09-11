import { format } from "date-fns";

export function getFormattedDateAndTime({ date }: { date: Date }) {
	const dateFormat = "yyyy-MM-dd";
	const timeFormat = "HH:mm:ss";

	const formattedDate = format(date, dateFormat);
	const formattedTime = format(date, timeFormat);

	return {
		formattedDate,
		formattedTime,
	};
}

export function getFormattedDateTime({ date }: { date: Date }) {
	const { formattedDate, formattedTime } = getFormattedDateAndTime({ date });
	return `${formattedDate}\n${formattedTime}`;
}
