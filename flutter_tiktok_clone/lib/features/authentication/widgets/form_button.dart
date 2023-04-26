import 'package:flutter/material.dart';
import 'package:flutter_tiktok_clone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  final String text;
  final bool? disabled;
  final void Function()? tapHandler;

  const FormButton({
    Key? key,
    required this.text,
    bool? disabled = false,
    void Function()? onTap,
  })  : disabled = disabled ?? false,
        tapHandler = onTap ?? emptyFunction,
        super(key: key);

  static void emptyFunction() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapHandler,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          // duration: const Duration(seconds: 5),
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size16,
          ),
          decoration: BoxDecoration(
            color: disabled!
                ? Colors.grey.shade300
                : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(Sizes.size5),
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            // duration: const Duration(seconds: 5),
            style: TextStyle(
              color: disabled! ? Colors.grey.shade400 : Colors.white,
              fontWeight: FontWeight.w600,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
