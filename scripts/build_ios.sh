#!/bin/bash
# ============================================
# ReplyOS - بناء تطبيق iOS
# ============================================
# ⚠️ يتطلب جهاز Mac + Xcode 15+
# ============================================

set -e

cd "$(dirname "$0")/.."

echo "============================================"
echo "  ReplyOS - بناء تطبيق iOS"
echo "============================================"

# التحقق من النظام
if [[ "$(uname)" != "Darwin" ]]; then
    echo "❌ بناء iOS يتطلب جهاز Mac مع Xcode!"
    echo "   لا يمكن بناء iOS على Linux أو Windows"
    exit 1
fi

if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter غير مثبت!"
    exit 1
fi

if ! xcode-select -p &> /dev/null; then
    echo "❌ Xcode غير مثبت! حمّله من Mac App Store"
    exit 1
fi

echo "✅ Flutter: $(flutter --version 2>&1 | head -1)"
echo "✅ Xcode: $(xcode-select -p)"

# تحميل المكتبات
echo "📥 تحميل المكتبات..."
flutter pub get

# التحقق من GoogleService-Info.plist
if [ ! -f "ios/Runner/GoogleService-Info.plist" ]; then
    echo "⚠️  ملف GoogleService-Info.plist غير موجود في ios/Runner/"
    echo "   حمّله من Firebase Console → Project Settings → iOS app"
fi

echo ""
echo "🔨 بناء iOS (بدون توقيع)..."
flutter build ios --release --no-codesign

echo ""
echo "============================================"
echo "  ✅ تم بناء الكود بنجاح!"
echo "============================================"
echo ""
echo "📌 للخطوات التالية:"
echo "   1. افتح ios/Runner.xcworkspace في Xcode"
echo "   2. اختر فريق التطوير (Signing & Capabilities)"
echo "   3. اختر target device أو Generic iOS Device"
echo "   4. Product → Archive"
echo "   5. Organizer → Distribute App"
echo ""
echo "📌 للنشر على App Store:"
echo "   - سجّل حساب مطور Apple ($99/سنة)"
echo "   - أضف الشهادات في Apple Developer Portal"
echo "   - Archive ثم Validate ثم Submit"