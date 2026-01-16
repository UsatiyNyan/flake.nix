# applauncher
{pkgs, ...}: {
  home = {
    packages = with pkgs; [rofi];
    # theme based on "github:rose-pine/rofi"
    file.".config/rofi/config.rasi".text = ''
      @import "default"

      * {
        bg: rgba(25, 23, 36, 0.8);
        cur: #1f1d2e;
        fgd: #e0def4;
        cmt: #6e6a86;
        cya: #9ccfd8;
        grn: #31748f;
        ora: #ebbcba;
        pur: #c4a7e7;
        red: #eb6f92;
        yel: #f6c177;

        font-family: "Iosevka Nerd Font";
        font-size: 18px;

        foreground: @fgd;
        background: @bg;
        transparent-background: rgba(0, 0, 0, 0);
        active-background: @grn;
        urgent-background: @red;

        selected-background: @active-background;
        selected-urgent-background: @urgent-background;
        selected-active-background: @active-background;
        separatorcolor: @active-background;
        bordercolor: @ora;
      }

      #window {
        background-color: @background;
        border:           0;
        padding:          5;
      }
      #mainbox {
        background-color: @transparent-background;
        border:  0;
        padding: 5;
      }
      #message {
        background-color: @transparent-background;
        border:       1px dash 0px 0px ;
        border-color: @separatorcolor;
        padding:      1px ;
      }
      #textbox {
        background-color: @transparent-background;
        text-color: @foreground;
      }
      #listview {
        background-color: @transparent-background;
        fixed-height: 0;
        border:       2px dash 0px 0px ;
        border-color: @bordercolor;
        spacing:      2px ;
        scrollbar:    false;
        padding:      2px 0px 0px ;
      }
      #element {
        background-color: @transparent-background;
        border:  0;
        padding: 1px;
      }
      #element.normal.normal {
        background-color: @transparent-background;
        text-color:       @foreground;
      }
      #element.normal.urgent {
        background-color: @urgent-background;
        text-color:       @urgent-foreground;
      }
      #element.normal.active {
        background-color: @active-background;
        text-color:       @background;
      }
      #element.selected.normal {
        background-color: @selected-background;
        text-color:       @foreground;
      }
      #element.selected.urgent {
        background-color: @selected-urgent-background;
        text-color:       @foreground;
      }
      #element.selected.active {
        background-color: @selected-active-background;
        text-color:       @background;
      }
      #element.alternate.normal {
        background-color: @transparent-background;
        text-color:       @foreground;
      }
      #element.alternate.urgent {
        background-color: @urgent-background;
        text-color:       @foreground;
      }
      #element.alternate.active {
        background-color: @active-background;
        text-color:       @foreground;
      }
      #scrollbar {
        width:        2px ;
        border:       0;
        handle-width: 8px ;
        padding:      0;
      }
      #sidebar {
        border:       2px dash 0px 0px ;
        border-color: @separatorcolor;
      }
      #button.selected {
        background-color: @selected-background;
        text-color:       @foreground;
      }
      #inputbar {
        spacing:    0;
        text-color: @foreground;
        padding:    1px ;
      }
      #case-indicator {
        spacing:    0;
        text-color: @foreground;
      }
      #entry {
        background-color: @transparent-background;
        spacing:    0;
        text-color: @cya;
      }
      #prompt {
        spacing:    0;
        text-color: @ora;
      }
      #inputbar {
        children:   [ prompt,textbox-prompt-colon,entry,case-indicator ];
      }
      #textbox-prompt-colon {
        expand:     false;
        str:        ">";
        margin:     0px 0.3em 0em 0em;
        text-color: @ora;
      }
    '';
  };
}
