import 'package:flutter/material.dart';

class ExpandablePageView extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final PageController? controller;
  final ValueChanged<int>? onPageChanged;
  final Duration animationDuration;

  const ExpandablePageView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.onPageChanged,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<ExpandablePageView> createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView> {
  late PageController _pageController;

  // Cache the heights of all built pages to prevent layout thrashing
  final Map<int, double> _heights = {};
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = widget.controller ?? PageController();
    // Ensure we start on the correct initial page
    _currentPage = _pageController.initialPage;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _pageController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Look up the target height. If it hasn't reported its size yet, fallback to 0.
    final targetHeight = _heights[_currentPage] ?? 1.0;

    return AnimatedContainer(
      duration: widget.animationDuration,
      curve: Curves.easeOutQuart,
      // If height is 0 (initial load), we use null so it sizes to its content automatically
      height: targetHeight > 0 ? targetHeight : null,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.itemCount,
        // Trigger the height change exactly when the page snaps into place
        onPageChanged: (index) {
          setState(() => _currentPage = index);
          if (widget.onPageChanged != null) {
            widget.onPageChanged!(index);
          }
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _SizeReportingWidget(
              onSizeChange: (size) {
                // Only trigger a rebuild if this specific page's height changed
                if (_heights[index] != size.height) {
                  // We use addPostFrameCallback here safely to avoid "setState during build" errors
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) setState(() => _heights[index] = size.height);
                  });
                }
              },
              child: widget.itemBuilder(context, index),
            ),
          );
        },
      ),
    );
  }
}

// Your _SizeReportingWidget code stays exactly the same!

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

    return OverflowBox(
      minHeight: 0,
      maxHeight: double.infinity,
      alignment: Alignment.topCenter,
      child: Container(key: _widgetKey, child: widget.child),
    );
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
