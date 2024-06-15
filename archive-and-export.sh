# For your convenience 
alias PlistBuddy=/usr/libexec/PlistBuddy
cp exportOptionsTemplate.plist exportOptionsTemplate_temp.plist
PlistBuddy -c "set :Animals $1" ./CatsUI/CatsUI/Info.plist

PLIST="exportOptionsTemplate_temp.plist"
PlistBuddy -c "set :destination export" $PLIST
PlistBuddy -c "set :method development" $PLIST
PlistBuddy -c "set :signingStyle manual" $PLIST
PlistBuddy -c "set :teamID D85QWSUNYA" $PLIST
PlistBuddy -c "set :signingCertificate iPhone Developer: Zakhar Litvinchuk (76KD92S32H)" $PLIST
PlistBuddy -c "delete :provisioningProfiles:%BUNDLE_ID%" $PLIST
PlistBuddy -c "add :provisioningProfiles:ua.edu.ukma.apple-env.litvinchuk.CatsAndModules string d1afd3ae-a3cf-4001-8d42-fbd9130b8b39" $PLIST

WORKSPACE=CatsAndModules_ZakharLitvinchuk.xcworkspace
SCHEME=CatsUI
CONFIG=Release
DEST="generic/platform=iOS"
VERSION="v1.0.0"
ARCHIVE_PATH="./Archives/${VERSION}.xcarchive"
# IMPLEMENT:
# Read script input parameter and add it to your Info.plist. Values can either be CATS or DOGS

# IMPLEMENT:
# Clean build folder
xcodebuild clean -workspace "${WORKSPACE}" -scheme "${SCHEME}" -configuration "${CONFIG}"

# IMPLEMENT:
# Create archive
xcodebuild archive \
-archivePath "${ARCHIVE_PATH}" \
-workspace "${WORKSPACE}" \
-scheme "${SCHEME}" \
-configuration "${CONFIG}" \
-destination "${DEST}"


# IMPLEMENT:
# Export archive
EXPORT_PATH="./Exported_$1"
EXPORT_OPTIONS_PLIST="./exportOptionsTemplate_temp.plist"

xcodebuild -exportArchive \
-archivePath "${ARCHIVE_PATH}" \
-exportPath "${EXPORT_PATH}" \
-exportOptionsPlist "${EXPORT_OPTIONS_PLIST}"

rm -r ./Archives
rm exportOptionsTemplate_temp.plist

