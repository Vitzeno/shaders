Shader "Custom/Edge Glow"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Saturation("Saturation", Range(0,1)) = 1.0
        _GlowIntensity ("Glow Intensity", Range(0, 1)) = 0.5

        _XWarp("X Warp", Range(0,1)) = 0.0
        _YWarp("Y Warp", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        sampler2D _MainTex;
        fixed4 _Color;
        half _Glossiness;
        half _Metallic;
        half _Saturation;
        half _GlowIntensity;
        half _XWarp, _YWarp;
        

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            //UV coords for texture mapping
            float2 uv = IN.uv_MainTex;

            //Messing with uv coords before texture application
            uv.y += sin(uv.x * 6.2831 + _Time.y) * _YWarp;
            uv.x += sin(uv.y * 6.2831 + _Time.y) * _XWarp;

            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, uv) *  _Color;
            
            // linear interp between of avg colour between default c and _Saturation value
            o.Albedo = lerp((c.r + c.g + c.b) / 3.0, c, _Saturation);
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
