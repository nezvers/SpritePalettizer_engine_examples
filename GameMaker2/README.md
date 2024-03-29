# GameMaker example

```C

/*
	Shader port by @XorDev.
	
	This is a simple palette swap shader.
	Each pixel is mapped to the palette based off it's red channel (or gray) value.
	The palette textures are organized so that you can have up to 255 colors per palette.
	Each row represents one palette and there are no implicit limits to the number of palettes.
	
	Quick overview of the uniforms:
	"palette" is the palette texture that colors get swapped to.
	"palette_uvs" should be set to the top-left coordinates of the palette texture (on a texture page)
	and the difference to the bottom-right corner (width and height).
	"palette_count" is the number of palettes you have on the palette texture (number of rows).
	"palette_index" is the current palette to use (ranging from 0 to the palette_count - 1).
*/

varying vec4 v_vColour;
varying vec2 v_vTexcoord;

uniform sampler2D palette;		//Use palettes in column with colors in rows
uniform vec4 palette_uvs;		//Palette texture coordinate offset and scale
uniform float palette_count;	//Tells the shader how many palettes you have
uniform float palette_index;	//Tells the shader which palette to choose

void main()
{
    float increment = 1.0/palette_count;    						//Value for getting palette index
    float y = increment * palette_index + increment * 0.5;			// + safety measure for floating point imprecision
    vec4 color = texture2D(gm_BaseTexture, v_vTexcoord);			//Original grayscale color used as column index
	vec2 coord = vec2(color.r, y) * palette_uvs.zw + palette_uvs.xy;//Get the palette texture coordinates
    vec4 new_color = texture2D(palette, coord);						//Get color from palette texture
    
    gl_FragColor = new_color*color.a;                      			//Set new color from palette with original alpha
}
```
