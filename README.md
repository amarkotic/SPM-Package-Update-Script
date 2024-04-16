# SPM-Package-Update-Script
Automate Package version update in modularized iOS projects without having to worry if Xcode will interfere with the process.

## Table of contents
  * [Usecase](#usecase)
  * [Initial Setup](#initial-setup)
  * [Usage](#usage)
  * [Moving Forward](#moving-forward)

## Usecase
iOS projects modularized with SPM contain Package.swift files. Number of Package.swift files can grow very fast as the project grows.

Each Package.swift file contains dependencies section where the dependencies used for that project are listed. 

```swift
.package(url: "https://github.com/pointfreeco/swift-dependencies", .upToNextMinor(from: "1.2.2")),
```

**When you decide to update that version, you normally have to go trough each Package.swift and update it manually. This script ensures that update is done automatically and with Xcode closed so Packages don't start resolving until all versions are updated.**

## Initial Setup
### Step 1. Clone this repo
Open terminal and run:
```swift
git clone git@github.com:amarkotic/SPM-Package-Update-Script.git
```

### Step 2. Open spm-update.sh and enter path to your Xcode project

```swift
xcodeProjectPath="/Users/path/to/your/project/iosApp.xcodeproj"
```
### Step 3. In spm-update.sh change searchString and replacementString 

```swift
searchString="package(url: \"git@github.com:name/of/your/package.git\", exact: \"$oldVersion\")"
replacementString="package(url: \"git@github.com:name/of/your/package.git\", exact: \"$newVersion\")"
```
Example:

```swift
searchString="package(url: \"git@github.com:pointfreeco/swift-dependencies.git\", exact: \"$oldVersion\")"
replacementString="package(url: \"git@github.com:pointfreeco/swift-dependencies.git\", exact: \"$newVersion\")"
```
## Usage

### Step 1. Open terminal, position yourself in SPM-Package-Update-Script folder and run

```swift
./spm-update.sh
```

### Step 2. You should see something like this:

![terminal-output](https://github.com/amarkotic/SPM-Package-Update-Script/assets/40775323/7050b79b-a89e-490f-b150-0902042b8806)

## Moving Forward
**Congrats!** Your script for automated update of SPM Package versions in Package.swift files is ready to be used. Simply open terminal and run ./spm-update.sh, enter your current version and desired version whenever you want to update them without having to think if Xcode is interfering with the process.
