# Gallery app

Hello there! My name is Pavel, I'm an iOS developer. Welcome to this repository!
My linkedin: https://www.linkedin.com/in/pavel-kernoga/

This is a simple iOS application that allows users to browse and favourite images fetched from Unsplash API.

## Additional features implemented beyond the stated requirements:
- Ability to open all your favorite pictures on a new page.

## Architecture:
The application is based on MVP architecture, which simplifies its further development, maintenance and testing. Dependency injection is used.

## Key functionalities: 
** Image Gallery Screen **
- In this screen app display grid of thumbnail images fetched from the Unsplash API.
- Each thumbnail is tappable and lead to the Image Detail Screen.
- Implemented pagination to load more images as the user scrolls to the bottom of the screen.
- If the image is favorite, there is a little red heart indicator in the image and heart button in the navigation bar.
- If user clicks to favorite button in the navigation bar it will lead to the page with all the favorites images.
- If user clicks to any image, it will lead user to the next Image Detail Screen.

** Image Detail Screen **
- Show the selected image in a larger view with additional details, such as the image title and description.
- Allow the user to mark the image as a favoгrite by tapping a heart-shaped button.
- Implemented basic swipe gestures to navigate between images in the detail view.

## Demo:
<img src="https://github.com/pavelkernoga/GalleryApp/assets/71964377/e2242249-8b42-461c-9cea-c1784a49d84e" width="393" height="852">

<img src ="https://github.com/pavelkernoga/GalleryApp/assets/71964377/80aa64eb-9d23-4272-8801-f32480a7a903" width="393" height="852">

<img src ="https://github.com/pavelkernoga/GalleryApp/assets/71964377/8aa299db-d0df-4441-9fe6-608b0c2e23c5" width="393" height="852">

<img src ="https://github.com/pavelkernoga/GalleryApp/assets/71964377/b6a99ee1-170f-4dab-bb5c-6188773d0e96" width="393" height="852">

<img src ="https://github.com/pavelkernoga/GalleryApp/assets/71964377/fe6cab13-2405-42ab-b2df-949af4335c95" width="393" height="852">

