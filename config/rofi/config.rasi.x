configuration {
  hide-scrollbar: true;
  sidebar-mode: true; 
  font: "CaskaydiaCove NF 10";
  show-icons: true;
  icon-theme: "Oranchelo";
  drun-display-format: "{icon} {name}";
  display-drun: "Applications:";
  display-window: "Windows:";
  display-drun: "   Apps ";
  display-run: "   Run ";
  display-window: " 﩯  Window";
  display-Network: " 󰤨  Network";

  modi: "window,run,drun";
  terminal: "alacritty";
  location: 0;
  disable-history: false;
}

@theme "/dev/null"

* {
  bg: #11121D;
  bg-alt: #444b6a;

  fg: #FFFFFF;
  fg-alt: #787c99;

  background-color: @bg;
  
  border: 0;
  margin: 0;
  padding: 0;
  spacing: 0;
}

window {
  width: 30%;
}

mainbox {
  background-color: @bg;
  children: [inputbar, listview];
}

inputbar {
  /* background-color: @bg-alt; */
  children: [prompt, entry];
}

prompt {
  enabled: true;
  background-color: @bg-alt;
  text-color: @fg;
  padding: 12px 0px 0px 0px;
  margin: 20px 0px 0px 20px;
  border-radius: 3px;
}

entry {
  background-color: @bg-alt;
  padding: 12px 12px 12px 12px;
  margin: 20px 20px 0px 0px;
  text-color: @fg;
}

listview {
  columns: 2;
  lines: 10;
  background-color: @bg;
  border: 0px 0px 0px 0px;
  padding: 0px 0px 0px 0px;
  margin: 10px 0px 0px 20px;
}

element {
  background-color: @bg;
  text-color: @fg-alt;
  padding: 5px;
}

element-icon {
  size: 25px;
}

element selected {
  text-color: @fg;
}

element-text {
  background-color: inherit;
  text-color: inherit;
  vertical-align: 0.5;
}

/* vim: ft=sass

