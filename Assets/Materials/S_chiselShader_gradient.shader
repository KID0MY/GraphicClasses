Shader "Custom Shaders/S_gradientShader"
{
    Properties
    {
        _mycolor1("Sample Color", Color) = (1,1,1,1)
        _mycolor2("Sample Color", Color) = (0,0,0,1)
    }
    SubShader
    {
        Tags {"RenderType"="Opaque" "RenderPipeline"="UniversalPipeline"}
        LOD 100

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0; // UV coordinates for interpolation
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            fixed4 _mycolor1;
            fixed4 _mycolor2;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv; // Pass UV coordinates to fragment shader
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // Linearly interpolate between TopColor and BottomColor based on the V (vertical) component of UV
                // i.uv.y ranges from 0 (bottom) to 1 (top) for a standard quad
                fixed4 col = lerp(_mycolor2, _mycolor1, i.uv.y);
                return col;
            }
            ENDHLSL
        }
    }
}
