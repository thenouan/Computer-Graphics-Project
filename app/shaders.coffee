@Shaders = {

}


@Shaders.gouraudVertexShader = """
  uniform vec3 lightPosition;
  uniform vec3 color;
  varying vec3 interpolatedColor;

  void main() {
    //1. Calculate the vertexPosition in the camera space.
    //2. Calculate the correct normal in the camera space.
    //3. Find the direction towards the viewer, normalize.
    //4. Find the direction towards the light source, normalize.

    //Implement Phong's lighting/reflection model:
    // - Ambient term you can just add
    // - Use the values calculated before for the diffuse/Lambertian term
    // - For Phong's specular, find the reflection of the light ray from the point
    //   See: https://www.opengl.org/sdk/docs/man/html/reflect.xhtml
    //   Use a value like 200 for the shininess

    interpolatedColor = color; //Replace this line

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position,1.0);
  }
"""

@Shaders.gouraudFragmentShader = """
  varying vec3 interpolatedColor;

  void main() {
    //Nothing fancy here, we already know the color.
    gl_FragColor = vec4(interpolatedColor, 1.0);
  }
"""

@Shaders.phongVertexShader = """
  varying vec3 interpolatedPosition; //We interpolate the position
  varying vec3 interpolatedNormal;   //We interpolate the normal

  void main() {
    //Find the correct values for the position and the normal in camera space.
    interpolatedPosition = position; //Replace these 2 lines
    interpolatedNormal = normal;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position,1.0);
  }
"""

@Shaders.phongFragmentShader = """
  uniform vec3 lightPosition;
  uniform vec3 color;
  varying vec3 interpolatedPosition;
  varying vec3 interpolatedNormal;

  void main() {
    //Do the same Phong's lighting/reflection model calculation that you did in Gouraud vertex shader before.
    gl_FragColor = vec4(color, 1.0);
  }
"""