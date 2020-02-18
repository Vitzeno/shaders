# Learning Shaders

## Distortion Effect

![](/video/Distort.gif)

  A standard surface shader, effect is acheived by calculating the distance from the center of the effect. This is used to create a mask which offsets uv when it is close to the center. Intensity and size of the distortion effect can also be controlled by altering the mask size.

## Edge Detection (Cell Shading Style)

![](/video/EdgeDetection.gif)

  An image shader applied to the entire screen, effect is acheived by offseting the uv by a small amount and then calculating the distance between the offset and original. Any distance below a threshold is combined with colour to create an edge effect with custom colours.

## Raytracing

![](/video/Raytraceing.png)

  Based on the well documented Whitted (-style) ray-tracer where ray are shot from the camera and not from the light source. 
  
## Warp Effect

![](/video/Warp.gif)

  A standard surface shader, effect is acheived by applying on offset in both direction of the uv. The offset is based on a sin wave and _Time.y.