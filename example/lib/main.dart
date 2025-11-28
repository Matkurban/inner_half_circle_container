import 'package:flutter/material.dart';
import 'package:inner_half_circle_container/inner_half_circle_container.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inner Half Circle Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final samples = [
      _Sample(
        title: 'Side handles',
        subtitle: 'Two mirrored notches on the left/right edges.',
        notches: const [
          HalfCircleNotch(edge: NotchEdge.left, center: 70, radius: 22),
          HalfCircleNotch(edge: NotchEdge.right, center: 70, radius: 22),
        ],
      ),
      _Sample(
        title: 'Ticket edges',
        subtitle: 'Top and bottom cuts for a ticket-like look.',
        notches: const [
          HalfCircleNotch(edge: NotchEdge.top, center: 110, radius: 18),
          HalfCircleNotch(edge: NotchEdge.bottom, center: 40, radius: 26),
        ],
      ),
      _Sample(
        title: 'Mixed edges',
        subtitle: 'Different radii across all four edges.',
        notches: const [
          HalfCircleNotch(edge: NotchEdge.left, center: 40, radius: 18),
          HalfCircleNotch(edge: NotchEdge.right, center: 110, radius: 22),
          HalfCircleNotch(edge: NotchEdge.top, center: 150, radius: 14),
          HalfCircleNotch(edge: NotchEdge.bottom, center: 80, radius: 20),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Inner Half Circle Container')),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemBuilder: (context, index) => _SampleCard(sample: samples[index]),
        separatorBuilder: (_, __) => const SizedBox(height: 24),
        itemCount: samples.length,
      ),
    );
  }
}

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.sample});

  final _Sample sample;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sample.title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(sample.subtitle, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: InnerHalfCircleContainer(
                height: 150,
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                color: theme.colorScheme.primaryContainer,
                notches: sample.notches,
                child: Center(
                  child: Text(
                    sample.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Sample {
  const _Sample({
    required this.title,
    required this.subtitle,
    required this.notches,
  });

  final String title;
  final String subtitle;
  final List<HalfCircleNotch> notches;
}
