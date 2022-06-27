import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosuto/themes/colors.dart';
import 'package:gosuto/utils/utils.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class ChartCard extends StatefulWidget {
  const ChartCard({Key? key, required this.data, required this.onUpdateFilter})
      : super(key: key);
  final List data;

  final Function(int value) onUpdateFilter;

  @override
  State<StatefulWidget> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChartCard> {
  final RxInt _selectedFilter = RxInt(ChartFilterEnum.day_1.value);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  Widget _buildWidget(BuildContext context) {
    double maxPrice = 0;
    double delta = 1;

    for (var element in widget.data) {
      if (maxPrice < element[1]) {
        maxPrice = element[1];
      }
    }
    if (maxPrice < 1) {
      delta = 1 / maxPrice;
    }
    final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 6);
    final customTickFormatter = charts.BasicNumericTickFormatterSpec(
        (value) => formatCurrency.format(value != null ? value / delta : 0));

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
              _createData(delta),
              animate: true,
              // domainAxis: charts.EndPointsTimeAxisSpec(),
              domainAxis: charts.EndPointsTimeAxisSpec(
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
                tickFormatterSpec: customTickFormatter,
                //   charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                // NumberFormat.compactSimpleCurrency(),
                // ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _changeFilter(value) {
    _selectedFilter(value);
    widget.onUpdateFilter(value);
  }

  List<DropdownMenuItem<Object>> _buildDropDownMenuItems() {
    return ChartFilterEnum.values
        .map((val) => DropdownMenuItem(
              value: val.value,
              child: Text(val.key),
            ))
        .toList();
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<ChartRow, DateTime>> _createData(double delta) {
    final _data = widget.data
        .map((element) => ChartRow(
            DateTime.fromMillisecondsSinceEpoch(element[0]), element[1]))
        .toList();

    return [
      charts.Series<ChartRow, DateTime>(
        id: 'prices',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(AppColors.lineChart),
        domainFn: (ChartRow row, _) => row.timeStamp,
        measureFn: (ChartRow row, _) => row.price * delta,
        data: _data,
      )
    ];
  }
}

/// Sample time series data type.
class ChartRow {
  final DateTime timeStamp;
  final double price;

  ChartRow(this.timeStamp, this.price);
}
