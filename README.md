# Flutter File Manager: Manage Your Files Seamlessly
## Overview:

Expand your file management reach with this versatile desktop application built using Flutter. It offers native-looking interfaces across Windows, macOS, and Linux while seamlessly aligning with the existing web application experience.

## Key Features:

### Cross-Platform: 
  Enjoy consistent performance and ease of use on any desktop operating system.
### Responsive Design: 
  The intuitive UI adapts effortlessly to various screen sizes and resolutions.
### Offline Capabilities: 
  Work productively even without an internet connection, managing crucial files locally.
#### File Management Made Easy:
##### Create New Files: 
  Effortlessly generate new text files (.txt) directly within the application.
##### Open and View Files: 
  Seamlessly open and display the contents of .txt files within the built-in viewer.
##### Rename Files: 
  Modify filenames with ease, ensuring uniqueness and avoiding conflicts.
##### Save Files: 
  Save changes promptly, either in the current directory or a user-specified location.
##### Delete Files: 
  Remove files effortlessly, using caution with this permanent action.
##### Find and Replace: 
  Quickly locate and replace specific word occurrences within open files.
##### Familiar Interface: 
  The user interface closely resembles the existing web application's design for easy navigation and familiarity.

  

## Packages:

### 1. path_provider:

#### Purpose: 
  This library simplifies locating platform-specific directories commonly used for storing application data, documents, and temporary files. It abstracts away the differences between Windows, macOS, and Linux, making your code more portable.
#### Key Functionalities:
  getApplicationDocumentsDirectory(): Retrieves the path to the directory where your application can store persistent data.
  getExternalStorageDirectory(): Fetches the path to external storage on devices that support it (e.g., SD card).

### 2. dart:io:

#### Purpose: 
  This core library provides low-level I/O operations, including file system interaction. It offers more granular control compared to path_provider but requires greater platform awareness.
#### Key Functionalities:
  File class: Represents a file on the file system, allowing operations like reading, writing, deleting, and renaming.
  Directory class: Represents a directory, enabling you to list its contents, create new subdirectories, or delete it.

  

## Get Started:

#### Clone the repository: git clone [https://github.com/G-Bhargav/fileManager/](https://github.com/G-Bhargav/fileManager.git)
#### Install dependencies: 
```flutter pub get```
#### Run the app: 
```flutter run```

## Screen Recording:

https://github.com/G-Bhargav/fileManager/assets/117430958/f75d455e-2334-4b97-8977-3b0d2929bd3f

## Contribute and Connect:
We welcome your contributions and feedback! Share your thoughts and help us enhance this File Manager for everyone.
