import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  const PostPage({
    super.key,
    required this.id,
    required this.title,
    this.description,
    this.tag,
    this.tagColor,
    required this.priority,
    required this.createdAt,
    required this.companyId,
    required this.companyName,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String? description;
  final String? tag;
  final Color? tagColor;
  final int priority;
  final DateTime createdAt;
  final String companyId;
  final String companyName;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,

      appBar: AppBar(
        title: const Text('Новость'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (tag != null && tag!.trim().isNotEmpty) ...[
                    _buildTag(context),
                    const SizedBox(height: 16),
                  ],

                  Text(
                    title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _InfoRow(
                    icon: Icons.calendar_today_outlined,
                    text: _formatDate(createdAt),
                  ),

                  if (companyName.trim().isNotEmpty) ...[
                    const SizedBox(height: 10),
                    _InfoRow(icon: Icons.business_outlined, text: companyName),
                  ],

                  if (description != null &&
                      description!.trim().isNotEmpty) ...[
                    const SizedBox(height: 28),

                    Divider(
                      color: colorScheme.onSurface.withValues(alpha: 0.12),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      description!,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontSize: 17,
                        height: 1.65,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return _ImagePlaceholder(colorScheme: colorScheme);
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.network(
        imageUrl!,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return _ImagePlaceholder(colorScheme: colorScheme);
        },
        loadingBuilder: (context, child, progress) {
          if (progress == null) {
            return child;
          }

          return _ImagePlaceholder(colorScheme: colorScheme, loading: true);
        },
      ),
    );
  }

  Widget _buildTag(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final backgroundColor = tagColor ?? colorScheme.primary;

    final textColor =
        ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tag!,
        style: theme.textTheme.labelMedium?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final local = date.toLocal();

    String twoDigits(int value) {
      return value.toString().padLeft(2, '0');
    }

    return '${twoDigits(local.day)}.'
        '${twoDigits(local.month)}.'
        '${local.year} '
        '${twoDigits(local.hour)}:'
        '${twoDigits(local.minute)}';
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: colorScheme.onSurface.withValues(alpha: 0.55),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.65),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.colorScheme, this.loading = false});

  final ColorScheme colorScheme;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: double.infinity,
        color: colorScheme.onSurface.withValues(alpha: 0.06),
        child: Center(
          child: loading
              ? SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(color: colorScheme.primary),
                )
              : Icon(
                  Icons.image_outlined,
                  size: 48,
                  color: colorScheme.onSurface.withValues(alpha: 0.25),
                ),
        ),
      ),
    );
  }
}
