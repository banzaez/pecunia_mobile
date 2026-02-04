flutter clean

cd android
./gradlew clean
cd ..

flutter pub get

cd ios
rm -rf Pods
rm -rf Podfile.lock
pod install
cd ..
