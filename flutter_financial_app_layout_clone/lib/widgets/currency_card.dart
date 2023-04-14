import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
import 'dart:developer';

class CurrencyCard extends StatelessWidget {
  final String name, code, amount;
  final IconData icon;
  late bool isInverted;
  late int index;

  // final _blackColor = const Color(0xFF1F2123);
  static const _blackColor = Color(0xFF1F2123);

  void _initOptionalParams(bool? isInverted, int? index) {
    if (isInverted == null && index == null) {
      this.isInverted = false;
      this.index = 0;
    } else if (isInverted == null && index != null) {
      if (index < 0) {
        // debugPrint("Warning: CurrencyCard - index is negative.");
        log("Warning: CurrencyCard - index is negative.");

        this.isInverted = false;
        this.index = 0;
      } else {
        this.isInverted = (index % 2) == 1 ? true : false;
        this.index = index;
      }
    } else if (isInverted != null && index == null) {
      this.isInverted = false;
      this.index = 0;
    } else {
      this.isInverted = isInverted!;
      this.index = index!;
    }
  }

  CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    bool? isInverted,
    int? index,
  }) {
    _initOptionalParams(isInverted, index);
  }

  CurrencyCard.fromMap(Map<String, dynamic> paramMap)
      : name = paramMap["name"],
        code = paramMap["code"],
        amount = paramMap["amount"],
        icon = paramMap["icon"] {
    _initOptionalParams(paramMap["isIverted"], paramMap["index"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "code": code,
      "amount": amount,
      "icon": icon,
      "isInverted": isInverted,
      "index": index,
    };
  }

  dynamic get(String propertyName) {
    var keyValMap = toMap();
    if (keyValMap.containsKey(propertyName)) {
      return keyValMap[propertyName];
    }
    throw ArgumentError('propery not found');
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, (-20 * index).toDouble()),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isInverted ? Colors.white : _blackColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: isInverted ? _blackColor : Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        amount,
                        style: TextStyle(
                          color: isInverted ? _blackColor : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        code,
                        style: TextStyle(
                          color: isInverted
                              ? _blackColor
                              : Colors.white.withOpacity(0.8),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.scale(
                scale: 2.2,
                child: Transform.translate(
                  offset: const Offset(
                    -5,
                    12,
                  ),
                  child: Icon(
                    icon,
                    color: isInverted ? _blackColor : Colors.white,
                    size: 88,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
