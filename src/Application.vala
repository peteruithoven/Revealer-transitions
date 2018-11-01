public class MyApp : Gtk.Application {
    private Gtk.Revealer revealer;
    private Gtk.Label transition_label;
    private Gtk.Button orientation_button;
    private Gtk.Button transition_button;
    private Gtk.Button toggle_button;
    private Gtk.Button revealed_button;
    private Gtk.RevealerTransitionType[] transitions = {
        Gtk.RevealerTransitionType.NONE,
        Gtk.RevealerTransitionType.CROSSFADE,
        Gtk.RevealerTransitionType.SLIDE_RIGHT,
        Gtk.RevealerTransitionType.SLIDE_LEFT,
        Gtk.RevealerTransitionType.SLIDE_UP,
        Gtk.RevealerTransitionType.SLIDE_DOWN
    };
    private int transition_index = 0;
    private Gtk.Box inner_box;
    private Gtk.Box outer_box;
    Gtk.Orientation current_orientation = Gtk.Orientation.VERTICAL;

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this);

        orientation_button = new Gtk.Button.with_label ("Switch orientation");
        orientation_button.clicked.connect (switch_orientation);

        transition_button = new Gtk.Button.with_label ("Next transition");
        transition_button.clicked.connect (next_transition);

        transition_label = new Gtk.Label ("");

        toggle_button = new Gtk.Button.with_label ("Toggle");
        toggle_button.clicked.connect (toggle);

        revealed_button = new Gtk.Button.with_label ("Revealed");
        revealer = new Gtk.Revealer ();
        revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_DOWN;
        revealer.transition_duration = 1000;
        revealer.add(revealed_button);

        outer_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        outer_box.add(orientation_button);

        main_window.add (outer_box);

        main_window.show_all ();

        rebuild_inner_box (current_orientation);

        next_transition ();
    }

    private void rebuild_inner_box (Gtk.Orientation orientation) {
        if (inner_box != null) {
            outer_box.remove (inner_box);
            inner_box.remove (transition_button);
            inner_box.remove (transition_label);
            inner_box.remove (toggle_button);
            inner_box.remove (revealer);
        }
        inner_box = new Gtk.Box (orientation, 0);
        inner_box.add (transition_button);
        inner_box.add (transition_label);
        inner_box.add (toggle_button);
        inner_box.add (revealer);

        outer_box.add (inner_box);

        outer_box.show_all ();
    }

    private void switch_orientation () {
        if (current_orientation == Gtk.Orientation.HORIZONTAL) {
            current_orientation = Gtk.Orientation.VERTICAL;
        } else {
            current_orientation = Gtk.Orientation.HORIZONTAL;
        }
        rebuild_inner_box (current_orientation);
    }

    private void next_transition () {
        transition_index++;
        if (transition_index >= transitions.length) {
            transition_index = 0;
        }
        revealer.transition_type = transitions[transition_index];
        transition_label.label = transition_to_string (revealer.transition_type);
    }

    private void toggle () {
        revealer.reveal_child = !revealer.reveal_child;
    }

    private string transition_to_string (Gtk.RevealerTransitionType type) {
        switch (type) {
            case Gtk.RevealerTransitionType.NONE:
                return "NONE";
            case Gtk.RevealerTransitionType.CROSSFADE:
                return "CROSSFADE";
            case Gtk.RevealerTransitionType.SLIDE_RIGHT:
                return "SLIDE_RIGHT";
            case Gtk.RevealerTransitionType.SLIDE_LEFT:
                return "SLIDE_LEFT";
            case Gtk.RevealerTransitionType.SLIDE_UP:
                return "SLIDE_UP";
            case Gtk.RevealerTransitionType.SLIDE_DOWN:
                return "SLIDE_DOWN";
            default:
                return "";
        }
    }

    public static int main (string[] args) {
        var app = new MyApp ();
        return app.run (args);
    }
}
