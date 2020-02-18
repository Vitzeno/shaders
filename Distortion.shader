Shader "Custom/Distortion"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0

        _DistortaionIntensity ("Distortion Intensity", Range(0,50)) = 0.5
        _DistortionSize ("Distortion Size", Range(0, 1)) = 0
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
        half _DistortaionIntensity, _DistortionSize;
        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Move to center
            float2 uv = IN.uv_MainTex - .5;
            // Move in circle over time
            float a = _Time.y;
            float2 pos = float2(sin(a), cos(a)) * .5;
            // Calc dist from center
            float2 distort = uv - pos;
            float dist = length(distort);

            //Create mask for distortion effect
            float mask = smoothstep(_DistortionSize, 0.0, dist);
            distort = distort * _DistortaionIntensity * mask;

            // Due to mask uv is only offest when distort is more than 0, this is only, in areas close to pos

            // Albedo comes from a texture tinted by color, also add the distortion value
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex + distort) * _Color;
            
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
