import { exec } from "astal";

export function getDominantImageColor(imagePath: string) {
  return exec(`bash ./scripts/get-image-dominant-color.sh ${imagePath}`);
}
