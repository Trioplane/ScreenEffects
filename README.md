<img align="center" src="./repository/images/screen-effects-banner.png">

# ScreenEffects by Trplnr
A small flexible library for showing animated screen overlays to the user.

### Download the datapack and resource pack!
<a href="https://modrinth.com/datapack/screeneffects">
    <img width="300" src="./repository/images/download-on-modrinth.png">
</a>
<a href="https://smithed.net/packs/screen-effects">
    <img width="300" src="./repository/images/download-on-smithed.png">
</a>

## Examples:
- This is a YouTube video, click to play.
[![Watch the video](https://img.youtube.com/vi/J5cWNG-nL1w/maxresdefault.jpg)](https://youtu.be/J5cWNG-nL1w)

## How to use:
### Making Screen Effects using the builder Deno file:

> [!NOTE]
> Using this method requires the following to be installed in your system: [Deno](https://deno.land/), [ffmpeg](https://ffmpeg.org/). After getting those, restart your computer.

- A screen effect is composed of multiple font frames that the datapack uses to show the animation.
- A **utility Deno JS file is provided** with the resource pack inside the `screen_effects` folder to make this process easier.
#### 1. Making the animation
> [!NOTE]
> - You can use any image editing software you like as long as it can **export your animation into a spritesheet**. [Aseprite](https://www.aseprite.org/) has this functionality.
> - It is recommended to make a **256x256 .png file** for the best results.
- Start by creating an animation.

<img align="center" src="./repository/images/making-screen-effects-step1-img1.png">

- Export your animation into a **vertical** spritesheet inside the `screen_effects` folder.

<img align="center" src="./repository/images/making-screen-effects-step1-img2.png">

- You can add more spritesheets inside the `screen_effects` folder if you want more screen effects.

#### 2. Building the animations
- To prepare for building the animations, go inside the `buildScreenEffects.js` folder and adjust these configs.
```js
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
```
- To make your amazing animations usable by the datapack, You can run a command in your terminal to convert your spritesheets into frames!
- Open your preferred terminal and **make sure you are inside the `screen_effects` folder**.
- After that, run this command `deno run --allow-all .\buildScreenEffects.js`

<img align="center" src="./repository/images/making-screen-effects-step1-img3.png">

- After running that, if everything is successful, it should look like this:

<img align="center" src="./repository/images/making-screen-effects-step1-img4.png">

- Congrats! You've successfully turned your wonderful animations into frames! :tada:

- If you only want to to compile 1 spritesheet, simply run `deno run --allow-all .\buildScreenEffects.js <REPLACE WITH FILENAME including .png>`

### Registering the Screen Effects
- The screen effect registry is inside the `scrfx:registry` .mcfunction file.
- It declares what screen effects are available and what their properties are.
- A screen effect inside the registry looks like this:
```js
"ns:identifier": {
    tps: positive integer,
    frame_count: positive integer,
    middle: {
        frame: positive_integer below or equal to frame_count,
        callback: command
    },
    end: { callback: command },
    path: resource path.
}
```
- Properties:
  * `"ns:identifier"` - The identifier of the screen effect, the namespace is optional but recommended to be compatible with other packs.
  * `tps` - The frametime / fps of the screen effect, but in ticks. (1 second = 20 ticks)
  * `frame_count` - How much frames the screen effect has.
  * `middle.frame (optional)` - Points to what frame the declared 'middle' is. This is useful for transition animations like tping the player when the screen is fully covered.
  * `middle.callback (optional)` - The command to run when the 'middle' frame is ran.
  * `end.callback (optional)` - The command to run when the 'end' frame is ran. This does not have a 'frame' property, this already runs once the animation ends.
  * `path` - The resource path of the font file with the number at the end omitted.

> [!TIP]
> When in development, you can turn on development mode using a scoreboard value so the registry always gets reloaded when doing `/reload`.
> Simply run `scoreboard players set .dev_mode scrfx.zinternals.globals 1` to turn this on.

### Running the Screen Effects
- Declare the animation to be played inside the `scrfx:in id` storage.
- Then execute as a player and run `scrfx:play`!
- Example:
```mcfunction
data modify storage scrfx:in id set value "ns:identifier"
execute as Trplnr run function scrfx:play
```
- You have successfully played a screen effect! :tada: