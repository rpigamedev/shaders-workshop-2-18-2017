Shader "Unlit/ImageComposite"
{
	Properties
	{
		_BlendMode ("Blend Mode", Int) = 0
		_Source ("Source", 2D) = "white" {}
		_Destination ("Destination", 2D) = "white" {}
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

			int _BlendMode;
			sampler2D _Source;
			sampler2D _Destination;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				float4 src = tex2D(_Source, i.uv);
				float4 dst = tex2D(_Destination, i.uv);

				float4 col;
				switch (_BlendMode)
				{
				case 1:
					col = BlendMultiply(src, dst);
					break;
				case 2:
					col = BlendScreen(src, dst);
					break;
				case 3:
					col = BlendOverlay(src, dst);
					break;
				case 4:
					col = BlendHardLight(src, dst);
					break;
				case 5:
					col = BlendDivide(src, dst);
					break;
				case 6:
					col = BlendAddition(src, dst);
					break;
				case 7:
					col = BlendSubtract(src, dst);
					break;
				case 8:
					col = BlendDifference(src, dst);
					break;
				case 9:
					col = BlendDarken(src, dst);
					break;
				case 10:
					col = BlendLighten(src, dst);
					break;
				default:
					col = BlendNormal(src, dst);
					break;
				}

				return col;
			}
			ENDCG
		}
	}
}
