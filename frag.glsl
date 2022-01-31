precision mediump float;

uniform float time;
uniform vec2 resolution;
uniform sampler2D texture;

void main() {
  vec2 coord = gl_FragCoord.xy / resolution;
  vec3 color = texture2D( texture, vec2( coord.x, 1. -coord.y) ).xyz;
  gl_FragColor = vec4( color, 1. );
}
