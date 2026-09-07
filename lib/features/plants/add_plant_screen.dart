import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../data/app_state.dart';
import '../../models/plant.dart';
import '../../shared/widgets/app_text_field.dart';
import 'widgets/add_plant_success_sheet.dart';
import 'widgets/plant_image_picker.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _nameController = TextEditingController();
  final _speciesController = TextEditingController();
  final _locationController = TextEditingController();
  String _selectedImage = PlantImagePicker.presetImages.first;
  bool _isIndoor = true;
  int _waterDays = 3;

  @override
  void dispose() {
    _nameController.dispose();
    _speciesController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _savePlant() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a plant name')),
      );
      return;
    }

    final appState = AppStateProvider.of(context);
    final newPlant = Plant(
      id: 'p-${DateTime.now().millisecondsSinceEpoch}',
      name: _nameController.text.trim(),
      species: _speciesController.text.trim().isEmpty
          ? 'Unknown Species'
          : _speciesController.text.trim(),
      location: _locationController.text.trim().isEmpty
          ? 'Indoor'
          : _locationController.text.trim(),
      imageUrl: _selectedImage,
      waterDaysLeft: _waterDays,
      status: PlantStatus.thriving,
      isIndoor: _isIndoor,
    );

    appState.addPlant(newPlant);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (sheetContext) => AddPlantSuccessSheet(
        plant: newPlant,
        onViewPlants: () {
          Navigator.pop(context);
        },
      ),
    ).then((_) {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Add New Plant', style: TextStyle(fontSize: 20)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.marginHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlantImagePicker(
              selectedImageUrl: _selectedImage,
              onImageSelected: (url) => setState(() => _selectedImage = url),
            ),
            const SizedBox(height: 24),
            const Text(
              'Plant Name',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 6),
            AppTextField(
              controller: _nameController,
              hintText: 'e.g. Monstera Deliciosa',
            ),
            const SizedBox(height: 16),
            const Text(
              'Species / Variety',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 6),
            AppTextField(
              controller: _speciesController,
              hintText: 'e.g. Araceae',
            ),
            const SizedBox(height: 16),
            const Text(
              'Location',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 6),
            AppTextField(
              controller: _locationController,
              hintText: 'e.g. Living Room Window',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Indoor Plant',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                Switch(
                  value: _isIndoor,
                  activeThumbColor: AppColors.primary,
                  activeTrackColor: AppColors.secondaryContainer,
                  onChanged: (val) => setState(() => _isIndoor = val),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Watering Interval',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                Text(
                  'Every $_waterDays days',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            Slider(
              value: _waterDays.toDouble(),
              min: 1,
              max: 14,
              divisions: 13,
              activeColor: AppColors.primary,
              onChanged: (val) => setState(() => _waterDays = val.round()),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _savePlant,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Save Plant',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
