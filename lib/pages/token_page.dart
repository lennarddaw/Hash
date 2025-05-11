import 'package:flutter/material.dart';
import '../assets/colors.dart';

class TokenPage extends StatelessWidget {
  const TokenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Belohnungen'),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.cyan,
        elevation: 0.5,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TokenDisplay(tokens: 120),
            SizedBox(height: 20),
            _ProgressBar(currentTokens: 120, goalTokens: 200),
            SizedBox(height: 30),
            Text(
              'Verfügbare Belohnungen',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(child: _RewardsList()),
          ],
        ),
      ),
    );
  }
}

class _TokenDisplay extends StatelessWidget {
  final int tokens;

  const _TokenDisplay({required this.tokens});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cyan.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.token, color: AppColors.cyan, size: 32),
          const SizedBox(width: 10),
          Text(
            '$tokens Tokens',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final int currentTokens;
  final int goalTokens;

  const _ProgressBar({required this.currentTokens, required this.goalTokens});

  @override
  Widget build(BuildContext context) {
    final double percent = currentTokens / goalTokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: percent,
          minHeight: 10,
          color: AppColors.cyan,
          backgroundColor: AppColors.cyan.withOpacity(0.2),
        ),
        const SizedBox(height: 6),
        Text('$currentTokens / $goalTokens zum nächsten Level'),
      ],
    );
  }
}

class _RewardsList extends StatelessWidget {
  const _RewardsList();

  @override
  Widget build(BuildContext context) {
    final rewards = [
      {'label': '1h Social Media frei', 'cost': 50},
      {'label': 'Freies YouTube am Abend', 'cost': 100},
      {'label': '1 Cheat Day Token', 'cost': 150},
    ];

    return ListView.builder(
      itemCount: rewards.length,
      itemBuilder: (context, index) {
        final reward = rewards[index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.star_outline, color: AppColors.grey),
            title: Text(reward['label'] as String),
            trailing: Text('${reward['cost']} Tokens'),
          ),
        );
      },
    );
  }
}
