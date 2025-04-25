import 'package:book_app/models/book_model/book_model.dart';

abstract class BookState {}

class BookInitialState extends BookState {}

class BookLoadingState extends BookState {}

class BookSuccessState extends BookState {
  final List<BookModel> books;

  BookSuccessState(this.books);
}

class BookErrorState extends BookState {
  final String error;

  BookErrorState(this.error);
}
