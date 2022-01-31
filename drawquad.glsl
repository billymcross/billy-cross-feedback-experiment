
precision mediump float;
uniform sampler2D prevState;
varying vec2 uv;
uniform vec2 resolution;
uniform float time;

float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(15.6234636, 70.3453425))) * 432113.12354125);
}

float noise (vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    //Make u, which is our smooth interpolation function
    vec2 u = f * f * (3.0 - 2.0 * f);

    //Mix the 4 corners
    return mix(a, b, u.x) +
    (c - a) * u.y * (1.0 - u.x) +
    (d - b) * u.x * u.y;
}

    #define OCTAVES 8
float fbm (vec2 st) {
    //Initialize values
    float value = 0.0;
    float amplitude = 1.0;

    //Loop
    for (int i = 0; i < OCTAVES; i++) {
        value += amplitude * noise(st + time);
        st *= .5;
        amplitude *= .5;
    }
    return value;
}

void main() {
    vec2 st = gl_FragCoord.xy/resolution.xy;
    vec3 color  = texture2D(prevState, 1.0 - uv * fbm(uv)).rgb;
    color *= mix(vec3(2.0, 0.0, 0.0), vec3(0.0, 0.0, 2.0), st.y);
    gl_FragColor = vec4(color, 1.0);
}
