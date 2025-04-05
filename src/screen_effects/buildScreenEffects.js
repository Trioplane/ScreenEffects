import { ensureDir } from "https://deno.land/std@0.181.0/fs/ensure_dir.ts";

// -------------CONFIGS---------------
// Replace with the namespace you use!
const NAMESPACE = "example";

// If you want the font JSON files to be formatted, make this boolean true.
const prettyPrintFontFiles = false;

// If you want to see the ffmpeg logs, make this boolean true.
const showFFMPEGLogs = false;
// -----------------------------------


// Thanks for using my library!! - @trplnr


// DO NOT TOUCH! ⚠
const PATHS = {
    screen_effects: "./",
    font_files: `../assets/${NAMESPACE}/font/scrfx`,
    textures: `../assets/${NAMESPACE}/textures/font/scrfx`,
};

ensureDir(PATHS.font_files)
ensureDir(PATHS.textures)

console.log(`🟡 Compiling screen effects.`)

for await (const file of Deno.readDir(PATHS.screen_effects)) {
    if (!file.isFile) continue
    if (!file.name.endsWith(".png")) continue
    
    const imagePath = `${PATHS.screen_effects}${file.name}`
    const image = await Deno.readFile(imagePath)
    const dataView = new DataView(image.buffer)

    const width = dataView.getUint32(16)
    const height = dataView.getUint32(20)

    const frameCount = height / width;

    for (let i = 0; i < frameCount; i++) {
        console.log(`----> 🟡 Writing frame '${file.name.replace(".png","")}${i}'`)
        const outputImagePath = `${PATHS.textures}/${file.name.replace(".png","")}${i}.png`
        const outputFontFilePath = `${PATHS.font_files}/${file.name.replace(".png","")}${i}.json`
        
        // writing font file json
        console.log(`------> 🟡 Writing font file '${outputFontFilePath}'`)
        const imageResourcePath = `${NAMESPACE}:font/scrfx/${file.name.replace(".png","")}${i}.png`
        const fontFileContents = JSON.stringify({
                providers: [
                    {
                        type: "bitmap",
                        file: imageResourcePath,
                    height: width,
                    ascent: -2000,
                    chars: [
                      "\uE000"
                    ]
                }
            ]
        }, null, prettyPrintFontFiles ? 4 : 0)
    
        Deno.writeFile(outputFontFilePath, new TextEncoder().encode(fontFileContents))
        console.log(`------> ✅ Successfully wrote font file '${outputFontFilePath}'`)
        
        // ffmpeg to split the image into individual frames
        console.log(`------> 🟡 Writing image '${imagePath}'`)
        const cropCommand = new Deno.Command("ffmpeg", {
            args: [
                    `-y`,
                    `-i`, imagePath,
                    `-vf`, `crop=w=${width}:h=${width}:x=0:y=${width * i}`,
                    `-frames:v`, `1`,
                    `-update`, `true`,
                    outputImagePath
                ]
            })
        const { stdout, stderr } = await cropCommand.output()
        if (showFFMPEGLogs) {
            console.log(new TextDecoder().decode(stdout))
            console.log(new TextDecoder().decode(stderr))
        }
        console.log(`------> ✅ Successfully wrote image '${outputImagePath}'`)
        
        console.log(`----> ✅ Successfully wrote frame '${file.name.replace(".png","")}${i}'`)
    }
    console.log(`--> ✅ Successfully built ${imagePath}`)
}

console.log(`✅ Successfully compiled all screen effects.`)