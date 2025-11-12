import 'package:admin_pannel/presentation/pages/ui/widgets/banner/bloc/banner_bloc.dart';
import 'package:admin_pannel/presentation/pages/ui/widgets/banner/bloc/banner_event.dart';
import 'package:admin_pannel/presentation/pages/ui/widgets/banner/bloc/banner_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerUploader extends StatelessWidget {
  const BannerUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController urlTextController = TextEditingController();

    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  state is BannerImageSelected
                      ? Colors.blue.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.3),
              width: 2,
            ),
            color:
                state is BannerImageSelected
                    ? Colors.transparent
                    : Colors.grey.withOpacity(0.05),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ─── Image Container ───
              InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => context.read<BannerBloc>().add(PickImageEvent()),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: _buildContent(state),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ─── Show TextField after image is selected ───
              if (state is BannerImageSelected) ...[
                TextFormField(
                  controller: urlTextController,
                  decoration: InputDecoration(
                    labelText: "Redirect URL",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.link),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // ─── Save Button ───
              if (state is BannerImageSelected)
                AnimatedScale(
                  scale: state is BannerUploading ? 0.9 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap:
                          state is BannerUploading
                              ? null
                              : () {
                                context.read<BannerBloc>().add(
                                  UploadImageEvent(
                                    state.imageBytes,
                                    state.fileName,
                                    urlTextController.text,
                                  ),
                                );
                              },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors:
                                state is BannerUploading
                                    ? [Colors.grey, Colors.grey.shade400]
                                    : [Colors.blue, Colors.blue.shade700],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (state is BannerUploading)
                              const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            else
                              const Icon(
                                Icons.save,
                                color: Colors.white,
                                size: 16,
                              ),
                            const SizedBox(width: 6),
                            Text(
                              state is BannerUploading ? 'Saving...' : 'Save',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent(BannerState state) {
    if (state is BannerImageSelected) {
      return Image.memory(
        state.imageBytes,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add_photo_alternate_outlined,
              size: 32,
              color: Colors.blue.shade600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Tap to select banner image',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'PNG, JPG up to 10MB',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
