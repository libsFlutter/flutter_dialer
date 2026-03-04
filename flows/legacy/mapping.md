# Node to Flow Mapping

> Maps understanding tree nodes to generated flow documents

## Session: 2026-03-04 - COMPLETE

| Understanding Node | Flow Path | Type | Status |
|--------------------|-----------|------|--------|
| /flutter-interface | flows/sdd-flutter-interface/ | SDD | DRAFT |
| /flutter-interface/public-api | (included in parent) | - | - |
| /flutter-interface/public-api/error-handling | (included in parent) | - | - |
| /flutter-interface/public-api/return-values | (included in parent) | - | - |
| /flutter-interface/platform-abstraction | (included in parent) | - | - |
| /flutter-interface/platform-abstraction/instance-management | (included in parent) | - | - |
| /flutter-interface/platform-abstraction/method-bridge | (included in parent) | - | - |
| /platform-channel | (included in sdd-flutter-interface) | - | - |
| /platform-channel/method-protocol | (included in parent) | - | - |
| /platform-channel/error-propagation | (included in parent) | - | - |
| /android-plugin | flows/sdd-android-plugin/, flows/tdd-android-plugin/ | SDD + TDD | DRAFT |
| /android-plugin/default-dialer-api | (included in parent) | - | - |
| /android-plugin/lifecycle-management | (included in parent) | - | - |
| /android-plugin/version-handling | (included in parent) | - | - |
| /incall-service | flows/tdd-incall-service/ | TDD | DRAFT |
| /incall-service/call-lifecycle | (included in parent) | - | - |
| /incall-service/call-state-monitoring | (included in parent) | - | - |
| /activity-intents | flows/sdd-activity-intents/ | SDD | DRAFT |
| /activity-intents/intent-filters | (included in parent) | - | - |
| /activity-intents/phone-number-handling | (included in parent) | - | - |

## Flow Summary

| Flow | Type | Documents | Status |
|------|------|-----------|--------|
| flows/sdd-flutter-interface/ | SDD | 01-requirements.md, 02-specifications.md | DRAFT |
| flows/sdd-android-plugin/ | SDD | 01-requirements.md, 02-specifications.md | DRAFT |
| flows/tdd-android-plugin/ | TDD | 01-test-requirements.md, 02-test-specifications.md | DRAFT |
| flows/tdd-incall-service/ | TDD | 01-test-requirements.md, 02-test-specifications.md | DRAFT |
| flows/sdd-activity-intents/ | SDD | 01-requirements.md, 02-specifications.md | DRAFT |

## Coverage

- **Total Domains**: 5
- **Domains with Flows**: 5 (100%)
- **Total Flows**: 5
- **SDD Flows**: 3
- **TDD Flows**: 2
- **ADR Flows**: 0
- **DDD Flows**: 0
- **VDD Flows**: 0

---

*Completed by /legacy - 2026-03-04*
