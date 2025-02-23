import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // For graphs

class Progress extends StatelessWidget {
  // Sample data
  final Map<String, double> todayPerformance = {
    'Accuracy': 85.0,
    'Fluency': 78.0,
    'Pronunciation': 92.0,
    'Grammar': 88.0,
  };
  final double overallPercentage = 85.5; // Overall progress
  final List<double> weeklyProgress = [
    70,
    75,
    80,
    85,
    82,
    88,
    90
  ]; // Last 7 days

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Progress'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Percentage
            Center(
              child: CircularProgressIndicator(
                value: overallPercentage / 100,
                semanticsLabel: 'Overall Progress',
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                strokeWidth: 10,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                '${overallPercentage.toStringAsFixed(1)}%',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 24),

            // Today's Performance
            Text(
              "Today's Performance",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1,
              children: todayPerformance.entries.map((entry) {
                return _buildMetricCard(entry.key, entry.value);
              }).toList(),
            ),
            SizedBox(height: 30),

            // Weekly Graph
            Text(
              "Weekly Progress",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: weeklyProgress.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value);
                      }).toList(),
                      isCurved: true,
                      color: Colors.blue,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build metric cards
  Widget _buildMetricCard(String title, double value) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '${value.toStringAsFixed(1)}%',
              style: TextStyle(fontSize: 24, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
