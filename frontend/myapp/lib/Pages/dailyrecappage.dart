import 'package:flutter/material.dart';

class DailyRecapPage extends StatelessWidget {
  // Sample data
  final List<String> grammaticalErrors = [
    "Incorrect: 'She don’t like it.'",
    "Correct: 'She doesn’t like it.'",
  ];
  final Map<String, String> newWordsLearned = {
    "Eloquent": "She gave an eloquent speech at the conference.",
    "Pragmatic": "His pragmatic approach solved the problem quickly.",
  };
  final Map<String, String> alternativePhrases = {
    "Used: 'I want to'": "Alternative: 'I would like to'",
    "Used: 'It’s hard'": "Alternative: 'It’s challenging'",
  };
  final List<String> pronunciationMistakes = [
    "Mispronounced: 'Specific' (said as 'Pacific')",
    "Mispronounced: 'Comfortable' (said as 'Comfterble')",
  ];
  final List<String> focusAreas = [
    "Work on subject-verb agreement.",
    "Practice pronouncing 'th' sounds.",
  ];
  final Map<String, double> timeSpent = {
    "Listening": 1.5, // in hours
    "Speaking": 2.0, // in hours
  };
  final String keyInsights = "Today, you improved your fluency by 10%!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recap of the Day'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Grammatical Errors
            _buildSectionContainer(
              title: "Grammatical Errors",
              children: grammaticalErrors.map((error) => _buildHighlightedText(error, mistake: true)).toList(),
            ),
            SizedBox(height: 16),

            // New Words Learned
            _buildSectionContainer(
              title: "New Words Learned",
              children: newWordsLearned.entries.map((entry) {
                return _buildHighlightedText("${entry.key}: ${entry.value}", newWord: true);
              }).toList(),
            ),
            SizedBox(height: 16),

            // Alternative Phrases
            _buildSectionContainer(
              title: "Alternative Phrases",
              children: alternativePhrases.entries.map((entry) {
                return _buildHighlightedText("${entry.key} → ${entry.value}", alternative: true);
              }).toList(),
            ),
            SizedBox(height: 16),

            // Pronunciation Mistakes
            _buildSectionContainer(
              title: "Pronunciation Mistakes",
              children: pronunciationMistakes.map((mistake) => _buildHighlightedText(mistake, mistake: true)).toList(),
            ),
            SizedBox(height: 16),

            // Focus Areas
            _buildSectionContainer(
              title: "What to Focus On",
              children: focusAreas.map((area) => _buildBulletPoint(area)).toList(),
            ),
            SizedBox(height: 16),

            // Time Spent (Circular)
            _buildSectionContainer(
              title: "Time Spent Today",
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTimeSpentCircle("Listening", timeSpent["Listening"]!),
                    _buildTimeSpentCircle("Speaking", timeSpent["Speaking"]!),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            // Key Insights
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue, width: 1),
              ),
              child: Text(
                keyInsights,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build section containers
  Widget _buildSectionContainer({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  // Helper function to build bullet points
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: TextStyle(fontSize: 16, color: Colors.grey[800])),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build highlighted text
  Widget _buildHighlightedText(String text, {bool mistake = false, bool newWord = false, bool alternative = false}) {
    Color highlightColor = Colors.transparent;
    if (mistake) {
      highlightColor = Colors.red.withOpacity(0.2); // Red for mistakes
    } else if (newWord) {
      highlightColor = Colors.green.withOpacity(0.2); // Green for new words
    } else if (alternative) {
      highlightColor = Colors.orange.withOpacity(0.2); // Orange for alternative phrases
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: highlightColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• ", style: TextStyle(fontSize: 16, color: Colors.grey[800])),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build time spent circles
  Widget _buildTimeSpentCircle(String label, double hours) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue.withOpacity(0.1),
            border: Border.all(color: Colors.blue, width: 2),
          ),
          child: Center(
            child: Text(
              '${hours.toString()}h',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey[800]),
        ),
      ],
    );
  }
}