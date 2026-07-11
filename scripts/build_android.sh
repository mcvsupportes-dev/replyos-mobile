#!/bin/bash
# ============================================
# ReplyOS - بناء APK أندرويد
# ============================================
# المتطلبات: Flutter 3.22+, Java JDK 17+, Android SDK, RAM 8GB+
# ============================================

set -e

cd "$(dirname "$0")/.."

echo "============================================"
echo "  ReplyOS - بناء تطبيق أندرويد"
echo "============================================"

if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter غير مثبت! حمّله من: https://docs.flutter.dev/get-started/install"
    exit 1
fi

echo "✅ Flutter: $(flutter --version 2>&1 | head -1)"

# تحميل المكتبات
echo "📥 تحميل المكتبات..."
flutter pub get

# التحقق من google-services.json
if [ ! -f "android/app/google-services.json" ]; then
    echo "⚠️  ملف google-services.json غير موجود"
    echo "   حمّله من Firebase Console → Project Settings → Android app"
fi

echo "🔨 بناء APK موحد لجميع أجهزة الأندرويد..."
flutter build apk --release --no-tree-shake-icons

if [ -f "build/app/outputs/flutter-apk/app-release.apk" ]; then
    AP_SIZE=$(ls -lh "build/app/outputs/flutter-apk/app-release.apk" | awk '{print $5}')
    echo ""
    echo "============================================"
    echo "  ✅ تم البناء بنجاح!"
    echo "  📁 build/app/outputs/flutter-apk/app-release.apk"
    echo "  📦 الحجم: $AP_SIZE"
    echo "============================================"
    echo ""
    echo "📌 تثبيت على جهاز: adb install build/app/outputs/flutter-apk/app-release.apk"
    echo "📌 رفع Play Store: flutter build appbundle --release --no-tree-shake-icons"
else
    echo "❌ فشل البناء!"
    exit 1
fi