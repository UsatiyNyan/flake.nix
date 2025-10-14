lib: let
  mkRaw = lib.generators.mkLuaInline;
  mkFun = x: mkRaw "function () ${x} end";
  mkCmd = x: "<cmd>${x}<CR>";
in {
  inherit mkRaw mkFun mkCmd;
}
