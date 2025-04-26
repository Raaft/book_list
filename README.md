# 📚 Book Listing App

A Flutter application to browse and search books with infinite scroll, shimmer loading, and offline handling.

---

## 🏗 Architecture

The app follows **Clean Architecture** principles:

- **Presentation Layer**: UI, Cubits, and Widgets
- **Domain Layer**: Entities, Repositories (abstract), and Use Cases
- **Data Layer**: Remote & Local Data Sources, Models, and Repository Implementation

---

## 🛆 Technologies

- **State Management**: `flutter_bloc`, `Cubit`
- **Networking**: `dio`, `connectivity_plus`
- **Dependency Injection**: `get_it`
- **Local Storage**: `shared_preferences`
- **UI Enhancements**: `shimmer`, `lazy_load_scrollview`, `flutter_screenutil`
- **Offline Detection**: `internet_connection_checker`

---

## 🚀 Features

- 🔎 **Search Books** by title
- 🔄 **Infinite Scroll** with lazy loading
- ✨ **Shimmer Effect** during data loading
- 📶 **Offline Detection** with custom UI
- 🎨 **Responsive and Modern UI**
- 🔔 **Snackbar Feedback** for errors and actions

---

## 🧐 State Management (Cubit)

| State | Purpose |
|:------|:--------|
| `Loading` | Fetching or refreshing books |
| `Success` | Books loaded successfully |
| `Failure` | Error fetching data |
| `No Internet` | No internet connection detected |
| `No More Books` | End of list reached |

All states are handled cleanly with proper UI feedback.

---

## ⚙️ Key Implementations

- **GetIt** for Dependency Injection.
- **Dio** setup with Base URL and interceptors.
- **NetworkInfo** to check connectivity before requests.
- **Shimmer Loading** to enhance user experience during fetch.
- **Lazy Loading** to fetch more books when scrolling down.
- **Retry Button** on failure or no connection.
- **Equatable** used for efficient state comparisons.

---

## 📈 Project Structure

```
lib/
 ├── core/
 │    ├── api/
 │    ├── network/
 │    └── helpers/
 ├── features/
 │    └── Home/
 │         ├── data/
 │         ├── domain/
 │         └── presentation/
 └── injection_container.dart
```

---

## 📢 Future Improvements

- Add full offline caching.
- Implement debounce for search inputs.
- Add dark mode support.
- Improve API retry strategies.
- Write unit and widget tests.

---

# ✅ Summary

This app demonstrates:

- Clean Architecture
- SOLID Principles
- Scalable State Management
- Responsive UI
- Reliable Offline Handling

> **Built with Flutter 3.24 & Dart 3.3** 🚀

---



