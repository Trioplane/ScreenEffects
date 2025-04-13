#version 150

#moj_import <minecraft:fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;
uniform vec2 ScreenSize;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

// look at this
vec2[] corners = vec2[](
  vec2(0.0, 1.0),
  vec2(0.0, 0.0),
  vec2(1.0, 0.0),
  vec2(1.0, 1.0)
);

vec3 newPosition = Position;

void main() {
    float id = floor((newPosition.y + 1000.0) / 2000.0);
    newPosition.y = mod(newPosition.y + 1000.0, 2000.0) - 1000.0;

    gl_Position = ProjMat * ModelViewMat * vec4(newPosition, 1.0);

    vertexDistance = fog_distance(Position, FogShape);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;

    if (id >= 4.0 && id <= 5.0) {
        if (Position.z == 2400.12) { gl_Position = vec4(2, 2, 1, 1); }
        float aspect = ScreenSize.x / ScreenSize.y;
        vec2 corner = corners[gl_VertexID % 4];
        vec2 scaled = (corner * 2.0 - 1.0) * vec2(1.0, aspect);

        gl_Position = vec4(scaled, 0.0, 1.0);
    }
}