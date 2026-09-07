import '../models/plant.dart';
import '../models/watering_task.dart';
import '../models/user_profile.dart';
import 'mock_care_tips.dart';

class MockData {
  MockData._();

  // Plants for Alex (User 1 - exact match with HTML demo)
  static final List<Plant> alexPlants = [
    const Plant(
      id: 'p-1',
      name: 'Monstera',
      species: 'Monstera Deliciosa',
      location: 'Living Room',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDjl164ySO1bub0IDK6xCvpp_lSPxRMCmjFev-sc0u7_Ox3AqE1Izlrbv7KmixUUPkNFXg-6w4PMRpqOMYXUkhyrE4FuaaW0XZ-aShm6vOSqq7lsogUsaAX9lTGN9OIR2Zp2fWjUstrOAPMyV1P_gRyjhmvaonMld2UvLR2NpQ8P_VdrhJ_jwQT0Xe3wkFlILOtSyiPpC8sz660GOjqKlxVMhYwCJa2uX_ULVvg7wJFTm5u_ogk7ZHF',
      waterDaysLeft: 2,
      status: PlantStatus.thriving,
      isIndoor: true,
      waterAmount: '200ml',
      lightRequirement: 'Bright indirect',
    ),
    const Plant(
      id: 'p-2',
      name: 'Snake Plant',
      species: 'Sansevieria Trifasciata',
      location: 'Bedroom',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDy5auWU-8XlPTGcheVE36syZxM0IuWavSfhyjsmOXPgR6mZoC8lqhQ6UUe3aJ5ZoBsmYg_fEdUe6qJ57qoNrZhvK59pGD5KR2zBA83BFb34fMdoIgJTyapb9DISGXffhXidZdcukSTWhejMpbrk6FRfOtdMRuBGCDm-Y5FGGP8RY35LGcXx3zia2BrJM6XE4MXatlZoy-StJJDjdzvuX1DMSS8AUdzhifxX8OEkjfsXYpsxxgm6vME',
      waterDaysLeft: 5,
      status: PlantStatus.good,
      isIndoor: true,
      waterAmount: '150ml',
      lightRequirement: 'Low to bright',
    ),
    const Plant(
      id: 'p-3',
      name: 'Aloe Vera',
      species: 'Aloe Barbadensis Miller',
      location: 'Kitchen',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAtuNdXlT0X-BcHbGNEEL67-tZbHb4E63jWVqj5cvuKnJkQ3dijJTzjV4umIUuY-zWT8K9euPePw9YEfuC8lah_0FvHMJkQB8_8WkCElPyNVdkjAIeruD1otncxOYyBi95Kx3uwKr9J_gwL7-qVk2honH6zNeAF2efpTd-5DGVvCVrL0QEg4nPyMpdtzQdpnHKboG_5gAbzaHK_1ewOWQwXt-hm4KGlz4AezvVc0yjlAXZRKQ-2m09R',
      waterDaysLeft: 0,
      status: PlantStatus.needsWater,
      isIndoor: true,
      waterAmount: '100ml',
      lightRequirement: 'Direct sunlight',
    ),
    const Plant(
      id: 'p-4',
      name: 'Rubber Tree',
      species: 'Ficus Elastica',
      location: 'Office',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDx7GYmJkKaB-vqWNyrT6-T8BH951IfDyQKHBQBT8BQpB47hlUQKsRtre-Nslniz0sy1l2fqu38vVEioo5mAmhaV17hu1bzZ76LSl0zj1A1wfBDXek7Q3iLAksQavryeDkt1TOlQzSzQl4jHwpQ6qbTpM0Gvv8NI0SWKP-bk1L4WMp1RMQXhEBVIKSMBAQiRiD-NqtqVmixSaw49lGp8gOFmTKTMKfoWh4RjRCv8e1EC581EFKYRca3',
      waterDaysLeft: 1,
      status: PlantStatus.thriving,
      isIndoor: true,
      waterAmount: '250ml',
      lightRequirement: 'Medium indirect',
    ),
    const Plant(
      id: 'p-5',
      name: 'Golden Pothos',
      species: 'Epipremnum Aureum',
      location: 'Balcony',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCb3E6maTmpoxoBMcAgtolj_CiaW2ZYNw0H6yks8Wo7jcuEtNyW5UeIP2H8NpIIFAXdzNPxqGl-9nfnF6dOaow4yn0cOhmuLnn0ZjPywh4gnH3lfDrgGLTAqDKPAIGKOlPi5LDzeQW919aT-bjdaEP-pTE3FqHkJWrHnkDkMsaqiE86mxwYD82MbDovaJIwYoC-6cHX7qqXp2yB5ZOOIwCpfhfJrCtRU-pJLMfKNioquqlX0mXUB2cy',
      waterDaysLeft: 3,
      status: PlantStatus.good,
      isIndoor: false,
      waterAmount: '180ml',
      lightRequirement: 'Partial shade',
    ),
    const Plant(
      id: 'p-6',
      name: 'Fiddle Leaf Fig',
      species: 'Ficus Lyrata',
      location: 'Patio',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDA2bHoYUouTg7vf38_5lPjPHtmXutZJMCgdmMiNgmZ36vW8A0Q9OnW433DQriGuIsoiYv7LPErsSR1I686b7uKKZ1l_bfiW2irsEzt9x61vUXhgCMYl7NMQ4MKWVYVTaaMk6cSU2mFhBMuSOw_E3gDe5Eh15Dju9u_7GfanfX_zkTbAV4X5VebE6phkDWhcVpHvsjsuEINOSw2zRXkVXpg72nkktAFfx697g7fDcuz8P9C09kH-X47',
      waterDaysLeft: 0,
      status: PlantStatus.needsWater,
      isIndoor: false,
      waterAmount: '300ml',
      lightRequirement: 'Bright filtered',
    ),
  ];

  static final List<WateringTask> alexTasks = [
    const WateringTask(
      id: 't-1',
      plantId: 'p-1',
      title: 'Water Monstera',
      subtitle: 'Living Room • 200ml',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCBJJEm2gx237SHvUX1WJyCiItl4umKG0Q7jP_YS279CJp1SyM6dHly_cCtNWKRtW3qWTl8BuLUc0N-l8hyTmrKyoPN-L8ExZySiXN2FzlhImIkSY6QWXWKbVH5YgcpeTQOLrLzcuiFEhHag7kLIRJp2T52L8dXgHI3_1HqZ2Iw7hNmbnDORCVOI71z29IDWDfyeSg7OWl14ddI5qmPB5_0DAXp2LAEmoFJjdjU2SNVr3pzcOx2Ih1Y',
      actionText: 'Water Now',
      isCompleted: false,
      isWatering: true,
    ),
    const WateringTask(
      id: 't-2',
      plantId: 'p-3',
      title: 'Check Aloe Sunlight',
      subtitle: 'Kitchen Window',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD0WDjU2hOewm6R3tYNkGISMB_Q2jKZt5OYIhIGtlPrO9x1LLVVqYS7Z5CaItfQvnmkEhFdXxKP3YEEITwA2AbO_h-9y3JbhDyiaLfBFL2CjF72Fs6mTzeye0YSvr-uCUCWauQ1uVhtgPDXTefE52MpBXR2g8AjxUqVmf4geJoJdMJLc8zFkCTo8IhtEJFVaEWXQb_hd-RE7esqcruwqwQ_Sl1Tun7C_6LTg_E9YKPbxkc7BxKuDBRn',
      actionText: 'Done',
      isCompleted: false,
      isWatering: false,
    ),
  ];

  // User 1: Alex (matches HTML 2 exact values)
  static final UserProfile alex = UserProfile(
    id: 'u-1',
    name: 'Alex',
    email: 'alex.rivers@plantcare.app',
    avatarUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBOXQCzzjkUaZopmgmE_fSsmTBaGok3ZdPvuOuk3iEVzLEyrfk54t8tmjdnFZQB6dzkchWIdBQxVMuO-Kmc6c7xDfNy1nhBJx7owRJXtzmyU917WSHL8RUw0oLXg15lIzHAaFGvFXHCkCwihoyFB8ngVtMdTi1SlcihYR_DUq_Q0t11to_AqpC9KE6B0XScLxRr-rNpTZB99neXg5Yee4iQ8YS1OhlsKzaoE-_AnyMiqlyrtw00epjV',
    wateringReminders: true,
    careTipsEnabled: true,
    weeklySummary: false,
    temperatureUnit: 'Celsius (°C)',
    dateFormat: 'DD/MM/YYYY',
    themePreference: 'Light',
    plants: List.from(alexPlants),
    tasks: List.from(alexTasks),
    careTip: MockCareTips.tipAlex,
  );

  // User 2: Sarah (matches HTML 3 profile picture, different plants)
  static final List<Plant> sarahPlants = [
    const Plant(
      id: 'sp-1',
      name: 'Peace Lily',
      species: 'Spathiphyllum Wallisii',
      location: 'Bedroom Shelf',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCBJJEm2gx237SHvUX1WJyCiItl4umKG0Q7jP_YS279CJp1SyM6dHly_cCtNWKRtW3qWTl8BuLUc0N-l8hyTmrKyoPN-L8ExZySiXN2FzlhImIkSY6QWXWKbVH5YgcpeTQOLrLzcuiFEhHag7kLIRJp2T52L8dXgHI3_1HqZ2Iw7hNmbnDORCVOI71z29IDWDfyeSg7OWl14ddI5qmPB5_0DAXp2LAEmoFJjdjU2SNVr3pzcOx2Ih1Y',
      waterDaysLeft: 0,
      status: PlantStatus.needsWater,
      isIndoor: true,
      waterAmount: '180ml',
      lightRequirement: 'Low light',
    ),
    const Plant(
      id: 'sp-2',
      name: 'Boston Fern',
      species: 'Nephrolepis Exaltata',
      location: 'Bathroom',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD0WDjU2hOewm6R3tYNkGISMB_Q2jKZt5OYIhIGtlPrO9x1LLVVqYS7Z5CaItfQvnmkEhFdXxKP3YEEITwA2AbO_h-9y3JbhDyiaLfBFL2CjF72Fs6mTzeye0YSvr-uCUCWauQ1uVhtgPDXTefE52MpBXR2g8AjxUqVmf4geJoJdMJLc8zFkCTo8IhtEJFVaEWXQb_hd-RE7esqcruwqwQ_Sl1Tun7C_6LTg_E9YKPbxkc7BxKuDBRn',
      waterDaysLeft: 1,
      status: PlantStatus.thriving,
      isIndoor: true,
      waterAmount: '220ml',
      lightRequirement: 'High humidity',
    ),
    const Plant(
      id: 'sp-3',
      name: 'Bird of Paradise',
      species: 'Strelitzia Reginae',
      location: 'Garden Terrace',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDA2bHoYUouTg7vf38_5lPjPHtmXutZJMCgdmMiNgmZ36vW8A0Q9OnW433DQriGuIsoiYv7LPErsSR1I686b7uKKZ1l_bfiW2irsEzt9x61vUXhgCMYl7NMQ4MKWVYVTaaMk6cSU2mFhBMuSOw_E3gDe5Eh15Dju9u_7GfanfX_zkTbAV4X5VebE6phkDWhcVpHvsjsuEINOSw2zRXkVXpg72nkktAFfx697g7fDcuz8P9C09kH-X47',
      waterDaysLeft: 4,
      status: PlantStatus.good,
      isIndoor: false,
      waterAmount: '400ml',
      lightRequirement: 'Direct sun',
    ),
  ];

  static final List<WateringTask> sarahTasks = [
    const WateringTask(
      id: 'st-1',
      plantId: 'sp-1',
      title: 'Mist Peace Lily',
      subtitle: 'Bedroom • Morning routine',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCBJJEm2gx237SHvUX1WJyCiItl4umKG0Q7jP_YS279CJp1SyM6dHly_cCtNWKRtW3qWTl8BuLUc0N-l8hyTmrKyoPN-L8ExZySiXN2FzlhImIkSY6QWXWKbVH5YgcpeTQOLrLzcuiFEhHag7kLIRJp2T52L8dXgHI3_1HqZ2Iw7hNmbnDORCVOI71z29IDWDfyeSg7OWl14ddI5qmPB5_0DAXp2LAEmoFJjdjU2SNVr3pzcOx2Ih1Y',
      actionText: 'Water Now',
      isCompleted: false,
      isWatering: true,
    ),
  ];

  static final UserProfile sarah = UserProfile(
    id: 'u-2',
    name: 'Sarah',
    email: 'sarah.green@plantcare.app',
    avatarUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBFfev7Sr_FPbxpebX41fDqZLwb5WEG27FcQc0AIKNGj-_kLC11-jencnuOnGP0aiGg0mTvDGUvLETW8shWsIB2E48abpjInE9an95fvzcAEozF1O0pFZaawjgPnz-EEZStLbpGHzdgQqYu0WLFAL7wYBBZ3mEUYNcHr5NVJDzxNY2sVWJUP1OctP69u29xUR1ZqBOPAQE42g6J9P_pH5GxnHVBur3b-QnDq6OLIdjdTAsKbQI_r4kF',
    wateringReminders: true,
    careTipsEnabled: true,
    weeklySummary: true,
    temperatureUnit: 'Fahrenheit (°F)',
    dateFormat: 'MM/DD/YYYY',
    themePreference: 'Light',
    plants: List.from(sarahPlants),
    tasks: List.from(sarahTasks),
    careTip: MockCareTips.tipSarah,
  );

  // User 3: David (Minimalist balcony garden)
  static final List<Plant> davidPlants = [
    const Plant(
      id: 'dp-1',
      name: 'Jade Plant',
      species: 'Crassula Ovata',
      location: 'Desk',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAtuNdXlT0X-BcHbGNEEL67-tZbHb4E63jWVqj5cvuKnJkQ3dijJTzjV4umIUuY-zWT8K9euPePw9YEfuC8lah_0FvHMJkQB8_8WkCElPyNVdkjAIeruD1otncxOYyBi95Kx3uwKr9J_gwL7-qVk2honH6zNeAF2efpTd-5DGVvCVrL0QEg4nPyMpdtzQdpnHKboG_5gAbzaHK_1ewOWQwXt-hm4KGlz4AezvVc0yjlAXZRKQ-2m09R',
      waterDaysLeft: 6,
      status: PlantStatus.thriving,
      isIndoor: true,
      waterAmount: '80ml',
      lightRequirement: 'Direct sun',
    ),
    const Plant(
      id: 'dp-2',
      name: 'String of Pearls',
      species: 'Senecio Rowleyanus',
      location: 'South Window',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCb3E6maTmpoxoBMcAgtolj_CiaW2ZYNw0H6yks8Wo7jcuEtNyW5UeIP2H8NpIIFAXdzNPxqGl-9nfnF6dOaow4yn0cOhmuLnn0ZjPywh4gnH3lfDrgGLTAqDKPAIGKOlPi5LDzeQW919aT-bjdaEP-pTE3FqHkJWrHnkDkMsaqiE86mxwYD82MbDovaJIwYoC-6cHX7qqXp2yB5ZOOIwCpfhfJrCtRU-pJLMfKNioquqlX0mXUB2cy',
      waterDaysLeft: 0,
      status: PlantStatus.needsWater,
      isIndoor: true,
      waterAmount: '60ml',
      lightRequirement: 'Bright indirect',
    ),
  ];

  static final List<WateringTask> davidTasks = [
    const WateringTask(
      id: 'dt-1',
      plantId: 'dp-2',
      title: 'Water String of Pearls',
      subtitle: 'South Window • 60ml',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCb3E6maTmpoxoBMcAgtolj_CiaW2ZYNw0H6yks8Wo7jcuEtNyW5UeIP2H8NpIIFAXdzNPxqGl-9nfnF6dOaow4yn0cOhmuLnn0ZjPywh4gnH3lfDrgGLTAqDKPAIGKOlPi5LDzeQW919aT-bjdaEP-pTE3FqHkJWrHnkDkMsaqiE86mxwYD82MbDovaJIwYoC-6cHX7qqXp2yB5ZOOIwCpfhfJrCtRU-pJLMfKNioquqlX0mXUB2cy',
      actionText: 'Water Now',
      isCompleted: false,
      isWatering: true,
    ),
  ];

  static final UserProfile david = UserProfile(
    id: 'u-3',
    name: 'David',
    email: 'david.chen@plantcare.app',
    avatarUrl:
        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200&auto=format&fit=crop&q=80',
    wateringReminders: false,
    careTipsEnabled: true,
    weeklySummary: false,
    temperatureUnit: 'Celsius (°C)',
    dateFormat: 'DD/MM/YYYY',
    themePreference: 'Dark',
    plants: List.from(davidPlants),
    tasks: List.from(davidTasks),
    careTip: MockCareTips.tipDavid,
  );

  static List<UserProfile> get allUsers => [alex, sarah, david];
}
