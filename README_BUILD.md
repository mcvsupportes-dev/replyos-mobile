# ReplyOS - تطبيق جاهز للأندرويد والآيفون

## 📱 عن المشروع

ReplyOS هو تطبيق مساعد ذكي لمستخدمي واتساب بزنس. يدعم:
- واجهة عربية كاملة RTL
- تسجيل دخول بالبريد/جوجل/ضيف
- ربط واتساب بزنس API
- مساعد ذكاء اصطناعي
- إعدادات الرد التلقائي
- نظام قواعد ذكي
- تحليلات وإحصائيات
- اشتراكات (مجاني/برو/بزنس)

## 🏗️ ما تم إعداده

### ✅ أندرويد (Android)
- مجلد `android/` كامل ومُعد
- `google-services.json` لـ Firebase
- `AndroidManifest.xml` بصلاحيات الإنترنت
- إعدادات Gradle متوافقة (compileSdk 35, minSdk 21)
- دعم multiDex
- دعم arm64-v8a, armeabi-v7a, x86_64

### ✅ آيفون (iOS)
- مجلد `ios/` مُولّد بالكامل (كان مفقوداً في الملف الأصلي)
- `GoogleService-Info.plist` لـ Firebase
- `Info.plist` باسم ReplyOS وصلاحيات الكاميرا والصور
- إعدادات Xcode جاهزة (Bundle ID: com.replyos.replyos)
- دعم iPhone و iPad بجميع الاتجاهات

### ✅ ويب (Web)
- مجلد `web/` موجود ويعمل

## 📋 المتطلبات لبناء التطبيق

### لأندرويد:
| المطلب | الإصدار |
|--------|---------|
| Flutter SDK | 3.22 أو أحدث |
| Java JDK | 17 أو أحدث |
| Android SDK | compileSdk 35 |
| RAM | 8 جيجا أو أكثر |
| مساحة قرص | 10 جيجا حرة |

### لآيفون:
| المطلب | الإصدار |
|--------|---------|
| جهاز Mac | أي جهاز Mac حديث |
| Xcode | 15 أو أحدث |
| Flutter SDK | 3.22 أو أحدث |
| حساب مطور Apple | $99/سنة (للنشر على App Store) |

## 🚀 طريقة البناء

### بناء APK أندرويد (لجميع الأجهزة):
```bash
# الطريقة السريعة
bash scripts/build_android.sh

# أو يدوياً:
flutter pub get
flutter build apk --release --no-tree-shake-icons
```
**الناتج:** `build/app/outputs/flutter-apk/app-release.apk` (~10 ميجا)

### بناء AAB لجوجل بلاي:
```bash
flutter build appbundle --release --no-tree-shake-icons
```
**الناتج:** `build/app/outputs/bundle/release/app-release.aab`

### بناء iOS (يتطلب Mac):
```bash
# الطريقة السريعة
bash scripts/build_ios.sh

# أو يدوياً:
flutter pub get
flutter build ios --release --no-codesign
# ثم افتح ios/Runner.xcworkspace في Xcode
# واختر فريق التطوير وArchive
```

## 📲 التثبيت على الجهاز

### أندرويد:
```bash
# عبر USB
adb install build/app/outputs/flutter-apk/app-release.apk

# أو انسخ الملف للهاتف وافتحه من مدير الملفات
```

### آيفون:
- افتح Xcode → اختر جهازك المتصل
- اضغط Run (▶️)
- أو عبر TestFlight بعد الرفع على App Store Connect

## 🔧 إعداد Firebase (مهم!)

### أندرويد:
1. افتح [Firebase Console](https://console.firebase.google.com)
2. اختر مشروع replyos-af4d3
3. اذهب لـ Project Settings → Android
4. حمّل `google-services.json`
5. ضعه في `android/app/google-services.json`

### آيفون:
1. نفس المشروع في Firebase Console
2. اذهب لـ Project Settings → iOS
3. حمّل `GoogleService-Info.plist`
4. ضعه في `ios/Runner/GoogleService-Info.plist`
5. أضف SHA-1 fingerprint في إعدادات Firebase

## ⚠️ ملاحظات مهمة

1. **ملف google-services.json**: الملف الحالي هو placeholder. حمّل الملف الحقيقي من Firebase Console
2. **ملف GoogleService-Info.plist**: نفس الشيء للـ iOS
3. **توقيع الـ APK**: البناء يستخدم توقيع debug. للإنتاج، أنشئ keystore:
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```
4. **Google Play**: تحتاج حساب مطور Google ($25 لمرة واحدة)
5. **App Store**: تحتاج حساب مطور Apple ($99/سنة)

## 🏗️ هيكل المشروع

```
replyos-app/
├── android/          ← إعدادات أندرويد
│   └── app/
│       ├── build.gradle
│       ├── google-services.json
│       └── src/main/
│           ├── AndroidManifest.xml
│           └── kotlin/.../MainActivity.kt
├── ios/              ← إعدادات آيفون (تم إنشاؤه)
│   ├── Runner.xcworkspace
│   ├── Runner.xcodeproj
│   └── Runner/
│       ├── AppDelegate.swift
│       ├── Info.plist
│       ├── GoogleService-Info.plist
│       └── Assets.xcassets/
├── lib/              ← كود Dart
│   ├── main.dart
│   ├── core/
│   │   ├── config/
│   │   ├── services/
│   │   ├── models/
│   │   ├── theme/
│   │   └── utils/
│   ├── features/
│   │   ├── auth/       (تسجيل/دخول)
│   │   ├── home/       (شاشة رئيسية)
│   │   ├── ai_assistant/ (مساعد ذكي)
│   │   ├── whatsapp/   (ربط واتساب)
│   │   ├── rules/      (قواعد الرد)
│   │   ├── analytics/  (إحصائيات)
│   │   ├── subscription/ (اشتراكات)
│   │   └── settings/   (إعدادات)
│   └── shared/
│       ├── widgets/
│       └── layouts/
├── web/              ← إعدادات الويب
├── scripts/
│   ├── build_android.sh
│   └── build_ios.sh
└── pubspec.yaml
```

## 🌐 رفع على المتاجر

### Google Play Store:
1. بناء AAB: `flutter build appbundle --release`
2. افتح [Google Play Console](https://play.google.com/console)
3. أنشئ تطبيق جديد
4. ارفع AAB
5. أكمل بيانات التطبيق (صور، وصف، تصنيف)

### Apple App Store:
1. بناء في Xcode: Archive
2. افتح [App Store Connect](https://appstoreconnect.apple.com)
3. ارفع عبر Xcode Organizer
4. أكمل بيانات التطبيق
5. أرسل للمراجعة

---
تم التجهيز بواسطة ReplyOS Team 2026