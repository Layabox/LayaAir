void vertexForward()
{
	vec4 position;
	#ifdef BONE
		mat4 skinTransform = u_Bones[int(a_BoneIndices.x)] * a_BoneWeights.x;
		skinTransform += u_Bones[int(a_BoneIndices.y)] * a_BoneWeights.y;
		skinTransform += u_Bones[int(a_BoneIndices.z)] * a_BoneWeights.z;
		skinTransform += u_Bones[int(a_BoneIndices.w)] * a_BoneWeights.w;
		position=skinTransform*a_Position;
	#else
		position=a_Position;
	#endif

	#ifdef GPU_INSTANCE
		gl_Position = a_MvpMatrix * position;
	#else
		gl_Position = u_MvpMatrix * position;
	#endif

	mat4 worldMat;
	#ifdef GPU_INSTANCE
		worldMat = a_WorldMat;
	#else
		worldMat = u_WorldMat;
	#endif

	v_PositionWorld=(worldMat*position).xyz;

	#if defined(DIFFUSEMAP)||defined(METALLICGLOSSTEXTURE)||defined(NORMALTEXTURE)||defined(EMISSIONTEXTURE)||defined(OCCLUSIONTEXTURE)||defined(PARALLAXTEXTURE)
		#ifdef TILINGOFFSET
			v_Texcoord0=TransformUV(a_Texcoord0,u_TilingOffset);
		#else
			v_Texcoord0=a_Texcoord0;
		#endif
	#endif

	v_EyeVec =u_CameraPos-v_PositionWorld;//will normalize per-pixel

	#ifdef LIGHTMAP
		v_LightMapUV=transformLightMapUV(a_Texcoord0,a_Texcoord1,u_LightmapScaleOffset);
	#endif

	mat3 worldInvMat;
	#ifdef BONE
		worldInvMat=inverse(mat3(worldMat*skinTransform));
	#else
		worldInvMat=inverse(mat3(worldMat));
	#endif
	v_Normal=a_Normal*worldInvMat;
	
	#if defined(NORMALMAP)||defined(PARALLAXMAP)
		v_Tangent=a_Tangent0.xyz*worldInvMat;
		v_Binormal=cross(v_Normal,v_Tangent)*a_Tangent0.w;
		#ifdef PARALLAXMAP
				// Build orthonormal basis.
				vec3 N = normalize(v_Normal);
				vec3 T = normalize(v_Tangent);
				vec3 B = normalize(v_Binormal);
				mat3 TBN = mat3(T, B, N);
				v_ViewDirForParallax = TBN * normalize(-v_EyeVec);
		#endif
	#endif

	//TODO:缺高差图TODO
}