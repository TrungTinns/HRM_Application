# Flutter Project Setup Guide

This guide will walk you through the steps to set up and run the Flutter source code on your local machine.

## Prerequisites

Before you begin, make sure you have the following installed:

- **Flutter SDK:** [Install Flutter](https://flutter.dev/docs/get-started/install) by following the official documentation.
- **IDE (Optional):** Use either Android Studio or Visual Studio Code for easier development.
- **Android Emulator or Physical Device:** Ensure you have an Android emulator set up or connect a physical device with USB debugging enabled.
- **Dart SDK:** This is bundled with the Flutter SDK, but verify it is set up correctly.
- **Xcode (for iOS development):** Required for running the project on iOS devices (only on Mac).

## Getting Started

1. **Clone the Repository:**
   ```bash
   git clone <your-repository-url>
   cd <your-project-directory>

2. **Install Dependencies:**
    Navigate to the project directory and run:
    bashCopyflutter pub get
    This command will fetch all the packages listed in the pubspec.yaml file.


3. **Set Up a Connected Device or Emulator: **
    Ensure you have either a physical device connected or an emulator running.
    To check available devices, run:
    bashCopyflutter devices

4. **Run the Project: **
    Run the project on the available device with:
    bashCopyflutter run
    You can also run the project directly from your IDE (e.g., Android Studio, Visual Studio Code) by selecting the target device and pressing Run.