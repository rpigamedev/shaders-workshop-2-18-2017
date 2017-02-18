float4 PremultiplyAlpha(float4 col)
{
	col.rgb *= col.a;
	col.a = 1.0;
	return col;
}
float4 BlendNormal(float4 src, float4 dst)
{
	float4 res;
	res.a = src.a + dst.a * (1.0 - src.a);
	res.rgb = (src.rgb * src.a + dst.rgb * dst.a * (1.0 - src.a)) / res.a;
	if (255.0 * res.a < 1.0)
	{
		res.a = 0;
		res.rgb = float3(0, 0, 0);
	}
	return res;
}
float4 BlendMultiply(float4 src, float4 dst)
{
	src = PremultiplyAlpha(src);
	dst = PremultiplyAlpha(dst);

	return src * dst;
}
float4 BlendScreen(float4 src, float4 dst)
{
	src = PremultiplyAlpha(src);
	dst = PremultiplyAlpha(dst);

	return 1.0 - (1.0 - src) * (1.0 - dst);
}
float BlendOverlayComponent(float a, float b)
{
	if (a < 0.5)
	{
		return 2.0 * a * b;
	}
	else
	{
		return 1.0 - 2.0 * (1.0 - a) * (1.0 - b);
	}
}
float4 BlendOverlay(float4 src, float4 dst)
{
	src = PremultiplyAlpha(src);
	dst = PremultiplyAlpha(dst);

	float4 res;
	res.r = BlendOverlayComponent(src.r, dst.r);
	res.g = BlendOverlayComponent(src.g, dst.g);
	res.b = BlendOverlayComponent(src.b, dst.b);
	res.a = 1.0;

	return res;
}
float4 BlendHardLight(float4 src, float4 dst)
{
	return BlendOverlay(dst, src);
}
float4 BlendDivide(float4 src, float4 dst)
{
	src = PremultiplyAlpha(src);
	dst = PremultiplyAlpha(dst);

	return src / dst;
}
float4 BlendAddition(float4 src, float4 dst)
{
	src = PremultiplyAlpha(src);
	dst = PremultiplyAlpha(dst);

	return min(src + dst, float4(1.0, 1.0, 1.0, 1.0));
}
float4 BlendSubtract(float4 src, float4 dst)
{
	src = PremultiplyAlpha(src);
	dst = PremultiplyAlpha(dst);

	return max(src - dst, float4(0.0, 0.0, 0.0, 1.0));
}
float4 BlendDifference(float4 src, float4 dst)
{
	src = PremultiplyAlpha(src);
	dst = PremultiplyAlpha(dst);

	return max(src - dst, dst - src);
}
float4 BlendDarken(float4 src, float4 dst)
{
	src = PremultiplyAlpha(src);
	dst = PremultiplyAlpha(dst);

	return min(src, dst);
}
float4 BlendLighten(float4 src, float4 dst)
{
	src = PremultiplyAlpha(src);
	dst = PremultiplyAlpha(dst);

	return max(src, dst);
}