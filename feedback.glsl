#version 120

precision mediump float;
uniform sampler2D prevState;
uniform sampler2D video;
varying vec2 uv;
void main() {
    vec3 last = texture2D( prevState, uv ).rgb;
    vec3 videocolor = texture2D( video, uv ).rgb;
    vec3 feedback = last * .95 + videocolor * .05;
    gl_FragColor = vec4( feedback, 1. );
}