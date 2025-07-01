import 'package:admin_pannel/core/services/models/banner/banner.dart';
import 'package:admin_pannel/presentation/pages/ui/bloc/ui_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget bannerListContainer(List<BannerModel> banners) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView.builder(
      itemCount: banners.length,
      itemBuilder: (context, index) {
        final banner = banners[index];
        return Dismissible(
          key: Key(banner.id.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.85),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('Delete Banner'),
                    content: const Text(
                      'Are you sure you want to delete this banner?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
            );
          },
          onDismissed: (direction) {
            context.read<UiBloc>().add(DeleteBannerEvent(bannerID: banner.id));
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              banner.imageUrl,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Text("Image failed to load")),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        );
      },
    ),
  );
}
