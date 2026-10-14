# Campus Event Registration

A Flutter app where students browse campus events, view details and register
with their name, email and year of study. Built for Task 3 (navigation, forms
and validation) of the Flutter Android 2-week cohort.

## Problem

A college club hosts workshops and wants students to browse events and
register. The app lists the events, shows the details of the selected event,
validates the registration form and confirms the registration.

## User stories

- I can browse a list of events.
- I can open an event to see its date, venue and description.
- I can submit my name, email and year of study and see confirmation.

## Features

- Event list with category, date, venue, registered count and seats left
- Search by title or venue, and filter by category (stretch goal)
- Bookmark events you are interested in
- Event details with organizer, seats progress bar and description
- Registration form with inline validation
- Confirmation screen with a summary of the event and the submitted details
- Registered count starts at 10 for every event and increases after each
  successful registration
- Full events show "Event full" and cannot be registered for

## Screens and navigation

```
EventListScreen  --tap event-->  EventDetailsScreen  --Register now-->  RegistrationScreen
       ^                                 ^                                      |
       |                                 |                              valid submit
       |                                 +------ system Back ----+              v
       +-------------- Back to events ------------------ ConfirmationScreen (replaces the form)
```

- The selected `Event` is passed through the constructor of each screen.
- `Navigator.push` opens the details and the form, so Back returns to the
  previous screen with the selected event preserved.
- After a valid submit, `Navigator.pushReplacement` swaps the form for the
  confirmation screen, so Back goes to the event details and a filled form
  cannot be submitted twice.
- "Back to events" uses `Navigator.popUntil` to return to the list.

## Validation rules

| Field | Rule | Error message |
|---|---|---|
| Full name | Required (spaces only counts as empty) | Please enter your full name |
| Email | Required | Please enter your email address |
| Email | Must look like name@example.com | Enter a valid email, e.g. name@example.com |
| Year of study | Must be selected | Please select your year of study |

The registered count only increases after all fields pass validation.

## Reusable widgets and layout choices

- `EventCard` is a reusable card with callbacks for tap and bookmark.
- `ListView.builder` renders the event list efficiently and scrolls.
- `Row` and `Column` build the info rows and cards; `Expanded` lets long text
  wrap instead of overflowing.
- `Form` with a `GlobalKey<FormState>` and `TextFormField` validators run all
  checks together.
- `StatefulWidget` is used where the screen changes over time: search text,
  selected category, bookmarks and the registered count.

## Project structure

```
lib/
  main.dart
  models/
    event.dart             Event data class (registered count is mutable)
    registration.dart      Registration data passed to the confirmation screen
  data/
    sample_events.dart     5 sample events
  theme/
    styles.dart            Colors, gradient and category icons
  widgets/
    event_card.dart        Reusable event card
  screens/
    event_list_screen.dart
    event_details_screen.dart
    registration_screen.dart
    confirmation_screen.dart
```

## How to run

Requirements: Flutter SDK installed (`flutter doctor` should pass).

```
flutter pub get
flutter run
```

To run in Chrome: `flutter run -d chrome`.



## Known limitations

- Data is not saved: registered counts and bookmarks reset when the app is
  closed (persistence is covered in Task 4).
- The same person can register more than once; there is no duplicate check.
- Year of study is a fixed list, and there is no phone number field.

## Possible improvements

- Save registrations locally and prevent duplicate registrations
- Show a "My registrations" screen
- Add a phone number field with its own validation

## Author

Venkatesh Kumar
