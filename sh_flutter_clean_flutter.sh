flutter clean

flutter pub get

cd ios
rm -rf Pods
rm -rf Podfile.lock
pod install --repo-update
cd ..
