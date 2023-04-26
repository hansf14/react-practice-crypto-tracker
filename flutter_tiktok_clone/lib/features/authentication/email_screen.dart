import 'package:flutter/material.dart';
import 'package:flutter_tiktok_clone/constants/gaps.dart';
import 'package:flutter_tiktok_clone/constants/sizes.dart';
import 'package:flutter_tiktok_clone/features/authentication/email_screen.dart';
import 'package:flutter_tiktok_clone/features/authentication/password_screen.dart';
import 'package:flutter_tiktok_clone/features/authentication/widgets/form_button.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _email = "";
  bool _hasEmailEverBeenTypedIn = false;

  void _onSubmit() {
    if (!_isEmailValid()) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
    );
  }

  bool _isEmailValid() {
    if (_email.isEmpty) return false;

    // perform some validation.
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) {
      return false;
    }
    return true;
  }

  String? _getErrorText() {
    if (_isEmailValid() || !_hasEmailEverBeenTypedIn) return null;
    return "Email not valid";
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      // print(_emailController.text);

      setState(() {
        _email = _emailController.text;
        if (_email.isNotEmpty) {
          _hasEmailEverBeenTypedIn = true;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Sign up",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                "What is your email?",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              TextField(
                onEditingComplete: _onSubmit,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                enableSuggestions: false,
                controller: _emailController,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  hintText: "Email",
                  errorText: _getErrorText(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
              Gaps.v16,
              FormButton(
                text: "Next",
                disabled: !_isEmailValid(),
                onTap: _onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
