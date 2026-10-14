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

  bool _reverse = false;  // Attribute 1: reverse
  double _padding = 8;    // Attribute 2: padding
  bool _fixedHeight = false; // Attribute 3: itemExtent

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
          SwitchListTile(
            title: const Text('itemExtent (fixed 56px rows)'),
            value: _fixedHeight,
            onChanged: (v) => setState(() => _fixedHeight = v),
          ),
          ListTile(
            title: Text('padding: ${_padding.round()}px'),
            subtitle: Slider(
              min: 0,
              max: 32,
              value: _padding,
              onChanged: (v) => setState(() => _padding = v),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              reverse: _reverse,
              padding: EdgeInsets.all(_padding),
              itemExtent: _fixedHeight ? 56 : null,
              itemCount: _expenses.length,
              itemBuilder: (context, index) => ListTile(
                tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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