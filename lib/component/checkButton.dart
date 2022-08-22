import 'package:flutter/material.dart';

class CheckButtonIcon extends StatelessWidget {
  final VoidCallback onTap;
  final bool isPressed;

  const CheckButtonIcon({
    Key? key,
    required this.onTap,
    required this.isPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 50,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Icon(Icons.add, color: Colors.amber,),
        decoration: BoxDecoration(
          color: isPressed ? Colors.red[300] : Colors.green[300],
          borderRadius: BorderRadius.circular(13),
          boxShadow: isPressed ? [
            BoxShadow(
                color: Colors.red.shade200,
                offset: const Offset(6, 6),
                blurRadius: 15,
                spreadRadius: 1),
            const BoxShadow(
                color: Colors.white,
                offset: Offset(-6, -6),
                blurRadius: 15,
                spreadRadius: 1),
          ] : [
            BoxShadow(
                color: Colors.green.shade200,
                offset: const Offset(6, 6),
                blurRadius: 15,
                spreadRadius: 1),
            const BoxShadow(
                color: Colors.white,
                offset: Offset(-6, -6),
                blurRadius: 15,
                spreadRadius: 1),
          ],
        ),
      ),
    );
  }
}
