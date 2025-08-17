import app from "ags/gtk3/app";
import { execAsync } from "ags/process";
import { monitorFile } from "ags/file";
import {
  globalFontSize,
  globalIconSize,
  globalOpacity,
  globalScale,
} from "../variables";
import { notify } from "./notification";

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

export async function refreshCss() {
  try {
    await execAsync(
      `
      bash -c "echo -e '
      \\$OPACITY: ${globalOpacity.get().value};\n
      \\$ICON-SIZE: ${globalIconSize.get().value}px;\n
      \\$FONT-SIZE: ${globalFontSize.get().value}px;\n
      \\$SCALE: ${globalScale.get().value}px;
      ' | cat - ${defaultColors} ${walColors} ${scss} > ${tmpScss} && sassc ${tmpScss} ${tmpCss} -I ${scssDir}"
      `,
    );
  } catch (e) {
    notify({ summary: `Error while generating css`, body: String(e) });
    console.error(e);
  }

  app.reset_css();
  app.apply_css(tmpCss);
}

monitorFile(
  // directory that contains pywal colors
  "../../.cache/wal/colors.scss",
  () => refreshCss(),
);
