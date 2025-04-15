import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/database_helper.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  // Lấy danh sách Task từ database
  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    _tasks = await DatabaseHelper.instance.getTasks();

    if (_tasks.isEmpty) {
      // Thêm dữ liệu mẫu nếu không có task nào
      await addSampleTasks();
      _tasks = await DatabaseHelper.instance.getTasks();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Thêm một task mới
  Future<void> addTask(Task task) async {
    await DatabaseHelper.instance.insertTask(task);
    await loadTasks();
  }

  // Xóa task
  Future<void> deleteTask(int id) async {
    await DatabaseHelper.instance.deleteTask(id);
    await loadTasks();
  }

  // Cập nhật task
  Future<void> updateTask(Task task) async {
    await DatabaseHelper.instance.updateTask(task);
    await loadTasks();
  }

  // Thêm dữ liệu mẫu
  Future<void> addSampleTasks() async {
    List<Task> sampleTasks = [
      Task(
        title: 'Complete Android Project',
        description: 'Finish the UI, integrate API, and write documentation',
        colorHex: '#AED9E0', // Màu xanh nhạt
      ),
      Task(
        title: 'Complete Android Project',
        description: 'Finish the UI, integrate API, and write documentation',
        colorHex: '#FFC2C2', // Màu hồng nhạt
      ),
      Task(
        title: 'Complete Android Project',
        description: 'Finish the UI, integrate API, and write documentation',
        colorHex: '#E8EABD', // Màu vàng nhạt
      ),
      Task(
        title: 'Complete Android Project',
        description: 'Finish the UI, integrate API, and write documentation',
        colorHex: '#FFC2C2', // Màu hồng nhạt
      ),
    ];

    for (var task in sampleTasks) {
      await DatabaseHelper.instance.insertTask(task);
    }
  }

  // Chuyển đổi chuỗi hex sang màu
  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse('0x$hexColor'));
  }
}
