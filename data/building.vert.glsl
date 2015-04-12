#define PROCESSING_TEXLIGHT_SHADER

uniform mat4 modelviewMatrix;
uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec3 lightNormal[2];
uniform vec3 lightAmbient[2];
uniform vec3 lightDiffuse[2];

attribute vec4 vertex;
attribute vec3 normal;
attribute vec2 texCoord;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
	vec4 vertPosition = modelviewMatrix * vertex;
	vec3 vertNormal = normalize(normalMatrix * normal);
	float intensity = max(0.0, dot(lightNormal[1], vertNormal));
	
	vertColor = vec4(lightDiffuse[1]*intensity, 1) + vec4(lightAmbient[0], 1)*0.5;
	vertTexCoord = vec4(texCoord, 1.0, 1.0);
	
	gl_Position = transform * vertex;
}