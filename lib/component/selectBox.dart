import 'package:flutter/material.dart';

class SelectBox extends StatelessWidget {
  const SelectBox({Key? key, this.language}) : super(key: key);
  final language;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(child: Text(
        language,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.amber.shade300 , fontSize:18),),),
    );
  }
}


class UnSelectBox extends StatelessWidget {
  const UnSelectBox({Key? key, this.language}) : super(key: key);
  final language;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(child: Text(
        language,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white , fontSize:18),),),
    );
  }
}