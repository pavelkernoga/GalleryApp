# Gallery app

Hello there! My name is Pavel, I'm an iOS developer. Welcome to this repository!
My CV: https://drive.google.com/file/d/1J6gS-EjPcqrBeD2hUhSNSEl4kQ5weolk/view?usp=share_link
My linkedin: https://www.linkedin.com/in/pavel-kernoga/

This is a simple native iOS application that allows users to browse and favourite images fetched from Unsplash API.

## Additional features implemented beyond the stated requirements:
- Ability to open all your favorite pictures on a new page.

## Architecture:
The application is based on MVP architecture, which simplifies its further development, maintenance and testing. Dependency injection is used.

## Key functionalities: 
** Image Gallery Screen **
- In this screen app display grid of thumbnail images fetched from the Unsplash API.
- Each thumbnail is tappable and lead to the Image Detail Screen.
- Implemented pagination to load more images as the user scrolls to the bottom of the screen.
- If the image is a favorite, a small red heart indicator will appear on the image and a heart button will appear on the navigation bar.
- If the user clicks on the "Favorites" button in the navigation bar, they will be taken to a page with all their favorite images.
- If the user clicks on any image, it will take them to the next image detail screen.

** Image Detail Screen **
- Shows the selected image in an expanded view with additional information such as the image title and description.
- Allows the user to mark an image as a favorite by clicking on a heart-shaped button.
- Implemented basic swipe gestures to navigate between images in the detail view.

** Favorites Images Screen **
- Shows all favorites images on a new page.
- Allow the user to select each image and navigate to the detail screen.
- Ability to return to the main gallery screen with all images.

## Demo:
<img src="https://github.com/pavelkernoga/GalleryApp/assets/71964377/e2242249-8b42-461c-9cea-c1784a49d84e" width="393" height="852">

<img src ="https://github.com/pavelkernoga/GalleryApp/assets/71964377/80aa64eb-9d23-4272-8801-f32480a7a903" width="393" height="852">

<img src ="https://github.com/pavelkernoga/GalleryApp/assets/71964377/8aa299db-d0df-4441-9fe6-608b0c2e23c5" width="393" height="852">

<img src ="https://github.com/pavelkernoga/GalleryApp/assets/71964377/b6a99ee1-170f-4dab-bb5c-6188773d0e96" width="393" height="852">

<img src ="https://github.com/pavelkernoga/GalleryApp/assets/71964377/fe6cab13-2405-42ab-b2df-949af4335c95" width="393" height="852">

## Configuration:
The application is supported on iOS 13 or above versions.
To run the application follow the steps below:
 1. Clone the repository first: https://github.com/pavelkernoga/GalleryApp
 2. Navigate to the project folder and open GalleryApp.xcodeproj in Xcode.
 3. Select the simulator or your phone in the available device settings.
 4. Launch the project and wait for loading.
