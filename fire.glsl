float hash(vec3 p) {
    p = fract(p * 0.3183099 + 0.1);
    p *= 17.0;
    return fract(p.x * p.y * p.z * (p.x + p.y + p.z));
}
float noise(vec3 x) {
    vec3 i = floor(x); vec3 f = fract(x);
    f = f * f * (3.0 - 2.0 * f);
    return mix(mix(mix(hash(i + vec3(0,0,0)), hash(i + vec3(1,0,0)), f.x),
                   mix(hash(i + vec3(0,1,0)), hash(i + vec3(1,1,0)), f.x), f.y),
               mix(mix(hash(i + vec3(0,0,1)), hash(i + vec3(1,0,1)), f.x),
                   mix(hash(i + vec3(0,1,1)), hash(i + vec3(1,1,1)), f.x), f.y), f.z);
}
float fbm(vec3 p) {
    float v = 0.0; float a = 0.5;
    for (int i = 0; i < 5; i++) {
        v += a * noise(p);
        p *= 2.0; a *= 0.5;
    }
    return v;
}
vec3 palette_fire(float d) {
    const vec3 yellow   = vec3(1.7, 1.3, 1.0);
    const vec3 orange   = vec3(1.0, 0.6, 0.0);
    const vec3 red      = vec3(1.0, 0.0, 0.0);
    const vec3 darkgray = vec3(0.2, 0.2, 0.2);
    const vec3 gray     = vec3(0.4, 0.4, 0.4);

    float x = clamp(d, 0.0, 1.0);

    if (x < 0.25)
        return mix(gray, darkgray, x * 4.0);
    else if (x < 0.5)
        return mix(darkgray, red, x * 4.0 - 1.0);
    else if (x < 0.75)
        return mix(red, orange, x * 4.0 - 2.0);
    return mix(orange, yellow, x * 4.0 - 3.0);
}
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    float t = iTime * 0.5; 
    
    vec3 ro = vec3(0.0, 0.0, -3.0); 
    vec3 rd = normalize(vec3(uv, 1.0));
    float d = 0.0; 
    vec3 col = vec3(0.0);
    vec3 bgColor = vec3(0.2, 0.7, 0.8); 
    for(int i = 0; i < 256; i++) {
        vec3 p = ro + rd * d;
       
        float dist = length(p) - 1.0;
        float n = fbm(p * 2.5 + vec3(0.0, -t, 0.0));
        
        float density = n - dist * 1.5;
        
        if (density > 0.0) {
            vec3 fireColor = palette_fire(density * 1.5);
            col = mix(col, fireColor, 0.1); 
        }
        
        d += 0.05;
        if(d > 5.0) break;
    }
    if(length(col) < 0.01) col = bgColor;

    fragColor = vec4(col, 1.0);
}