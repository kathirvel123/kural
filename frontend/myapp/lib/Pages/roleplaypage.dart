import 'package:flutter/material.dart';

class RoleplayPage extends StatelessWidget {
  // Sample data for scenarios and conversations
  final Map<String, List<String>> scenarios = {
    "Interviews": [
      "Tell me about yourself.",
      "What are your strengths and weaknesses?",
      "Why should we hire you?",
    ],
    "Daily Routine": [
      "What time do you wake up?",
      "What do you do in the evening?",
      "How do you plan your day?",
    ],
    "Travel": [
      "Booking a flight ticket.",
      "Asking for directions.",
      "Checking into a hotel.",
    ],
    "Restaurants": [
      "Making a reservation.",
      "Ordering food.",
      "Asking for the bill.",
    ],
    "Shopping": [
      "Asking for the price.",
      "Trying on clothes.",
      "Returning a product.",
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roleplay Scenarios'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: scenarios.entries.map((entry) {
          return _buildScenarioCard(context, entry.key, entry.value);
        }).toList(),
      ),
    );
  }

  // Helper function to build scenario cards
  Widget _buildScenarioCard(
      BuildContext context, String title, List<String> conversations) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        children: conversations.map((conversation) {
          return ListTile(
            title: Text(conversation),
            trailing: IconButton(
              icon: Icon(Icons.play_arrow, color: Colors.blue),
              onPressed: () {
                _startRoleplay(context, title, conversation);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  // Helper function to start roleplay
  void _startRoleplay(
      BuildContext context, String scenario, String conversation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoleplayPracticePage(
            scenario: scenario, conversation: conversation),
      ),
    );
  }
}

class RoleplayPracticePage extends StatelessWidget {
  final String scenario;
  final String conversation;

  RoleplayPracticePage({required this.scenario, required this.conversation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice: $scenario'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              conversation,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Text(
              "Your Turn:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Type your response here...",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add logic to analyze the response
                },
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
