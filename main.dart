import 'package:flutter/material.dart';

import 'screens/dashboard_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const UMKMInsightDashboard());
}

class UMKMInsightDashboard extends StatelessWidget {
  const UMKMInsightDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UMKM Insight Dashboard',
      theme: AppTheme.lightTheme,
      home: const DashboardScreen(),
    );
  }
}