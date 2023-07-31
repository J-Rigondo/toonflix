import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String name, code, amount;
  final IconData icon;
  final _privateData = 'private';

  const CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge, //overflow 컨트롤
      decoration: BoxDecoration(
          color: Colors.teal, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Text(amount),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(code)
                  ],
                ),
              ],
            ),
            Transform.scale(
              scale: 2.5,
              child: Transform.translate(
                offset: const Offset(5, 10),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
