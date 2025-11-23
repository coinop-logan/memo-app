use dioxus::prelude::*;

fn main() {
    dioxus::launch(App);
}

#[component]
fn App() -> Element {
    rsx! {
        div {
            style: "padding: 20px; font-family: sans-serif;",
            h1 { "Memo App" }
            p { "Hello from Dioxus!" }
            p { "This is your mobile memo app." }
        }
    }
}
