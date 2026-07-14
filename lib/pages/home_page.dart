import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/models/to_do_model.dart';
import 'package:to_do_app/providers/auth_provider.dart';
import 'package:to_do_app/services/database_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<List<ToDoModel>>(context);
    final databaseServices = Provider.of<DatabaseService>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To do List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logOut();
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: todos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_add,
                    size: 44,
                    color: AppColors.primary.withOpacity(.5),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'no to do yet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (_, index) =>
                  ListTile(title: Text(todos[index].title)),
              itemCount: todos.length,
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
