# Compositor

## Introduction

Within a modern Wayland desktop, the compositor is the central component of the graphical system.

Every graphical application interacts with it, every frame displayed on the screen passes through it, and every input event is ultimately coordinated by it.

For this reason, understanding the role of the compositor is essential before selecting a specific implementation such as Hyprland.

Project Kintsugi approaches the compositor as an architectural concept rather than a particular piece of software.

---

## From Window Manager to Compositor

The term *window manager* originates from the X11 architecture.

Under X11, the graphical system was divided into multiple independent components. The X server was responsible for communicating with the hardware and exposing graphical capabilities, while the window manager controlled the appearance and placement of application windows.

These responsibilities were intentionally separated.

Wayland adopts a different approach.

Instead of relying on an external display server and a separate window manager, Wayland places these responsibilities under a single central component: the compositor.

As a result, a Wayland compositor is significantly more than a traditional window manager.

---

## The Responsibilities of a Compositor

A compositor coordinates the graphical desktop by fulfilling several fundamental responsibilities.

These include:

* Receiving graphical content from applications.
* Composing the final image displayed on each monitor.
* Managing application windows and their layout.
* Processing keyboard, mouse, and other input devices.
* Coordinating outputs such as monitors and display scaling.
* Implementing the Wayland protocol for client applications.

Although additional desktop services may exist around it, none of them replace the compositor's role.

It is the foundation upon which the graphical desktop operates.

---

## The Center of a Wayland Desktop

Unlike a traditional desktop environment, where many components appear equally important, a Wayland desktop has a clear architectural center.

Applications do not communicate directly with the display hardware.

Instead, they communicate with the compositor.

Likewise, input devices do not deliver events directly to applications.

The compositor receives those events, determines which application should receive them, and forwards them accordingly.

This makes the compositor responsible for coordinating both graphical output and user interaction.

Every visible element on the screen ultimately depends on it.

---

## What the Compositor Does Not Do

Although the compositor is the central component of a Wayland desktop, it is not responsible for every desktop feature.

Tasks such as notifications, application launching, wallpaper management, clipboard history, authentication dialogs, or status bars belong to independent desktop services.

Some compositor projects include additional functionality beyond their core responsibilities, while others intentionally remain minimal.

Project Kintsugi treats these responsibilities as separate architectural concerns.

Understanding this distinction allows each desktop component to be evaluated independently instead of assuming that every feature belongs inside the compositor.

---

## Why This Matters for Project Kintsugi

One of the primary goals of Project Kintsugi is to understand the architecture of the desktop before modifying it.

Recognizing the compositor as the central component of a Wayland system changes how the entire desktop is understood.

Rather than viewing Hyprland as a configurable window manager, the project views it as the implementation responsible for coordinating the graphical session itself.

Every desktop service introduced during the following phases will either communicate with the compositor directly or rely on the environment it provides.

For that reason, understanding the compositor is the foundation for understanding the rest of the desktop architecture.
