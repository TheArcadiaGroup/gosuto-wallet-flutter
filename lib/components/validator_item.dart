import 'package:flutter/material.dart';

class ValidatorItem extends StatelessWidget {
  const ValidatorItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Arcadia',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(width: 10),
            Container(
              padding:
                  const EdgeInsets.only(left: 11, right: 11, top: 4, bottom: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF725DFF),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFF725DFF),
                ),
              ),
              child: const Text(
                'Delegate',
                style: TextStyle(fontSize: 8, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 13),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Uptime',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontSize: 9),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                '100%',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 9,
                    color: Theme.of(context).colorScheme.onTertiary),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                'Self-\ndelegation',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontSize: 9),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                '100%',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 9,
                    color: Theme.of(context).colorScheme.onTertiary),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                'Validator\nComminission',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontSize: 9),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                '100%',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 9,
                    color: Theme.of(context).colorScheme.onTertiary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Delegation\nReturn',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontSize: 9),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                '40.05%%',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 9,
                    color: Theme.of(context).colorScheme.onTertiary),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                'Voting\npower',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontSize: 9),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                '100%',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 9,
                    color: Theme.of(context).colorScheme.onTertiary),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                '',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontSize: 9),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                '',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onTertiary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
