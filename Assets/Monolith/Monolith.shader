// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Xaver/Monolith1"
{
	Properties
	{
		_FlowMap("FlowMap", 2D) = "white" {}
		_Speed("Speed", Float) = 1
		_Diffuse("Diffuse", 2D) = "white" {}
		_Emissive("Emissive", 2D) = "white" {}
		_Normals("Normals", 2D) = "white" {}
		_FlowMapTiling("FlowMap Tiling", Float) = 1
		_Metalic("Metalic", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.5
		_Strength("Strength", Float) = 1
		[HDR]_EmissiveColor("Emissive Color", Color) = (0,0,0,0)
		_Color0("Color 0", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Normals;
		uniform sampler2D _FlowMap;
		uniform float4 _FlowMap_ST;
		uniform float _Speed;
		uniform float _Strength;
		uniform float _FlowMapTiling;
		uniform sampler2D _Diffuse;
		uniform float4 _Color0;
		uniform sampler2D _Emissive;
		uniform float4 _EmissiveColor;
		uniform float _Metalic;
		uniform float _Smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_FlowMap = i.uv_texcoord * _FlowMap_ST.xy + _FlowMap_ST.zw;
			float2 blendOpSrc30 = i.uv_texcoord;
			float2 blendOpDest30 = (tex2D( _FlowMap, uv_FlowMap )).rg;
			float2 temp_output_30_0 = ( saturate( (( blendOpDest30 > 0.5 ) ? ( 1.0 - 2.0 * ( 1.0 - blendOpDest30 ) * ( 1.0 - blendOpSrc30 ) ) : ( 2.0 * blendOpDest30 * blendOpSrc30 ) ) ));
			float temp_output_1_0_g3 = ( _Time.y * _Speed );
			float temp_output_28_0 = (0.0 + (( ( temp_output_1_0_g3 - floor( ( temp_output_1_0_g3 + 0.5 ) ) ) * 2 ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0));
			float TimeA32 = ( -temp_output_28_0 * _Strength );
			float2 lerpResult31 = lerp( i.uv_texcoord , temp_output_30_0 , TimeA32);
			float2 temp_cast_0 = (_FlowMapTiling).xx;
			float2 uv_TexCoord39 = i.uv_texcoord * temp_cast_0;
			float2 FlowA34 = ( lerpResult31 + uv_TexCoord39 );
			float temp_output_1_0_g4 = (( _Speed * _Time.y )*1.0 + 0.5);
			float TimeB46 = ( -(0.0 + (( ( temp_output_1_0_g4 - floor( ( temp_output_1_0_g4 + 0.5 ) ) ) * 2 ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) * _Strength );
			float2 lerpResult47 = lerp( i.uv_texcoord , temp_output_30_0 , TimeB46);
			float2 FlowB50 = ( uv_TexCoord39 + lerpResult47 );
			float BlendTime62 = saturate( abs( ( 1.0 - ( temp_output_28_0 / 0.5 ) ) ) );
			float3 lerpResult74 = lerp( UnpackNormal( tex2D( _Normals, FlowA34 ) ) , UnpackNormal( tex2D( _Normals, FlowB50 ) ) , BlendTime62);
			float3 Normal75 = lerpResult74;
			o.Normal = Normal75;
			float4 lerpResult53 = lerp( ( tex2D( _Diffuse, FlowA34 ) * _Color0 ) , ( _Color0 * tex2D( _Diffuse, FlowB50 ) ) , BlendTime62);
			float4 Diffuse36 = lerpResult53;
			o.Albedo = Diffuse36.rgb;
			float4 lerpResult102 = lerp( ( tex2D( _Emissive, FlowA34 ) * _EmissiveColor ) , ( tex2D( _Emissive, FlowB50 ) * _EmissiveColor ) , BlendTime62);
			float4 Emissive103 = lerpResult102;
			o.Emission = Emissive103.rgb;
			o.Metallic = _Metalic;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18800
0;0;1536;812.6;1450.651;841.4419;1.816576;True;True
Node;AmplifyShaderEditor.CommentaryNode;64;-5101.912,214.162;Inherit;False;2289.829;950.0336;Comment;22;26;55;24;56;42;25;43;27;28;44;29;45;32;46;57;59;60;61;62;80;81;82;TIME;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-5051.912,489.0665;Inherit;False;Property;_Speed;Speed;1;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;55;-5035.036,812.2092;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;24;-5048.522,264.162;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-4793.95,791.5441;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-4815.38,375.9646;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;42;-4518.653,779.6701;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;27;-4236.053,379.4956;Inherit;False;Sawtooth Wave;-1;;3;289adb816c3ac6d489f255fc3caf5016;0;1;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;43;-4233.618,786.1811;Inherit;False;Sawtooth Wave;-1;;4;289adb816c3ac6d489f255fc3caf5016;0;1;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;28;-3989.66,377.8062;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;44;-3990.165,786.3831;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;29;-3711.922,377.9132;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-3599.727,593.3578;Inherit;False;Property;_Strength;Strength;8;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;45;-3715.701,790.3321;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;65;-5108.159,-983.9498;Inherit;False;2510.26;884.9705;Comment;14;15;19;16;33;48;40;30;39;47;31;41;49;34;50;FlowMap;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;-3391.41,375.6262;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;-3378.463,795.7896;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;15;-5058.159,-532.0255;Inherit;True;Property;_FlowMap;FlowMap;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;32;-3233.927,374.9615;Inherit;False;TimeA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-4733.801,-933.4595;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;16;-4743.198,-527.2702;Inherit;False;True;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;46;-3228.002,795.7637;Inherit;False;TimeB;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;30;-4400.972,-603.6506;Inherit;False;Overlay;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-3630.788,-639.1791;Inherit;False;Property;_FlowMapTiling;FlowMap Tiling;5;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;33;-3920.53,-607.0653;Inherit;False;32;TimeA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;48;-3934.89,-214.9794;Inherit;False;46;TimeB;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;39;-3416.307,-656.9816;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;31;-3644.944,-933.9498;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;57;-3687.083,1029.195;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;47;-3609.502,-258.5378;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;49;-3112.68,-275.1417;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;59;-3538.083,1029.195;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-3120.915,-927.8106;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;50;-2821.899,-285.1687;Inherit;False;FlowB;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;66;-2210.854,-956.8884;Inherit;False;1565.66;694.5486;Comment;11;36;53;23;63;51;37;35;52;123;124;125;Diffuse;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;34;-2840.181,-924.737;Inherit;False;FlowA;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;95;-2226.154,1028.298;Inherit;False;1584.328;667.4401;Comment;11;103;98;97;102;101;100;99;96;105;104;106;Emissive;1,1,1,1;0;0
Node;AmplifyShaderEditor.AbsOpNode;60;-3349.083,1030.195;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;-2161.927,1491.542;Inherit;False;50;FlowB;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;-2174.906,1301.985;Inherit;False;34;FlowA;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;61;-3208.083,1032.195;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;37;-2144.118,-689.5075;Inherit;False;34;FlowA;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;98;-2176.154,1079.351;Inherit;True;Property;_Emissive;Emissive;3;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.CommentaryNode;67;-2236.881,194.6279;Inherit;False;1246.328;675.2402;Comment;9;75;74;73;72;71;70;69;68;122;Normals;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;35;-2160.854,-905.8353;Inherit;True;Property;_Diffuse;Diffuse;2;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;52;-2146.627,-493.6447;Inherit;False;50;FlowB;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;123;-1822.546,-695.8253;Inherit;False;Property;_Color0;Color 0;12;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;69;-2170.144,462.0083;Inherit;False;34;FlowA;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;106;-1816.249,1278.171;Inherit;False;Property;_EmissiveColor;Emissive Color;9;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;101;-1915.826,1078.298;Inherit;True;Property;_TextureSample3;Texture Sample 3;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;99;-1913.311,1463.091;Inherit;True;Property;_TextureSample2;Texture Sample 2;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;62;-3036.083,1032.195;Inherit;False;BlendTime;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;68;-2172.653,657.8713;Inherit;False;50;FlowB;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;23;-1900.527,-906.8884;Inherit;True;Property;_DiffuseTexture;DiffuseTexture;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;51;-1892.253,-500.5852;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;70;-2186.881,245.681;Inherit;True;Property;_Normals;Normals;4;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;-1496.28,-748.3463;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;73;-1912.339,541.021;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;100;-1228.383,1477.037;Inherit;False;62;BlendTime;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;72;-1926.554,244.6279;Inherit;True;Property;_TextureSample4;Texture Sample 4;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;71;-1795.511,753.8676;Inherit;False;62;BlendTime;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;63;-1242.643,-540.8613;Inherit;False;62;BlendTime;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-1430.15,1369.171;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;-1430.151,1085.77;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-1489.914,-624.2057;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;102;-1012.326,1229.734;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;53;-1035.609,-742.455;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;74;-1523.554,398.6639;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;103;-834.626,1227.188;Inherit;False;Emissive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;119;-4456.884,2028.384;Inherit;False;1887.768;454.2583;Comment;12;118;117;116;115;114;113;112;111;110;109;108;120;NormalExtrusion;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;36;-854.3408,-748.9022;Inherit;False;Diffuse;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;75;-1250.808,392.2167;Inherit;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;121;-268.0747,401.6694;Inherit;False;120;NormalExstrusion;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;115;-3466.794,2266.17;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;77;-263.8675,17.58247;Inherit;False;75;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-257.3252,129.1057;Inherit;False;103;Emissive;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;76;-274.4857,-81.54648;Inherit;False;36;Diffuse;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-321.542,299.2363;Inherit;False;Property;_Smoothness;Smoothness;7;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-325.4733,217.5615;Inherit;False;Property;_Metalic;Metalic;6;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-4121.806,2317.064;Inherit;False;Property;_ExtrusionPoint;Extrusion Point;10;0;Create;True;0;0;0;False;0;False;0.25;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-3836.344,2364.642;Inherit;False;Property;_ExtrusionAmount;Extrusion Amount;11;0;Create;True;0;0;0;False;0;False;10;0;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;118;-2989.917,2219.699;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;120;-2839.076,2221.582;Inherit;False;NormalExstrusion;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;108;-4386.586,2078.383;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;110;-4120.091,2184.902;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;109;-4406.884,2262.091;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;117;-3280.907,2101.312;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VoronoiNode;122;-1528.802,598.5958;Inherit;True;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SimpleMaxOpNode;116;-3279.804,2267.276;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;113;-3686.975,2224.125;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;112;-3877.283,2229.656;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3.2,1.6;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Xaver/Monolith1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;56;0;26;0
WireConnection;56;1;55;0
WireConnection;25;0;24;0
WireConnection;25;1;26;0
WireConnection;42;0;56;0
WireConnection;27;1;25;0
WireConnection;43;1;42;0
WireConnection;28;0;27;0
WireConnection;44;0;43;0
WireConnection;29;0;28;0
WireConnection;45;0;44;0
WireConnection;80;0;29;0
WireConnection;80;1;82;0
WireConnection;81;0;45;0
WireConnection;81;1;82;0
WireConnection;32;0;80;0
WireConnection;16;0;15;0
WireConnection;46;0;81;0
WireConnection;30;0;19;0
WireConnection;30;1;16;0
WireConnection;39;0;40;0
WireConnection;31;0;19;0
WireConnection;31;1;30;0
WireConnection;31;2;33;0
WireConnection;57;0;28;0
WireConnection;47;0;19;0
WireConnection;47;1;30;0
WireConnection;47;2;48;0
WireConnection;49;0;39;0
WireConnection;49;1;47;0
WireConnection;59;0;57;0
WireConnection;41;0;31;0
WireConnection;41;1;39;0
WireConnection;50;0;49;0
WireConnection;34;0;41;0
WireConnection;60;0;59;0
WireConnection;61;0;60;0
WireConnection;101;0;98;0
WireConnection;101;1;97;0
WireConnection;99;0;98;0
WireConnection;99;1;96;0
WireConnection;62;0;61;0
WireConnection;23;0;35;0
WireConnection;23;1;37;0
WireConnection;51;0;35;0
WireConnection;51;1;52;0
WireConnection;124;0;23;0
WireConnection;124;1;123;0
WireConnection;73;0;70;0
WireConnection;73;1;68;0
WireConnection;72;0;70;0
WireConnection;72;1;69;0
WireConnection;105;0;99;0
WireConnection;105;1;106;0
WireConnection;104;0;101;0
WireConnection;104;1;106;0
WireConnection;125;0;123;0
WireConnection;125;1;51;0
WireConnection;102;0;104;0
WireConnection;102;1;105;0
WireConnection;102;2;100;0
WireConnection;53;0;124;0
WireConnection;53;1;125;0
WireConnection;53;2;63;0
WireConnection;74;0;72;0
WireConnection;74;1;73;0
WireConnection;74;2;71;0
WireConnection;103;0;102;0
WireConnection;36;0;53;0
WireConnection;75;0;74;0
WireConnection;115;0;113;0
WireConnection;115;1;114;0
WireConnection;118;0;117;0
WireConnection;118;1;116;0
WireConnection;120;0;118;0
WireConnection;110;0;108;2
WireConnection;110;1;109;3
WireConnection;116;0;115;0
WireConnection;113;0;112;0
WireConnection;112;0;110;0
WireConnection;112;1;111;0
WireConnection;0;0;76;0
WireConnection;0;1;77;0
WireConnection;0;2;107;0
WireConnection;0;3;79;0
WireConnection;0;4;78;0
ASEEND*/
//CHKSM=38957A00A01CD8BE4E09265C341CD1ED3285E576