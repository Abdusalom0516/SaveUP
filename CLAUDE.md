# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Generate code (Freezed models, JSON serialization)
dart run build_runner build
dart run build_runner watch   # Watch mode during development

# Lint and analyze
flutter analyze

# Format code
dart format lib/

# Run tests
flutter test

# Build
flutter build apk    # Android
flutter build ipa    # iOS
flutter build web    # Web
```

> Run `dart run build_runner build --delete-conflicting-outputs` after modifying any Freezed or JSON serializable models.

## Architecture

SaveUP is a Flutter savings/goals management app following **Clean Architecture** with **BLoC/Cubit** state management.

### Layer Structure (per feature)

Each feature under `lib/features/<feature>/` is organized into:
- `data/` — DTOs, repository implementations, remote/local data sources
- `domain/` — abstract repository interfaces, use cases (business logic)
- `presentation/` — BLoC/Cubit, screens, feature-specific widgets

### Core Infrastructure (`lib/core/`)

- `design_system/` — `AppColors`, `AppTextStyles`, `AppTheme` (dark-only theme, primary purple `#8B5CF6`)
- `network/` — `ApiClient` (Dio), `ApiEndpoints`, auth/logging interceptors
- `services/` — `TokenService` (SharedPreferences), `LoggerService`
- `utils/` — `AppRouter`, `ThemeManagerCubit`, `DateFormatter`, `CustomFormatters`
- `common/widgets/` — Shared reusable widgets

### Dependency Injection

`lib/infrastructure/injector/injector.dart` configures GetIt (`sl`). Register all new services, repositories, and BLoCs there.

### Navigation

`lib/main_screen.dart` hosts a 4-tab `PageView` with `WaterDropNavBar`:
1. **Home** — dashboard / savings overview
2. **Premium** — upgrade/subscription screen
3. **Add Dream** — create a new savings goal
4. **Settings** — app settings

Route logic lives in `lib/core/utils/app_router.dart`.

### State Management Conventions

- Use **BLoC** for complex async flows (API calls, multi-state screens)
- Use **Cubit** for simple or synchronous state (e.g., `ThemeManagerCubit`)
- BLoC status enum: `lib/core/constants/enum_bloc_status.dart`
- Wrap app entry widgets with `AppStateWrapper` (`lib/core/utils/app_state_wrapper.dart`)

### Code Generation

Models using `freezed` / `json_serializable` require generated `.g.dart` and `.freezed.dart` files. Always run `build_runner` after modifying these models.

### API

- Base URL: `https://api.ishora.uz`
- Endpoints defined in `lib/core/network/api_endpoints.dart`
- `ApiClient` uses a 5-second timeout with auth and logging interceptors

### Assets

- Fonts: JetBrainsMono, Roboto, NotoSerif (declared in `pubspec.yaml`)
- Images: `assets/images/`
- Translations: `assets/translations/` (EasyLocalization)
- All new assets must be declared in `pubspec.yaml`
