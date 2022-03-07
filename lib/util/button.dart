import 'package:arquitect/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const PrimaryButton({Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    if (widget.onPressed != null) isEnabled = true;

    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: 50,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Pallete.orange,
        ),
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style: GoogleFonts.mulish(
            textStyle: TextStyle(
              letterSpacing: 1.1,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Pallete.white,
            ),
          ),
        ),
      ),
    );
  }
}
