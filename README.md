# 💰 SaveUP

**SaveUP** is a mobile application designed to help users set, track, and achieve personal savings goals. Whether you're saving for a vacation, a new gadget, or an emergency fund, SaveUP keeps you motivated with clear progress tracking, contribution history, and beautiful visual charts.

🌐 **Landing Page:** [save-up-landing-page.vercel.app](https://save-up-landing-page.vercel.app/)

---

## 📱 Preview

<table>
  <tr>
    <td align="center"><img src="assets/images/preview/Simulator Screenshot - iPhone 17 Pro - 2026-02-27 at 23.56.27.png" width="180"/></td>
    <td align="center"><img src="assets/images/preview/Simulator Screenshot - iPhone 17 Pro - 2026-02-27 at 23.56.31.png" width="180"/></td>
    <td align="center"><img src="assets/images/preview/Simulator Screenshot - iPhone 17 Pro - 2026-02-27 at 23.56.33.png" width="180"/></td>
    <td align="center"><img src="assets/images/preview/Simulator Screenshot - iPhone 17 Pro - 2026-02-27 at 23.56.34.png" width="180"/></td>
    <td align="center"><img src="assets/images/preview/Simulator Screenshot - iPhone 17 Pro - 2026-02-27 at 23.56.49.png" width="180"/></td>
  </tr>
</table>

---

## 🎯 Features

- 💸 Create and manage multiple savings goals
- 📊 Track progress with live charts and contribution history
- ➕ Add or remove savings with quick-select amount shortcuts
- 🏆 Celebrate goal completion with a confetti animation
- 📦 Archive completed goals for reference
- 🎨 Customize each goal with a unique color
- 🌙 Dark-themed, modern UI with smooth animations
- 💾 Fully offline — all data saved locally on device

---

## 🚀 Getting Started

### 📦 Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (3.x or later)
- Dart SDK
- Android Studio / VS Code

### 🧪 Installation

```bash
git clone https://github.com/Abdusalom0516/SaveUP.git
cd SaveUP
flutter pub get
```

### ▶️ Running the App

```bash
flutter run

# Or target a specific device:
flutter run -d emulator-5554
```

### ⚙️ Code Generation

This project uses `freezed` and `json_serializable`. After modifying any annotated models, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 🔧 Project Structure

```text
lib/
├── core/
│   ├── common/          # Shared widgets (buttons, sliver helpers, etc.)
│   ├── constants/       # App-wide constants (image paths, enums, texts)
│   ├── design_system/   # Colors, text styles, theme
│   ├── network/         # Dio client, endpoints, interceptors
│   ├── services/        # Token service, logger
│   └── utils/           # Router, theme cubit, formatters, state wrapper
│
├── features/
│   ├── add_dream/       # Feature: Create a new savings goal
│   │   └── presentation/
│   │       ├── screens/
│   │       └── widgets/
│   │
│   ├── archive/         # Feature: Completed/archived goals
│   │   └── presentation/
│   │       └── screens/
│   │
│   ├── home/            # Feature: Dashboard & active goals
│   │   ├── data/
│   │   │   ├── datasources/    # SharedPreferences local data source
│   │   │   ├── models/         # DreamModel, ContributionModel
│   │   │   └── repositories/   # Repository implementation
│   │   ├── domain/
│   │   │   └── repositories/   # Abstract repository interface
│   │   └── presentation/
│   │       ├── blocs/          # DreamsCubit & DreamsState
│   │       ├── screens/        # HomeScreen, StatisticsScreen
│   │       └── widgets/        # DreamCard, charts, action buttons
│   │
│   └── settings/        # Feature: App settings (theme, font, accent)
│       └── presentation/
│           ├── blocs/
│           ├── screens/
│           └── widgets/
│
├── infrastructure/
│   └── injector/        # GetIt dependency injection setup
│
└── main.dart
```

---

## 🧰 Built With

- **Flutter** — Cross-platform UI toolkit
- **flutter_bloc / Cubit** — State management
- **SharedPreferences** — Local offline storage
- **fl_chart** — Progress and contribution charts
- **flutter_hooks** — Hook-based widget state
- **flutter_screenutil** — Responsive sizing
- **Dio** — Networking layer
- **GetIt** — Dependency injection
- **easy_localization** — Localization support
- **toastification** — Toast notifications

---

## 🧪 Testing

```bash
flutter test
```

Unit and widget tests live in the `test/` folder.

---

## 📦 Deployment

### Android

```bash
flutter build apk --release
# or
flutter build appbundle
```

### iOS

```bash
flutter build ios --release
```

---

## 🤝 Contributing

1. Fork the repo
2. Create your feature branch: `git checkout -b feature/awesome-feature`
3. Commit your changes: `git commit -m 'Add awesome feature'`
4. Push to the branch: `git push origin feature/awesome-feature`
5. Open a pull request

---

## 📧 Contact

**Abdusalom G'ayratov**
📧 [abdusalomgayratov7@gmail.com](mailto:abdusalomgayratov7@gmail.com)
📱 Telegram: [@freedom999_16](https://t.me/freedom999_16)

---

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

> 💰 SaveUP – Save smarter, reach your goals faster.
