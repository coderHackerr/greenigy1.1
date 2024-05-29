import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider.dart'; // Assuming you have PointsProvider class defined in points_provider.dart

class RewardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewards Page'),
      ),
      body: Center(
        child: Consumer<PointsProvider>(
          builder: (context, pointsProvider, _) {
            return Text(
              'Total Reward Points: ${pointsProvider.totalRewardPoints}',
              style: TextStyle(fontSize: 24),
            );
          },
        ),
      ),
    );
  }
}
