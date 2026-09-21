import 'package:flutter/material.dart';

class PaginatedList<T> extends StatefulWidget {
  const PaginatedList({
    super.key,
    required this.loadPage,
    required this.itemBuilder,
    this.pageSize = 10,
    this.padding = const EdgeInsets.all(0),
    this.emptyWidget,
    this.onRefresh,
    this.isOnce = false,
    this.scrollable = true,
  });

  final Future<List<T>> Function(int page, int limit) loadPage;
  final Widget Function(BuildContext context, T item) itemBuilder;

  final int pageSize;
  final EdgeInsets padding;
  final Widget? emptyWidget;

  /// Optional callback called after the first page is loaded.
  final Future<void> Function()? onRefresh;

  final bool isOnce;
  final bool scrollable;

  @override
  State<PaginatedList<T>> createState() => _PaginatedListState<T>();
}

class _PaginatedListState<T> extends State<PaginatedList<T>> {
  final ScrollController _scrollController = ScrollController();

  final List<T> _items = [];

  int _page = 1;
  bool _loading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
    _loadMore();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (widget.isOnce) return;

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 300) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_loading || !_hasMore) return;

    setState(() {
      _loading = true;
    });

    try {
      final data = await widget.loadPage(_page, widget.pageSize);

      if (!mounted) return;

      setState(() {
        _items.addAll(data);
        _page++;

        if (data.length < widget.pageSize) {
          _hasMore = false;
        }
      });
    } catch (e) {
      if (!mounted) return;

      // Handle error here or expose onError callback.
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _refresh() async {
    if (_loading) return;

    setState(() {
      _items.clear();
      _page = 1;
      _hasMore = true;
      _loading = true;
    });

    try {
      final data = await widget.loadPage(1, widget.pageSize);

      if (!mounted) return;

      setState(() {
        _items.addAll(data);
        _page = 2;

        if (data.length < widget.pageSize) {
          _hasMore = false;
        }
      });

      await widget.onRefresh?.call();
    } catch (e) {
      if (!mounted) return;

      // Handle error here or expose onError callback.
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = ListView.builder(
      controller: widget.scrollable ? _scrollController : null,
      physics: widget.scrollable
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      shrinkWrap: !widget.scrollable,
      padding: widget.padding,
      itemCount: _items.length + (_hasMore && widget.scrollable ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return widget.itemBuilder(context, _items[index]);
      },
    );

    if (!widget.scrollable) {
      return list;
    }

    return RefreshIndicator(onRefresh: _refresh, child: list);
  }
}
