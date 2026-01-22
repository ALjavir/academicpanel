import 'package:flutter/material.dart';

class ExpandablePageView extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final PageController? controller;
  final ValueChanged<int>? onPageChanged;

  const ExpandablePageView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.onPageChanged,
  });

  @override
  State<ExpandablePageView> createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView> {
  late PageController _pageController;
  double _currentHeight = 0;

  @override
  void initState() {
    super.initState();
    _pageController = widget.controller ?? PageController();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: _currentHeight, end: _currentHeight),
      builder: (context, value, child) {
        return SizedBox(height: value, child: child);
      },
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.itemCount,
        onPageChanged: widget.onPageChanged,
        itemBuilder: (context, index) {
          // Wrap the item in a widget that reports its size
          return _SizeReportingWidget(
            onSizeChange: (size) {
              // Only update height if this is the currently visible page
              // (or if it's the first render)
              // We use a small delay to ensure layout is done
              if (_pageController.positions.isNotEmpty &&
                  (_pageController.page?.round() ?? 0) != index) {
                return;
              }
              setState(() => _currentHeight = size.height);
            },
            child: widget.itemBuilder(context, index),
          );
        },
      ),
    );
  }
}

// Helper Widget to measure size
class _SizeReportingWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  const _SizeReportingWidget({required this.child, required this.onSizeChange});

  @override
  State<_SizeReportingWidget> createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<_SizeReportingWidget> {
  final _widgetKey = GlobalKey();
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return Container(key: _widgetKey, child: widget.child);
  }

  void _notifySize() {
    final context = _widgetKey.currentContext;
    if (context == null) return;
    final size = context.size;
    if (size != null && _oldSize != size) {
      _oldSize = size;
      widget.onSizeChange(size);
    }
  }
}
