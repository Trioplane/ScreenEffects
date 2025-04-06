import { ensureDir } from "https://deno.land/std@0.181.0/fs/ensure_dir.ts";

// -------------CONFIGS---------------
// Replace with the namespace you use!
const NAMESPACE = "example";

// This logs what the builder is currently doing.
// If compiling is taking a while, disabling this will improve compilation time.
const debugMode = false;

// If you want the font JSON files to be formatted, make this boolean true.
const prettyPrintFontFiles = false;

// If you want to see the ffmpeg logs, make this boolean true.
// If compiling is taking a while, disabling this will improve compilation time.
const showFFMPEGLogs = false;
// -----------------------------------


// Thanks for using my library!! - @trplnr

const fileToBuild = Deno.args[0]

// DO NOT TOUCH! ⚠
const PATHS = {
    screen_effects: "./",
    font_files: `../assets/${NAMESPACE}/font/scrfx`,
    textures: `../assets/${NAMESPACE}/textures/font/scrfx`,
};

ensureDir(PATHS.font_files)
ensureDir(PATHS.textures)

function writeFontAndImageFiles(frameCount, width, imagePath, fileName) {
    const baseName = fileName.replace(".png","")
    const baseOutputImagePath = `${PATHS.textures}/${baseName}`
    const baseOutputFontFilePath = `${PATHS.font_files}/${baseName}`
    const baseImageResourcePath = `${NAMESPACE}:font/scrfx/${baseName}`
    for (let i = 0; i < frameCount; i++) {
        if (debugMode) console.log(`----> 🟡 Writing frame '${baseName}${i}'`)
        const outputImagePath = `${baseOutputImagePath}${i}.png`
        const outputFontFilePath = `${baseOutputFontFilePath}${i}.json`
        // writing font file json
        if (debugMode) console.log(`------> 🟡 Writing font file '${outputFontFilePath}'`)
        const imageResourcePath = `${baseImageResourcePath}${i}.png`
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
        if (debugMode) console.log(`------> ✅ Successfully wrote font file '${outputFontFilePath}'`)
        
        // ffmpeg to split the image into individual frames
        if (debugMode) console.log(`------> 🟡 Writing image '${imagePath}'`)
        const cropCommand = new Deno.Command("ffmpeg", {
            args: [
                `-y`,
                `-i`, imagePath,
                `-vf`, `crop=w=${width}:h=${width}:x=0:y=${width * i}`,
                `-frames:v`, `1`,
                `-update`, `true`,
                outputImagePath
            ],
            stdout: showFFMPEGLogs ? "inherit" : "null",
            stderr: showFFMPEGLogs ? "inherit" : "null",
        })
        cropCommand.output()
        if (debugMode) console.log(`------> ✅ Successfully wrote image '${outputImagePath}'`)
        
        if (debugMode) console.log(`----> ✅ Successfully wrote frame '${baseName}${i}'`)
    }
}

async function buildScreenEffect(file) {
    if (!file.endsWith(".png")) throw new TypeError("Screen effect spritesheet must be a .png!")

    const imagePath = `${PATHS.screen_effects}${file}`
    const image = await Deno.readFile(imagePath)
    const dataView = new DataView(image.buffer)

    const width = dataView.getUint32(16)
    const height = dataView.getUint32(20)

    const frameCount = height / width;

    writeFontAndImageFiles(frameCount, width, imagePath, file)

    if (debugMode) console.log(`--> ✅ Successfully built ${imagePath}`)
}

async function compileAllScreenEffects() {
    for await (const file of Deno.readDir(PATHS.screen_effects)) {
        if (!file.isFile) continue
        if (!file.name.endsWith(".png")) continue

        const imagePath = `${PATHS.screen_effects}${file.name}`
        const image = await Deno.readFile(imagePath)
        const dataView = new DataView(image.buffer)

        const width = dataView.getUint32(16)
        const height = dataView.getUint32(20)

        const frameCount = height / width;

        writeFontAndImageFiles(frameCount, width, imagePath, file.name)

        if (debugMode) console.log(`--> ✅ Successfully built ${imagePath}`)
    }
}

console.log(`🟡 Compiling screen effects.`)
const startTime = performance.now();
if (!fileToBuild) {
    await compileAllScreenEffects();
} else {
    await buildScreenEffect(fileToBuild)
}
const endTime = performance.now() - startTime;
console.log(`✅ Successfully compiled all screen effects! Took ${endTime / 1000} seconds.`)
