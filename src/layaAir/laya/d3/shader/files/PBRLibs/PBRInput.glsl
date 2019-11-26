




//alphaTest
#ifdef ALPHATEST
	uniform float u_AlphaTestValue;
#endif

uniform vec4 u_AlbedoColor;

#ifdef NORMALTEXTURE
	uniform sampler2D u_NormalTexture;
#endif
//漫反射贴图
#ifdef ALBEDOTEXTURE
	uniform sampler2D u_AlbedoTexture;
#endif

#ifdef METALLICGLOSSTEXTURE
	uniform sampler2D u_MetallicGlossTexture;
#endif

uniform float u_smoothness;
uniform float u_smoothnessScale;

uniform float u_metallic;

#ifdef PARALLAXTEXTURE
	uniform sampler2D u_ParallaxTexture;
	uniform float u_Parallax;
	varying vec3 v_ViewDirForParallax;
#endif

#ifdef OCCLUSIONTEXTURE
	uniform sampler2D u_OcclusionTexture;
	uniform float u_occlusionStrength;
#endif

#ifdef EMISSIONTEXTURE
	uniform sampler2D u_EmissionTexture;
#endif
uniform vec4 u_EmissionColor;


#if defined(DIFFUSEMAP)||defined(METALLICGLOSSTEXTURE)||defined(NORMALTEXTURE)||defined(EMISSIONTEXTURE)||defined(OCCLUSIONTEXTURE)||defined(PARALLAXTEXTURE)
	varying vec2 v_Texcoord0;
#endif

#ifdef LIGHTMAP
	varying vec2 v_LightMapUV;
	uniform sampler2D u_LightMap;
#endif



varying vec3 v_Normal; 

#if defined(DIRECTIONLIGHT)||defined(POINTLIGHT)||defined(SPOTLIGHT)
	#ifdef LEGACYSINGLELIGHTING
		#ifdef DIRECTIONLIGHT
			uniform DirectionLight u_DirectionLight;
		#endif
		#ifdef POINTLIGHT
			uniform PointLight u_PointLight;
		#endif
		#ifdef SPOTLIGHT
			uniform SpotLight u_SpotLight;
		#endif
	#else
		uniform mat4 u_View;
		uniform vec4 u_ProjectionParams;
		uniform vec4 u_Viewport;
		uniform int u_DirationLightCount;
		uniform sampler2D u_LightBuffer;
		uniform sampler2D u_LightClusterBuffer;
	#endif
#endif
//后面考虑宏TODO
varying vec3 v_EyeVec;

#if defined(NORMALMAP)||defined(PARALLAXMAP)
	varying vec3 v_Tangent;
	varying vec3 v_Binormal;
#endif


//后面考虑宏TODO
varying vec3 v_PositionWorld;


mediump float lerpOneTo(mediump float b, mediump float t)
{
    mediump float oneMinusT = 1.0 - t;
    return oneMinusT + b * t;
}

//FS
vec3 emission(vec2 uv)
{
	#ifdef EMISSIONTEXTURE
		return texture2D(u_EmissionTexture, uv).rgb * u_EmissionColor.rgb;
	#else
		return u_EmissionColor.rgb;
	#endif
}

mediump float alpha(vec2 uv)
{
	#ifdef SMOOTHNESSSOURCE_ALBEDOTEXTURE_ALPHA
		return u_AlbedoColor.a;
	#else
		#ifdef ALBEDOTEXTURE
			return texture2D(u_AlbedoTexture, uv).a * u_AlbedoColor.a;
		#else
			return u_AlbedoColor.a;
		#endif
	#endif
}

mediump float occlusion(vec2 uv)
{
	#ifdef OCCLUSIONTEXTURE
		mediump float occ = texture2D(u_OcclusionTexture, uv).g;
		return lerpOneTo(occ, u_occlusionStrength);
	#else
		return 1.0;
	#endif
}

mediump vec3 albedo(vec2 uv)
{
	#ifdef ALBEDOTEXTURE
		return u_AlbedoColor.rgb * texture2D(u_AlbedoTexture, uv).rgb;
	#else
		return u_AlbedoColor.rgb;
	#endif
	//TODO:Detail Texture
}

mediump vec2 metallicGloss(vec2 uv)
{
	mediump vec2 ms;//x is metallic,y is smoothness
	#ifdef METALLICGLOSSTEXTURE
		#ifdef SMOOTHNESSSOURCE_ALBEDOTEXTURE_ALPHA
			ms.x = texture2D(u_MetallicGlossTexture, uv).r;
			ms.y = texture2D(u_AlbedoTexture, uv).a;
		#else
			mg = texture2D(u_MetallicGlossTexture, uv).ra;
		#endif
		ms.y *= u_smoothnessScale;
	#else
		ms.x = u_metallic;
		//TODO:Judge with ALBEDOTEXTURE define
		#ifdef SMOOTHNESSSOURCE_ALBEDOTEXTURE_ALPHA
			ms.y = texture2D(u_AlbedoTexture, uv).a * u_smoothnessScale;
		#else
			ms.y = u_smoothness;
		#endif
	#endif
	return ms;
}

// mediump vec4 specularGloss(vec2 uv)
// {
// 	mediump vec4 sg;
// 	#ifdef SPECULARGLOSSTEXTURE
// 		#ifdef SMOOTHNESSSOURCE_ALBEDOTEXTURE_ALPHA
// 			sg.rgb = texture2D(u_SpecGlossTexture, uv).rgb;
// 			sg.a = texture2D(u_AlbedoTexture, uv).a;
// 		#else
// 			sg = texture2D(u_SpecGlossTexture, uv);
// 		#endif
// 		sg.a *= u_smoothnessScale;
// 	#else
// 		sg.rgb =u_SpecularColor.rgb;
// 		#ifdef SMOOTHNESSSOURCE_ALBEDOTEXTURE_ALPHA
// 			sg.a = texture2D(u_AlbedoTexture, uv).a * u_SpecGlossScale;
// 		#else
// 			sg.a = u_smoothness;
// 		#endif
// 	#endif
// 		return sg;
// }


#ifdef NORMALMAP
	mediump vec3 NormalInTangentSpace(vec2 texcoords)
	{
		//TODO:_BumpScale
		mediump vec3 normalTangent = texture2D(u_NormalTexture, texcoords).rgb;
		//TODO:DETAIL and DETAIL_NORMALMAP
		return normalTangent;
	}
#endif

#ifdef PARALLAXTEXTURE
vec2 parallaxOffset1Step(float h, float height, vec3 viewDir)
{
	h = h * height - height / 2.0;
	vec3 v = normalize(viewDir);
	v.z += 0.42;
	return h * (v.xy / v.z);
}
vec4 parallax(vec2 texcoords, vec3 viewDir)
{
	float h = tex2D(u_ParallaxTexture, texcoords.xy).g;
	vec2 offset = parallaxOffset1Step(h, u_Parallax, viewDir);
	return vec2(texcoords.xy + offset);
}
#endif








