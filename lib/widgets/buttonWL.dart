import 'package:flutter/material.dart';

class ButtonWL extends StatelessWidget {
  final bool isLoading;
  final String text;
  final VoidCallback onPressed;
  final bool lighter;

  const ButtonWL({
    super.key,
    required this.text,
    required this.onPressed,
    this.lighter = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              backgroundColor: lighter ? MaterialStateProperty.all(Colors.amber.shade100) : null ,
              minimumSize: MaterialStateProperty.all(
                Size( isLoading ? 0 : double.infinity , 58))
            ),
            onPressed: onPressed,
            child: isLoading
              ? const SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white
                  ),
              )
              : Text( text, style: const TextStyle(fontWeight: FontWeight.w800)),
          );
  }
}