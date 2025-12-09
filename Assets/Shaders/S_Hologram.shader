Shader "LucasShaders/S_Hologram"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}
        _MainColor("Main Color", Color) = (1,1,1,1)
        _LineColor ("Line Color", Color) = (0, 1, 1, 1)
        _LineSpeed ("Line Speed", Float) = 1.0
        _LineFrequency ("Line Frequency", Float) = 10.0 
        _Transparency ("Transparency", Range(0, 1)) = 0.5
        }

    SubShader
    {
        Tags { "RenderType" = "Transparent" "Queue"="Transparent" "RenderPipeline" = "UniversalPipeline" }
        
        Blend SrcAlpha OneMinusSrcAlpha
        
        Pass
        {
            HLSLPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 positionOS   : POSITION;
                float3 NormalOS     : NORMAL;
                float2 uv           : TEXCOORD0;
            };

            struct Varyings
            {
                float4 positionHCS  : SV_POSITION;  // Clip-space position
                float2 uv           : TEXCOORD0;
                float3 normalWS     : TEXCOORD1;    // World space normal
                float3 viewDirWS    : TEXCOORD2;    // World space view direction
                float2 positionOS   : TEXCOORD3;    // Texture coordinates
            };

            // Material properties
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            float4 _MainTex_ST; 
            float4 _MainColor;
            
            //Lines
            float4 _LineColor;
            float _LineSpeed;
            float _LineFrequency;
            float _Transparency;

            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                // Transform object space position to clip space
                OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
                OUT.positionOS = IN.positionOS.xyz;
                // Transform normal to world space
                OUT.normalWS = normalize(TransformObjectToWorldNormal(IN.NormalOS));

                // Calculate view direction in world space
                OUT.viewDirWS = normalize(GetWorldSpaceViewDir(IN.positionOS.xyz));

                //Correcting the Scale of Textures
                OUT.uv = TRANSFORM_TEX(IN.uv,_MainTex);

                return OUT;
            }

            half4 frag(Varyings IN) : SV_Target
            {
                // Scrolling lines effect
                float lineValue = sin(IN.positionOS.x * _LineFrequency + _Time.y * _LineSpeed);
                half3 lineColor = _LineColor.rgb * step(0.5, lineValue);  // Creates sharp scan lines

                // Combine the texture color, fresnel rim, and scan lines
                half3 finalColor = _MainColor + lineColor;

                // Apply transparency
                return half4(finalColor, _Transparency);
            }
            ENDHLSL
        }
    }
}
