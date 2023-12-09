# Factory Manager App

## Overview
This Flutter application provides a management interface for factories. It includes features such as listing factories, adding new factories, and displaying factory details. The app also incorporates various UI animations for a more engaging user experience.

## Features
- **List of Factories**: Display a list of factories, each with details like the number of workers, shops, and salaries.
- **Add New Factory**: Functionality to add new factories to the list.
- **View Factory Details**: View details of each factory by tapping on a list item.
- **Interactive UI Animations**:
  - Scale animation on the 'Add Factory' floating action button.
  - Fade-in animation for factory list items.
  - Slide transition when navigating to the factory details page.
  - Gear icon animation in the AppBar, which appears after tapping on a list item.

## Implementation Details

### Factory List
The main page of the app displays a list of factories. Each list item is interactive and responds to taps, leading the user to the details page of the selected factory.

### Adding a Factory
The application allows users to add a new factory. This is achieved through a dedicated page where users can enter details such as the name, number of workers, and salaries. This page also serves to display factory details in a read-only format.

### Animations
- **List Item Animation**: When a factory list item is tapped, a gear icon animation is triggered in the AppBar. This icon remains visible for a set duration, emphasizing the interactive nature of the list.
- **Scale Animation**: The floating action button on the main page uses a scale animation for a dynamic appearance.
- **Slide Transition**: The transition to the factory details page is a smooth slide animation, enhancing the user experience.

### Responsive Gear Icon
- The gear icon in the AppBar starts hidden and becomes visible with a rotation animation upon interacting with a list item. It serves as a visual indicator of the interaction and remains visible for a few seconds.

## Usage
To use the app, simply tap on a factory in the list to view its details or use the floating action button to add a new factory.

## Future Enhancements
- Implement more interactive features and animations.
- Integrate with a backend service for real-time data management.
- Enhance the UI for a more intuitive user experience.

