import 'package:flutter/material.dart';
import 'package:arabia/core/utils/app_colors.dart'; // Adjust this import according to your project structure

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const PaginationWidget({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> pageButtons = [];

    // Add previous button
    pageButtons.add(
      IconButton(
        onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
        icon: Icon(Icons.chevron_left),
        color: currentPage > 1 ? Colors.black : Colors.grey,
      ),
    );

    // Add page number buttons with ellipsis logic
    for (int i = 1; i <= totalPages; i++) {
      if (i == 1 || i == totalPages || (i >= currentPage - 1 && i <= currentPage + 1)) {
        pageButtons.add(
          ElevatedButton(
            onPressed: currentPage == i ? null : () => onPageChanged(i),
            style: ElevatedButton.styleFrom(
              backgroundColor: currentPage == i ? Colors.white : Colors.white,
              side: BorderSide(color: currentPage == i ? AppColors.blue: Colors.grey, width: 1), // Border style
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4), // Rounded corners
              ),
              padding: EdgeInsets.all(8),
              elevation: 0, // Remove shadow
            ),
            child: Text(
              '$i',
              style: TextStyle(
                color: currentPage == i ? Colors.blue : Colors.black,
                fontWeight: currentPage == i ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      } else if (i == 2 && currentPage > 3) {
        pageButtons.add(const Text("..."));
      } else if (i == totalPages - 1 && currentPage < totalPages - 2) {
        pageButtons.add(const Text("..."));
      }
    }

    // Add next button
    pageButtons.add(
      IconButton(
        onPressed: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
        icon: Icon(Icons.chevron_right),
        color: currentPage < totalPages ? Colors.black : Colors.grey,
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: pageButtons,
    );
  }
}
