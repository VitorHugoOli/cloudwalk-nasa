import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final void Function() onNext;
  final void Function() onPrevious;

  const PaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, size: 16),
              onPressed: currentPage == 1 ? null : onPrevious,
              disabledColor: Colors.grey,
            ),
            Text(
              '$currentPage/$totalPages',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward, size: 16),
              onPressed: currentPage == totalPages ? null : onNext,
              disabledColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
