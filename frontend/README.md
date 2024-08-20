# Getting Started with the Flutter Project

This guide will walk you through setting up and running the Flutter source code on your local machine.

## Prerequisites

Before running the project, ensure that you have the following installed:

- **Flutter SDK**:  
  Install Flutter by following the [official documentation](https://flutter.dev/docs/get-started/install).

- **Android Studio / Visual Studio Code (Optional)**:  
  IDEs for easier Flutter development.

- **Android Emulator or Physical Device**:  
  Ensure you have an emulator set up or connect a physical device with USB debugging enabled.

- **Dart SDK**:  
  Comes bundled with Flutter, but ensure it's set up correctly.

- **Xcode (for iOS development)**:  
  Required if you plan to run the project on iOS. Make sure you have a Mac machine with Xcode installed.

## Getting Started

### 1. Clone the Repository

```bash
git clone <your-repository-url>
cd <your-project-directory>
2. Install Dependencies
Navigate to the project directory and run:

bash
Sao chép mã
flutter pub get
This command fetches all the packages listed in the pubspec.yaml file.

3. Set Up a Connected Device or Emulator
Ensure you have either a physical device connected or an emulator running.

To check available devices, run:

bash
Sao chép mã
flutter devices
4. Run the Project
Use the following command to run the project on the available device:

bash
Sao chép mã
flutter run
You can also run the project directly from your IDE (e.g., Android Studio, Visual Studio Code) by selecting the target device and pressing Ru
