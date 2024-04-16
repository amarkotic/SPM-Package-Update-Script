# Created by Antonio Markotic on 07.01.2023

# Full path to the Xcode executable
xcodeProjectPath="/Users/path/to/your/project/iosApp.xcodeproj"

# Initialize the counter variables
fileCounter=0
updatedFilesCounter=0

# Force quit Xcode
echo 
echo "Exiting Xcode..."
pkill -9 Xcode

# Ask the user for the old and new version of SPM
echo "Enter the current SPM shared framework version: "
read oldVersion
echo "Enter the new SPM shared framework version: "
read newVersion

# Clear SPM caches
rm -rf ~/Library/Caches/org.swift.swiftpm
rm -rf ~/Library/org.swift.swiftpm

# Create current and replacement strings used to update SPM version for Package.swift files
searchString="package(url: \"git@github.com:name/of/your/package.git\", exact: \"$oldVersion\")"
replacementString="package(url: \"git@github.com:name/of/your/package.git\", exact: \"$newVersion\")"

# Locate parent directory of Xcode executable and iterate trough it directories and subdirectories, find Package.swift files and update them
parentDirectory=$(dirname "$xcodeProjectPath")
find "$parentDirectory" -name "Package.swift" -print0 | while IFS= read -r -d $'\0' file; do

    fileCounter=$((fileCounter+1))
    if grep "$searchString" "$file" &> /dev/null; then
        sed -i '' "s|$searchString|$replacementString|g" "$file"
        updatedFilesCounter=$((updatedFilesCounter + 1))
        echo "Successfully updated $updatedFilesCounter / $fileCounter Package.swift files"
    else
        echo "The current version inside $file is different than what you specified"
    fi

done 

# Create full path to the project.pbxproj file
fullProjectFilePath=$xcodeProjectPath/project.pbxproj

# Create current and replacement strings used to update SPM version in project.pbxproj file
searchString2="version = $oldVersion;"
replacementString2="version = $newVersion;"

# Update the SPM version in the project.pbxproj file
if sed -i '' "s|$searchString2|$replacementString2|g" "$fullProjectFilePath"; then
  echo "Updating project.pbxproj succedeed!"
else
  echo "Updating project.pbxproj failed!"
fi

# Start the Xcode project executable
echo "\033[32;1mStarting Xcode project...\033[0m"
echo
open $xcodeProjectPath
