# Desktop Environment

## Introduction

When people refer to a *desktop environment*, they usually think of the graphical interface they interact with every day: windows, panels, application launchers, notifications, wallpapers, system settings, and countless other visual elements.

From the user's perspective, all of these features appear to belong to a single application. In reality, they do not.

A modern desktop environment is a collection of independent components working together to provide a cohesive user experience. Some components are responsible for drawing windows, others manage notifications, handle authentication requests, provide application launchers, integrate the clipboard, or communicate with the operating system on behalf of applications.

This distinction is easy to overlook because traditional desktop environments intentionally hide this complexity behind a unified interface.

Understanding this architecture is essential for Project Kintsugi.

Rather than adopting a complete desktop environment as a single product, this project aims to build a desktop by understanding each responsibility individually and selecting the components that best satisfy the project's principles.

---

## A Desktop Environment Is a System

A desktop environment should not be understood as a single application.

Instead, it is better described as a system composed of multiple services that cooperate to provide a complete graphical workspace.

Each service has a well-defined responsibility. Together, they create the experience commonly referred to as "the desktop."

Although implementations differ, most modern desktop environments provide responsibilities such as:

* Displaying and managing application windows.
* Rendering graphical elements on the screen.
* Managing user input from keyboards, mice, and touchpads.
* Launching applications.
* Displaying notifications.
* Managing the clipboard.
* Providing authentication dialogs.
* Handling screenshots and screen sharing.
* Managing wallpapers and lock screens.
* Integrating applications with the underlying operating system.

The important observation is that these responsibilities are conceptually independent, even if they are delivered together by a single desktop environment.

---

## Integrated Desktop Environments

Traditional desktop environments such as KDE Plasma and GNOME offer an integrated experience.

The user installs a single desktop environment and immediately gains access to all the services required for everyday work.

This approach offers several advantages:

* Consistent user experience.
* Tight integration between components.
* Minimal configuration.
* Predictable behavior.
* Lower maintenance for the user.

The complexity still exists, but it is largely hidden behind the desktop environment itself.

For many users, this is exactly the right solution.

---

## Modular Desktop Environments

A modular desktop follows a different philosophy.

Instead of relying on a single project to provide every desktop service, each responsibility can be fulfilled by an independent component.

This approach increases flexibility and allows each part of the desktop to be selected according to specific goals and requirements.

However, this flexibility also transfers responsibility to the user.

Building a modular desktop requires understanding:

* which responsibilities exist,
* how the different components communicate,
* which dependencies they introduce,
* and how they fit together into a coherent system.

Without this understanding, configuration quickly becomes a collection of copied files rather than an intentionally designed environment.

---

## Why This Matters for Project Kintsugi

Project Kintsugi is not a customization project.

Its objective is to understand the architecture of a modern Linux desktop before modifying it.

The migration from KDE Plasma to Hyprland is therefore not simply a change of graphical interface. It is a transition from an integrated desktop environment to a modular one.

This transition requires making explicit decisions that were previously made by the desktop environment itself.

Every new component introduced during the project will be evaluated according to the same engineering principles established during Phase 0:

* Understand before modifying.
* Document decisions before implementing them.
* Prefer simplicity over unnecessary complexity.
* Build the system incrementally.
* Prioritize long-term maintainability.

For this reason, the next steps of Project Kintsugi will focus on understanding each desktop responsibility individually before selecting the software that will implement it.

The goal is not to assemble a collection of tools, but to design a desktop whose architecture is fully understood by the person maintaining it.
