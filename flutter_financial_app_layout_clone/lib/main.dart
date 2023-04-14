import 'package:flutter/material.dart';
import 'widgets/currency_card.dart';
import 'widgets/button.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  static const List<Map<String, dynamic>> currencyCardDatas = [
    {
      "name": "Euro",
      "code": "EUR",
      "amount": "6 428",
      "icon": Icons.euro_rounded,
    },
    {
      "name": "Bitcoin",
      "code": "BTC",
      "amount": "9 785",
      "icon": Icons.currency_bitcoin,
    },
    {
      "name": "Dollar",
      "code": "USD",
      "amount": "428",
      "icon": Icons.attach_money_rounded,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Hey, Selena",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "Welcome back",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                Text(
                  "Total Balance",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "\$5 194 482",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Button(
                        text: "Transfer",
                        textColor: Colors.black,
                        bgColor: Color(0xFFF1B33B)),
                    Button(
                        text: "Request",
                        textColor: Colors.white,
                        bgColor: Color(0xFF1F2123)),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Wallets",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ...currencyCardDatas.asMap().entries.map((entry) {
                  var currencyCard = {
                    ...entry.value,
                    "index": entry.key,
                  };
                  return CurrencyCard.fromMap(currencyCard);
                })
                // CurrencyCard(
                //   name: "Euro",
                //   code: "EUR",
                //   amount: "6 428",
                //   icon: Icons.euro_rounded,
                // ),
                // CurrencyCard(
                //   name: "Bitcoin",
                //   code: "BTC",
                //   amount: "9 785",
                //   icon: Icons.currency_bitcoin,
                // ),
                // CurrencyCard(
                //   name: "Dollar",
                //   code: "USD",
                //   amount: "428",
                //   icon: Icons.attach_money_rounded,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
