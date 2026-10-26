import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';

// Nama: Gena Anggarani
// NIM: 2415051038

class EditCoursePage extends StatefulWidget {
  final Course course;

  const EditCoursePage({
    super.key,
    required this.course,
  });

  @override
  State<EditCoursePage> createState() => _EditCoursePageState();
}

class _EditCoursePageState extends State<EditCoursePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _codeController;
  late final TextEditingController _titleController;
  late final TextEditingController _creditsController;

  late String _status;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(
      text: widget.course.code,
    );
    _titleController = TextEditingController(
      text: widget.course.title,
    );
    _creditsController = TextEditingController(
      text: widget.course.credits.toString(),
    );
    _status = widget.course.status;
  }

  @override
  void dispose() {
    _codeController.dispose();
    _titleController.dispose();
    _creditsController.dispose();
    super.dispose();
  }

  Future<void> _updateCourse() async {
    if (!_formKey.currentState!.validate()) return;

    final id = widget.course.id;
    if (id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ID course tidak tersedia.'),
        ),
      );
      return;
    }

    final updatedCourse = Course(
      id: id,
      code: widget.course.code,
      title: _titleController.text.trim(),
      credits: int.parse(_creditsController.text.trim()),
      status: _status,
      createdAt: widget.course.createdAt,
    );

    try {
      await context.read<CourseProvider>().updateCourse(
            id,
            updatedCourse,
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Course berhasil diperbarui.'),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui course: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUpdating =
        context.watch<CourseProvider>().isUpdating;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Course'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Perbarui Mata Kuliah',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _codeController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Kode Course',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Nama Course',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama course wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _creditsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Credits (SKS)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Credits wajib diisi';
                  }
                  final credits = int.tryParse(value.trim());
                  if (credits == null || credits <= 0) {
                    return 'Masukkan angka bulat lebih dari 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'planned',
                    child: Text('Planned'),
                  ),
                  DropdownMenuItem(
                    value: 'active',
                    child: Text('Active'),
                  ),
                  DropdownMenuItem(
                    value: 'done',
                    child: Text('Done'),
                  ),
                ],
                onChanged: isUpdating
                    ? null
                    : (value) {
                        if (value != null) {
                          setState(() => _status = value);
                        }
                      },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: isUpdating ? null : _updateCourse,
                icon: isUpdating
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.save),
                label: Text(
                  isUpdating ? 'Menyimpan...' : 'Simpan Perubahan',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}