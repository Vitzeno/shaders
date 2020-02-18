Shader "Custom/Edge Detection"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Threshold ("Threshold", Range(0, 0.5)) = 0.1
        _Offset ("Offset", Range(0.001, 0.5)) = 0.001
        _Thickness ("Thickness", Range(1, 2)) = 1
        _Colour ("Outline Colour", Color) = (1,1,1,1)
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            uniform float _Offset;
            uniform float _Threshold;
            uniform float _Thickness;
            uniform float4 _Colour;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                // Offset texture, the offset is essentially the outline thickness
                fixed4 offsetCol = tex2D (_MainTex, i.uv - _Offset * _Thickness);
                // Calc dist between original and offset, set to 0 if over threshold
                if(length(col - offsetCol) > _Threshold)
                    col = col * _Colour;
                
                return col;
            }
            ENDCG
        }
    }
}
