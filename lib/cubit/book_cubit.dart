import 'package:book_app/cubit/book_state.dart';
import 'package:book_app/models/book_model/book_model.dart';
import 'package:book_app/service/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookCubit extends Cubit<BookState> {
  final Repository repository;
  List<BookModel> books = [];
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;

  BookCubit(this.repository) : super(BookInitialState());

  static BookCubit get(context) => BlocProvider.of(context);

  Future<void> getAllBooks({bool isRefresh = false}) async {
    if (isLoading || (!hasMore && !isRefresh)) return;

    try {
      if (isRefresh) {
        page = 1;
        books.clear();
        hasMore = true;
        emit(BookLoadingState());
      }

      isLoading = true;
      final newBooks = await repository.getAllBooks(page: page);

      if (newBooks.isEmpty) {
        hasMore = false;
      } else {
        if (isRefresh) {
          books = newBooks;
        } else {
          books.addAll(newBooks);
        }
        page++;
      }

      emit(BookSuccessState(books));
    } catch (e) {
      emit(BookErrorState(e.toString()));
    } finally {
      isLoading = false;
    }
  }
}
