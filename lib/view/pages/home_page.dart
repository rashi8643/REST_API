import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest_api_employee/model_view/employee_view_model.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Home Page',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Employee Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            switch (ref.watch(fetchDataProvider)) {
              AsyncData(:final value) => ListView.builder(
                  itemCount: value.length,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                AssetImage('assets/images/profile.png'),
                          ),
                          title: Text(value[index].employeeName!),
                          subtitle: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Salary : ${value[index].employeeSalary.toString()}',
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Age : ${value[index].employeeAge.toString()}',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              AsyncError() => const Center(
                  child: Text('Somthing Wrong'),
                ),
              _ => const Center(
                  child: CircularProgressIndicator(),
                ),
            }
          ],
        ),
      ),
    );
  }
}
