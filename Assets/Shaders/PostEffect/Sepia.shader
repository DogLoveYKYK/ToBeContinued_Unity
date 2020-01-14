Shader "PostEffect/Sepia"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Darkness("Darkness",Range(0,0.1)) = 0.04
		_Strength("Strength", Range(0.05, 0.15)) = 0.05
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

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

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			half _Darkness;
			half _Strength;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);

				half gray = col.r * 0.3 + col.g * 0.6 + col.b * 0.1 - _Darkness;
				gray = max(0, gray);

				half R = gray + _Strength;
				half B = gray - _Strength;

				R = min(1.0, R);
				B = max(0, B);


				// just invert the colors
				col.rgb = fixed3(R,gray,B);
				return col;
			}
			ENDCG
		}
	}
}
