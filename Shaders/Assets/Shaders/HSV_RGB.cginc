// 0 <= h, s, v, <= 1
float3 HSVtoRGB(float h, float s, float v)
{
	float c = v * s;
	float hp = (h % 1.0 + 1.0) % 1.0 * 6.0;
	float x = c * (1.0 - abs(hp % 2.0 - 1));
	float m = v - c;

	float3 rgb;
	if (hp < 1.0)
		rgb = float3(c, x, 0.0);
	else if (hp < 2.0)
		rgb = float3(x, c, 0.0);
	else if (hp < 3.0)
		rgb = float3(0.0, c, x);
	else if (hp < 4.0)
		rgb = float3(0.0, x, c);
	else if (hp < 5.0)
		rgb = float3(x, 0.0, c);
	else
		rgb = float3(c, 0.0, x);

	return float3(rgb.r + m, rgb.g + m, rgb.b + m);
}