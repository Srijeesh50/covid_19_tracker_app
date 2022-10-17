import 'package:covid_19_tracker_app/controller/statsController.dart';
import 'package:covid_19_tracker_app/view/widget/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

import 'model/WorldStatsModel.dart';
import 'view/widget/databox.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  var formatter = NumberFormat('##,000');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color(0xffABE9ED),
    Color(0xffBCE5BA),
    Color(0xffFFB4B1),
  ];
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            FutureBuilder(
                future: statsServices.fetchWorldStatsRecords(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        child: SpinKitFadingCircle(
                      color: Colors.teal,
                      size: 50.0,
                      controller: _controller,
                    ));
                  } else {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                height: 60,
                                image: AssetImage('images/trackerlogo.png')),
                          ],
                        ),
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases!.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered!.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths!.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          colorList: colorList,
                          chartType: ChartType.ring,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),
                          animationDuration: Duration(milliseconds: 2000),
                          chartRadius: MediaQuery.of(context).size.width / 3.7,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DataBox(
                                image: 'images/cases.png',
                                color: Color(0xffABE9ED),
                                width: 320,
                                name: 'Confirmed \nCases',
                                data: formatter.format(snapshot.data!.cases),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DataBox(
                                image: 'images/death.png',
                                color: Color(0xffFFB4B1),
                                name: 'Total \nDeaths',
                                data: formatter.format(snapshot.data!.deaths),
                              ),
                              DataBox(
                                image: 'images/recover.png',
                                color: Color(0xffBCE5BA),
                                name: 'Total \nRecovered',
                                data:
                                    formatter.format(snapshot.data!.recovered),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DataBox(
                                image: 'images/active.png',
                                color: Color(0xffABE9ED).withOpacity(0.7),
                                name: 'Active \nCases',
                                data: formatter.format(snapshot.data!.active),
                              ),
                              DataBox(
                                image: 'images/critical.png',
                                color: Color(0xffF3D9BE),
                                name: 'Critical \nCases',
                                data: formatter.format(snapshot.data!.critical),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DataBox(
                                image: 'images/death.png',
                                color: Color(0xffFFB4B1).withOpacity(0.7),
                                name: 'Today \nDeaths',
                                data: formatter
                                    .format(snapshot.data!.todayDeaths),
                              ),
                              DataBox(
                                image: 'images/recover.png',
                                color: Color(0xffBCE5BA).withOpacity(0.7),
                                name: 'Today \nRecovered',
                                data: formatter
                                    .format(snapshot.data!.todayRecovered),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .07,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CountriesListScreen()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Track Countries",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                })
          ],
        ),
      )),
    );
  }
}
