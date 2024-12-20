import 'package:flutter/material.dart';
import '../widgets/project_card.dart';

class ProjectsScreen extends StatelessWidget {
  final List<Map<String, String>> projects = [
    {"title": "Portfolio App", "description": "A modern app showcasing my work."},
    {"title": "E-Commerce App", "description": "An app for seamless online shopping."},
    {"title": "Task Manager", "description": "A productivity app to manage tasks."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Projects"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ProjectCard(
            title: projects[index]['title']!,
            description: projects[index]['description']!,
          );
        },
      ),
    );
  }
}
