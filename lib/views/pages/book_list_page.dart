import 'package:book_app/cubit/book_cubit.dart';
import 'package:book_app/cubit/book_state.dart';
import 'package:book_app/models/book_model/book_model.dart';
import 'package:book_app/views/widgets/book_item.dart';
import 'package:book_app/views/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final searchTextController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<BookModel> allBooks = [];
  List<BookModel> searchForBook = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    loadInitialBooks();
    setupScrollListener();
  }

  void loadInitialBooks() {
    BookCubit.get(context).getAllBooks(isRefresh: true);
  }

  void setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        BookCubit.get(context).getAllBooks();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchTextController.dispose();
    super.dispose();
  }

  void startSearch() {
    ModalRoute.of(
      context,
    )!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearch));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearch() {
    clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [];
    } else {
      return [
        IconButton(
          onPressed: startSearch,
          icon: const Icon(Icons.search, color: Colors.white),
        ),
      ];
    }
  }

  void handleSearchResults(List<BookModel> results) {
    setState(() {
      searchForBook = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        leading: isSearching ? const BackButton(color: Colors.white) : null,
        title:
            isSearching
                ? CustomSearchBar(
                  allBooks: allBooks,
                  onSearchResultsChanged: handleSearchResults,
                )
                : const Text(
                  'Books Library',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        actions: buildAppBarActions(),
      ),
      body: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) {
          if (state is BookLoadingState && allBooks.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              ),
            );
          } else if (state is BookSuccessState) {
            allBooks = state.books;
            final displayBooks = isSearching ? searchForBook : allBooks;

            if (displayBooks.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isSearching ? 'No books found' : 'No books available',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              color: Colors.deepPurple,
              onRefresh: () async {
                await BookCubit.get(context).getAllBooks(isRefresh: true);
              },
              child: ListView.builder(
                controller: scrollController,
                itemCount: displayBooks.length + 1,
                itemBuilder: (context, index) {
                  if (index < displayBooks.length) {
                    return BookItem(book: displayBooks[index]);
                  } else if (state is BookLoadingState && !isSearching) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.deepPurple,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            );
          } else if (state is BookErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
                  const SizedBox(height: 16),
                  Text(
                    state.error,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed:
                        () =>
                            BookCubit.get(context).getAllBooks(isRefresh: true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Retry', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
