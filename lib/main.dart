import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const StudyPlannerScreen(),
    );
  }
}

class StudyPlannerScreen extends StatefulWidget {
  const StudyPlannerScreen({super.key});

  @override
  State<StudyPlannerScreen> createState() =>
      _StudyPlannerScreenState();
}

class _StudyPlannerScreenState extends State<StudyPlannerScreen> {

  // LOGIC: Store study goals
  List<Map<String, dynamic>> goals = [
    {
      'subject': 'Programming',
      'hours': 2,
      'done': false,
    },
    {
      'subject': 'Database',
      'hours': 3,
      'done': false,
    },
    {
      'subject': 'Cybersecurity',
      'hours': 2,
      'done': false,
    },
  ];

  // LOGIC: Add a new sample goal
  void _addGoal() {
    setState(() {
      goals.add({
        'subject': 'New Study Goal ${goals.length + 1}',
        'hours': 1,
        'done': false,
      });
    });
  }

  // LOGIC: Toggle goal completion
  void _toggleGoal(int index) {
    setState(() {
      goals[index]['done'] = !goals[index]['done'];
    });
  }

  // LOGIC: Delete a goal
  void _deleteGoal(int index) {
    setState(() {
      goals.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FC),

      // STATIC: AppBar
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Study Planner',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      // STATIC: Main screen content
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Study Goals',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF25213D),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Keep learning and achieve your goals!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            // LOGIC: Build goals from the list
            Expanded(
              child: goals.isEmpty
                  ? const Center(
                      child: Text(
                        'No study goals yet. Tap + to add one!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: goals.length,
                      itemBuilder: (context, index) {
                        final goal = goals[index];
                        final isDone = goal['done'] as bool;

                        return _buildGoalCard(
                          subject: goal['subject'],
                          hours: goal['hours'],
                          isDone: isDone,
                          onToggle: () => _toggleGoal(index),
                          onDelete: () => _deleteGoal(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // STATIC: Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: _addGoal,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  // STATIC: Reusable goal card
  Widget _buildGoalCard({
    required String subject,
    required int hours,
    required bool isDone,
    required VoidCallback onToggle,
    required VoidCallback onDelete,
  }) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onToggle,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),

        // CONNECTION: Checkbox updates the goal status
        leading: Checkbox(
          value: isDone,
          activeColor: Colors.deepPurple,
          onChanged: (value) {
            onToggle();
          },
        ),

        title: Text(
          subject,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDone ? Colors.grey : const Color(0xFF25213D),
            decoration: isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),

        subtitle: Text('$hours Hours'),

        trailing: IconButton(
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
          onPressed: onDelete,
        ),
      ),
    );
  }
}