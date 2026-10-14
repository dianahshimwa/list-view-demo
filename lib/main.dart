import 'package:flutter/material.dart';

void main() => runApp(const ListViewApp());

class ListViewApp extends StatelessWidget {
  const ListViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const ExpenseListScreen(),
    );
  }
}

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  static final List<String> _expenses = List.generate(
    30,
    (i) => 'Expense #${i + 1}  ·  RWF ${(i + 1) * 1500}',
  );

  bool _reverse = false; // Attribute 1: reverse

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Household Expenses')),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('reverse'),
            value: _reverse,
            onChanged: (v) => setState(() => _reverse = v),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              reverse: _reverse,
              itemCount: _expenses.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(_expenses[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}