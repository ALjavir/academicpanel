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
  double _currentHeight = 0;

  @override
  void initState() {
    super.initState();
    _pageController = widget.controller ?? PageController();
  }

  @override
  void dispose() {
    // Only dispose if we created it ourselves
    if (widget.controller == null) {
      _pageController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeOutQuart, // Smoother curve
      duration: widget.animationDuration,
      tween: Tween<double>(begin: _currentHeight, end: _currentHeight),
      builder: (context, value, child) {
        return SizedBox(height: value, child: child);
      },
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.itemCount,
        onPageChanged: widget.onPageChanged,
        itemBuilder: (context, index) {
          return _SizeReportingWidget(
            onSizeChange: (size) {
              // Logic: Only update height if this is the CURRENT page
              // or if the controller isn't ready yet (initial render)
              final isControllerAttached = _pageController.positions.isNotEmpty;

              if (isControllerAttached) {
                final currentPage = _pageController.page?.round() ?? 0;
                if (currentPage != index) return;
              }

              // Only rebuild if height actually changed to save performance
              if (_currentHeight != size.height) {
                setState(() => _currentHeight = size.height);
              }
            },
            child: widget.itemBuilder(context, index),
          );
        },
      ),
    );
  }
}

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
