import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//ignore_for_file: prefer_const_constructors,
//ignore_for_file: prefer_const_literals_to_create_immutables

class MoneyBox extends StatelessWidget {
  final String? title;
  final double? amount;
  final Color? color;
  final double? size;

  const MoneyBox({
    @required this.title,
    @required this.amount,
    @required this.color,
    @required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      height: size,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title!,
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              // ignore: unnecessary_string_interpolations
              '${NumberFormat("#,###.##").format(amount)}',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
