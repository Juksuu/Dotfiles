import { exec } from "astal";
import { monitorFile } from "astal/file";
import { globalIconSize, globalOpacity } from "../variables";
import { App } from "astal/gtk3";

// target css file
const tmpCss = `/tmp/tmp-style.css`;
const tmpScss = `/tmp/tmp-style.scss`;
const scssDir = `~/.config/ags/scss`;
const scss = `~/.config/ags/scss/style.scss`;

const walColors = `~/.cache/wal/colors.scss`;
const defaultColors = "~/.config/ags/scss/default_colors.scss";

export const getCssPath = () => {
  refreshCss();
  return tmpCss;
};

export function refreshCss() {
  // console.log("refresh css");
  // console.log(
  //   "command: ",
  //   `bash -c "echo -e '\\$OPACITY: ${globalOpacity.get().value};\n\\$ICON-SIZE: ${globalIconSize.get().value}px;' | cat - ${defaultColors} ${walColors} ${scss} > ${tmpScss} && sassc ${tmpScss} ${tmpCss} -I ${scssDir}"`,
  // );

  exec(
    `bash -c "echo -e '\\$OPACITY: ${globalOpacity.get().value};\n\\$ICON-SIZE: ${globalIconSize.get().value}px;' | cat - ${defaultColors} ${walColors} ${scss} > ${tmpScss} && sassc ${tmpScss} ${tmpCss} -I ${scssDir}"`,
  );

  App.reset_css();
  App.apply_css(tmpCss);
}

monitorFile(
  // directory that contains pywal colors
  "../../.cache/wal/colors.scss",
  () => refreshCss(),
);
