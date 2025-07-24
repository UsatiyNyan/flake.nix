config: let
  mkRaw = config.lib.nixvim.mkRaw;
  mkFun = x: mkRaw "function () ${x} end";
  mkCmd = x: "<cmd>${x}<CR>";
in {
  inherit mkRaw mkFun mkCmd;
}
