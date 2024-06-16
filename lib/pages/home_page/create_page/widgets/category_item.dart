import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final bool selected;
  final Function(String id) onTap;
  final String id;
  const CategoryItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.selected,
    required this.onTap,
    required this.id,
  });
  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.id);
      },
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: widget.selected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              width: 72,
              height: 72,
              padding: EdgeInsets.all(4),
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.fill,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: child,
                  );
                },
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
