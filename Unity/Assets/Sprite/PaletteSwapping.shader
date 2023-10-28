Shader "Retro/PaletteSwapping"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _PaletteTex ("Palette Texture", 2D) = "white" {}
        _PaletteIndex ("Palette Index", Integer) = 0
        _Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags {"Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
        LOD 100

        Lighting Off

        Pass {
            CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #pragma target 2.0
                #pragma multi_compile_fog

                #include "UnityCG.cginc"

                struct appdata_t {
                    float4 vertex : POSITION;
                    float2 texcoord : TEXCOORD0;
                    UNITY_VERTEX_INPUT_INSTANCE_ID
                };

                struct v2f {
                    float4 vertex : SV_POSITION;
                    float2 texcoord : TEXCOORD0;
                    UNITY_FOG_COORDS(1)
                    UNITY_VERTEX_OUTPUT_STEREO
                };

                sampler2D _MainTex;
                sampler2D _PaletteTex;
                float4 _MainTex_ST;
                fixed _Cutoff;
                float4 _PaletteTex_TexelSize;
                int _PaletteIndex;

                v2f vert (appdata_t v)
                {
                    v2f o;
                    UNITY_SETUP_INSTANCE_ID(v);
                    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
                    o.vertex = UnityObjectToClipPos(v.vertex);
                    o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                    UNITY_TRANSFER_FOG(o,o.vertex);
                    return o;
                }

                fixed4 frag (v2f i) : SV_Target
                {

                    fixed4 grey = tex2D(_MainTex, i.texcoord);
                    clip(grey.a - _Cutoff);

                    float width = _PaletteTex_TexelSize.z;
                    float height = _PaletteTex_TexelSize.w;
                    float index = float( abs(_PaletteIndex) % int(height) );
                    float x = grey.b + (0.5 / width);
                    float y = 1.0 - ((index + 0.5) / height); // start indexing from top
                    //float y = (index / height); // start indexing from bottom
                    fixed4 color = tex2D(_PaletteTex, float2( x, y ) );
                    grey.rgb = color.rgb;

                    //UNITY_APPLY_FOG(i.fogCoord, grey);
                    return grey;
                }
            ENDCG
        }
    }
}
