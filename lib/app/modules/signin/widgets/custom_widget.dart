// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../componen/color.dart';
import '../common/common.dart';

class CustomTextFormField extends StatefulWidget {
  final String hinttext;
  final bool obsecuretext;
  final TextEditingController? controller;
  const CustomTextFormField({
    super.key,
    required this.hinttext,
    required this.obsecuretext,
    this.controller,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.bgformborder),
        borderRadius: BorderRadius.circular(10),
      ),
      child:
      TextFormField(
        controller: widget.controller,
        obscureText: widget.obsecuretext,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(18),
            border: InputBorder.none,
            counterStyle: TextStyle(color: Colors.grey),
            hintStyle: GoogleFonts.nunito(color: Colors.grey, fontWeight: FontWeight.bold),
            hintText: widget.hinttext),
      ),
    );
  }
}


class CustomElevatedButton extends StatefulWidget {
  final String message;
  final FutureOr<void> Function() function;
  final Color? color;
  const CustomElevatedButton({
    super.key,
    required this.message,
    required this.function,
    this.color = Colors.white,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          loading = true;
        });
        await widget.function!();

        setState(() {
          loading = false;
        });
      },
      style: ButtonStyle(
        // side: const MaterialStatePropertyAll(BorderSide(color: Colors.black)),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          fixedSize: const MaterialStatePropertyAll(Size.fromWidth(370)),
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(vertical: 20),
          ),
          backgroundColor: MaterialStatePropertyAll(widget.color)),
      child: loading
          ? const CupertinoActivityIndicator()
          : FittedBox(
          child: Text(
            widget.message,
            style: GoogleFonts.nunito(color: Colors.grey, fontWeight: FontWeight.bold),
          )),
    );
  }
}
class CustomElevatedButton2 extends StatefulWidget {
  final String message;
  final FutureOr<void> Function() function;
  final Color? color;
  const CustomElevatedButton2({
    super.key,
    required this.message,
    required this.function,
    this.color = Colors.white,
  });

  @override
  State<CustomElevatedButton2> createState() => _CustomElevatedButton2State();
}

class _CustomElevatedButton2State extends State<CustomElevatedButton2> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          loading = true;
        });
        await widget.function!();

        setState(() {
          loading = false;
        });
      },
      style: ButtonStyle(
          side: const MaterialStatePropertyAll(BorderSide(color: Colors.white)),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          fixedSize: const MaterialStatePropertyAll(Size.fromWidth(370)),
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(vertical: 20),
          ),
          backgroundColor: MaterialStatePropertyAll(widget.color)),
      child: loading
          ? const CupertinoActivityIndicator()
          : FittedBox(
          child: Text(
            widget.message,
            style: GoogleFonts.nunito(color: Colors.grey, fontWeight: FontWeight.bold),
          )),
    );
  }
}

class DynamicFilledButton extends StatefulWidget {
  const DynamicFilledButton(
      {super.key, required this.child, required this.onPressed, this.color});

  final Widget child;
  // final VoidCallback onPressed;
  final Color? color;
  final FutureOr<void> Function() onPressed;

  @override
  State<DynamicFilledButton> createState() => _DynamicFilledButtonState();
}

class _DynamicFilledButtonState extends State<DynamicFilledButton> {
  bool isLoading = false;

  func() async {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      isLoading = true;
    });

    await widget.onPressed();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return FractionallySizedBox(
        widthFactor: .8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CupertinoButton(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            color: widget.color ?? Common().white,
            onPressed: isLoading ? null : func,
            child:
            isLoading ? const CupertinoActivityIndicator() : widget.child,
          ),
        ),
      );
    }
    return FractionallySizedBox(
      widthFactor: .8,
      child: SizedBox(
        height: 48,
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: widget.color ?? Colors.grey,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: isLoading ? null : func,
          child: isLoading
              ? const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          )
              : widget.child,
        ),
      ),
    );
  }
}
