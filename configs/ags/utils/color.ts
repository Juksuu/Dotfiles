export function playerToColor(name: string) {
  let colors: Record<string, string> = {
    spotify: "#1ED760",
    VLC: "#FF9500",
    YouTube: "#FF0000",
    Brave: "#FF9500",
    Audacious: "#FF9500",
    Rhythmbox: "#FF9500",
    Chromium: "#FF9500",
    Firefox: "#FF9500",
    firefox: "#FF9500",
  };

  return colors[name];
}
