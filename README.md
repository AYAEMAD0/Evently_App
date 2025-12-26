# **Evently 🎉**
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/AYAEMAD0/Evently_App)

**Evently** is a comprehensive and modern Flutter event management application built using **Clean Architecture, MVVM, and the Repository Pattern**.  
The app allows users to **discover, create, and manage events with ease**, offering a personalized experience with **theme and language customization**, **interactive maps for event locations**, **notifications for upcoming events**, **favoriting events**, and **caching** to improve performance.  
It provides a **fast, lightweight, and smooth user experience**, supporting **theming**, **multi-language**, **maps integration**, **notifications**, and **favorites**.
---

## ✨ **Features**

### **📝 Onboarding**
- 4 onboarding screens with unique **image, title, and description**.
- **Theme toggle** (Light / Dark) and **language toggle** (English / Arabic).
- Navigation dots for smooth navigation.
- **Caching** using SharedPreferences to skip onboarding for returning users.

### **🔐 Authentication**
- Sign-up, Login, Forget Password using **Firebase Auth**.
- **Google Sign-In** for quick login.
- **Email verification** for new accounts.
- Cached login to skip authentication for returning users.

### **🏠 Dashboard**
- Bottom navigation with animated tabs: **Home**, **Map**, **Add Event**, **Favorites**, **Profile**.

#### Home
- Shows **user name**, **theme toggle**, and **show language**.
- Events filtered based on selected category(All, Sports, Birthday, Holiday, Meeting, Gaming, Eating…).
- Events sorted from Firestore by date and time.
- Event cards contains **image, date, description**, **and favorite toggle(shows toast on update)**.

#### Event Details screen with:
- Displays full event information including **image, title, date, time, and description**.
- Shows the **event address** converted from latitude and longitude using Geocoding.
- Shows the event location on **Google Map**.
- AppBar Actions:
   - Delete Event
     - Shows a confirmation dialog before deletion.
     - Displays a toast message after successful deletion.
   - Edit Event
     - Edit image, category, title, description, date, time, and location.
     - Map opens directly at the event location for easy editing.
     - Displays a toast message after successful update.

#### Map
- Displays all events on **Google Map**.
- Clicking events highlights them(Blue)
- unclicked events remain default color(Black).
- Event cards to navigate to specific map locations.

#### Add Event
- Fields: Image, Category,Title, DescriptionDate, Time, Map location.
- Stores events in **Firestore**.
- **Local notifications** when event time arrives.

#### Favorites
- Displays favorite events.
- Toggle favorite status.
- Search events by title or description.

#### Profile
- Displays user data from **Firebase Auth**.
- Theme and language selection.
- Logout.

---

### **🎨 Theming**
- Light / Dark mode.
- Theme saved using **SharedPreferences**.

### **🌐 Localization**
- Full support for English (`en`) and Arabic (`ar`).

### **🔔 Notifications**
- Event reminders appear as **local notifications**.

---

## 🛠️ **Tech Stack**

- **Framework**: Flutter
- **Architecture**: Clean Architecture + MVVM
- **State Management**: Cubit (**flutter_bloc**)
- **Backend**: Firebase Auth + Firestore
- **Maps & Location**: Google Maps + Geocoding
- **Local Storage**: SharedPreferences
- **Dependency Injection**: GetIt + Injectable

---

## 📦 **Dependencies**

- `flutter_native_splash`, `google_fonts`, `intl`
- `introduction_screen`, `animated_toggle_switch`, `provider`
- `easy_localization`, `icons_plus`, `animated_bottom_navigation_bar`
- `carousel_slider`, `fluttertoast`, `flutter_svg`
- `timezone`, `shared_preferences`, `injectable`
- `get_it`, `flutter_bloc`, `firebase_core`
- `firebase_auth`, `google_sign_in`, `cloud_firestore`
- `google_maps_flutter`, `permission_handler`, `geolocator`
- `flutter_dotenv`, `flutter_screenutil`, `geocoding`
- `flutter_local_notifications`, `icons_launcher`

### **Dev Dependencies**
- `build_runner`, `injectable_generator`, `flutter_lints`
---

## 🚀 **Getting Started**

### 1️⃣ Clone the repository
```bash
git clone https://github.com/AYAEMAD0/evently_app.git
cd evently_app
```
### **2️⃣ Install dependencies**

   ```bash
   flutter pub get
   ```

### **3️⃣ Generate injectable files**

 ```bash
flutter pub run build_runner build --delete-conflicting-outputs
  ```

### **4️⃣ Run the app**

   ```bash
   flutter run
   ```
**🏛️ Architecture**

The project is structured using Clean Architecture + MVVM
![Arch Diagram2](assets/screenshots/arch.png)
---
---

## 🔐 **Environment Variables**

Create a `.env` file in the root directory:

```env
API_KEY=your_api_key_here
Used to protect secret API keys from being exposed publicly.
  ```
**🖼️ Screenshots**

## 🚀 Launcher & Splash

| Launcher                                     | Splash                                   |
|----------------------------------------------|------------------------------------------|
| ![Launcher](assets/screenshots/launcher.png) | ![Splash](assets/screenshots/splash.png) |

---
# Onboarding
 ## Onboarding Dark
| Onboarding1 Dark                                        | Onboarding2 Dark                                        | Onboarding3 Dark                                        | Onboarding4 Dark                                        |                               
|---------------------------------------------------------|---------------------------------------------------------|---------------------------------------------------------|---------------------------------------------------------|
| ![Onboarding1](assets/screenshots/onboarding1_dark.png) | ![Onboarding2](assets/screenshots/onboarding2_dark.png) | ![Onboarding3](assets/screenshots/onboarding3_dark.png) | ![Onboarding4](assets/screenshots/onboarding4_dark.png) |
## Onboarding Light
| Onboarding1 Light                                        | Onboarding1 Light Arabic                                | Onboarding2 Light                                        | Onboarding3 Light                                        | Onboarding4 Light                                        |                          
|----------------------------------------------------------|---------------------------------------------------------|----------------------------------------------------------|----------------------------------------------------------|----------------------------------------------------------|
| ![Onboarding1](assets/screenshots/onboarding1_light.png) | ![Onboarding1Ar](assets/screenshots/onboarding1_ar.png) | ![Onboarding2](assets/screenshots/onboarding2_light.png) | ![Onboarding3](assets/screenshots/onboarding3_light.png) | ![Onboarding4](assets/screenshots/onboarding4_light.png) |

---
## Auth
  ## Register Dark
| Register Dark                                      | Register Dark Arabic                                  | Register Dark Required                                      | Register Dark Password                                      | Register Dark Name                                       | Register Dark Loading                                      | Register Dark Verify                                      |
|----------------------------------------------------|-------------------------------------------------------|-------------------------------------------------------------|-------------------------------------------------------------|----------------------------------------------------------|------------------------------------------------------------|-----------------------------------------------------------|
| ![Register1](assets/screenshots/register_dark.png) | ![Register2](assets/screenshots/register_dark_ar.png) | ![Register3](assets/screenshots/register_dark_required.png) | ![Register4](assets/screenshots/register_dark_password.png) | ![Register5](assets/screenshots/register_dark_name.png)  | ![Register6](assets/screenshots/register_dark_loading.png) | ![Register7](assets/screenshots/register_dark_verify.png) |

 ## Register Light
| Register Light                                      | Register Light Arabic                                  | Register Light Required                                      | Register Light Password                                      | Register Light Name                                      | Register Light Loading                                      | Register Light Verify                                      |
|-----------------------------------------------------|--------------------------------------------------------|--------------------------------------------------------------|--------------------------------------------------------------|----------------------------------------------------------|-------------------------------------------------------------|------------------------------------------------------------|
| ![Register1](assets/screenshots/register_light.png) | ![Register2](assets/screenshots/register_light_ar.png) | ![Register3](assets/screenshots/register_light_required.png) | ![Register4](assets/screenshots/register_light_password.png) | ![Register5](assets/screenshots/register_light_name.png) | ![Register6](assets/screenshots/register_light_loading.png) | ![Register7](assets/screenshots/register_light_verify.png) |

 ## Login Dark
| Login Dark                                   | Login Dark Required                                   | Login Dark Successfully                              | Login Dark Verify                                   |
|----------------------------------------------|-------------------------------------------------------|------------------------------------------------------|-----------------------------------------------------|
| ![Login1](assets/screenshots/login_dark.png) | ![Login2](assets/screenshots/login_dark_required.png) | ![Login3](assets/screenshots/login_dark_success.png) | ![Login4](assets/screenshots/login_dark_verify.png) |

 ## Login Light
| Login Light                                   | Login Light Required                                   | Login Light Loading                                   | Login Light Verify                                   |
|-----------------------------------------------|--------------------------------------------------------|-------------------------------------------------------|------------------------------------------------------|
| ![Login1](assets/screenshots/login_light.png) | ![Login2](assets/screenshots/login_light_required.png) | ![Login3](assets/screenshots/login_light_loading.png) | ![Login4](assets/screenshots/login_light_verify.png) |

## Login Google
| Google Account                                    | Google Loading                                    | Google Successfully                            | 
|---------------------------------------------------|---------------------------------------------------|------------------------------------------------|
| ![google1](assets/screenshots/google_account.png) | ![google2](assets/screenshots/google_loading.png) | ![google3](assets/screenshots/google_succ.png) |

## Forget Password 
| Forget Password  Dark                             | Forget Password Dark Loading                           | Forget Password Dark Successfully                         | Forget Password Light                           | Forget Password Light Loading                           | Forget Password Light Not Verify                          |
|---------------------------------------------------|--------------------------------------------------------|-----------------------------------------------------------|-------------------------------------------------|---------------------------------------------------------|-----------------------------------------------------------|
| ![Forget1](assets/screenshots/forget_dark.png)    | ![Forget2](assets/screenshots/forget_dark_loading.png) | ![Forget3](assets/screenshots/forget_dark_meesage.png)    | ![Forget4](assets/screenshots/forget_light.png) | ![Forget5](assets/screenshots/forget_light_loading.png) | ![Forget6](assets/screenshots/forget_light_notVerify.png) |


---
## Home
| Home No Event Dark                                 | Home No Event Light                           | Home All Category Light                   | Home Filter Category Light                        | Home Toggle Fav Light                            | Home Toggle Fav Light                              |
|----------------------------------------------------|-----------------------------------------------|-------------------------------------------|---------------------------------------------------|--------------------------------------------------|----------------------------------------------------|
| ![Home1](assets/screenshots/home_noEvent_dark.png) | ![Home2](assets/screenshots/home_noEvent.png) | ![Home3](assets/screenshots/home_all.png) | ![Home4](assets/screenshots/home_filter_cate.png) | ![Home5](assets/screenshots/home_update_fav.png) | ![Home6](assets/screenshots/home_update_unfav.png) |
---
## Details Event
| Details Event                                      | Details Event                                      |
|----------------------------------------------------|----------------------------------------------------|
| ![Details1](assets/screenshots/details_event1.png) | ![Details2](assets/screenshots/details_event2.png) |
---
## Delete Event
| Delete Event                                      | Toast After Delete Event                                |
|---------------------------------------------------|---------------------------------------------------------|
| ![Delete1](assets/screenshots/delete_event1.png)  | ![Delete2](assets/screenshots/delete_event2_toast.png)  |
---
## Edit Event
| Edit Event part1                             | Edit Event part2                             | Toast Change Location                                      | Toast After Edited                                |
|----------------------------------------------|----------------------------------------------|------------------------------------------------------------|---------------------------------------------------|
| ![Edit1](assets/screenshots/edit_event1.png) | ![Edit2](assets/screenshots/edit_event2.png) | ![Edit3](assets/screenshots/edit_event_location_toast.png) | ![Edit4](assets/screenshots/edit_event_toast.png) |
---


## Map
| Map Show Event(circles)             | Map Show Event(circles)                            | Notification                                          | Notification Back                                      |
|-------------------------------------|----------------------------------------------------|-------------------------------------------------------|--------------------------------------------------------|
| ![Map1](assets/screenshots/map.png) | ![Map2](assets/screenshots/map_location_event.png) | ![Notification1](assets/screenshots/notification.png) | ![Notification2](assets/screenshots/notification2.png) |
---


## Add Event
| Add Event part1                            | Add Event part2                            | Date&Time Required                                      | Location Required                                      |
|--------------------------------------------|--------------------------------------------|---------------------------------------------------------|--------------------------------------------------------|
| ![Add1](assets/screenshots/add_event1.png) | ![Add2](assets/screenshots/add_event2.png) | ![Add3](assets/screenshots/add_event_time&date_req.png) | ![Add4](assets/screenshots/add_event_location_req.png) |

| Request Location                                           | Toast Selected Location                                         | Add Event aAddress                         | Toast After Added                               |
|------------------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------|-------------------------------------------------|
| ![Add5](assets/screenshots/add_event_location_request.png) | ![Add6](assets/screenshots/add_event_choose_location_toast.png) | ![Add7](assets/screenshots/add_event3.png) | ![Add8](assets/screenshots/add_event_toast.png) |


---
## Fav Event
| Not Fav Event                              | Fav Search                                 | Fav Not Match Search                                 | Fav Refresh                                 | Toast After Updated                               | 
|--------------------------------------------|--------------------------------------------|------------------------------------------------------|---------------------------------------------|---------------------------------------------------|
| ![Fav1](assets/screenshots/fav_nobody.png) | ![Fav2](assets/screenshots/fav_search.png) | ![Fav3](assets/screenshots/fav_not_match_search.png) | ![Fav4](assets/screenshots/fav_refresh.png) | ![Fav5](assets/screenshots/fav_update_toggle.png) |
---


## Profile
| Profile Dark En                                     | Profile Dark Ar                                     | Profile Light En                                     | Profile Light Ar                                     | Profile Light Google                               | Drop Menu Theme                                        | Drop Menu Lang                                        |
|-----------------------------------------------------|-----------------------------------------------------|------------------------------------------------------|------------------------------------------------------|----------------------------------------------------|--------------------------------------------------------|-------------------------------------------------------|
| ![Profile1](assets/screenshots/profile_dark_en.png) | ![Profile2](assets/screenshots/profile_dark_ar.png) | ![Profile3](assets/screenshots/profile_light_en.png) | ![Profile4](assets/screenshots/profile_light_ar.png) | ![Profile5](assets/screenshots/profile_google.png) | ![Profile6](assets/screenshots/profile_drop_theme.png) | ![Profile7](assets/screenshots/profile_drop_lang.png) |

---

**👩‍💻 Author**
Developed by **Aya Emad**

* [GitHub](https://github.com/AYAEMAD0)
* [LinkedIn](https://www.linkedin.com/in/aya-emad1/)