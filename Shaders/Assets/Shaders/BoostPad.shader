Shader "Unlit/BoostPad"
{
	Properties
	{
		_BoostPadTexture ("Boost Pad Texture", 2D) = "white" {}
		_DetailTexture ("Detail Texture", 2D) = "White" {}

		_RainbowScrollSpeed("Rainbow Scroll Speed", Float) = 1.0
		_BoostPadScrollSpeed ("Boost Pad Scroll Speed", Float) = 1.0
		_DetailScrollSpeed ("Detail Scroll Speed", Float) = 1.0
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
			#include "BlendModes.cginc"

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

			sampler2D _BoostPadTexture;
			sampler2D _DetailTexture;
			float _RainbowScrollSpeed;
			float _BoostPadScrollSpeed;
			float _DetailScrollSpeed;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			float Scroll(float input, float speed)
			{
				return (input - _Time.x * speed);
			}
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				float4 rainbowColor = float4(HSVtoRGB(Scroll(i.uv.y, _RainbowScrollSpeed), 1.0, 1.0), 1.0);
				float4 boostPadColor = tex2D(_BoostPadTexture, float2(i.uv.x, Scroll(i.uv.y, _BoostPadScrollSpeed)));
				float4 detailColor = tex2D(_DetailTexture, float2(i.uv.x, Scroll(i.uv.y, _DetailScrollSpeed)));

				return BlendAddition(BlendAddition(boostPadColor, detailColor), rainbowColor);
			}
			ENDCG
		}
	}
}
