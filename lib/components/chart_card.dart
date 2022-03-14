import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/themes/colors.dart';
import 'package:gosuto/utils/utils.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class ChartCard extends StatefulWidget {
  const ChartCard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChartCard> {
  final RxString _selectedFilter = RxString(AppConstants.chartFilterItems[0]);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  Widget _buildWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      // padding: const EdgeInsets.all(20),
      // height: 214,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, -1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CSRP Price',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    RichText(
                        text: TextSpan(
                            text: '\$26.234 USD ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                              text: '+2.5% USD',
                              style: Theme.of(context).textTheme.headline3)
                        ])),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: DropdownButtonHideUnderline(
                  child: Obx(() => DropdownButton2(
                        value: _selectedFilter.value,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 10),
                        items: _buildDropDownMenuItems(),
                        onChanged: _changeFilter,
                        buttonHeight: 35,
                        buttonPadding: const EdgeInsets.only(right: 7),
                        alignment: Alignment.centerRight,

                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        // dropdownColor: Theme.of(context).colorScheme.primary,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        dropdownWidth: 90,
                      )),
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            padding: const EdgeInsets.all(10),
            child: charts.TimeSeriesChart(
              _createSampleData(),
              animate: true,
              domainAxis: charts.DateTimeAxisSpec(
                renderSpec: charts.GridlineRendererSpec(
                  lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.transparent),
                  ),
                  labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(
                      const Color(0xFFAAB5C5),
                    ),
                    fontSize: 8,
                  ),
                ),
              ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                renderSpec: charts.GridlineRendererSpec(
                  lineStyle: const charts.LineStyleSpec(dashPattern: [4, 8]),
                  labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(
                      const Color(0xFFAAB5C5),
                    ),
                    fontSize: 7,
                    // fontWeight: FontWeight.bold.toString()
                  ),
                ),
                tickFormatterSpec:
                    charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                  NumberFormat.compactSimpleCurrency(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _changeFilter(value) {
    _selectedFilter(value);
  }

  List<DropdownMenuItem<String>> _buildDropDownMenuItems() {
    return AppConstants.chartFilterItems.map((String items) {
      return DropdownMenuItem(
        value: items,
        child: Text(items),
      );
    }).toList();
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<MyRow, DateTime>> _createSampleData() {
    final data = [
      MyRow(DateTime(2017, 9, 25), 600),
      MyRow(DateTime(2017, 9, 26), 800),
      MyRow(DateTime(2017, 9, 27), 6000),
      MyRow(DateTime(2017, 9, 28), 9000),
      MyRow(DateTime(2017, 9, 29), 11000),
      MyRow(DateTime(2017, 9, 30), 15000),
      MyRow(DateTime(2017, 10, 01), 25000),
      MyRow(DateTime(2017, 10, 02), 33000),
      MyRow(DateTime(2017, 10, 03), 27000),
      MyRow(DateTime(2017, 10, 04), 31000),
      MyRow(DateTime(2017, 10, 05), 23000),
    ];

    return [
      charts.Series<MyRow, DateTime>(
        id: 'Cost',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(AppColors.lineChart),
        domainFn: (MyRow row, _) => row.timeStamp,
        measureFn: (MyRow row, _) => row.cost,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class MyRow {
  final DateTime timeStamp;
  final int cost;

  MyRow(this.timeStamp, this.cost);
}
