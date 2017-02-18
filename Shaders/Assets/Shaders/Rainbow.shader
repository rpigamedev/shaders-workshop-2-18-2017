Shader "Unlit/Rainbow"
{
	Properties
	{
		_Scale("Scale", float) = 1.0
		_Speed("Speed", float) = 1.0
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "HSV_RGB.cginc"

			float _Scale;
			float _Speed;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			float4 frag (v2f i) : SV_Target
			{
				float2 coord = i.uv - float2(0.5, 0.5);
				float4 col = float4(HSVtoRGB(_Time.x * _Speed + length(coord) * sqrt(2.0) * _Scale, 1.0, 1.0), 1.0);
				return col;
			}
			ENDCG
		}
	}
}
