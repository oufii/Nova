# Nova AI (UI-only phase)

Flutter Android app + static website. No real AI, API, database or auth: only mock services.

## Requirements
Windows 10 64-bit, Flutter SDK (stable), Android Studio (Android SDK + cmdline tools; emulator optional), Python 3 or any static server for the website.

## Run the mobile app
```
cd mobile
flutter create . --platforms=android   # generates android/ once; keeps lib/ and pubspec.yaml
flutter pub get
flutter run                            # best on a real phone with USB debugging (8GB RAM friendly)
```

## Build the APK
```
cd mobile
flutter build apk --release
```
Output: `mobile/build/app/outputs/flutter-apk/app-release.apk`
Copy it to `website/public/downloads/app.apk`.

## Run the website
```
cd website/public
python -m http.server 8080
```
Open http://localhost:8080 (plain HTML/CSS, no build step).

## Structure
- `mobile/lib/core` theme and `locator.dart` (the single place mocks are swapped)
- `mobile/lib/models` User, Conversation, Message, UserSettings
- `mobile/lib/services/ai_service.dart` AI interface; `api_service.dart` API placeholder (`YOUR_API_URL_HERE`)
- `mobile/lib/repositories` repository interfaces
- `mobile/lib/mock` MockAIService + mock data (delete later)
- `mobile/lib/screens`, `widgets` UI and reusable components
- `website/public` site, `downloads/` APK placeholder

## Replacing Mock AI later
1. Create `RealAIService implements AIService` in `services/`.
2. In `core/locator.dart` change `MockAIService()` to `RealAIService()`.
3. Do the same for `chatRepository`. No UI changes needed.
Typing "error" in the chat triggers the mock error state.
