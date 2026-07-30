# SevaSetu – India's Trusted Service Network

## Project Purpose
SevaSetu is a production-grade, enterprise Flutter application designed to connect verified customers with verified service providers instantly.
It is a **Universal Trust Infrastructure for Services** – covering everything from home repairs (AC, Fridge) to highway emergencies and heavy machinery.

## Architecture Overview
- **Approach:** Feature-first + Clean Architecture.
- **State Management:** Riverpod (to be added).
- **Navigation:** GoRouter (to be added).

### Folder Responsibility
- `lib/core/` – App-wide infrastructure: constants, environment, logger, network, utilities.
- `lib/features/` – Self-contained modules (auth, booking, home). Each contains `data/`, `domain/`, `presentation/`.
- `lib/shared/` – Reusable widgets, extensions, and helpers.
- `lib/router/` – Navigation configuration and route guards.
- `lib/main.dart` – Application entry point.

## Development Rules (Director Rules)
1. **NEVER build UI before infrastructure.** Core → Infrastructure → UI.
2. **Max 8–10 files per stage.** Each stage is reviewed before proceeding.
3. **Review-Driven Workflow:** Deep → Code → Director Review → Approved → Git Commit.

## Current Status
- ✅ Stage 1: Project Foundation (Git, pubspec, Folder Structure) – **Locked**
- ✅ Stage 2: Core Foundation (Constants, Logger, Dio, Validators) – **Approved**