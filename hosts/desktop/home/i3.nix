{ pkgs, lib, ... }:
let
  # monitors
  m1_port = "DP-2";
  m2_port = "DP-4";

  # workspaces
  ws1 = "1";
  ws2 = "2";
  ws3 = "3";
  ws4 = "4";
  ws5 = "5";
  ws6 = "6";
  ws7 = "7";
  ws8 = "8";
  ws9 = "9";
  ws10 = "10";
in
{
  xsession.windowManager.i3 = {
    config = {
      assigns = lib.mkAfter {
        "${ws4}" = [{ class = "^steam$"; } { class = "^Lutris$"; } { class = "^lutris$"; } { class = "^battle.net.exe$"; }];
        "${ws5}" = [{ class = "^wow.exe$"; } { class = "^pathofexile.exe$"; } { class= "^steam_app_739630$"; } ];
      };

      startup = lib.mkAfter [
        {
          command = ''${pkgs.xorg.xinput}/bin/xinput set-prop "pointer:Logitech G903 LS" "libinput Middle Emulation Enabled" 0'';
          always = true;
          notification = false;
        }
      ];
    };

    extraConfig = lib.mkAfter ''
      workspace ${ws1} output ${m2_port}
      workspace ${ws2} output ${m2_port}
      workspace ${ws3} output ${m2_port}
      workspace ${ws4} output ${m2_port}
      workspace ${ws5} output ${m2_port}
      workspace ${ws6} output ${m2_port}
      workspace ${ws7} output ${m2_port}
      workspace ${ws8} output ${m2_port}
      workspace ${ws9} output ${m1_port}
      workspace ${ws10} output ${m1_port}
  
      for_window [class="wow.exe"] move to workspace ${ws5}
    '';
  };
}
