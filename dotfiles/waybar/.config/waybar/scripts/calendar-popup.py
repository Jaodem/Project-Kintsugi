#!/usr/bin/env python3

import signal
import subprocess
import sys

# Toggle: second click closes
try:
    out = subprocess.check_output(
        ["pgrep", "-af", "calendar-popup.py"], text=True
    ).strip().split("\n")
    running = [l for l in out if "python" in l and "calendar-popup.py" in l]
    if len(running) > 1:
        subprocess.run(["pkill", "-f", "calendar-popup.py"])
        sys.exit(0)
except subprocess.CalledProcessError:
    pass

import gi
gi.require_version("Gtk", "3.0")
gi.require_version("GtkLayerShell", "0.1")
from gi.repository import Gtk, Gdk, GtkLayerShell

TOP_MARGIN = 4
RIGHT_MARGIN = 12

MONTHS = ("Jan", "Feb", "Mar", "Apr", "May", "Jun",
          "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")


def close_all(*_):
    Gtk.main_quit()
    return True


class ClickCatcher(Gtk.Window):
    def __init__(self):
        super().__init__()
        self.set_decorated(False)
        self.set_app_paintable(True)

        GtkLayerShell.init_for_window(self)
        GtkLayerShell.set_layer(self, GtkLayerShell.Layer.TOP)
        for edge in (
            GtkLayerShell.Edge.TOP,
            GtkLayerShell.Edge.BOTTOM,
            GtkLayerShell.Edge.LEFT,
            GtkLayerShell.Edge.RIGHT,
        ):
            GtkLayerShell.set_anchor(self, edge, True)

        css = Gtk.CssProvider()
        css.load_from_data(b"window { background-color: transparent; }")
        self.get_style_context().add_provider(
            css, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        )
        self.connect("button-press-event", close_all)
        self.show_all()


class CalendarPopup(Gtk.Window):
    def __init__(self):
        super().__init__(type=Gtk.WindowType.TOPLEVEL)
        self.set_decorated(False)
        self.set_resizable(False)
        self.set_skip_taskbar_hint(True)
        self.set_skip_pager_hint(True)
        self.set_default_size(340, 320)

        GtkLayerShell.init_for_window(self)
        GtkLayerShell.set_layer(self, GtkLayerShell.Layer.TOP)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.TOP, True)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.RIGHT, True)
        GtkLayerShell.set_margin(self, GtkLayerShell.Edge.TOP, TOP_MARGIN)
        GtkLayerShell.set_margin(self, GtkLayerShell.Edge.RIGHT, RIGHT_MARGIN)
        GtkLayerShell.set_exclusive_zone(self, 0)
        GtkLayerShell.set_keyboard_mode(
            self, GtkLayerShell.KeyboardMode.ON_DEMAND
        )

        self.connect("key-press-event", self.on_key)
        self.connect("destroy", close_all)

        box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        box.set_margin_top(14)
        box.set_margin_bottom(14)
        box.set_margin_start(14)
        box.set_margin_end(14)

        self.calendar = Gtk.Calendar()
        self.calendar.set_display_options(
            Gtk.CalendarDisplayOptions.SHOW_HEADING
            | Gtk.CalendarDisplayOptions.SHOW_DAY_NAMES
        )
        self.calendar.connect("day-selected", self.on_day_selected)
        self.calendar.connect("month-changed", self.on_month_changed)
        box.pack_start(self.calendar, True, True, 0)

        # Bottom label: larger, bold, and lighter color
        self.date_label = Gtk.Label()
        self.date_label.set_margin_top(4)
        self.date_label.set_markup(
            '<span foreground="#f0f0f0" size="large" weight="bold">Select a day</span>'
        )
        box.pack_start(self.date_label, False, False, 0)

        nav = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        btn_prev = Gtk.Button(label="‹")
        btn_next = Gtk.Button(label="›")
        btn_today = Gtk.Button(label="Today")
        btn_prev.connect("clicked", self.prev_month)
        btn_next.connect("clicked", self.next_month)
        btn_today.connect("clicked", self.go_today)
        nav.pack_start(btn_prev, True, True, 0)
        nav.pack_start(btn_today, True, True, 0)
        nav.pack_start(btn_next, True, True, 0)
        box.pack_start(nav, False, False, 0)

        self.add(box)
        self.apply_css()
        self.refresh_mark()
        self.show_all()

    def apply_css(self):
        css = Gtk.CssProvider()
        css.load_from_data("""
        window {
            background: rgba(30, 30, 30, 0.96);
            border-radius: 12px;
            border: 1px solid rgba(255, 255, 255, 0.10);
        }
        calendar {
            color: #e0e0e0;
            background: transparent;
            font-family: "JetBrainsMono Nerd Font", "Noto Sans", sans-serif;
            font-size: 15px;
            padding: 4px;
        }
        calendar.header {
            font-weight: bold;
            font-size: 15px;
            color: #f0f0f0;
        }
        calendar.button {
            border-radius: 8px;
            min-width: 34px;
            min-height: 34px;
            padding: 0;
            margin: 1px;
            color: #e0e0e0;
            background: transparent;
        }
        calendar.button:hover {
            background: rgba(255, 255, 255, 0.08);
        }
        button {
            background: rgba(255, 255, 255, 0.08);
            color: #e0e0e0;
            border: none;
            border-radius: 8px;
            padding: 6px 12px;
            font-size: 14px;
        }
        button:hover {
            background: rgba(255, 255, 255, 0.14);
        }

        /* Hacer el círculo (marca) del día seleccionado más grande y visible */
        calendar day.mark {
            background: rgba(255, 255, 255, 0.35);
            border: 2px solid #cccccc;
            border-radius: 50%;
            /* También podemos forzar tamaño mínimo */
            min-height: 24px;
            min-width: 24px;
        }
        """.encode("utf-8"))
        screen = Gdk.Screen.get_default()
        Gtk.StyleContext.add_provider_for_screen(
            screen, css, Gtk.STYLE_PROVIDER_PRIORITY_USER
        )

    def refresh_mark(self):
        self.calendar.clear_marks()
        y, m, day = self.calendar.get_date()
        if day > 0:
            self.calendar.mark_day(day)
            # Label inferior con fecha, negrita y color claro
            self.date_label.set_markup(
                f'<span foreground="#f0f0f0" size="large" weight="bold">{day:02d} {MONTHS[m]} {y}</span>'
            )
        else:
            self.date_label.set_markup(
                '<span foreground="#f0f0f0" size="large" weight="bold">Selecciona un día</span>'
            )

    def on_day_selected(self, _cal):
        self.refresh_mark()

    def on_month_changed(self, _cal):
        self.refresh_mark()

    def on_key(self, widget, event):
        if event.keyval == Gdk.KEY_Escape:
            close_all()

    def prev_month(self, _):
        y, m = self.calendar.get_property("year"), self.calendar.get_property("month")
        if m == 0:
            self.calendar.select_month(11, y - 1)
        else:
            self.calendar.select_month(m - 1, y)
        self.refresh_mark()

    def next_month(self, _):
        y, m = self.calendar.get_property("year"), self.calendar.get_property("month")
        if m == 11:
            self.calendar.select_month(0, y + 1)
        else:
            self.calendar.select_month(m + 1, y)
        self.refresh_mark()

    def go_today(self, _):
        from datetime import date
        t = date.today()
        self.calendar.select_month(t.month - 1, t.year)
        self.calendar.select_day(t.day)
        self.refresh_mark()


def main():
    signal.signal(signal.SIGINT, signal.SIG_DFL)
    ClickCatcher()
    CalendarPopup()
    Gtk.main()


if __name__ == "__main__":
    main()
