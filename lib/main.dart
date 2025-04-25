import 'package:book_app/cubit/book_cubit.dart';
import 'package:book_app/cubit/book_state.dart';
import 'package:book_app/get_it.dart';
import 'package:book_app/views/pages/book_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookCubit>(
      create: (context) => gi<BookCubit>(),
      child: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            home: BookListPage(),
          );
        },
      ),
    );
  }
}
