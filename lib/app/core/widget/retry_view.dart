import '/app/core/exporter.dart';

class RetryView extends StatelessWidget {
  final VoidCallback? onRetry;

  const RetryView({
    super.key,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.pageBackground,
      ),
      width: double.infinity,
      height: 400,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Failed to load data',
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
