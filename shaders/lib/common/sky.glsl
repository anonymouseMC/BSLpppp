vec3 getSkyColor(vec3 fragpos, vec3 light){
vec3 sky_col = sky_c;
vec3 nfragpos = normalize(fragpos);

float NdotU = max(dot(nfragpos,upVec),0.0);
float NdotS = dot(nfragpos,sunVec)*0.5+0.5;

float top = pow(max(NdotU,0.1),0.25)*SkyBrightness;
float horizon = pow(1.0-abs(NdotU),2.5)*(0.4*sunVisibility+0.2)*(1-rainStrength*0.75);
float lightmix = (NdotS*NdotS*(1-max(NdotU,0.0))*pow(1.0-timeBrightness,3.0) + horizon*0.1*timeBrightness)*sunVisibility*(1.0-rainStrength);

#ifdef SkyVanilla
sky_col = mix(sky_col,fog_c,max(1.0-abs(NdotU),0.0));
#endif

float mult = 0.5 - top*(1.0-rainStrength*0.2) + horizon;

sky_col = (mix(sky_col*pow(max(1-lightmix,0.0),2.0),pow(light,vec3(1.5)),lightmix)*sunVisibility + light_n*0.4);
sky_col = mix(sky_col,weather*luma(ambient)*4.0,rainStrength)*mult;

return pow(sky_col,vec3(1.15));
}