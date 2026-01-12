# Smart Medicine Reminder 💊

A comprehensive Flutter application designed to help elders manage their medications and enable caregivers to monitor and support medication adherence. The app features dual-mode functionality optimized for both elderly users and healthcare professionals.


## Application Installation

###App Path###
```bash
https://github.com/sanjib994/Smart_medicine_reminder/main/MEDIFIT.apk
```
1. Go to the Path
2. Click on the `Download icon (Download raw file)` button at right-hand side or click `view raw` in the center to download the application
3. Install and open in Android


## 🎯 Features

### For Elders
- **Medicine Schedule**: Easy-to-read daily medicine schedule with clear timing
- **Quick Mark-As-Taken**: One-tap confirmation when medicine is taken
- **Progress Tracking**: Visual progress ring showing today's medication completion
- **Medicine Timeline**: Chronological view of scheduled medicines
- **SOS Emergency Button**: Quick emergency contact (red FAB)
- **Voice Alerts**: Text-to-speech reminders for medicine times
- **Location Services**: GPS tracking for safety monitoring
- **Settings Dashboard**: Personalized reminders and preferences

### For Caregivers
- **Patient Dashboard**: Overview of all patients' medication status
- **Medicine Management**: Add, edit, and manage patient medications
- **Health Reports**: Detailed analytics and adherence reports
- **Alert Monitoring**: Real-time alerts for missed or taken medicines
- **GPS Tracking**: Location monitoring of elderly patients
- **Notification System**: Push notifications for important events

### Core Features
- 🔐 **Firebase Authentication**: Secure login with Firebase Auth
- 🗄️ **Cloud Database**: Real-time data sync with Cloud Firestore
- 📱 **Cross-Platform**: Works on Android and iOS
- 🎨 **Modern UI**: Beautiful, intuitive interface with smooth animations
- ♿ **Accessibility**: WCAG AAA color contrast, touch targets ≥ 56dp
- 🎬 **Smooth Animations**: 60fps transitions and page animations
- 💾 **Offline Support**: Works offline with local caching

## 🏗️ Architecture

The app uses a clean, scalable architecture:

```
lib/
├── core/              # Theme, constants, utilities
├── models/            # Data models
├── providers/         # State management (Provider)
├── screens/           # UI screens
│   ├── elder/        # Elder user screens
│   └── caregiver/    # Caregiver user screens
├── services/          # Firebase, notifications, location
├── widgets/           # Reusable UI components
└── main.dart         # App entry point
```

### Key Architecture Components

- **State Management**: Provider for reactive state management
- **Firebase Integration**: Auth, Firestore, Cloud Messaging
- **Navigation**: Custom navigation shells with animated transitions
- **Theme System**: Centralized theme with AppColors and AppTypography
- **Providers**:
  - `MedicineProvider`: Medicine data management
  - `MedicineHistoryProvider`: Medicine taken history
  - `AlertProvider`: Alert notifications
  - `SettingsProvider`: User preferences
 

## 🚀 Getting Started

### Prerequisites

- Flutter SDK >= 3.22.0
- Dart >= 3.2.0
- Android Studio / Xcode
- Firebase account

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/smart-medicine-reminder.git
cd smart-medicine-reminder
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Set up Firebase**
   - Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
   - Add Android and iOS apps
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the appropriate directories

4. **Run the app**
```bash
flutter run
```

## 📦 Dependencies

### Core Flutter
- `flutter_sdk`: Material Design components

### Backend & Authentication
- `firebase_core: ^3.15.2` - Firebase initialization
- `firebase_auth: ^5.7.0` - User authentication
- `cloud_firestore: ^5.0.0` - Real-time database

### State Management
- `provider: ^6.1.2` - Reactive state management

### Notifications & Reminders
- `flutter_local_notifications: ^17.0.0` - Local push notifications
- `flutter_tts: ^4.0.0` - Text-to-speech for alerts

### Utilities
- `intl: ^0.19.0` - Internationalization and date formatting
- `google_fonts: ^6.2.1` - Custom fonts
- `shared_preferences: ^2.2.2` - Local data persistence
- `url_launcher: ^6.2.2` - Open URLs and emails
- `geolocator: ^12.0.0` - GPS location services

## 🎨 Design System

### Colors
- **Primary**: Teal (#4DB8C4)
- **Success**: Green (#28A745)
- **Warning**: Orange (#FF9800)
- **Danger**: Red (#DC3545)
- **Dark Background**: #1F1F23

### Typography
- **Headline**: Roboto 32sp Bold
- **Title**: Roboto 20sp Bold
- **Body**: Roboto 14sp Regular
- **Captions**: Roboto 12sp Regular

### Animations
- Fade transitions: 400ms
- Slide transitions: 500ms
- Scale transitions: 400ms
- Bounce transitions: 600ms

## 🔧 Development

### Project Structure
- `ARCHITECTURE_GUIDE.md` - Detailed architecture documentation
- `DATABASE_SETUP.md` - Firebase setup instructions
- `NAVIGATION_IMPLEMENTATION.md` - Navigation flow documentation
- `QUICK_REFERENCE.md` - Quick developer reference

### Build & Test

**Debug Build**
```bash
flutter run
```

**Release Build**
```bash
flutter build apk    # Android
flutter build ipa    # iOS
```

**Run Tests**
```bash
flutter test
```

### Code Quality

The project maintains high code quality:
- ✅ Zero compilation errors
- ✅ Zero lint warnings
- ✅ Type-safe Dart code
- ✅ Clean architecture principles
- ✅ Comprehensive error handling

## 📖 User Workflows

### Elder User Journey
1. Launch app → Mode Selection
2. Login with credentials
3. View today's medicine schedule
4. Tap medicine to mark as taken
5. Check progress and history
6. Adjust settings as needed

### Caregiver User Journey
1. Launch app → Mode Selection
2. Login/Register as caregiver
3. View patient overview dashboard
4. Add/manage patient medicines
5. Monitor adherence with reports
6. Receive real-time alerts

## 🔐 Security & Privacy

- Firebase Authentication with email/password
- Secure Firestore rules for data access
- Encrypted sensitive data
- Local secure storage with Shared Preferences
- HIPAA-compliant architecture ready

## 🚧 Future Enhancements

- [ ] Biometric authentication (fingerprint, face recognition)
- [ ] Medication interactions database
- [ ] Integration with wearable devices
- [ ] WhatsApp integration for notifications
- [ ] Family tree / multiple caregivers
- [ ] Prescription import from pharmacies
- [ ] AI-based adherence prediction
- [ ] Dark mode support

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 👥 Authors

- Sanjib Ghara
- Soumodip Ghosh

## 📞 Support

For support, message us or open an issue on GitHub.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Material Design for UI guidelines
- Community contributors
