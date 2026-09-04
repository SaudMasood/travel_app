
# ✈️ Travel App

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white"/>
  <img src="https://img.shields.io/badge/BLoC-State%20Management-4F46E5?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/REST%20API-Integration-0891B2?style=for-the-badge"/>
</p>

<p align="center">
  <b>🌍 Explore the World • 🌤️ Check Weather • 🗺️ Discover Destinations • 📝 Manage Travel Plans</b>
</p>

<p align="center">
  A Flutter-based API integration project developed during my
  <b>Week 5 Flutter Internship at Owasoft Technologies</b>.
</p>

---

## 🌍 About The Project

**Travel App** is a Flutter mobile application built to practice real-world
**REST API integration**, **BLoC state management**, **model-based JSON parsing**,
and **CRUD operations**.

The application connects multiple free public APIs and combines their data
into different travel-related screens.

The project demonstrates how a Flutter application can communicate with
different APIs and manage their responses using BLoC.

---

## ✨ Features

### 🏠 Home

- 🔎 Search countries using country codes
- 🌍 Display country information
- 🏙️ Capital city
- 🌎 Region
- 👥 Population
- 💰 Currency
- 🗺️ Latitude & Longitude
- ✈️ Explore destination
- ℹ️ View more information

---

### 🌤️ Destination Explorer

Provides detailed information about a selected country:

- 🌡️ Current temperature
- 💧 Humidity
- 🌬️ Wind speed
- 🌡️ Apparent temperature
- 🌫️ Air quality
- 💨 PM10
- 💨 PM2.5
- 🏭 Carbon monoxide
- 🏭 Nitrogen dioxide
- 🏭 Sulphur dioxide
- ☀️ Ozone
- 💱 Currency exchange rates
- 📰 Travel-related news

---

### ℹ️ More Information

Additional information about the selected destination:

- 🎉 Public holidays
- 🌅 Sunrise
- 🌇 Sunset
- 🌄 Dawn & Dusk
- 📍 Location search
- ⛰️ Elevation
- 📖 Wikipedia information
- 📚 Travel books
- 🌍 City information

---

### 🌎 World Explorer

Explore country information from another dedicated screen:

- 🌍 Country details
- 🏙️ Capital
- 🗺️ Region
- 🚩 Flag
- 👥 Population
- 🗣️ Languages
- 🕐 Timezones
- ☀️ Sunrise & Sunset
- 📖 Wikipedia information
- 💰 Currency rates
- 📚 Travel books
- 📊 Population information

---

### 📝 Travel Notes

A CRUD-based travel notes feature.

Users can:

- ➕ Add travel notes
- 👀 View travel notes
- ✏️ Update travel notes
- 🗑️ Delete travel notes

CRUD operations:

```text
CREATE  → POST
READ    → GET
UPDATE  → PUT
DELETE  → DELETE
````

---

### 🧳 My Trips

Users can manage their travel plans:

* ➕ Add trip
* 👀 View trips
* ✏️ Edit trip
* 🔄 Update trip
* 🗑️ Delete trip

Each trip contains:

```text
Destination
Start Date
End Date
```

---

### 📊 Info

The Info screen integrates additional APIs for:

* 📍 Current IP location
* 🌎 Country information
* 📸 Travel photos
* 👤 Random travelers
* 🐕 Random dog images

---

# 🔌 API Integration

This project integrates **20+ public APIs/services** and demonstrates
multiple HTTP operations.

| #  | API / Service           | Method | Feature          |
| -- | ----------------------- | ------ | ---------------- |
| 1  | Countries.dev           | GET    | Home             |
| 2  | Open-Meteo Weather      | GET    | Destination      |
| 3  | Open-Meteo Air Quality  | GET    | Destination      |
| 4  | Frankfurter             | GET    | Currency         |
| 5  | FreeNewsAPI             | GET    | News             |
| 6  | Nager.Date              | GET    | Holidays         |
| 7  | Sunrise-Sunset          | GET    | Sunrise/Sunset   |
| 8  | OpenStreetMap Nominatim | GET    | Location         |
| 9  | Open-Elevation          | GET    | Elevation        |
| 10 | Wikipedia REST API      | GET    | Destination Info |
| 11 | Open Library            | GET    | Travel Books     |
| 12 | Open-Meteo Geocoding    | GET    | Cities           |
| 13 | World Bank              | GET    | Population       |
| 14 | IPWho.is                | GET    | IP Location      |
| 15 | CountriesNow            | GET    | Countries        |
| 16 | Picsum Photos           | GET    | Photos           |
| 17 | Random User             | GET    | Travelers        |
| 18 | Dog CEO                 | GET    | Dog Images       |
| 19 | DummyJSON               | GET    | Travel Notes     |
| 20 | DummyJSON               | POST   | Add Notes        |
| 21 | DummyJSON               | PUT    | Update Notes     |
| 22 | DummyJSON               | DELETE | Delete Notes     |
| 23 | JSONPlaceholder         | GET    | Trips            |
| 24 | JSONPlaceholder         | POST   | Add Trip         |
| 25 | JSONPlaceholder         | PUT    | Update Trip      |
| 26 | JSONPlaceholder         | DELETE | Delete Trip      |

---

# 🔄 CRUD Flow

The project demonstrates complete REST CRUD operations.

```text
                    📱 Flutter UI
                         │
                         ▼
                    🎯 BLoC Event
                         │
                         ▼
                  🌐 API Service
                         │
              ┌──────────┼──────────┐
              ▼          ▼          ▼
             GET        POST       PUT
              │          │          │
              └──────────┼──────────┘
                         │
                         ▼
                       DELETE
                         │
                         ▼
                    📦 JSON Data
                         │
                         ▼
                    🧩 Model
                         │
                         ▼
                    🔄 BLoC State
                         │
                         ▼
                    🖥️ Flutter UI
```

---

# 🧠 State Management

The application uses **BLoC** for state management.

Basic flow:

```text
User Action
     ↓
Event
     ↓
BLoC
     ↓
API Service
     ↓
API Response
     ↓
Model
     ↓
State
     ↓
UI
```

### BLoC Components

Each major feature follows:

```text
bloc/
├── feature_bloc.dart
├── feature_event.dart
└── feature_state.dart
```

Examples:

* `HomeBloc`
* `DestinationBloc`
* `TripBloc`
* `MoreInfoBloc`
* `WorldExplorerBloc`
* `TravelNotesBloc`
* `InfoBloc`

---

# 🧩 Models

API responses are converted into Dart model objects.

Examples:

```text
CountryModel
WeatherModel
AirQualityModel
CurrencyModel
NewsModel
HolidayModel
SunriseModel
LocationModel
ElevationModel
WikipediaModel
BookModel
CityModel
TripModel
TravelNoteModel
```

The project uses:

```dart
factory Model.fromJson(...)
```

to convert JSON data into Dart objects.

---

# 🏗️ Project Structure

```text
lib/
│
├── main.dart
│
├── core/
│   ├── constants/
│   │   ├── api_constants.dart
│   │   └── app_constants.dart
│   │
│   ├── services/
│   │   └── api_service.dart
│   │
│   └── theme/
│       ├── app_colors.dart
│       ├── app_theme.dart
│       └── app_text_styles.dart
│
└── features/
    │
    ├── splash/
    │
    ├── main/
    │
    ├── home/
    │   ├── bloc/
    │   ├── models/
    │   └── screen/
    │
    ├── destination/
    │   ├── bloc/
    │   ├── models/
    │   └── screen/
    │
    ├── trips/
    │   ├── bloc/
    │   ├── models/
    │   └── screen/
    │
    ├── moreinfo/
    │   ├── block/
    │   ├── models/
    │   └── screen/
    │
    ├── world_explorer/
    │   ├── block/
    │   ├── models/
    │   └── screen/
    │
    ├── travelnotes/
    │   ├── block/
    │   ├── models/
    │   └── screen/
    │
    └── info/
        ├── block/
        ├── models/
        └── screen/
```

---

# 🛠️ Technologies Used

<p align="center">

<img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white"/>
<img src="https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white"/>
<img src="https://img.shields.io/badge/BLoC-4F46E5?style=flat-square"/>
<img src="https://img.shields.io/badge/REST%20API-0891B2?style=flat-square"/>
<img src="https://img.shields.io/badge/HTTP-2196F3?style=flat-square"/>
<img src="https://img.shields.io/badge/JSON-000000?style=flat-square"/>
<img src="https://img.shields.io/badge/Git-GitF050?style=flat-square&logo=git&logoColor=white"/>
<img src="https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white"/>

</p>

---

# 📦 Packages

The project uses:

```yaml
dependencies:
  flutter_bloc:
  http:
  equatable:
```

Install them with:

```bash
flutter pub get
```

---

# 🚀 Getting Started

### 1️⃣ Clone the repository

```bash
git clone https://github.com/SaudMasood/travel_app.git
```

### 2️⃣ Open the project

```bash
cd travel_app
```

### 3️⃣ Install dependencies

```bash
flutter pub get
```

### 4️⃣ Run the application

```bash
flutter run
```

---

# 🧪 API Testing

The APIs can be tested using tools such as:

* Postman
* Browser
* Flutter application

Example CRUD endpoint:

```text
GET
https://jsonplaceholder.typicode.com/posts
```

```text
POST
https://jsonplaceholder.typicode.com/posts
```

```text
PUT
https://jsonplaceholder.typicode.com/posts/1
```

```text
DELETE
https://jsonplaceholder.typicode.com/posts/1
```

---

# ⚠️ Note About Testing APIs

Some APIs used in this project are **public testing/demo APIs**.

Services such as JSONPlaceholder and DummyJSON simulate POST, PUT and DELETE
operations. Their responses can be successful, but changes may not be
permanently stored on the server.

The application therefore updates its local in-memory list after successful
CRUD requests so that the UI immediately reflects the operation.

---

# 🎨 UI

The application follows a simple and modern travel-oriented design:

```text
🎨 Dark Blue
      +
💜 Indigo
      +
💎 Cyan
      +
⚪ White
```

The UI focuses on:

* Clean layouts
* Rounded containers
* Simple navigation
* Easy-to-read information
* Responsive API result screens
* Bottom navigation
* Beginner-friendly Flutter implementation

---

# 📱 Main Screens

```text
Splash
  ↓
Home
  ├── Explore Destination
  └── More Info
       ↓
Main Navigation
  ├── 🏠 Home
  ├── ✈️ Trips
  ├── 🌎 Explore
  └── 📝 Notes

Additional:
  └── ℹ️ Info
```

---

# 🎓 Internship Project

This project was developed as part of my:

### 💼 Owasoft Technologies

### 🚀 Flutter Development Internship

### 📅 Week 5 — API Integration Project

### Week 5 Focus

```text
Flutter
   ↓
REST APIs
   ↓
HTTP Requests
   ↓
JSON Parsing
   ↓
Dart Models
   ↓
BLoC
   ↓
CRUD
   ↓
Complete Flutter Application
```

---

# 📚 Learning Outcomes

Through this project, I practiced:

* ✅ REST API integration
* ✅ GET requests
* ✅ POST requests
* ✅ PUT requests
* ✅ DELETE requests
* ✅ JSON parsing
* ✅ Dart model classes
* ✅ Factory constructors
* ✅ BLoC events
* ✅ BLoC states
* ✅ BlocBuilder
* ✅ BlocListener
* ✅ BlocConsumer
* ✅ API error handling
* ✅ Multiple API integration
* ✅ CRUD operations
* ✅ Flutter navigation
* ✅ Git & GitHub workflow

---

# 🔮 Future Improvements

Possible future improvements include:

* 🔐 User authentication
* 💾 Persistent local storage
* 🗺️ Interactive maps
* ⭐ Favorite destinations
* 🔔 Travel reminders
* 🌐 More travel APIs
* 📱 Better responsive layouts
* ☁️ Backend database integration

---

# 👨‍💻 Developer

### Saud Masood

**BS Computer Science Student | Flutter Developer | AI/ML Enthusiast**

This project represents my practical learning and development work during
my Flutter internship at Owasoft Technologies.

---

<p align="center">

### 🌍 Explore More. ✈️ Travel More. 💙 Build More.

</p>

<p align="center">

⭐ If you find this project useful, consider giving it a star!

</p>
```
