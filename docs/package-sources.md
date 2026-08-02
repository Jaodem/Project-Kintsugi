# Package Sources

## Introduction

Every software component installed by Project Kintsugi originates from a package source.

Choosing where software comes from is an engineering decision with long-term implications for maintainability, stability, security, and reproducibility.

For this reason, Project Kintsugi evaluates package sources with the same care applied to selecting desktop components.

The objective is not to avoid external sources entirely, but to understand the trade-offs associated with each one.

---

## Guiding Principle

Whenever possible, Project Kintsugi prefers software distributed through sources that integrate naturally with Fedora and provide a predictable update path.

Additional package sources are accepted only when they solve a clearly identified problem that cannot reasonably be addressed using the default repositories.

---

## Package Source Hierarchy

### Fedora Official Repositories

The official Fedora repositories are the preferred source of software.

Packages are integrated into Fedora's release process, follow its packaging standards, and receive updates through the normal system update workflow.

Whenever an appropriate package is available from Fedora, it is generally preferred.

---

### RPM Fusion

RPM Fusion extends Fedora with software that cannot be distributed through the official repositories for legal, licensing, or policy reasons.

It is considered a well-established extension of the Fedora ecosystem and is an acceptable package source for Project Kintsugi when required.

---

### COPR Repositories

COPR provides community-maintained repositories for software that is unavailable or unsuitable for the official Fedora repositories.

Because each COPR is maintained independently, quality and maintenance practices vary.

Project Kintsugi evaluates each COPR individually rather than treating all COPR repositories equally.

A COPR may be accepted when:

* it is recommended by the upstream project,
* it is actively maintained,
* it provides a clear maintenance advantage,
* and no suitable Fedora package exists.

The addition of every COPR repository should be documented as an explicit engineering decision.

The Hyprland COPR recommended by the upstream project is the first example of this policy being applied in Project Kintsugi.

---

### Flatpak

Flatpak provides application distribution independently of the operating system.

It is particularly useful for desktop applications that benefit from sandboxing or that are updated independently of the Fedora release cycle.

Project Kintsugi evaluates Flatpak on an application-by-application basis rather than adopting it as the default installation method.

---

### Manual Compilation

Compiling software directly from source provides maximum flexibility but also transfers responsibility for dependency management, updates, and reproducibility to the system maintainer.

For this reason, manual compilation is considered a last resort.

It should only be used when no suitable packaged alternative exists and the additional maintenance burden is justified.

---

## Decision Process

Before introducing a new package source, Project Kintsugi evaluates:

* why the default repositories are insufficient,
* whether the source is recommended by the upstream project,
* the expected maintenance requirements,
* the impact on long-term system maintenance,
* and whether the decision aligns with the project's engineering principles.

Every new package source should be justified before implementation.

---

## Project Kintsugi Perspective

Project Kintsugi values reproducible and understandable systems.

Software sources are therefore selected according to technical reasoning rather than convenience.

The project does not reject external repositories categorically.

Instead, it documents why each additional source is introduced and evaluates whether the long-term benefits justify the additional maintenance responsibility.

This approach keeps package management aligned with the project's broader principles of simplicity, maintainability, and informed decision-making.

---

## Weak Dependencies

Project Kintsugi does not automatically install weak dependencies when they introduce desktop components whose selection has not yet been documented.

Optional components such as terminal emulators, launchers, panels, or notification daemons are evaluated independently and installed only after a dedicated architectural decision has been made.