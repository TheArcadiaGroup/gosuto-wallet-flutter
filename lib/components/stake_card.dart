import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StakeCard extends StatelessWidget {
  const StakeCard({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  Widget _buildWidget(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 48 - 40;
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, -1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text('Wallet 1',
                              style: Theme.of(context).textTheme.headline4,
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '15 CSPR\nUnlocked',
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(
                                  color: const Color(0xFFFF7A28),
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '15 CSPR\nUnlocked',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '15 CSPR\nUnlocked',
                          textAlign: TextAlign.right,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Expanded(child: Text('', textAlign: TextAlign.center,))
                    ],
                  ),
                  const SizedBox(height: 5),
                  LinearPercentIndicator(
                    lineHeight: 17,
                    percent: 0.5,
                    barRadius: const Radius.circular(8),
                    backgroundColor: const Color(0xFFE5E5E5),
                    progressColor: const Color(0xFFFFCB66),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Staked on\n1 Dec 2021',
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(
                                  color: const Color(0xFFFF7A28),
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Unlocked on\n1 Dec 2021',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Reward on\n1 Dec 2021',
                          textAlign: TextAlign.right,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Expanded(child: Text('', textAlign: TextAlign.center,))
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '19:12:53:27',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 12),
                        ),
                        const DottedLine(
                          direction: Axis.vertical,
                          lineLength: 20,
                          lineThickness: 1,
                          dashLength: 2,
                          dashColor: Color(0xFFFF7A28),
                          dashRadius: 0,
                          dashGapLength: 2,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0,
                        ),
                        Text(
                          '19:12:53:27',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  DottedLine(
                    lineLength: width,
                    direction: Axis.horizontal,
                    lineThickness: 1,
                    dashLength: 2,
                    dashColor: const Color(0xFFFF7A28),
                    dashRadius: 0,
                    dashGapLength: 2,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total Time Until Reward\n19:12:53:27',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: const Color(0xFFFF7A28),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
