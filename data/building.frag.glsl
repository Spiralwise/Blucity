#ifdef GL_ES
precision mediump float;
precision medium int;
#endif

uniform float textureCoeff;
uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
	vec4 offsetVertTexCoord = vertTexCoord;
	offsetVertTexCoord.x += 1.0f/3.0f;
	vec4 offsetVertSelfilumCoord = vertTexCoord;
	offsetVertSelfilumCoord.x += 2.0f/3.0f;
	
	// Daylight texture
	gl_FragColor = texture2D(texture, vertTexCoord) * textureCoeff;
	
	// Nightlight texture
	gl_FragColor += texture2D(texture, offsetVertTexCoord) * (1.0-textureCoeff);
	
	// Lighting
	gl_FragColor *= vertColor + texture2D(texture, offsetVertSelfilumCoord)*(1.0-textureCoeff);
}