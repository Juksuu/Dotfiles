import { exec } from "ags/process";

export function getDominantImageColor(imagePath: string) {
  return exec(`bash ./scripts/get-image-dominant-color.sh ${imagePath}`);
}
