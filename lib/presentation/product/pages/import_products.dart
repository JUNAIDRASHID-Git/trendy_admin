import 'package:admin_pannel/presentation/product/bloc/product_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExcelUploadWidget extends StatelessWidget {
  const ExcelUploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ExcelUploadSuccess) {
          _showMessage(context, "Upload successfully", isSuccess: true);
        } else if (state is ExcelUploadFailure) {
          _showMessage(
            context,
            "Upload failed: ${state.error}",
            isSuccess: false,
          );
        }
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Excel Product Upload",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              _buildUploadArea(context),
              const SizedBox(height: 16),
              if (state is ExcelUploadInProgress)
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUploadArea(BuildContext context) {
    return InkWell(
      onTap: () => _pickExcelFile(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 1),
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor.withOpacity(0.05),
        ),
        child: Column(
          children: [
            Icon(
              Icons.upload_file,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 8),
            const Text('Click to select Excel file (.xlsx)'),
          ],
        ),
      ),
    );
  }

  void _showMessage(
    BuildContext context,
    String message, {
    required bool isSuccess,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: isSuccess ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor:
            isSuccess
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _pickExcelFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      withData: true,
    );

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;
    context.read<ProductBloc>().add(
      UploadExcelFileEvent(fileName: file.name, excelBytes: file.bytes!),
    );
  }
}
