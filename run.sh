set -e

echo "🔄 Limpando build..."
flutter clean

echo "📦 Atualizando dependências..."
flutter pub get

echo "▶️ Iniciando o aplicativo..."
flutter run
