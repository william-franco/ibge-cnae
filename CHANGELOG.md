# Changelog

All notable changes to this project are documented in this file.

## 2026-11-22

- Commit: Expanded app structure, tests, Linux E2E, and CI workflow.
  - Feature modules, unit tests, integration_test, and flutter_ci Linux E2E job.
- Commit: Use material_ui in integration_test to fix Flutter analyze deprecation.
  - Replaced legacy material.dart imports in integration tests for current Flutter stable analyze.

## 2026-11-21

- Commit: Added settings feature with dark theme and About/GitHub link.
  - Persisted theme via `shared_preferences`, `get_it` + `StateBuilderWidget` at app root, route `/settings` from CNAE home.
- Commit: Initial CNAE app scaffold mirrored from app-github.
  - Hierarchical navigation over IBGE CNAE v2 API, clean architecture, CI, and aligned Android toolchain.