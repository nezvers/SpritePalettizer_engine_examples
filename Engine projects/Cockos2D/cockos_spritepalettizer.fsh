//Fragment shader
#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
uniform sampler2D u_texture;                //I'm assuming this is objects original texture

uniform sampler2D palette;                  //Use palletes in collum with colors in rows
uniform float palette_count = 1.0;          //Tells the shader how many palettes you have
uniform float palette_index = 0.0;          //Telss the shader which palette to choose

void main()
{
    float increment = 1.0/palette_count;                    //Value for getting palette index
    float y = increment * palette_index + increment * 0.5;  // + safety measure for floating point imprecision
    vec4 color = texture2D(u_texture, v_texCoord.xy);       //Original graysscale color used as collumn index
    vec4 new_collor = texture(palette, vec2(color.r, y));   //get color from palette texture
    float a = step(0.00392, color.a);                       //check if transparent color is less than 1/255 for backgrounds
    new_color.a *= a;                                       //if BG is transparent, then alpha is multiplied by 0
   
    gl_FragColor = new_color;                               //set new color from palette
}
