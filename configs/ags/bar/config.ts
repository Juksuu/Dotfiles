export const CONFIG = {
  animations: {
    durationLarge: 180,
    durationSmall: 110,
  },
  time: {
    interval: 5000,
    format: "%H:%M",
    dateInterval: 5000,
    dateFormatLong: "%A, %d/%m", // On bar
  },

  keyboard: {
    useFlag: true,

    // For keyboard layout in statusicons.js
    // This list is not exhaustive. It just includes known/possible languages of users of my dotfiles
    // Add your language here if you use multi-lang xkb input. Else, ignore
    // Note that something like "French (Canada)" should go before "French"
    //                      and "English (US)" should go before "English"
    languages: [
      {
        layout: "us",
        name: "English (US)",
        flag: "🇺🇸",
      },
      {
        layout: "fi",
        name: "Finnish",
        flag: "🇫🇮",
      },
      {
        layout: "undef",
        name: "Undefined",
        flag: "🧐",
      },
    ],
  },
};
