# Test Notes: Campus Event Registration

Tested with `flutter run -d chrome`. Each case was run manually.

## Manual test cases

| # | Test | Steps | Expected result | Result |
|---|------|-------|-----------------|--------|
| 1 | Empty form is blocked | Open an event, tap Register now, tap Submit with nothing filled | Red errors under name, email and year; no navigation | Pass |
| 2 | Spaces-only name | Enter spaces in the name, fill the rest, Submit | Name error shown | Pass |
| 3 | Invalid email | Enter `abc`, `abc@`, then `abc@gmail` as the email | "Enter a valid email" error each time | Pass |
| 4 | Year not selected | Fill name and email, leave year empty, Submit | "Please select your year of study" | Pass |
| 5 | Valid submission | Fill all fields correctly, Submit | Confirmation screen shows the correct event and the submitted name | Pass |
| 6 | Event is preserved | Register for a different event | Confirmation shows that event's title, date and venue | Pass |
| 7 | Back from details | Open an event, press Back | Returns to the event list | Pass |
| 8 | Back from the form | Open the form, press Back | Returns to the same event's details | Pass |
| 9 | Back after submitting | On the confirmation screen press system Back | Returns to the event details | Pass |
| 10 | Back to events | On the confirmation screen tap "Back to events" | Returns to the event list | Pass |
| 11 | Initial count | Open the app | Every event shows 10 registered | Pass |
| 12 | Count increases | Register successfully for one event | That event shows 11 registered; other events stay at 10 | Pass |
| 13 | Invalid input does not change the count | Submit an invalid form | Count stays the same | Pass |
| 14 | Full event | Register once for Open Mic Night | It shows Full and the Register button is disabled | Pass |
| 15 | Search and filter | Search `hack`, then use the category chips | Only matching events are shown; empty result shows "No events found" | Pass |

## Issues found and fixed

1. **Labels overlapping the input boxes.** The floating labels ("Full name",
   "Year of study") sat on the top border of the fields. Fixed by placing the
   labels above the fields and using hint text inside the boxes.
2. **Validation and Submit seemed not to work.** The app was still running an
   old build because a new screen file had been added and the app was only
   hot reloaded. Fixed by stopping the app and running `flutter run` again.

## Not tested

- Real Android device (tested in Chrome)
- Data after closing the app: counts reset to 10 because nothing is saved yet
