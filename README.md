# Inventory Management App

A fully functional Flutter application for managing inventory items with real-time synchronization to Firebase Firestore. This app provides a comprehensive solution for tracking inventory with CRUD operations, advanced search and filtering capabilities, and data insights dashboard.

## Features

### Core CRUD Operations
- **Create**: Add new inventory items with name, quantity, price, and category
- **Read**: View all inventory items in a real-time updated list
- **Update**: Edit existing items with pre-filled form data
- **Delete**: Remove items with confirmation dialog
- **Real-time Updates**: All changes sync automatically across devices using Firestore streams

### Enhanced Features

#### 1. Advanced Search & Filtering
- **Real-time Search**: Search items by name (case-insensitive) as you type
- **Category Filtering**: Filter items by category using filter chips
- **Stock Status Filter**: Filter items by stock status (All Items, Low Stock)
- **Combined Filters**: Use search, category, and stock filters simultaneously
- **Visual Indicators**: Low stock items (quantity < 5) are highlighted with warning icons

#### 2. Data Insights Dashboard
- **Total Items Count**: Display total number of unique inventory items
- **Total Inventory Value**: Calculate and display sum of (quantity × price) for all items
- **Out-of-Stock Items**: List all items with quantity ≤ 0
- **Category Breakdown**: Show items grouped by category with counts
- **Real-time Statistics**: All metrics update automatically when inventory changes

## Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (version 3.9.0 or higher)
  - Download from: https://docs.flutter.dev/get-started/install
  - Verify installation: `flutter doctor`

- **Dart SDK** (included with Flutter)

- **Firebase Account**
  - Create a free account at: https://firebase.google.com/
  - Access to Firebase Console

## Setup Instructions

### 1. Clone the Repository

```bash
git clone <your-repository-url>
cd act15_mad
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

#### Step 1: Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" or select existing project
3. Enter project name: `inventory-app-yourname`
4. Follow the setup wizard

#### Step 2: Enable Firestore Database
1. In Firebase Console, navigate to **Firestore Database**
2. Click **Create database**
3. Select **Start in test mode** (allows read/write for 30 days)
4. Choose a location (e.g., `us-central1`)
5. Click **Enable**

#### Step 3: Configure Firestore Security Rules
1. In Firestore Database, go to **Rules** tab
2. Set rules to test mode:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```
3. Click **Publish**

#### Step 4: Configure Flutter App with Firebase
1. Install FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

2. Configure Firebase for your Flutter project:
```bash
flutterfire configure
```

3. Select your Firebase project when prompted
4. Select platforms: android, ios, web, windows, macos

This will generate `lib/firebase_options.dart` automatically.

## How to Run the App

### Run on Connected Device/Emulator

**Run the app:**
```bash
flutter run
```


## APK Build Instructions

### Build Release APK

1. **Build the APK:**
```bash
flutter build apk --release
```

## Project Structure

```
lib/
├── main.dart                 # App entry point and Firebase initialization
├── firebase_options.dart     # Firebase configuration (auto-generated)
├── models/
│   └── item.dart            # Item data model with Firestore serialization
├── services/
│   └── firestore_service.dart  # Firestore CRUD operations service
└── screens/
    ├── inventory_home_page.dart    # Main screen with item list and search
    ├── add_edit_item_screen.dart   # Form for adding/editing items
    └── dashboard_screen.dart       # Data insights and statistics
```

## Usage Guide

### Adding an Item
1. Tap the **+** (FloatingActionButton) on the home screen
2. Fill in the form:
   - **Name**: Item name (required)
   - **Quantity**: Positive integer (required)
   - **Price**: Positive decimal number (required)
   - **Category**: Item category (required)
3. Tap **Save**

### Editing an Item
1. Tap on any item in the list
2. Modify the fields as needed
3. Tap **Save**

### Deleting an Item
1. Tap on an item to open edit screen
2. Tap the **delete icon** in the app bar
3. Confirm deletion in the dialog

### Searching Items
1. Use the search bar in the app bar
2. Type item name (case-insensitive)
3. Results filter in real-time

### Filtering Items
1. Use **Category** filter chips to filter by category
2. Use **Stock** filter chips to filter by stock status
3. Combine multiple filters for precise results

### Viewing Dashboard
1. Tap the **dashboard icon** in the home screen app bar
2. View:
   - Total items count
   - Total inventory value
   - Out-of-stock items list
   - Category breakdown

## Dependencies

- `flutter`: SDK framework
- `firebase_core: ^2.24.0`: Firebase core functionality
- `cloud_firestore: ^4.9.5`: Firestore database integration
- `cupertino_icons: ^1.0.8`: iOS-style icons

## License

This project is created for educational purposes as part of MAD (Mobile Application Development) coursework.

## Author

Sanjay Reddy

## Version

1.0.0
