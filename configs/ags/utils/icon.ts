export function playerToIcon(name: string) {
  let icons: {
    [key: string]: string;
  } = {
    spotify: "󰓇",
    VLC: "󰓈",
    YouTube: "󰓉",
    Brave: "󰓊",
    Audacious: "󰓋",
    Rhythmbox: "󰓌",
    Chromium: "󰓍",
    Firefox: "󰈹",
    firefox: "󰈹",
  };
  return icons[name];
}
