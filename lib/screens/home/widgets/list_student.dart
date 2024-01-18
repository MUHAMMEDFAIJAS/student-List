import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_3/db/functions/dbfunctions.dart';
import 'package:hive_3/model/datamodel.dart';
import 'package:hive_3/screens/home/widgets/profilepage.dart';
import 'editstudent.dart';

class ListStudent extends StatelessWidget {
  ListStudent({Key? key}) : super(key: key);



  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              
              searchStudents(value); 
            },
            decoration: const InputDecoration(
              hintText: 'Search students',
              icon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: studentListNotifier,
            builder: (BuildContext ctx, List<StudentModel> studentList,
                Widget? child) {
              return ListView.separated(
                itemBuilder: (ctx, index) {
                  final data = studentList[index];
                  return ListTile(
                    title: Text(data.name),
                    subtitle: Text(data.age),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(student: data),
                        ),
                      );
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditStudent(
                                  index: index,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteStudents(index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(

  backgroundImage: data.imagePath != null
    ? FileImage(File(data.imagePath!))
    : const NetworkImage(
        'https://tse2.mm.bing.net/th?id=OIP.x7X2oAehk5M9IvGwO_K0PgHaHa&pid=Api&P=0&h=180'
      ) as ImageProvider,
),

                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider();
                },
                itemCount: studentList.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
