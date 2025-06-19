import 'package:flutter/material.dart';
import 'package:product_dice/core/data/my_dice_data.dart';

class DataTestScreen extends StatelessWidget {
  const DataTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Test'),
      ),
      body: Column(
        children: [
          Text(
            'Total items in myDiceData: ${myDiceData.length}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: myDiceData.length,
              itemBuilder: (context, index) {
                final item = myDiceData[index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text(
                      '${item.totalQuestion.toInt()} questions - ${item.status}'),
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
