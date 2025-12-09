Shader "Custom/S_PacMan"
{
    Properties
    {
        [MainColor] _BaseColor("Base Color", Color) = (1, 1, 0, 1)
        _ShadowTint ("Shadow Tint Color", Color) = (0, 0, 0, 1) // Tint color for shadows
    }

    SubShader
    {
        Tags
        {
            "RenderType" = "AlphaTest" "RenderPipeline" = "UniversalPipeline"
        }

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN

            // Include URP core, lighting, and shadow libraries
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
            
            half4 _BaseColor;
            half4 _ShadowTint;

            struct appdata
            {
                float4 vertex : POSITION; // Object space vertex position
                float3 normal : NORMAL; // Object space normal
                float2 uv : TEXCOORD0; // UV coordinates for texture sampling
            };

            struct v2f
            {
                float4 pos : SV_POSITION; // Clip space position
                float2 uv : TEXCOORD0; // UV coordinates passed to fragment shader
                half3 worldNormal : TEXCOORD1; // World space normal for lighting
                float3 worldPos : TEXCOORD2; // World space position for shadow sampling
                float4 shadowCoord : TEXCOORD3; // Shadow coordinates
            };

            // Vertex Shader
            v2f vert(appdata v)
            {
                v2f o;
                // Transform vertex to clip space
                o.pos = TransformObjectToHClip(v.vertex.xyz);

                // Pass UV coordinates to fragment shader
                o.uv = v.uv;

                // Transform object space normal to world space
                o.worldNormal = normalize(TransformObjectToWorldNormal(v.normal));

                // Store the world position (before the transformation to clip space)
                float3 worldPos = TransformObjectToWorld(v.vertex.xyz);
                o.worldPos = worldPos;

                // Compute shadow coordinates using world position (no truncation warning)
                o.shadowCoord = TransformWorldToShadowCoord(worldPos);

                return o;
            }

            // Fragment Shader
            half4 frag(v2f i) : SV_Target
            {
                // Calculate shadow amount from shadow map
                half shadowAmount = MainLightRealtimeShadow(i.shadowCoord);

                // Tint only the shadow
                half4 tintedShadow = lerp(float4(1, 1, 1, 1), _ShadowTint, -shadowAmount);

                // Combine the texture color with tinted shadow
                return _BaseColor * tintedShadow;

            }
            ENDHLSL
        }
         // Shadow caster pass
        Pass
        {
            Name "ShadowCaster"
            Tags { "LightMode" = "ShadowCaster" }

            HLSLPROGRAM

            #pragma vertex vertShadowCaster
            #pragma fragment fragShadowCaster
            #pragma multi_compile_shadowcaster

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 vertex : POSITION;
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
            };

            // Vertex shader for shadow caster pass
            Varyings vertShadowCaster(Attributes IN)
            {
                Varyings OUT;
                OUT.positionCS = TransformObjectToHClip(IN.vertex.xyz); // Transform to clip space
                return OUT;
            }

            // Fragment shader for shadow caster pass
            float4 fragShadowCaster(Varyings i) : SV_Target
            {
                return float4(0, 0, 0, 1);  // Standard output for shadow casting
            }

            ENDHLSL
        }
    }
}