import 'package:cricklyzer/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricklyzer/widgets/bottom_navigation_bar.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});
  final _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar:
          CustomBottomNavigationBar(selectedIndex: _selectedIndex),
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            color: Color(0xfffef7ff).withOpacity(0.9),
          ),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : const AssetImage("assets/images/sample.jpg")
                              as ImageProvider<Object>?,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user?.displayName ?? "",
                      style:  TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,)
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     Text(
                      "Your Pace History",
                      style: TextStyle(
                         color: Colors.black,
                        fontSize: 22,
                      )
                    ),
                    const SizedBox(height: 30),
                    const PaceLineChart(),
                    const SizedBox(height: 20),
                    const SpeedBoxes(),
                    const SizedBox(height: 20),
                    const TopDeliveries(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaceLineChart extends StatelessWidget {
  const PaceLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
  stream: FirebaseFirestore.instance
      .collection('users')
      .doc(user?.uid)
      .collection('paces')
      .orderBy('timestamp', descending: true)
      .snapshots(),
  builder: (context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      var paces = snapshot.data!.docs;
      List<FlSpot> paceData = [];
      for (var i = 0; i < paces.length; i++) {
        var paceDoc = paces[i];
        var paceDataMap = paceDoc.data() as Map;
        paceData.add(FlSpot(i.toDouble(), paceDataMap["pace"]));
      }
      return AspectRatio(
        aspectRatio: 1.8,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: paceData,
                isCurved: true,
                color: Colors.red,
                barWidth: 2,
                isStrokeCapRound: false,
                dotData: const FlDotData(
                  show: false,
                ),
              ),
            ],
            lineTouchData: const LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                // tooltipBgColor: Colors.black,
                tooltipRoundedRadius: 2,
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toStringAsFixed(2),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 9,
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toStringAsFixed(0),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
  },
);
  }
}

class SpeedBoxes extends StatelessWidget {
  const SpeedBoxes({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .collection('paces')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var paces = snapshot.data!.docs;
          double totalSpeed = 0;
          double highestSpeed = 0;

          for (var paceDoc in paces) {
            var paceData = paceDoc.data() as Map<String, dynamic>;
            double pace = paceData["pace"];
            totalSpeed += pace;

            if (pace > highestSpeed) {
              highestSpeed = pace;
            }
          }

          double averageSpeed = totalSpeed / paces.length;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSpeedBox("Average Speed" , averageSpeed),
              _buildSpeedBox("Highest Speed", highestSpeed),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildSpeedBox(String label, double speed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${speed.toStringAsFixed(1)} km/hr",
            style: TextStyle(color: Colors.white,
              fontSize: 20,)
          ),
        ],
      ),
    );
  }
}

class TopDeliveries extends StatelessWidget {
  const TopDeliveries({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .collection('paces')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var paces = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: paces.map((paceDoc) {
                var paceData = paceDoc.data() as Map<String, dynamic>;

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        "${paceData["pace"].toStringAsFixed(1)} km/hr",
                        style:
                            TextStyle(
                                  fontSize: 20,
                                ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        DateFormat('MMM d, y')
                            .format(paceData["timestamp"].toDate()),
                        style: TextStyle(color: Colors.grey,
                          fontSize: 16,)
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}