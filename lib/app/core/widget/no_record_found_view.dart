import '/app/core/exporter.dart';

class NoRecordFoundView extends StatelessWidget {
  final VoidCallback? onRetry;

  const NoRecordFoundView({
    super.key,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No record found',
            style: errorTextStyle,
          ),
          if (onRetry != null)
            SelectiveButton(
              onPressed: onRetry,
              text: 'Retry',
              icon: TablerIcons.refresh_dot,
              iconColor: Colors.red,
              color: Colors.transparent,
              padding: 10,
              isSelected: true,
              width: 100,
              margin: 20,
            ),
        ],
      ),
    );
  }
}
