public class MyApp : Gtk.Application {
    private Gtk.Revealer revealer;
    private Gtk.Label transition_label;
    private Gtk.RevealerTransitionType[] transitions = {
        Gtk.RevealerTransitionType.NONE,
        Gtk.RevealerTransitionType.CROSSFADE,
        Gtk.RevealerTransitionType.SLIDE_RIGHT,
        Gtk.RevealerTransitionType.SLIDE_LEFT,
        Gtk.RevealerTransitionType.SLIDE_UP,
        Gtk.RevealerTransitionType.SLIDE_DOWN
    };
    private int transition_index = 0;
    private Gtk.Box box;

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this);

        var transition_button = new Gtk.Button.with_label ("Next transition");
        transition_button.clicked.connect (next_transition);

        transition_label = new Gtk.Label ("");

        var toggle_button = new Gtk.Button.with_label ("Toggle");
        toggle_button.clicked.connect (toggle);

        var revealed_button = new Gtk.Button.with_label ("Revealed");
        revealer = new Gtk.Revealer ();
        revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_DOWN;
        revealer.transition_duration = 1000;
        revealer.add(revealed_button);

        box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        box.add (transition_button);
        box.add (transition_label);
        box.add (toggle_button);
        box.add (revealer);
        main_window.add (box);

        main_window.show_all ();

        next_transition ();
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
