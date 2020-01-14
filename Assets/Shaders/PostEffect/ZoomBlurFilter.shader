Shader "MyShader/ZoomBlurFilter"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_SampleCount("Sample Count", Range(4,16)) = 8
		_Strength("Strength", Range(0.0,1.0)) = 0.5
	}
	SubShader
	{
		Cull Off
		ZWrite Off
		ZTest Always

		Tags { "RenderType"="Opaque" }
		LOD 100

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

			sampler2D _MainTex;
			float4 _MainTex_ST;
			half _SampleCount;
			half _Strength;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 color = fixed4(0,0,0,1);
				//UVを-0.5～0.5に変換
				half2 symmetryUV = i.uv - 0.5;

				half distance = length(symmetryUV);

				for(int j = 0; j < _SampleCount; j++){
					float uvOffset = 1.0 - _Strength * j / _SampleCount * distance;
					color += tex2D(_MainTex, symmetryUV * uvOffset + 0.5);
				}

				color /= _SampleCount;

				return color;
			}
			ENDCG
		}
	}
}
