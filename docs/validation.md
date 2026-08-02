# Validation

## Introduction

Project Kintsugi is built through small, incremental changes.

Every modification should produce a system that remains understandable, functional, and recoverable before the next change is introduced.

For this reason, every significant implementation must be validated before it becomes part of the project's history.

Validation is not an optional final step.

It is an integral part of the engineering process.

---

## Purpose

The objective of validation is to confirm that a component fulfills the responsibility it was introduced to provide.

Validation focuses on observable behavior rather than assumptions.

A successful installation does not necessarily mean that a component has been integrated correctly.

Only by verifying its intended functionality can the implementation be considered complete.

---

## Validation Principles

Every implementation in Project Kintsugi follows the same principles.

### Validate One Change at a Time

Only one significant component should be introduced at a time.

This makes it possible to identify the source of unexpected behavior and simplifies troubleshooting.

### Verify the Intended Responsibility

Validation should confirm the responsibility assigned to the component.

For example, a status bar should display desktop information, while an application launcher should successfully start applications.

The objective is to verify the component's purpose rather than every available feature.

### Keep Validation Simple

Validation procedures should remain straightforward and repeatable.

Whenever possible, a small number of checks should provide sufficient confidence that the component behaves as expected.

### Validate Before Committing

A component should not be committed until its expected behavior has been verified.

Each commit should represent a stable and functional state of the project.

---

## Validation Workflow

Every implementation follows the same workflow.

1. Define the responsibility of the component.
2. Install or configure the component.
3. Verify that it fulfills its intended responsibility.
4. Document any important observations or decisions.
5. Commit the validated state.

This workflow ensures that implementation and documentation evolve together.

---

## Examples

The validation process depends on the responsibility of each component.

Examples include:

* **Hyprland**: A graphical Wayland session starts successfully and accepts keyboard and mouse input.
* **Status Bar**: The bar is displayed correctly and updates desktop information.
* **Application Launcher**: Applications can be discovered and launched successfully.
* **Notification Manager**: Test notifications are displayed correctly.
* **Lock Screen**: The desktop session locks and can be unlocked after authentication.
* **Clipboard Manager**: Clipboard history is recorded and previous entries can be restored.

These examples illustrate the principle that validation should focus on the primary responsibility of the component.

---

## Project Kintsugi Perspective

Project Kintsugi treats every commit as a reliable milestone in the evolution of the desktop.

Validation ensures that each milestone represents a working system rather than an intermediate experiment.

By validating every significant change before recording it in version control, the project maintains a clear relationship between architecture, implementation, and documented decisions.

This approach supports the project's long-term goals of simplicity, maintainability, and understanding.
