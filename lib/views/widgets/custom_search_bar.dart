import 'package:flutter/material.dart';
import 'package:book_app/models/book_model/book_model.dart';

class CustomSearchBar extends StatefulWidget {
  final List<BookModel> allBooks;
  final Function(List<BookModel>) onSearchResultsChanged;

  const CustomSearchBar({
    super.key,
    required this.allBooks,
    required this.onSearchResultsChanged,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final searchTextController = TextEditingController();

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void performSearch(String query) {
    if (query.isEmpty) {
      widget.onSearchResultsChanged(widget.allBooks);
      return;
    }

    final searchResults =
        widget.allBooks.where((book) {
          final result = book.results?.firstOrNull;
          if (result == null) return false;

          final title = result.title?.toLowerCase() ?? '';
          final author = result.authors?.firstOrNull?.name?.toLowerCase() ?? '';

          return title.contains(query.toLowerCase()) ||
              author.contains(query.toLowerCase());
        }).toList();

    widget.onSearchResultsChanged(searchResults);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchTextController,
      autofocus: true,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        hintText: 'Search by title or author',
        hintStyle: const TextStyle(color: Colors.white70),
        border: InputBorder.none,
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear, color: Colors.white),
          onPressed: () {
            searchTextController.clear();
            performSearch('');
          },
        ),
      ),
      onChanged: performSearch,
    );
  }
}
