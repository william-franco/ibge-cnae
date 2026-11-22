# Changelog

All notable changes to this project are documented in this file.

## 2026-11-21

- Commit: Added settings feature with dark theme and About/GitHub link.
  - Persisted theme via `shared_preferences`, `get_it` + `StateBuilderWidget` at app root, route `/settings` from CNAE home.
- Commit: Initial CNAE app scaffold mirrored from app-github.
  - Hierarchical navigation over IBGE CNAE v2 API, clean architecture, CI, and aligned Android toolchain.