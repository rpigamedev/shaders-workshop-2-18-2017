// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Unlit/Bunny"
{
	Properties
	{
		_Scale ("Scale", Float) = 1.0
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "HSV_RGB.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float4 uv : TEXCOORD0;
				float4 worldpos : TEXCOORD1;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = ComputeScreenPos(o.pos);
				o.worldpos = mul(unity_ObjectToWorld, v.vertex);
				return o;
			}

			float _Scale;

			float4 frag (v2f i) : SV_Target
			{
				float3 worldPos = i.worldpos + float3(_Time.x, 0, 0);
				float3 intCoords = floor(worldPos * _Scale);
				float3 pos = worldPos * _Scale - intCoords;

				float radius = length(pos - float3(0.5, 0.5, 0.5));
				if (radius > 0.5)
					return float4(0, 0, 0, 1);

				return float4(HSVtoRGB((intCoords.x + intCoords.y + intCoords.z) / 18.0, 1, 1), 1.0);
			}
			ENDCG
		}
	}
}
