# LifeTrack — Pluggable Event Router (SOLID & Design Patterns)

Welcome to **LifeTrack**, a modular command-line tool written in Ruby that enables users to track work sessions, study sessions, workouts, and meals. 

This project is built from the ground up according to strict **SOLID principles** and demonstrates the combination of the **Observer** and **Strategy** design patterns.

---

## File Structure

The application is split into highly modular, single-responsibility components:

*   **`lifetrack.rb`**: The application entry point which sets up the router, registers handlers, and runs the interactive menu loop.
*   **`lib/event.rb`**: A simple, read-only data carrier (DTO) representing a single life event.
*   **`lib/event_router.rb`**: The central dispatch unit (Observer Subject) that routes events to registered handlers.
*   **`lib/handlers/base_handler.rb`**: The handler interface/contract enforcing `#call(event)` at runtime.
*   **`lib/handlers/console_handler.rb`**: Formats and prints events directly to standard output.
*   **`lib/handlers/file_handler.rb`**: Appends formatted event logs to a text file (`lifetrack.log`).
*   **`lib/handlers/stats_handler.rb`**: Collects events during the session and automatically outputs a summary of statistics to the console when the program exits.
*   **`lib/handlers/slack_handler.rb`**: Simulates sending event payloads via a Slack webhook (demonstrating the Architect's Bonus task).

---

## How to Run

No external dependencies are required. Run the application from your terminal using:

```bash
ruby lifetrack.rb
```

### Example Session

```text
=== LifeTrack ===
1. Log a work session
2. Log a study session
3. Log an exercise session
4. Log a meal
5. Exit

Choose an option: 2
Description: Deep work on Ruby SOLID principles
Duration (minutes): 45

[2026-06-19 08:05] STUDY — Deep work on Ruby SOLID principles (45 min)
[Slack Notification] Simulated POST to https://hooks.slack.com/services/mock/lifetrack with payload: ⚡ *New LifeEvent Logged!* | *Type:* STUDY | *Desc:* Deep work on Ruby SOLID principles | *Duration:* 45 mins
✓ Event logged.

=== LifeTrack ===
1. Log a work session
2. Log a study session
3. Log an exercise session
4. Log a meal
5. Exit

Choose an option: 5
Exiting LifeTrack. Goodbye!

========================================
        LIFETRACK SESSION SUMMARY       
========================================
Total Events:        1
Total Duration:      45 minutes
----------------------------------------
Breakdown by Category:
  • STUDY    : 1 session(s) (45 min)
========================================
```

