import 'package:flutter/material.dart';

void main() => runApp(const TransactionsApp());

class TransactionsApp extends StatelessWidget {
  const TransactionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF0E7C66),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F6F5),
      ),
      home: const TransactionsScreen(),
    );
  }
}

class Transaction {
  final String title;
  final String category;
  final String date;
  final int amount; // negative = expense, positive = income
  final IconData icon;
  final Color color;

  const Transaction(
    this.title,
    this.category,
    this.date,
    this.amount,
    this.icon,
    this.color,
  );
}

const _transactions = [
  Transaction('Kigali Market', 'Groceries', 'Today, 09:14', -12500,
      Icons.shopping_basket_rounded, Color(0xFF2E7D32)),
  Transaction('Salary deposit', 'Income', 'Yesterday', 450000,
      Icons.account_balance_wallet_rounded, Color(0xFF1565C0)),
  Transaction('Bus to Nyamirambo', 'Transport', 'Yesterday', -300,
      Icons.directions_bus_rounded, Color(0xFF6A1B9A)),
  Transaction('REG electricity', 'Utilities', 'Mon, 18:30', -18750,
      Icons.bolt_rounded, Color(0xFFF9A825)),
  Transaction('Morning coffee', 'Dining', 'Mon, 07:45', -2000,
      Icons.local_cafe_rounded, Color(0xFF6D4C41)),
  Transaction('Pharmacy', 'Health', 'Sun, 16:02', -6400,
      Icons.medical_services_rounded, Color(0xFFC62828)),
  Transaction('Airtime top-up', 'Phone', 'Sun, 11:20', -5000,
      Icons.phone_android_rounded, Color(0xFF00838F)),
  Transaction('Rent payment', 'Housing', 'Sat, 09:00', -150000,
      Icons.home_rounded, Color(0xFF455A64)),
  Transaction('School fees', 'Education', 'Fri, 14:10', -85000,
      Icons.school_rounded, Color(0xFF283593)),
  Transaction('Fuel', 'Transport', 'Thu, 17:55', -20000,
      Icons.local_gas_station_rounded, Color(0xFFEF6C00)),
  Transaction('Freelance payout', 'Income', 'Wed', 120000,
      Icons.account_balance_wallet_rounded, Color(0xFF1565C0)),
  Transaction('Groceries', 'Groceries', 'Tue, 10:30', -8900,
      Icons.shopping_basket_rounded, Color(0xFF2E7D32)),
];

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  bool _reverse = false;     // Attribute 1: reverse
  double _padding = 12;      // Attribute 2: padding
  bool _fixedHeight = false; // Attribute 3: itemExtent

  static const double _rowHeight = 84; // 72px card + 6px margin top and bottom

  String _formatAmount(int amount) {
    final digits = amount.abs().toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (m) => ',',
        );
    final sign = amount < 0 ? '−' : '+';
    return '$sign RWF $digits';
  }

  void _openSettings() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setSheet) {
          // Update the screen and the open sheet together
          void update(VoidCallback change) {
            setState(change);
            setSheet(() {});
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('List settings',
                      style: Theme.of(context).textTheme.titleLarge),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('reverse'),
                    subtitle: const Text('Flip the scroll direction'),
                    value: _reverse,
                    onChanged: (v) => update(() => _reverse = v),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('itemExtent'),
                    subtitle: const Text('Force every row to the same height'),
                    value: _fixedHeight,
                    onChanged: (v) => update(() => _fixedHeight = v),
                  ),
                  const SizedBox(height: 8),
                  Text('padding: ${_padding.round()}px'),
                  Slider(
                    min: 0,
                    max: 24,
                    divisions: 24,
                    value: _padding,
                    onChanged: (v) => update(() => _padding = v),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            tooltip: 'List settings',
            onPressed: _openSettings,
          ),
        ],
      ),
      body: ListView.builder(
        reverse: _reverse,
        padding: EdgeInsets.all(_padding),
        itemExtent: _fixedHeight ? _rowHeight : null,
        itemCount: _transactions.length,
        itemBuilder: (context, index) {
          final t = _transactions[index];
          final isIncome = t.amount > 0;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: t.color.withValues(alpha: 0.15),
                child: Icon(t.icon, color: t.color),
              ),
              title: Text(
                t.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text('${t.category} · ${t.date}'),
              trailing: Text(
                _formatAmount(t.amount),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: isIncome ? Colors.green.shade700 : scheme.onSurface,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}