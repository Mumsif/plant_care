import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class PlantImagePicker extends StatelessWidget {
  final String? selectedImageUrl;
  final ValueChanged<String>? onImageSelected;

  const PlantImagePicker({
    super.key,
    this.selectedImageUrl,
    this.onImageSelected,
  });

  static const List<String> presetImages = [
    'https://lh3.googleusercontent.com/aida-public/AB6AXuDjl164ySO1bub0IDK6xCvpp_lSPxRMCmjFev-sc0u7_Ox3AqE1Izlrbv7KmixUUPkNFXg-6w4PMRpqOMYXUkhyrE4FuaaW0XZ-aShm6vOSqq7lsogUsaAX9lTGN9OIR2Zp2fWjUstrOAPMyV1P_gRyjhmvaonMld2UvLR2NpQ8P_VdrhJ_jwQT0Xe3wkFlILOtSyiPpC8sz660GOjqKlxVMhYwCJa2uX_ULVvg7wJFTm5u_ogk7ZHF',
    'https://lh3.googleusercontent.com/aida-public/AB6AXuDy5auWU-8XlPTGcheVE36syZxM0IuWavSfhyjsmOXPgR6mZoC8lqhQ6UUe3aJ5ZoBsmYg_fEdUe6qJ57qoNrZhvK59pGD5KR2zBA83BFb34fMdoIgJTyapb9DISGXffhXidZdcukSTWhejMpbrk6FRfOtdMRuBGCDm-Y5FGGP8RY35LGcXx3zia2BrJM6XE4MXatlZoy-StJJDjdzvuX1DMSS8AUdzhifxX8OEkjfsXYpsxxgm6vME',
    'https://lh3.googleusercontent.com/aida-public/AB6AXuAtuNdXlT0X-BcHbGNEEL67-tZbHb4E63jWVqj5cvuKnJkQ3dijJTzjV4umIUuY-zWT8K9euPePw9YEfuC8lah_0FvHMJkQB8_8WkCElPyNVdkjAIeruD1otncxOYyBi95Kx3uwKr9J_gwL7-qVk2honH6zNeAF2efpTd-5DGVvCVrL0QEg4nPyMpdtzQdpnHKboG_5gAbzaHK_1ewOWQwXt-hm4KGlz4AezvVc0yjlAXZRKQ-2m09R',
    'https://lh3.googleusercontent.com/aida-public/AB6AXuDx7GYmJkKaB-vqWNyrT6-T8BH951IfDyQKHBQBT8BQpB47hlUQKsRtre-Nslniz0sy1l2fqu38vVEioo5mAmhaV17hu1bzZ76LSl0zj1A1wfBDXek7Q3iLAksQavryeDkt1TOlQzSzQl4jHwpQ6qbTpM0Gvv8NI0SWKP-bk1L4WMp1RMQXhEBVIKSMBAQiRiD-NqtqVmixSaw49lGp8gOFmTKTMKfoWh4RjRCv8e1EC581EFKYRca3',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Plant Photo',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 72,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: presetImages.length,
            separatorBuilder: (_, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final url = presetImages[index];
              final isSelected = selectedImageUrl == url;

              return GestureDetector(
                onTap: () => onImageSelected?.call(url),
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
