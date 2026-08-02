# Wayland

## Introduction

Wayland is the communication protocol that defines how graphical applications interact with a compositor.

It is not a desktop environment, a display server, or a compositor itself.

Instead, Wayland specifies the rules that both applications and compositors follow in order to communicate with one another.

Understanding this distinction is essential for understanding the architecture of a modern Linux desktop.

Project Kintsugi approaches Wayland as the foundation that enables independent graphical components to cooperate through a common protocol.

---

## A Protocol, Not an Application

A protocol is a contract between independent pieces of software.

It defines how information is exchanged, what messages can be sent, and how both sides of the communication are expected to behave.

A protocol does not determine how either side must be implemented.

Instead, it ensures that different implementations can communicate successfully by following the same rules.

Wayland follows this model.

Any application that implements the client side of the protocol can communicate with any compositor that implements the server side of the protocol, provided both support the required features.

This separation allows multiple compositors to exist while remaining compatible with the same ecosystem of Wayland applications.

---

## Clients and Compositors

The Wayland protocol defines a relationship between two participants:

* The client.
* The compositor.

The client is typically a graphical application.

Its responsibility is to create its own graphical content and request services from the compositor.

The compositor is responsible for implementing the Wayland protocol, receiving requests from clients, managing the graphical session, and presenting the final result on the display.

Neither side operates independently.

A graphical application requires a compositor to display its interface, while the compositor provides the environment in which graphical applications can exist.

---

## Communication Through Wayland

Applications do not draw directly onto the screen.

Instead, they render their own graphical content and submit it to the compositor.

The compositor then decides how and where that content will appear within the desktop.

Likewise, input events such as keyboard presses or mouse movement are first received by the compositor.

The compositor determines which application should receive those events and forwards them accordingly.

In this model, every interaction between graphical applications and the desktop passes through the compositor using the Wayland protocol.

---

## Security by Design

One of the fundamental characteristics of Wayland is that applications do not receive unrestricted access to the graphical session.

A client cannot freely inspect other application windows, monitor global keyboard input, or capture the contents of the screen without explicit cooperation from the compositor or other trusted desktop services.

This architecture establishes clear boundaries between applications and contributes to a more secure graphical environment.

Features such as screen sharing, screenshots, global shortcuts, and clipboard integration therefore require explicit mechanisms rather than unrestricted access.

Understanding this design is essential for understanding many of the desktop components that will be introduced later in Project Kintsugi.

---

## Why This Matters for Project Kintsugi

Project Kintsugi aims to build a desktop environment through understanding rather than experimentation.

Recognizing Wayland as a communication protocol—not as a specific application or compositor—provides the correct mental model for every decision that follows.

Hyprland will eventually become the compositor chosen by the project, but it is only one possible implementation of the Wayland protocol.

By separating the protocol from its implementations, Project Kintsugi can evaluate desktop components according to their architectural responsibilities instead of treating them as interchangeable configuration packages.

This understanding forms the foundation for studying desktop services, compositor extensions, portals, and the remaining components of a modern Wayland desktop.
